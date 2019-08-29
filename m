Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F95C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837B215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="E93QWYzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfH2IeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:34:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34488 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfH2Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so2208288ljh.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tcoOM1w5ijN0RdaUdp5NUc+yqkoT1xSuYtvZ7crxOM=;
        b=E93QWYzboWAlOq+FWQVGJ+m1OydUiOkpgnwjIN4wa7RHlHscY9k3fzfofNTjKvZZqe
         q4nJyUiRCKRycATjsTO6tvnjJVilUBql1VlOUzKL0i3nTYBkhjdPFiYVurUlEmdOI7fZ
         iWyXFFAFLj3o3z71Fkjg6RTTJpvndAPKOQjbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tcoOM1w5ijN0RdaUdp5NUc+yqkoT1xSuYtvZ7crxOM=;
        b=jZk122ipJdOAEHZDX9xki6eiuZJ3UNJz6AQ808nm9Vu9HVGLM8J2WiwjinDlZQxsBn
         0R6JqkET2BiTDU01bbL4tpmxg20ckdQgdqGgtD28kEg+mrLg80eQTIfWyaIAXAHJhR2Q
         ET1IqIO0sIycjjCgySGHtAG1zodXII6X6KWfIwnuiAqptLVnkYmD45xzwOvQwq5nCgkk
         rEL6PB+yDC3dQsCrgR8Y3QHDU5PF2Hx0VuxuZnl9rqhnoofc9mXkSU1JOBzjqMxusx5q
         cxNFAgkSpaQjqitY/PvzFKrQHSFT3285pIaBaeMPeWoEMPY3RynWCVjMoQzPLkAhHnvh
         UZpg==
X-Gm-Message-State: APjAAAVLTRa7o/PQmfq1a7ckvG5H+t2l2Pst9MeKD88iWz3utVMDsGxs
        GsZkVSKptB1m8JNSAS16n106oQ==
X-Google-Smtp-Source: APXvYqzMBM4lsn9sepDdYHdkbnUMJo40+/8WvzjU8RMdOmOtcPZuxR7Sq43ybjvitvmGGeUeW8xHNw==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr3094134ljn.111.1567067569251;
        Thu, 29 Aug 2019 01:32:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20sm248087ljg.31.2019.08.29.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:32:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
Date:   Thu, 29 Aug 2019 10:32:28 +0200
Message-Id: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 9 provides a way to override the otherwise crude heuristic that
gcc uses to estimate the size of the code represented by an asm()
statement. From the gcc docs

  If you use 'asm inline' instead of just 'asm', then for inlining
  purposes the size of the asm is taken as the minimum size, ignoring
  how many instructions GCC thinks it is.

For compatibility with older compilers, we obviously want a

  #if new enough
  #define asm_inline asm inline
  #else
  #define asm_inline asm
  #endif

But since we #define the identifier inline to attach some attributes,
we have to use the alternate spelling __inline__ of that
keyword. Unfortunately, we also currently #define that one (to
inline), so we first have to get rid of all (mis)uses of
__inline__. Hence the huge diffstat. I think patch 1 should be
regenerated and applied just before -rc1.

There are a few remaining users of __inline__, in particular in uapi
headers, which I'm not sure what to do about (kernel-side users of
those will get slightly different semantics since we no longer
automatically attach the __attribute__((__gnu_inline__)) etc.). So RFC.

The two x86 changes cause smaller code gen differences than I'd
expect, but I think we do want the asm_inline thing available sooner
or later, so this is just to get the ball rolling.

Rasmus Villemoes (5):
  treewide: replace __inline__ by inline
  compiler_types.h: don't #define __inline__
  compiler-gcc.h: add asm_inline definition
  x86: alternative.h: use asm_inline for all alternative variants
  x86: bug.h: use asm_inline in _BUG_FLAGS definitions

 arch/alpha/include/asm/atomic.h               | 12 +++---
 arch/alpha/include/asm/bitops.h               |  6 +--
 arch/alpha/include/asm/dma.h                  | 22 +++++-----
 arch/alpha/include/asm/floppy.h               |  2 +-
 arch/alpha/include/asm/irq.h                  |  2 +-
 arch/alpha/include/asm/local.h                |  4 +-
 arch/alpha/include/asm/smp.h                  |  2 +-
 .../arm/mach-iop32x/include/mach/uncompress.h |  2 +-
 .../arm/mach-iop33x/include/mach/uncompress.h |  2 +-
 .../arm/mach-ixp4xx/include/mach/uncompress.h |  2 +-
 arch/ia64/hp/common/sba_iommu.c               |  2 +-
 arch/ia64/hp/sim/simeth.c                     |  2 +-
 arch/ia64/include/asm/atomic.h                |  8 ++--
 arch/ia64/include/asm/bitops.h                | 34 ++++++++--------
 arch/ia64/include/asm/delay.h                 | 14 +++----
 arch/ia64/include/asm/irq.h                   |  2 +-
 arch/ia64/include/asm/page.h                  |  2 +-
 arch/ia64/include/asm/sn/leds.h               |  2 +-
 arch/ia64/include/asm/uaccess.h               |  4 +-
 arch/ia64/oprofile/backtrace.c                |  4 +-
 arch/m68k/include/asm/blinken.h               |  2 +-
 arch/m68k/include/asm/checksum.h              |  2 +-
 arch/m68k/include/asm/dma.h                   | 32 +++++++--------
 arch/m68k/include/asm/floppy.h                |  8 ++--
 arch/m68k/include/asm/nettel.h                |  8 ++--
 arch/m68k/mac/iop.c                           | 14 +++----
 arch/mips/include/asm/atomic.h                | 16 ++++----
 arch/mips/include/asm/checksum.h              |  2 +-
 arch/mips/include/asm/dma.h                   | 20 +++++-----
 arch/mips/include/asm/jazz.h                  |  2 +-
 arch/mips/include/asm/local.h                 |  4 +-
 arch/mips/include/asm/string.h                |  8 ++--
 arch/mips/kernel/binfmt_elfn32.c              |  2 +-
 arch/nds32/include/asm/swab.h                 |  4 +-
 arch/parisc/include/asm/atomic.h              | 20 +++++-----
 arch/parisc/include/asm/bitops.h              | 18 ++++-----
 arch/parisc/include/asm/checksum.h            |  4 +-
 arch/parisc/include/asm/compat.h              |  2 +-
 arch/parisc/include/asm/delay.h               |  2 +-
 arch/parisc/include/asm/dma.h                 | 20 +++++-----
 arch/parisc/include/asm/ide.h                 |  8 ++--
 arch/parisc/include/asm/irq.h                 |  2 +-
 arch/parisc/include/asm/spinlock.h            | 12 +++---
 arch/powerpc/include/asm/atomic.h             | 40 +++++++++----------
 arch/powerpc/include/asm/bitops.h             | 28 ++++++-------
 arch/powerpc/include/asm/dma.h                | 20 +++++-----
 arch/powerpc/include/asm/edac.h               |  2 +-
 arch/powerpc/include/asm/irq.h                |  2 +-
 arch/powerpc/include/asm/local.h              | 14 +++----
 arch/sh/include/asm/pgtable_64.h              |  2 +-
 arch/sh/include/asm/processor_32.h            |  4 +-
 arch/sh/include/cpu-sh3/cpu/dac.h             |  6 +--
 arch/x86/include/asm/alternative.h            | 14 +++----
 arch/x86/include/asm/bug.h                    |  4 +-
 arch/x86/um/asm/checksum.h                    |  4 +-
 arch/x86/um/asm/checksum_32.h                 |  4 +-
 arch/xtensa/include/asm/checksum.h            | 14 +++----
 arch/xtensa/include/asm/cmpxchg.h             |  4 +-
 arch/xtensa/include/asm/irq.h                 |  2 +-
 block/partitions/amiga.c                      |  2 +-
 drivers/atm/he.c                              |  6 +--
 drivers/atm/idt77252.c                        |  6 +--
 drivers/gpu/drm/mga/mga_drv.h                 |  2 +-
 drivers/gpu/drm/mga/mga_state.c               | 14 +++----
 drivers/gpu/drm/r128/r128_drv.h               |  2 +-
 drivers/gpu/drm/r128/r128_state.c             | 14 +++----
 drivers/gpu/drm/via/via_irq.c                 |  2 +-
 drivers/gpu/drm/via/via_verifier.c            | 30 +++++++-------
 drivers/media/pci/ivtv/ivtv-ioctl.c           |  2 +-
 drivers/net/ethernet/sun/sungem.c             |  8 ++--
 drivers/net/ethernet/sun/sunhme.c             |  6 +--
 drivers/net/hamradio/baycom_ser_fdx.c         |  2 +-
 drivers/net/wan/lapbether.c                   |  2 +-
 drivers/net/wan/n2.c                          |  4 +-
 drivers/parisc/led.c                          |  4 +-
 drivers/parisc/sba_iommu.c                    |  2 +-
 drivers/parport/parport_gsc.h                 |  4 +-
 drivers/scsi/lpfc/lpfc_scsi.c                 |  2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c            |  4 +-
 drivers/scsi/qla2xxx/qla_inline.h             |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                 |  2 +-
 drivers/tty/amiserial.c                       |  2 +-
 drivers/tty/serial/ip22zilog.c                |  2 +-
 drivers/tty/serial/sunsab.c                   |  4 +-
 drivers/tty/serial/sunzilog.c                 |  2 +-
 drivers/video/fbdev/core/fbcon.c              | 20 +++++-----
 drivers/video/fbdev/ffb.c                     |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c      |  8 ++--
 drivers/video/fbdev/intelfb/intelfbhw.c       |  2 +-
 drivers/w1/masters/matrox_w1.c                |  4 +-
 fs/coda/coda_linux.h                          |  6 +--
 fs/freevxfs/vxfs_inode.c                      |  2 +-
 fs/nfsd/nfsfh.h                               |  4 +-
 include/acpi/platform/acgcc.h                 |  2 +-
 include/asm-generic/ide_iops.h                |  8 ++--
 include/linux/atalk.h                         |  4 +-
 include/linux/compiler-gcc.h                  |  4 ++
 include/linux/compiler_types.h                |  5 ++-
 include/linux/hdlc.h                          |  4 +-
 include/linux/inetdevice.h                    |  6 +--
 include/linux/parport.h                       |  4 +-
 include/linux/parport_pc.h                    | 22 +++++-----
 include/net/ax25.h                            |  2 +-
 include/net/checksum.h                        |  2 +-
 include/net/dn_nsp.h                          | 16 ++++----
 include/net/ip.h                              |  2 +-
 include/net/ip6_checksum.h                    |  2 +-
 include/net/ipx.h                             | 10 ++---
 include/net/llc_c_ev.h                        |  4 +-
 include/net/llc_conn.h                        |  4 +-
 include/net/llc_s_ev.h                        |  2 +-
 include/net/netrom.h                          |  8 ++--
 include/net/scm.h                             | 14 +++----
 include/net/udplite.h                         |  2 +-
 include/net/x25.h                             |  8 ++--
 include/net/xfrm.h                            | 18 ++++-----
 include/video/newport.h                       | 12 +++---
 net/appletalk/atalk_proc.c                    |  4 +-
 net/appletalk/ddp.c                           |  2 +-
 net/core/neighbour.c                          |  2 +-
 net/core/scm.c                                |  2 +-
 net/decnet/dn_nsp_in.c                        |  2 +-
 net/decnet/dn_nsp_out.c                       |  2 +-
 net/decnet/dn_route.c                         |  2 +-
 net/decnet/dn_table.c                         |  4 +-
 net/ipv6/af_inet6.c                           |  2 +-
 net/ipv6/icmp.c                               |  4 +-
 net/ipv6/udp.c                                |  2 +-
 net/lapb/lapb_iface.c                         |  4 +-
 net/llc/llc_input.c                           |  2 +-
 sound/sparc/amd7930.c                         |  6 +--
 131 files changed, 449 insertions(+), 442 deletions(-)

-- 
2.20.1

