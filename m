Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC0C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65092075C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJc/Z0Ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfG0MrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:47:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36028 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0MrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:47:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so25783407pfl.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vCgH18Sx+HG3PjjMYsyJR+T5KOZZ1lCW+dOldljDzvU=;
        b=XJc/Z0EaEU4mkmhHwZ/sDYw7Vun3wx5kEA6+/KUnOX5FT9/bJyQQBGulBfHXI8kosg
         TLWKOD5Y0oYcoGvxX1v42XNkBbDqmDQ/4jqera5P5HKX928NIztp1ZGtwDEIl3ASg1js
         2BzR/1pDU/t59iX0oozRc0aTAv03WSNsewRwk5mpo0241UvBPKBxu+aW9nHBtFKLP0me
         pz+JXZa3xKSqNqLimzJDN8AcYBToC6KngjJsVb1QQfiVhbN7RgS/4QveJmSymeX5+eds
         q0Iad3lexazmGkmtNuQkIwtHO+4XBzPxCuDRZWTd8N6OtQFGLIr6QwF5+p0urMicmwuY
         cpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vCgH18Sx+HG3PjjMYsyJR+T5KOZZ1lCW+dOldljDzvU=;
        b=QD5JUTQDSIIotEbVt/9K5XqOPn3gyBRFkVIo9scjuMVPD4h9VuPJFC4lQNg9tTw6zP
         Hj1+Sz7x5kAYNHP8Qnx2J7agUv2ya1GbV7O+GLFCGrxc8Ouz5bOPDGZZbWmDOybCCb3W
         qAfGyksTnYfl95nl7rjaoPkFQY/KotZkGNMQYW7hBP/dlo0srKRLPOIqtfFKLcUsWrip
         p8ncQ8kFkcemnFQSKTuhOPhudxGmP9uMhcKPj7ZX/DL3jX4Z1L18DU5cce4ZesI8fEte
         Uj1Bzh89czzQ/e8C/fwWZ9MNaCH2S+hJMBD7R0SkFXMshSm92S62dDiuWZVpsD3dcNMj
         di/w==
X-Gm-Message-State: APjAAAWEaulbrBoRHIblufEaHNHB/ei79erVlipz1dDWEv1VmFX3YOFc
        kKVT3ILCI7JpxfFNQOtRZO4=
X-Google-Smtp-Source: APXvYqy3/fig2ne1YkWYjVCjGBDdGWAGaCWbJi1DUQ/9F0vceF170kOGOvn52SdQy4awnJixaNN0kA==
X-Received: by 2002:a65:46cf:: with SMTP id n15mr1881375pgr.267.1564231623635;
        Sat, 27 Jul 2019 05:47:03 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id e189sm34311617pgc.15.2019.07.27.05.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 05:47:03 -0700 (PDT)
Date:   Sat, 27 Jul 2019 18:16:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove unused defines
Message-ID: <20190727124658.GA7829@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below unused defines RTW_CH_MAX_2G_CHANNEL rtw_a_rates
RTW_A_RATES_NUM RTW_5G_CHANNELS_NUM

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9bc6856..30165ca 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -19,8 +19,6 @@
 #define RTW_MAX_REMAIN_ON_CHANNEL_DURATION 5000 /* ms */
 #define RTW_MAX_NUM_PMKIDS 4
 
-#define RTW_CH_MAX_2G_CHANNEL               14      /* Max channel in 2G band */
-
 static const u32 rtw_cipher_suites[] = {
 	WLAN_CIPHER_SUITE_WEP40,
 	WLAN_CIPHER_SUITE_WEP104,
@@ -73,13 +71,10 @@ static struct ieee80211_rate rtw_rates[] = {
 	RATETAB_ENT(540, 0x800, 0),
 };
 
-#define rtw_a_rates		(rtw_rates + 4)
-#define RTW_A_RATES_NUM	8
 #define rtw_g_rates		(rtw_rates + 0)
 #define RTW_G_RATES_NUM	12
 
 #define RTW_2G_CHANNELS_NUM 14
-#define RTW_5G_CHANNELS_NUM 37
 
 static struct ieee80211_channel rtw_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
-- 
2.7.4

