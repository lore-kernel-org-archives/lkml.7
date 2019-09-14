Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620E8206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CWLwMa0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfINNwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 09:52:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfINNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:52:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so11890430wru.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=RdKdyuMchtAQNR5tLHPOh6qnxzDs2wdkOkgcEODQq6Q=;
        b=CWLwMa0/jg5XrFiCfk6EZWcggOctvz5YacJtR3eGqWKgEEoTTDq1eNfAp8SZy1C2bj
         kS+5mL49/HZCZO4hFttI67TEM1w/1TYnXqe4O6sC6rngosQGUzl4pFO1rbk/DDYn8CNv
         Xv4aBw9v9g7Qe32DVbHy7jhRpnaCAxKvZ60CwV0dIG+EIV4l26ZTmuYU7176s0+UIvU2
         P2AujOj1L/J7j3G2m4TTjHUJNWHdlfs8OZIFCfT/OioLvqAVtCGf90faqItWdj6nZACQ
         eDXbxkzwKunK7278bAEpWluRoeuz/O8hPA7Uu+w73S915UXWoSDIaWCHYWIuVJ3BnqiU
         bGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=RdKdyuMchtAQNR5tLHPOh6qnxzDs2wdkOkgcEODQq6Q=;
        b=RTYXvQ/jSKENeoWonYaWt3z9duc551zgRcdrTDsRdmcEuksiyvwmLnwRirVWU4PJm4
         ypZeXh75TxH86e2qcCPYlUbj/1tDoRP1zs7BW6CWiyeJVVZmVml5hICh1j2pP3ioqZq5
         UGs9CPCXz+5/JbqOah2edpFkDE2Hc/IDyeFR7McqgOd33LllNyLVoFFCkQ366nkFqChI
         OMaL5bz5kkH3bzmThbgBzKrZMkobmDXNpDYvMEgjhuFap6Z+SZoCbvRZzCaKe/2EXJel
         fpOpFfvNrz8YWiqm7CjJS8Z6QrT72fiQIszZUfJ99/QLylvzNKDDuo7JO5gDt407a5Mx
         3zKg==
X-Gm-Message-State: APjAAAV8H5IcUbmadTlBgGO6qDFZHafaKInf5KDnxF43Zu5VOS3Ko/CG
        OtNHr1VDPuYjMtSueo7xsiLO4FSe3vw=
X-Google-Smtp-Source: APXvYqxQZXGxDvytZcxEFYvIkYLbXYnM+f7vgeON5vWCZPwueJv553ZvDKXS047vVPmVnGPS/VeaHw==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr12444450wrj.277.1568469170049;
        Sat, 14 Sep 2019 06:52:50 -0700 (PDT)
Received: from localhost (193-126-247-196.net.novis.pt. [193.126.247.196])
        by smtp.gmail.com with ESMTPSA id m18sm44032730wrg.97.2019.09.14.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 06:52:49 -0700 (PDT)
Date:   Sat, 14 Sep 2019 06:52:48 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@sifive.com
Subject: [GIT PULL] Urgent RISC-V fix for v5.3
Message-ID: <alpine.DEB.2.21.9999.1909140651430.10284@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3

for you to fetch changes up to 474efecb65dceb15f793b6e2f2b226e952f0f8e9:

  riscv: modify the Image header to improve compatibility with the ARM64 header (2019-09-13 19:03:52 -0700)

----------------------------------------------------------------
Urgent RISC-V fix for v5.3

Last week, Palmer and I learned that there was an error in the RISC-V
kernel image header format that could make it less compatible with the
ARM64 kernel image header format.  I had missed this error during my
original reviews of the patch.

The kernel image header format is an interface that impacts
bootloaders, QEMU, and other user tools.  Those packages must be
updated to align with whatever is merged in the kernel.  We would like
to avoid proliferating these image formats by keeping the RISC-V
header as close as possible to the existing ARM64 header.  Since the
arch/riscv patch that adds support for the image header was merged
with our v5.3-rc1 pull request as commit 0f327f2aaad6a ("RISC-V: Add
an Image header that boot loader can parse."), we think it wise to try
to fix this error before v5.3 is released.

The fix itself should be backwards-compatible with any project that
has already merged support for premature versions of this interface.
It primarily involves ensuring that the RISC-V image header has
something useful in the same field as the ARM64 image header.

----------------------------------------------------------------
Paul Walmsley (1):
      riscv: modify the Image header to improve compatibility with the ARM64 header

 Documentation/riscv/boot-image-header.txt | 13 +++++++------
 arch/riscv/include/asm/image.h            | 12 ++++++------
 arch/riscv/kernel/head.S                  |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)
