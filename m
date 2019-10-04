Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B66C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j2VU4nhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:36:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36075 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbfJDRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:36:57 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so15302061iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=wY8a4I6EvPZotqzLTyscITojeAnhMbow8kNJLZSccGA=;
        b=j2VU4nhudfCwpOV14M8+kBsDhVuSQiLUgOglDWxA9Or6YplVHi0izJ84RQ6xD5qfQY
         Ypifmxa2jOePCXYgtHaG8m3e9xMkrYNk5TwCfsGKfC1AWobdrLtnp/2qEncRXNL+um1C
         ti22ewBrCqeditYfBbebGBqzOzlLx8rPydAq0HyjxxnCxoNXNoX1kYl7BGiDuzc1JAYs
         mawjrVPc/BTmgs+FOXzC3/uiX85pBulABLMNNLkbXSqT0bh+U2svnvpLf3c5DNb1arL4
         p50k6IBbrwlShDOXZQp0sEZqxff3RMZA/sOG1bUbgR1SDmAPq1OZpOc6AIS0JFFMmS97
         wa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=wY8a4I6EvPZotqzLTyscITojeAnhMbow8kNJLZSccGA=;
        b=qgLG8TDsADGw9DHkGAGMAaHyger4e6wYOOhRqUss36oEuJehGQsAnkwaT5np1WcZUZ
         eKwRstRv4Li0OdqTn7VQ2KWGD6FEr5Tm58VECImFNV4/nY2+zGuQ4WuYGyrW/tEALpB2
         tm66KxdpJOgPT0wJDVIX+0KCX5HOhs5sAQyiggm1icH7OE5X/UBKejHPF0WgXKoD9YtI
         AxegC3VUEtbjly9kc8od4a/SR7Cjtf4JdnMrcoCT0sAL63mk9c7a0Ps3ECb3XP5Cy+p7
         ipf2LYc3y4L7PQJdFBmu1V8ytcw7bQ+WCDdBQbyniY6e7FOAE5fG7l8tDp1zjeR+X4wJ
         9/gQ==
X-Gm-Message-State: APjAAAWXbzUF8dry83rcO0w0AWRf+7KO3RODjaZxDDMX6VC/Tja2tewr
        EA8pLgC5LtLjlBbihCyD/+bYMw==
X-Google-Smtp-Source: APXvYqwiiyfcO5zfpFG0B4LUXjsy02MITOscolsE3p87ClD/+IpiRYj3xKideFfLwgHqf3N/ClEFGg==
X-Received: by 2002:a6b:7b01:: with SMTP id l1mr14101296iop.292.1570210615947;
        Fri, 04 Oct 2019 10:36:55 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id m14sm2634004ild.3.2019.10.04.10.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:36:55 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:36:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.4-rc2
Message-ID: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc2

for you to fetch changes up to 922b0375fc93fb1a20c5617e37c389c26bbccb70:

  riscv: Fix memblock reservation for device tree blob (2019-10-01 13:22:39 -0700)

----------------------------------------------------------------
RISC-V updates for v5.4-rc2

Two RISC-V fixes for v5.4-rc2:

- Ensure that exclusive-load reservations are terminated after system
  call or exception handling.  This primarily affects QEMU, which does
    not expire load reservations.

- Fix an issue primarily affecting RV32 platforms that can cause the
  DT header to be corrupted, causing boot failures.

----------------------------------------------------------------
Albert Ou (1):
      riscv: Fix memblock reservation for device tree blob

Palmer Dabbelt (1):
      RISC-V: Clear load reservations while restoring hart contexts

 arch/riscv/include/asm/asm.h |  1 +
 arch/riscv/kernel/entry.S    | 21 ++++++++++++++++++++-
 arch/riscv/mm/init.c         | 12 +++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)
