Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ABFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4938B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx7Zd1DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfDSTHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:07:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfDSTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7945315wre.7;
        Fri, 19 Apr 2019 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BK+hMQZhbc01flr8GR70aSzxt77OZF9p21PsIdL24yQ=;
        b=Sx7Zd1DLOo8hWgAsVsWBEFYxGJ+IXXaZr0PLYzzRRCQXJ5JeAwNRUdfFhAC26v4Fyz
         5zmFj00NwG/77nthJEY6t7pYt/IaRgMc6VnBqDuEq/bzrj3Rb+3ey6gHTk6XBPZgIyPD
         yRxzNHQ9sEkCHkMghSYSKmO6j+JLq1holWnksi1TAZk7GQKz8kxL1kqlVVGQmlMNuCtS
         uck2v2limBP8lqH/ZD+67qyjPgclF1ndHLFMVKKO8vLQIee/2D5OxcONZLQDnElitV9w
         80Hw5yRTtE0nwBdv1sCZ9LBZS8OVTfhAaeRDfd+OKe1NltnyO/dXh4t+h+qHQMwgfZrZ
         +iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BK+hMQZhbc01flr8GR70aSzxt77OZF9p21PsIdL24yQ=;
        b=qvHsBiijj2CPkiAnxJT30XzWNeBBTSoQsTM20alWmZyJqkGeZSP5GGMPZUSZW8vyQm
         UTlS85nZeetSecEC8dlGwAX/qSK/asZDEPovLWU5HkHx7RPjyglJkmzZf4QbCb/+K3+s
         QdyOYFG1qbeaZTCiI+FG5QPJtQRH/nYm+OR8MQ1Wm6SixaBh+TObCTM+ZiJv4pyS6NrM
         8gdCgyfthurjidHJjNDTIoJMAENkS6+GptGWMesHy2HrjjWcZdCyQJyvytebYsXgWPBd
         6pnUEcwtknugAOi9zwmKTAvpnatL4ndjeOjE8GwHjq6Rtvb/y2FD2mcWIZEMiJVitoyE
         lUyA==
X-Gm-Message-State: APjAAAUBC9Yd2k3eVC/WfpoYmkXKvXyJe5A6oItuNqeyD6IgS1aJm+po
        ont149O51+3AeFmem9TumNsar462uls=
X-Google-Smtp-Source: APXvYqzmbJn0qxXoGUnseuwmlY339mJox3Bzk9jmKHxmC6rhGfq0VwFaEAohsbCt/unMcwdeDKV55Q==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr2349078wrp.172.1555668700232;
        Fri, 19 Apr 2019 03:11:40 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id x5sm3680563wru.12.2019.04.19.03.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:11:39 -0700 (PDT)
Subject: [PATCH v3 06/11] platform/x86: asus-nb-wmi: Add microphone mute key
 code
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <27f68b4c-69bf-2129-955e-3a686848fe32@gmail.com>
Date:   Fri, 19 Apr 2019 12:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone mute key is missing from sparse keymap. It is present on
FX505GM and possibly other laptops. Add the missing code.

Also, comment on the fan mode switch key, which has the same code as the
already used key.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b6f2ff95c3ed..d2399ce0b3cd 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -468,6 +468,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
 	{ KE_KEY, 0x82, { KEY_CAMERA } },
@@ -482,7 +483,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x92, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + DVI */
 	{ KE_KEY, 0x93, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + DVI */
 	{ KE_KEY, 0x95, { KEY_MEDIA } },
-	{ KE_KEY, 0x99, { KEY_PHONE } },
+	{ KE_KEY, 0x99, { KEY_PHONE } }, /* Conflicts with fan mode switch */
 	{ KE_KEY, 0xA0, { KEY_SWITCHVIDEOMODE } }, /* SDSP HDMI only */
 	{ KE_KEY, 0xA1, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + HDMI */
 	{ KE_KEY, 0xA2, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + HDMI */
-- 
2.17.1

