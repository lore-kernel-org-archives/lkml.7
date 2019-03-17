Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154421738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i81CYTxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCQSb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfCQSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so8005820wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=g7tOxAcFEx63LQwUzdEe3ozHSxRGGrriyldxHFwb6O4=;
        b=i81CYTxM7bpmF9A/mBDaleYRZixf8K285YCM9jwthIQ5lSJr7A3TFPeIO1FWEceRYy
         ZI8noCPouzliZMI5DFRPcv6j0t50A2bmHAXPkp6eYyMAgfbjLwhi6zPl8LfhQvcYEEJ7
         RjxDBDpTcH8YMzb7+/D8dIZgDnHuoNFNHBwRVU8kd4f9TMHEzeqUIuz88ARSHC2eSjy7
         CcU0vOQpaGPXpdDLNH4E3dqUm4rHCM0J36C8g9wobHjZdn4ES83b8lvBHbYMrVShAqOy
         jHKvrqeWWZiwjX03Hc84t711NrjTL4V7jvUGM5zfJegOn1a12B8ipQ0w7Y1dNsJHoYkW
         W69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=g7tOxAcFEx63LQwUzdEe3ozHSxRGGrriyldxHFwb6O4=;
        b=Uvp7h6cbEULss2VTIL9HyA5JSsaZOQGqDMoed02X0tPuoZr8OUX2xi1RgJx8yybpzr
         1E/VhBL2voKjNi5ZgBRyo3jo5+mC4yH4VK8lxhyTNs0Wr1w00kFNkb2myfAWS3LReHNz
         c6SiRZkRWY/82aD/bXTqjgRxzuQ+b3d7cyj3TnvsOaIjcwLZlyuQ5+XzekXMpouGAscU
         Uo5W74tsOhx+VSSFko0rZ3+/+2BVyF9Gx+OhIKLVRw1T4zPTZzl/f/nNE1Cv+Gu+rAq0
         T34f+94PEknfVTmC62+c2yV8QohfcAXPVWcp8IAFMNTKtFl0JlAURH0YrQV9VBc+C0V7
         cWEg==
X-Gm-Message-State: APjAAAVZWwjtfCXf2LwYVIG8NpbF0Q2zqaNeShwM4M/b5izCKHlNM7/v
        hQO9vu8mnEmnYbRAIQensiB5ScP4bN0=
X-Google-Smtp-Source: APXvYqx3koVpfFBR817aosLklT/ix3x72g+jd/9V/JUhQhAVc+A0KO6CQ4m9DJnOLULHexzPi8vDMA==
X-Received: by 2002:a1c:2885:: with SMTP id o127mr9228429wmo.135.1552847481371;
        Sun, 17 Mar 2019 11:31:21 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:20 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 02/10] staging: rtl8723bs: Remove Dead Include in include/drv_types.h
Date:   Sun, 17 Mar 2019 19:31:05 +0100
Message-Id: <20190317183115.32393-2-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`rtw_intel_widi.h` is never included due to CONFIG_INTEL_WIDI.
This Patch removes the dead code.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index bafb2c30e7fb..d29cc18a0ecc 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -37,10 +37,6 @@ enum _NIC_VERSION {
 
 #include <rtw_ht.h>
 
-#ifdef CONFIG_INTEL_WIDI
-#include <rtw_intel_widi.h>
-#endif
-
 #include <rtw_cmd.h>
 #include <cmd_osdep.h>
 #include <rtw_security.h>
-- 
2.19.1

