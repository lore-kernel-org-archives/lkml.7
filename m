Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86653C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF812173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLlV01Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfC1Tej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1Tei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so76410wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7lRspCxlFPLzK4hldvCX5JS4V+Z7U4Plbci4Lx3QQ4=;
        b=ZLlV01Ur26ogbvrBH/87grdXS8KLxjs1Kyovb4Ndh48hz+mEGjwmQXM8CWbTNpRHE8
         49N2WhtgbUihwTkLJPm3M6zr/yXAgzQG4KblKnolAgZk9WsuzXkujcpuVyL7RbVvrQlp
         XnMnSCfjf1GeYzbb6TbaektqtsbB7PNJXEI8oGIVT9V/HbmLf1FdT4OG7rX6YBlUqOUc
         49mOHep26+1FW8DIdCzAM+BmdiOhmZPEVJdrlqEzNVevitqbE+H4N00a/FqJnENAuOeF
         1eL5c6x5iQ+hF0kFLwqWoc+xY6AVoIr1tvXd0XdpDX5o2a+89EuQviTMTxmDGbMdUx5s
         PdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7lRspCxlFPLzK4hldvCX5JS4V+Z7U4Plbci4Lx3QQ4=;
        b=nt2zABoGG3ZRkMJRLAa8dZtU25MSAvlOcA65Bh3qdrOalHHqiW4Vf7GCAxKpUijPiV
         q+pTSrri+DCL0KEANbAY77pbNVm2ZW/t0CU85Zs98MnsFUzyVYLY2mBRIcvzhl6AxFS3
         Fu6IkDIyWaPN4/R50S2Xskc71p9iebEK59YIsbgUoxNMr+bM5C/bKjc0PxWHqhX6AcwK
         QMdHU+E5zaGHAbvKkWnpHVfrmSO1HK9ONmAO29qvKTwBpaSQY7MPrruycjWCq1MLa1rJ
         G7S+JVbnYE+jv24ZARrmg53d+SFpZ4sN5CMm3ytM2QQLvmNMJ0cCfYWa1pDvnz4/s04q
         MO1w==
X-Gm-Message-State: APjAAAX1sNw/oNCw2azs19KZx0BZbMAgAWtSWl+2t3XG2XRLsq0ykDup
        hHuXbDs5Kdn9o5mQh2+/hjhcgg==
X-Google-Smtp-Source: APXvYqzl5i4UzY/SfFF5Kpb0L2mUvBbeaSR+3K7Cce2/611KOjQz6jEHHR28U4YVGneW+dv1tmuulA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr1135900wmh.9.1553801676904;
        Thu, 28 Mar 2019 12:34:36 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:35 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Marcin Benka <mbenka@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Jones <pjones@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL 0/5] EFI changes for v5.2
Date:   Thu, 28 Mar 2019 20:34:24 +0100
Message-Id: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to a72f65180feb446cc59616aab400475679b6ffce:

  efi/libstub/arm: omit unneeded stripping of ksymtab/kcrctab sections (2019-03-28 09:22:32 +0100)

----------------------------------------------------------------
EFI updates for v5.2:
- Squash a spurious warning when using the EFI framebuffer on a non-EFI boot.
- Use DMI data to annotate RAS memory errors on ARM just like we do on Intel.
- Some followup cleanups for DMI.
- Some libstub Makefile cleanups.

----------------------------------------------------------------
Ard Biesheuvel (2):
      efifb: omit memory map check on legacy boot
      efi/libstub/arm: omit unneeded stripping of ksymtab/kcrctab sections

Marcin Benka (1):
      efi/arm: Show SMBIOS bank/device location in cper and ghes error logs

Masahiro Yamada (1):
      efi/libstub: refactor cmd_stubcopy

Robert Richter (1):
      efi: Unify dmi setup code over architectures arm/arm64, ia64 and x86

 arch/ia64/kernel/setup.c              |  4 +---
 arch/x86/kernel/setup.c               |  6 ++----
 drivers/firmware/dmi_scan.c           | 28 +++++++++++++++-------------
 drivers/firmware/efi/arm-runtime.c    |  6 ++----
 drivers/firmware/efi/libstub/Makefile | 14 +++++++-------
 drivers/video/fbdev/efifb.c           |  3 ++-
 include/linux/dmi.h                   |  8 ++------
 7 files changed, 31 insertions(+), 38 deletions(-)
