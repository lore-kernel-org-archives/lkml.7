Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B178C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B71208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ/ez4+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfGaSRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:17:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44380 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGaSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:17:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so32295218pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=C5LUoF9wt23TkOe1qlJjYDBJ8FM6oQedM0HGhfgeOjc=;
        b=aJ/ez4+lxs7KkM0SRxZVVF6/pqzJevVAc1EBV0/DyYIvbiwmD87VGD+DeBVjPYplFv
         lxzcNTz3nfFo2jkZQWSKjDpl3frMvGj4VzJV14CN3fhEXTt5hgMcc0GNT3pOxnpZ8GuA
         oxtHkqXp2oc89c4sDsKRJnz/FVPXZpSNfiBZjJARBlawIuDR9gFY6apTHGkxx8dj5ENk
         pVPCmwrftgzfb3Ip00rbpL+pDQyazIk4S7gPorocRl/Rlb+8CudlqUo76boF6WwhPcfg
         6edqKwE0LOSZShqa2wdXAvvVpYsqEM1nf+9VUsl6n7FKcGY/4iWyuJM7e357GDUmr1iV
         Z0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C5LUoF9wt23TkOe1qlJjYDBJ8FM6oQedM0HGhfgeOjc=;
        b=TEIoW//e07dFcbLXVvjeDYxpWRHI1Xp/lZ8QaIxqcRTd2DCmlgO/cpt/HH0SkR56Zx
         C+3720fCdav3ihHMe4T5ZkMrblF2USe2SNajbJiVsmx5LcvYrf2BDmMzItrbzHLm+PtR
         Ef7CSPiSapgE685k7Q6xNRKjFIt/5RU9CdmQLpHTXmhpmscmCqD+f5Isz7LLijKp8kBj
         zvpH7yVK+O6UVOfZejHSqv/d9BTHimP7+jGwWSkgTBEvEWW9PJyCPEOVghAPQoAwHZbM
         +K+4rxrK3TSxvsKRZQ87eoonVI5CWaRFCbAAJBIQKxUylkJSXF3Skyl6meKl4x7gkyDa
         bFqw==
X-Gm-Message-State: APjAAAVX7jrfoyoDh/5G29IcLN0W+ZQk/7exo25y4p4K7PdXv3oXytYY
        CsBkAFhdhKCLAcbEWLQWY50=
X-Google-Smtp-Source: APXvYqxIfI11bfEXr6hEhdatJu6SWlztNlTKjBctw5c68rbYscHmra0EnAHZHWrnmz7T9ek4VXZ0Vw==
X-Received: by 2002:a62:2b81:: with SMTP id r123mr47147570pfr.108.1564597060398;
        Wed, 31 Jul 2019 11:17:40 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id s12sm69137141pgr.79.2019.07.31.11.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:17:39 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:47:35 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com
Subject: [Patch v2 05/10] staging: rtl8723bs: os_dep: Remove unused defines
Message-ID: <20190731181735.GA9441@hari-Inspiron-1545>
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
v2 - Add patch number

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

