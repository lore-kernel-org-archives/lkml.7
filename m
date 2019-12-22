Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB384C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 03:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E2C20663
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 03:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XXsesugG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLVC54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 21:57:56 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45128 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLVC54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 21:57:56 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so13134273ioi.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 18:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=kJK8dnMKjhx1jwfX9hU56RSfsCTRfjhHTaELgQDlsSQ=;
        b=XXsesugG1x9YVhsNiK9YkzVHTmcJ9uQ983eWZ98FGa9Y4BqeEaLJ6CaKovW8HSqe01
         QJLPmd3yt/KBXpFMG04ypLWnijz5OYhr0c4n1u3vcPVbXbfsxY8LWibyJALHbGUBTTEI
         X1sY1SibRLZ32JouPOEBBoR2dHOdTKyBWx5OwxAT6LP2uLSByHALFTu0Y93czgyNO+bI
         vmXy5Kc3wX71FAUNNULLNj5WMj88O9uMbXxy3nnoBYPSUkHCQ/PSCxSYebxyDG9XNVG1
         YH4YansJeKIEeEop/IXLSdzKg/ykoHa/5PYxxJIWxgCisHesjLjpBkAGaVHbsPLjYuRT
         vCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=kJK8dnMKjhx1jwfX9hU56RSfsCTRfjhHTaELgQDlsSQ=;
        b=SmBE6iBJeEQXaQZNV7BjbbCV2zfmS0k3Gf1wHeycnZcl+ppwH24m1LgKVeNyF1v67v
         iz3u7YGncjORGvEJLjhb53ElbAeXs8Qw7yv4eN7pU7ZjuLaIOc88N0NEPQAo89dFWKrN
         6gVK+SH48FqlAyBMtu2336HHiCTybOiMD0f821gKv1MPEV6UM+MlvfD9LqgECS4NwJbz
         VOBxHYNuZtQMdXCAnlVJiZwgbqdZLoSF+fA3ANNCe2khpDuoNc0UiY4crPBxOk7Png3m
         ac6MrSaqrUBkqwyxzw9nOCFygS2yg/aEpK9PzOm5rdiSIXIh6ytX5sgQDw+5qy1IJ7UD
         NeLw==
X-Gm-Message-State: APjAAAWjVLPcnqQz4WpBbCK/OwYos4RrDFG5iIj/2x/6Odct+FDJGLvP
        P9g/acejVWhAwb4Odd+FVMaAdaDScIY=
X-Google-Smtp-Source: APXvYqyCCL5PzwujEJ64y01MQfpVGe4nNzyo2C8eL7WmMhFBH9ygIqUJm/ywM4JHZq7hCUPuJ8pmgg==
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr19380662jas.37.1576983475483;
        Sat, 21 Dec 2019 18:57:55 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d7sm4927940ioo.68.2019.12.21.18.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 18:57:54 -0800 (PST)
Date:   Sat, 21 Dec 2019 18:57:50 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc3
Message-ID: <alpine.DEB.2.21.9999.1912211854440.57866@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7e0165b2f1a912a06e381e91f0f4e495f4ac3736:

  Merge branch 'akpm' (patches from Andrew) (2019-12-19 08:13:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc3

for you to fetch changes up to 9209fb51896fe0eef8dfac85afe1f357e9265c0d:

  riscv: move sifive_l2_cache.c to drivers/soc (2019-12-20 03:40:24 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc3

Several fixes, and one cleanup, for RISC-V.

Fixes:

- Fix an error in a Kconfig file that resulted in an undefined Kconfig
  option "CONFIG_CONFIG_MMU"

- Fix undefined Kconfig option "CONFIG_CONFIG_MMU"

- Fix scratch register clearing in M-mode (affects nommu users)

- Fix a mismerge on my part that broke the build for
  CONFIG_SPARSEMEM_VMEMMAP users

Cleanups:

- Move SiFive L2 cache-related code to drivers/soc, per request

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: Fix use of undefined config option CONFIG_CONFIG_MMU

Christoph Hellwig (1):
      riscv: move sifive_l2_cache.c to drivers/soc

David Abdurachmanov (1):
      riscv: define vmemmap before pfn_to_page calls

Greentime Hu (1):
      riscv: fix scratch register clearing in M-mode.

 MAINTAINERS                                        |  1 +
 arch/riscv/Kconfig                                 |  2 +-
 arch/riscv/include/asm/pgtable.h                   | 38 ++++++++++++----------
 arch/riscv/kernel/head.S                           |  2 +-
 arch/riscv/mm/Makefile                             |  1 -
 drivers/edac/Kconfig                               |  2 +-
 drivers/soc/Kconfig                                |  1 +
 drivers/soc/Makefile                               |  1 +
 drivers/soc/sifive/Kconfig                         | 10 ++++++
 drivers/soc/sifive/Makefile                        |  3 ++
 .../mm => drivers/soc/sifive}/sifive_l2_cache.c    |  0
 11 files changed, 40 insertions(+), 21 deletions(-)
 create mode 100644 drivers/soc/sifive/Kconfig
 create mode 100644 drivers/soc/sifive/Makefile
 rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6895393	2330852	 313920	9540165	 919245	vmlinux.rv64.orig
6894347	2329588	 313920	9537855	 91893f	vmlinux.rv64.patched
6656178	1939832	 257640	8853650	 871892	vmlinux.rv32.orig
6655130	1938688	 257576	8851394	 870fc2	vmlinux.rv32.patched
1172240	 354256	 130024	1656520	 1946c8	vmlinux.nommu_virt.orig
1171538	 353368	 130024	1654930	 194092	vmlinux.nommu_virt.patched
