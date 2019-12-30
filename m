Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B85C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF57C20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="EA7HTUbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfL3Icl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 03:32:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38519 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfL3Ick (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 03:32:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so17655575pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 00:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s7ohP3Z8i+XydTTvz21BD2f0Cry8Bo5p1LTlT19B4g=;
        b=EA7HTUbqUnIitOM9hMwC5NmMDjt5Dl9ltD+1qxOpdpPIW9UHf7+tI7Qy/oQwAtA4vW
         H6HG7HTUJCxGZnGuaxRKAwpEFnEbvqT/ImBccHuptDEIE4FQ9VW0q76DkR3wdHnkWOdi
         1Pgp9zYBO+fenX2k0p4jKRuM1OBeVz2LRwwGeoZh7J9sFelNo3LBBSDQ14VzONb1FfRh
         2ddpzvkaDCB/SjXaFrZ2MLI/tNWetR+/WwmDDHlplsZZwcA0P7zS4Q+TLTsk4HOh75sX
         gdTGlErVdECuB1qagkgC+e6uynre1XT9kVuEnutUu31MJIq47pBHbO9ts8g2c1SV9taI
         tcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s7ohP3Z8i+XydTTvz21BD2f0Cry8Bo5p1LTlT19B4g=;
        b=DU+DklKJvlrKeCC98vkiyXb7y2/XrAyPQDuQ+caNErN8X4tSekhjwQoTZCcs3PuUlH
         JSOiC9aaiflHE5iySW/EmJIV37n8KwBb3dMrLICyQCPRj4ioBcOnzQ+WoXMWGeTtW2go
         q75/uTfPZ9KWhCFso5hAWLKXSe6TVP5RsMHlobLGbO4/PiYiY+nVRjEetkyc4OzdT637
         1obfhAYWs81UvbbFS9EaLlEixR9SHdHqqfM/R8tuYXpPjHbWvg9yG3sBZ2DV1lzh+b9S
         0tdf0KYECjJ/Zlpn3c1Bv2g4kjzDe+e4lPYlf/FrDdrXGstp3zMPzbKnR/91NbY71dEB
         5Yeg==
X-Gm-Message-State: APjAAAVSnyASrycYUy21vMvyFR3nxW5/FMm4OomoRZqV41SrJne5Hy78
        K/gWmiHfy5p8/0hqj6yEjwcjaQ==
X-Google-Smtp-Source: APXvYqxFKKazEmaMHoujQh5jNJgTodqHmA3KCyczG78X9j4EM0Vr0BNNLetv2mkg+9uwCmoNZ4gBDQ==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr70387114pfp.0.1577694760024;
        Mon, 30 Dec 2019 00:32:40 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id 17sm51485268pfv.142.2019.12.30.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 00:32:39 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] platform/x86: asus-wmi: Fix keyboard brightness cannot be set to 0
Date:   Mon, 30 Dec 2019 16:30:45 +0800
Message-Id: <20191230083044.11582-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of ASUS laptops like UX431FL keyboard backlight cannot be set to
brightness 0. According to ASUS' information, the brightness should be
0x80 ~ 0x83. This patch fixes it by following the logic.

Fixes: e9809c0b9670 ("asus-wmi: add keyboard backlight support")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e01635..982f0cc8270c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -512,13 +512,7 @@ static void kbd_led_update(struct asus_wmi *asus)
 {
 	int ctrl_param = 0;
 
-	/*
-	 * bits 0-2: level
-	 * bit 7: light on/off
-	 */
-	if (asus->kbd_led_wk > 0)
-		ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
-
+	ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
 }
 
-- 
2.20.1

