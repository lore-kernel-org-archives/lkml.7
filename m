Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A269C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A7206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAJg/Vsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLRDnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:43:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:43:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so619796oto.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTLHJB/iUcLDfSNgBM/rRd3/H05ShntwvWDkcVOuP88=;
        b=ZAJg/VsfqHfAuA79L5vD2Ey6OpHmmoZSS1dDrf4XEoZWod53aC9rF4y45Noqua0A50
         LtZYqDB1iJt43WO4BjCyodOhPdraBw3odtu8MA7i/A9qpySPvR3hHf5uOvjBRLlHGYIV
         FQ4Jt6o80x4l2JzqJRF/DluvbyOVLjOqSMwTbhtmEnCEeMRMrr6YoPZerrCrISuzJiBS
         dcBhss7gTBIZyUz5WFFN3XvcSf/LhG9NKm9SQDFM/mLlGld5HAVcTpZZU9ZF241lawy0
         MNoTo6uE1F26dNLh7GEKt+gPQOdXQPY459Im7iTHCyXLhlo/V+zSN7Fhl1o60v/n1Jm+
         swrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTLHJB/iUcLDfSNgBM/rRd3/H05ShntwvWDkcVOuP88=;
        b=MRYzPWmRMK1uuwGX7zUJEskJnxwqGUZAToImci41EZGx8B/RIxM17cH9RtnHxxIc5M
         hQxOL8s6VQSIzOLUB5eA9eckDK9GNL4cggRUzybpVRWuD4cbEAsHg+6wAfhqslAqVAkZ
         WipLP3hieqMZs2iWlVHTd1J2NAB43I04Tjnv5JGex4xJw+YZ4yTZDkilXF3+/luKyBNA
         SYcjeDS7J+CqZft4ti0fgb+RASZHo7AWJmIqb5ID/CQgk8jQXd5ogymy+eGxjGUa5DyY
         v76l2xwndfkWSr9fIElcN1OAN3XbEjxfubiMfVK9aimdw8Plf3+UmVgvLJlfkKEEfCh/
         huFQ==
X-Gm-Message-State: APjAAAXXq7NU3bShFAoHiQEL8ufs9U/Bfe3MguUdAQEwKovvy3cftvTp
        qs8Pk73NarskVWrJHDUFs2Q=
X-Google-Smtp-Source: APXvYqyWkKYiPX0Oalp+GwJKtbJm7N+/LKAcXm06U7mnzZIJAM/DsOUTb+h0bjkHM9vDH2c+qw6uiA==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr236481ota.328.1576640580929;
        Tue, 17 Dec 2019 19:43:00 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q1sm358262otr.40.2019.12.17.19.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:43:00 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ALSA: usx2y: Adjust indentation in snd_usX2Y_hwdep_dsp_status
Date:   Tue, 17 Dec 2019 20:42:57 -0700
Message-Id: <20191218034257.54535-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../sound/usb/usx2y/usX2Yhwdep.c:122:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        info->version = USX2Y_DRIVER_VERSION;
        ^
../sound/usb/usx2y/usX2Yhwdep.c:120:2: note: previous statement is here
        if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

This was introduced before the beginning of git history so no fixes tag.

Link: https://github.com/ClangBuiltLinux/linux/issues/831
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/usb/usx2y/usX2Yhwdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index d1caa8ed9e68..9985fc139487 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -119,7 +119,7 @@ static int snd_usX2Y_hwdep_dsp_status(struct snd_hwdep *hw,
 	info->num_dsps = 2;		// 0: Prepad Data, 1: FPGA Code
 	if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
 		info->chip_ready = 1;
- 	info->version = USX2Y_DRIVER_VERSION; 
+	info->version = USX2Y_DRIVER_VERSION;
 	return 0;
 }
 
-- 
2.24.1

