Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643F20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551660203;
	bh=VHLrTLxfHVzkf73bXPJIIP3dRdTz0+xNmhzHqEjknsg=;
	h=From:Date:Subject:To:List-ID:From;
	b=yPc/mv42JEN4J5S2QsMj5oZoUJ2wnkPDATXQt0Ji9BT99lIntWAYW+2GOW/FeSjH3
	 r/pEuxxfZKwBgob/hKbSIxn+/HTH7+aB49Dj3LRf1EYPlXItjDH4Hyd2pSHFxA8J9U
	 bUYtT/fzpi5L5AIkmUew6ThgEzRvBXK9p4Q9XhLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfCDAnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:43:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46342 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDAnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:43:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id g12so2230980lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 16:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xN0ONW990I7sQi07vYWyc1/4tKgn/8mjC2AorP2j2so=;
        b=YGGbbt00SY5L4E2Kl59vYWxvSS5KvFHfrnOsgoiHTQoLKUP+TfiHw5DyJ50nDNBiDq
         MKiCICd9S4Bg4F1yf1mtwRowApU7jPk8l/UGeDuN11HsfsS7ML/GVg91PBnsxBuNOfQj
         JKYzKRLBWuj4q/EtMCL9MSeOw1jFxzH637dCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xN0ONW990I7sQi07vYWyc1/4tKgn/8mjC2AorP2j2so=;
        b=r/gsxdg1p3Bml9o1oOdy1nll98PRKBHRyIlwJh4gxAI64vwLTBJWEDh5QYZsvzABvj
         QkqXCvlh0y47vaVwodw/06F9/bFxNx/qFZttSs/yS0dgsbC+TOw9A5h4Qo1LsUDRSEXg
         9tBbDnb6OcI0rxA8pf5qsolXtc5UL/O6q/9w3rXywgHIueJQOnyi8CMu5qvNAGXXeAPF
         x0eYtXBT8FDaOjmTN9Nu//HvDozF8FsLNLJoxYwiHo8mbjgkYdgFl1r1OGfKf/Hn0Q4H
         tGSV5+48wweTJUqAMm5ayYM7jBY+4TLeJIyxb1Jx626wGrCIRLwZvsrkSjfr53D/CHTh
         7RlQ==
X-Gm-Message-State: APjAAAWCD7b1iXitoOJGJE6NR/S3IFcCUpIAJRDEI129ueHZl1n/jyJr
        XzFjcimdn1ygsxjkulBv1Rg7eVBxfCM=
X-Google-Smtp-Source: APXvYqyh1/+rZ5WiWMe72ZJDE7x0GbEYJwuDaWML2DmzKYm5uylWhB0kdPE12YVCwS7Jcy9pgpIO9g==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr8925660lfh.78.1551660197509;
        Sun, 03 Mar 2019 16:43:17 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m24sm1229811ljj.17.2019.03.03.16.43.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 16:43:16 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id d24so2762240ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 16:43:16 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr8903458lji.125.1551660196103;
 Sun, 03 Mar 2019 16:43:16 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 16:43:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjuG6HiGbD7DCGfvDvhr_1WZUR-eYF2qWGbYyn9k6unvg@mail.gmail.com>
Message-ID: <CAHk-=wjuG6HiGbD7DCGfvDvhr_1WZUR-eYF2qWGbYyn9k6unvg@mail.gmail.com>
Subject: Linux 5.0
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the last week of the 5.0 release wasn't entirely quiet, but
it's a lot smaller than rc8 was, and on the whole I'm happy that I
delayed a week and did an rc8.

It turns out that the actual patch that I talked about in the rc8
release wasn't the worrisome bug I had thought: yes, we had an
uninitialized variable, but the reason we hadn't immediately noticed
it due to a warning was that the way gcc works, the compiler had
basically initialized it for us to the right value.  So the same thing
that caused not the lack of warning, also effectively meant that the
fix was a no-op in practice.

But hey, we had other bug fixes come in that actually did matter, and
the uninitialized variable _could_ have been a problem with another
compiler.

Regardless - all is well that ends well. We have more than a handful
of real fixes in the last week, but not enough to make me go "Hmm,
things are really unstable". In fact, at least two thirds of the
patches are marked as being fixes for previous releases, so it's not
like 5.0 itself looks bad.

Knock wood.

Anyway, with this, the merge window for 5.1 is obviously open, and I'm
happy to see that I already have several early pull requests.  Which
I'll start processing tomorrow.

And appended is - as usual - the shortlog just for the last week. The
overall changes for all of the 5.0 release are much bigger. But I'd
like to point out (yet again) that we don't do feature-based releases,
and that "5.0" doesn't mean anything more than that the 4.x numbers
started getting big enough that I ran out of fingers and toes.

                Linus

---

Alamy Liu (2):
      mmc: cqhci: fix space allocated for transfer descriptor
      mmc: cqhci: Fix a tiny potential memory leak on error condition

Alistair Francis (1):
      drm/bochs: Fix the ID mismatch error

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix u64 statistics
      net: dsa: mv88e6xxx: Fix statistics on mv88e6161

Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluatio=
n

Andy Shevchenko (2):
      net: dev: Use unsigned integer as an argument to left-shift
      enc28j60: Correct description of debug module parameter

Ard Biesheuvel (2):
      crypto: sha256/arm - fix crash bug in Thumb2 build
      crypto: sha512/arm - fix crash bug in Thumb2 build

Arnd Bergmann (1):
      kasan: turn off asan-stack for clang-8 and earlier

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Bart Van Assche (1):
      scsi: core: Avoid that system resume triggers a kernel warning

Bryan Whitehead (1):
      lan743x: Fix TX Stall Issue

Christoph Hellwig (1):
      MIPS: lantiq: pass struct device to DMA API functions

Daniel Borkmann (1):
      bpf: fix sanitation rewrite in case of non-pointers

Darrick J. Wong (1):
      tmpfs: fix uninitialized return value in shmem_link

David Ahern (4):
      ipv4: Return error for RTA_VIA attribute
      ipv6: Return error for RTA_VIA attribute
      mpls: Return error for RTA_GATEWAY attribute
      ipv4: Pass original device to ip_rcv_finish_core

David Howells (1):
      afs: Fix manually set volume location server list

Davide Caratti (2):
      net/sched: act_ipt: fix refcount leak when replace fails
      net/sched: act_skbedit: fix refcount leak when replace fails

Dmitry Bogdanov (1):
      net: aquantia: regression on cpus with high cores: set mode with 8 qu=
eues

Eric Biggers (3):
      net: socket: set sock->sk to NULL after calling proto_ops::release()
      crypto: arm64/chacha - fix chacha_4block_xor_neon() for big endian
      crypto: arm64/chacha - fix hchacha_block_neon() for big endian

Gilad Ben-Yossef (1):
      crypto: ccree - add missing inline qualifier

Greg Kroah-Hartman (1):
      kvm: properly check debugfs dentry before using it

Haiyang Zhang (1):
      hv_netvsc: Fix IP header checksum for coalesced packets

Hangbin Liu (1):
      ipv4: Add ICMPv6 support when parse route ipproto

Hannes Reinecke (8):
      scsi: lpfc: fix calls to dma_set_mask_and_coherent()
      scsi: 3w-9xxx: fix calls to dma_set_mask_and_coherent()
      scsi: 3w-sas: fix calls to dma_set_mask_and_coherent()
      scsi: aic94xx: fix calls to dma_set_mask_and_coherent()
      scsi: bfa: fix calls to dma_set_mask_and_coherent()
      scsi: csiostor: fix calls to dma_set_mask_and_coherent()
      scsi: hisi_sas: fix calls to dma_set_mask_and_coherent()
      scsi: hptiop: fix calls to dma_set_mask()

Hauke Mehrtens (1):
      net: dsa: lantiq: Add GPHY firmware files

Heiner Kallweit (2):
      net: phy: phylink: fix uninitialized variable in phylink_get_mac_stat=
e
      net: dsa: mv88e6xxx: prevent interrupt storm caused by
mv88e6390x_port_set_cmode

Igor Druzhinin (2):
      xen-netback: fix occasional leak of grant ref mappings under
memory pressure
      xen-netback: don't populate the hash cache on XenBus disconnect

Jann Horn (1):
      mm: enforce min addr even if capable() in expand_downwards()

Jiri Benc (1):
      geneve: correctly handle ipv6.disable module parameter

Jonas Gorski (1):
      MIPS: BCM63XX: provide DMA masks for ethernet devices

Jonathan Neusch=C3=A4fer (1):
      mmc: spi: Fix card detection during probe

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Julia Lawall (1):
      tee: optee: add missing of_node_put after of_device_is_available

Lan Tianyu (1):
      x86/hyper-v: Fix definition of HV_MAX_FLUSH_REP_COUNT

Linus Torvalds (2):
      Revert "x86/fault: BUG() when uaccess helpers fault on kernel address=
es"
      Linux 5.0

Linus Walleij (1):
      ARM: dts: gemini: Re-enable display controller

Mao Wenan (1):
      net: sit: fix memory leak in sit_init_net()

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Extend TZ reserved memory area

Mario Kleiner (1):
      drm/amd/display: Use vrr friendly pageflip throttling in DC.

Matthias Maennich (1):
      sctp: chunk.c: correct format string for size_t in printk

Max Uvarov (1):
      net: phy: dp83867: add soft reset delay

Maxime Chevallier (1):
      net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X

Michael Chan (1):
      bnxt_en: Drop oversize TX packets to prevent errors.

Michael Clark (1):
      MIPS: fix truncation in __cmpxchg_small for short values

Mike Kravetz (1):
      hugetlbfs: fix races and page leaks during migration

Mike Marshall (1):
      orangefs: remove two un-needed BUG_ONs...

Ming Lei (1):
      mmc: core: align max segment size with logical block size

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

Nicholas Kazlauskas (1):
      drm: Block fb changes for async plane updates

Paolo Abeni (3):
      selftests: pmtu: disable DAD in all namespaces
      selftests: pmtu: add explicit tests for PMTU exceptions cleanup
      selftests: fixes for UDP GRO

Paul Burton (1):
      MIPS: eBPF: Fix icache flush end address

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Peng Sun (2):
      bpf: decrease usercnt if bpf_map_new_fd() fails in bpf_map_get_fd_by_=
id()
      bpf: drop refcount if bpf_map_new_fd() fails in map_create()

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Ritesh Harjani (1):
      mmc: core: Fix NULL ptr crash from mmc_should_fail_request

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Sheng Lan (1):
      net: netem: fix skb length BUG_ON in __skb_to_sgvec

Takeshi Saito (1):
      mmc: tmio: fix access width of Block Count Register

Thomas Bogendoerfer (1):
      MIPS: fix memory setup for platforms with PHYS_OFFSET !=3D 0

Timur Celik (2):
      tun: fix blocking read
      tun: remove unnecessary memory barrier

Tung Nguyen (1):
      tipc: fix race condition causing hung sendto

Vlad Buslov (1):
      net: sched: act_tunnel_key: fix NULL pointer dereference during init

Wen Yang (1):
      net: dsa: fix a leaked reference by adding missing of_node_put

YueHaibing (1):
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
