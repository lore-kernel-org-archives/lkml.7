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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F7D2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWpdLNv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCQSbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46336 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCQSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id 33so14626244wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=N5yYA/kicfXnM4j6NxNa7mLF50I9vME8TkED83otKo8=;
        b=hWpdLNv7j8TO9blzWkd3a+87agCozxKi90XZFAfJsN5gFOG8VtT7j52gCvexUjRy/X
         MBdHlRCQm92Ra4hasb55W+Mbp8sVylhxGq6VazqJPamCBVTZGrAnxTRkoL6wNInslamM
         ifejUyZk5wsiYaGl+g0vZ1n+CknjlGF7YclkHCHOWPdPd2Jn2mPk73b0GOniiv8B0JxZ
         pwnp/gV1Jfhrq1u9A/Nwzp/Jn3OuBAlOWQ/Vr2d3bDLPZGtDNP1eAqkiOwMM/o7DMAha
         EHm/EEU4RAwSF65E/gZpv74bUdm6LhcJ9HoYkGLHFtcHft9x3EhziGhdExdNHr9L3r/5
         2Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=N5yYA/kicfXnM4j6NxNa7mLF50I9vME8TkED83otKo8=;
        b=BggQYWQlvuR2a9ytXPJJ1l6pOUc/SeMBaeXW8wuMEWBvql6YUPqigWlXIJvcCAjAqb
         MxdkT/2ZwYcNUfHV/t0QWyT2XkQba8lg1MhXw9ORmxKSmXhpGo8CmJ4CsnEzxBx+vif2
         x34+SeKu3YXMF9Nhr6RbzuOdtBGlMIUNx8j5c0kUjHqTMf+jPGa6kNSBhXbxTixgGiHw
         4LFOhcYBodnszmCSH3x4mzxaTUzmgB+zw76lYdWe+a9ruIW4h/0K3VvRtdUkmdNU7POi
         7sGmnZo+f2Ymzg9AjBhiemsbg0AiceOxZu82KeaJETi3eZFamY6JAflmSykJTS6cEF69
         NBug==
X-Gm-Message-State: APjAAAWA0munlMoCwIwMCJagERZ5TTGPoz3RLAePaeji2Ocz3Nx1upJg
        vFhgJ0I2Hh/hZA9fDtQyGyp5hknmVCo=
X-Google-Smtp-Source: APXvYqw3o0Yu6xwp2dl4Ohs5yVl+fT5v6iDQaZ4kg7s0w/TVUdekuHi9pKGiEI9hybLK/LJdpil22A==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr2358775wro.20.1552847505719;
        Sun, 17 Mar 2019 11:31:45 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:45 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 08/10] staging: rtl8723bs: Remove Dead Code in os_dep/ioctl_linux.c
Date:   Sun, 17 Mar 2019 19:31:11 +0100
Message-Id: <20190317183115.32393-8-benniciemanuel78@gmail.com>
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

Remove Dead Code in `static int rtw_wps_start`,
`struct iw_handler rtw_private_handler[]` and
`struct iw_priv_args rtw_private_args[]` since they use the Macro
CONFIG_INTEL_WIDI witch doesn't exists any more.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 8fb03efd588b..f1a1baf72488 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2590,10 +2590,6 @@ static int rtw_wps_start(struct net_device *dev,
 
 	DBG_871X("[%s] wps_start = %d\n", __func__, u32wps_start);
 
-#ifdef CONFIG_INTEL_WIDI
-	process_intel_widi_wps_status(padapter, u32wps_start);
-#endif /* CONFIG_INTEL_WIDI */
-
 exit:
 
 	return ret;
@@ -4791,17 +4787,6 @@ static const struct iw_priv_args rtw_private_args[] = {
 		IW_PRIV_TYPE_CHAR | 40, IW_PRIV_TYPE_CHAR | 0x7FF, "test"
 	},
 
-#ifdef CONFIG_INTEL_WIDI
-	{
-		SIOCIWFIRSTPRIV + 0x1E,
-		IW_PRIV_TYPE_CHAR | 1024, 0, "widi_set"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x1F,
-		IW_PRIV_TYPE_CHAR | 128, 0, "widi_prob_req"
-	},
-#endif /*  CONFIG_INTEL_WIDI */
-
 #ifdef CONFIG_WOWLAN
 		{ MP_WOW_ENABLE , IW_PRIV_TYPE_CHAR | 1024, 0, "wow_mode" }, /* set */
 #endif
@@ -4852,10 +4837,6 @@ static iw_handler rtw_private_handler[] = {
 	rtw_mp_efuse_get,				/* 0x1B */
 	NULL,							/*  0x1C is reserved for hostapd */
 	rtw_test,						/*  0x1D */
-#ifdef CONFIG_INTEL_WIDI
-	rtw_widi_set,					/* 0x1E */
-	rtw_widi_set_probe_request,		/* 0x1F */
-#endif /*  CONFIG_INTEL_WIDI */
 };
 
 static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
-- 
2.19.1

