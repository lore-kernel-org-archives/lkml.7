Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32698C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0399B205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mn01vxM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfHQBZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 21:25:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46536 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQBZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 21:25:42 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so9822973iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=r3OpJwbBDOwHPxJNtLJ3xBe/K17VIy9hFFgeMpXJq1Y=;
        b=mn01vxM/ek1dPiMc2W5VTlT+qImlJM53Q9PD789aJvUjL3fSgBbxIfFa/ykojjwa7+
         6M6Bt/qyCmeC1fKdyIZGe+w1G5mMstDPo8Ex8ArbaCnmYlVQET+KV1gKRS+HIF64+SPB
         jH3tpgeRRD7CzvUots1qawLofT8sZYg4e3AQWbA2r8m+Y8eSfvuSSVM/f6Gp6PnIGfkf
         dCopj7TlLO9U32tpKqflDVSblTPFZg6hS9RxZBP9X2j+7UtzLhxIYKq1Tk4MNijMSlAr
         04zTjPzvj9K3gCr5OtRTfMD+/8TZu10jrQ8R82uh5ikrKLkdA5f1N8ayldLdocma+OKq
         1k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=r3OpJwbBDOwHPxJNtLJ3xBe/K17VIy9hFFgeMpXJq1Y=;
        b=kH4BQljyzeoamsAO0rfxUEGKXwS4CapM6ZXrfukX8Tnl7qhKk+4ZuN5DA8s3WH8+me
         MLwrvXNuaCfI5oVOa1iy7s2184oOxiecgMuOWUKBDr6kPnKadJSaM8UCMPfYGUnXL0qN
         +X3nyunuMcEIWDu9qSpPGemUN6nNtwdcswD7uyzvWr4VvFem92TSsXh5GwilSldCdHtU
         4YKTkcZ/ASdZ3kfSV/5COuaLdwtPFd/KwVLPKvCZpJPYkBAlo85ASBTy0DJpr9KAS0pC
         jsnM9rp5MsDjPZgYs3M5FMcpAC5BQ6BTrfPltDi2gdIue/QKQGmP3WzMNFuujd9YvgD1
         uokA==
X-Gm-Message-State: APjAAAV+k3GeddJWN4j4TymFgyWbXXHy+Sy/H+VUdfpQlQbBSIGatRp7
        5uW1Ot7gopEkQXf+o+kfiof9x2pF5Es=
X-Google-Smtp-Source: APXvYqyvJdjvTmwp85J3CXa05ry4xmaYqztXglK2aB7PWLhYu7RK5iBqLq8Ue5UYZUOc45RtFDc7Xw==
X-Received: by 2002:a6b:d006:: with SMTP id x6mr4073667ioa.218.1566005141854;
        Fri, 16 Aug 2019 18:25:41 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e12sm15282871iob.66.2019.08.16.18.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 18:25:41 -0700 (PDT)
Date:   Fri, 16 Aug 2019 18:25:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.3-rc5
Message-ID: <alpine.DEB.2.21.9999.1908161824300.18249@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc5

for you to fetch changes up to 69703eb9a8ae28a46cd5bce7d69ceeef6273a104:

  riscv: Make __fstate_clean() work correctly. (2019-08-14 13:20:46 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3-rc5

These updates include:

- Two patches to fix significant bugs in floating point register
  context handling

- A minor fix in RISC-V flush_tlb_page(), to supply a valid end
  address to flush_tlb_range()

- Two minor defconfig additions: to build the virtio hwrng driver by
  default (for QEMU targets), and to partially synchronize the 32-bit
  defconfig with the 64-bit defconfig

----------------------------------------------------------------
Alistair Francis (2):
      riscv: rv32_defconfig: Update the defconfig
      riscv: defconfig: Update the defconfig

Paul Walmsley (1):
      riscv: fix flush_tlb_range() end address for flush_tlb_page()

Vincent Chen (2):
      riscv: Correct the initialized flow of FP register
      riscv: Make __fstate_clean() work correctly.

 arch/riscv/configs/defconfig       |  2 ++
 arch/riscv/configs/rv32_defconfig  |  3 +++
 arch/riscv/include/asm/switch_to.h |  8 +++++++-
 arch/riscv/include/asm/tlbflush.h  | 11 +++++++++--
 arch/riscv/kernel/process.c        | 11 +++++++++--
 5 files changed, 30 insertions(+), 5 deletions(-)
