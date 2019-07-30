Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8AF2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nn4jyTto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfG3SR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfG3SQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so21657993pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drpvbwUEmUOqA3rSa/EHTjOXz8bDuvvIlVQlOazqbgk=;
        b=nn4jyTtoTH9EMFWnV9qKEVgmKzU6j7rTN7ZN81N8sybrrR929M2kyR8mWylfC5gGIf
         bu5GBll3oHbvOyBmuQu+k7OVAvIQlaQ3I2+3kCQhOQlP61Y+XxlbSeyZi1Az2wTEt7aW
         jzN6RM4Zk6JorcmqOmzg2N6UBzSygP63SU10I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drpvbwUEmUOqA3rSa/EHTjOXz8bDuvvIlVQlOazqbgk=;
        b=k43jvlZmotbr0kaZnOo9CzfnkHJfA+jDZn3gXDUG1l34rbSrvbdWVpyw9S/NQ3lQiK
         2GBAhHAQMZGptfCimHf0dOk1xqBSwXyM3psPX6Y3Ap0YcshkaqZpXVsL3bZpaZnIUo5M
         HuVMjANiPTjso6O//V28g5wgS9NCq1otvFqZLd8fiqoohJAmyoyfnQKZDCA89wKAIZ8q
         9J0SPVORPznpVCYWDG6s01/HSSslABVIOFgN6+bLr8lHhQNcNm/TQdPDHwEH3zJQHmDo
         VWsZzID3oDBYUejCuStQrcDtrpnLCOQb6nodPr7GvoFPi/RkXI3gwpNqb5Z6lo7tK2KV
         pVQw==
X-Gm-Message-State: APjAAAU9x14tqkjIRxDk5E8tKD8fwwd9DZA5+HOBQQHQEg9AslWg7hKI
        2LUASpaAtcLerx5EY3Qy0IaIeF/RuqgkUw==
X-Google-Smtp-Source: APXvYqxN5aOtZPn1fNcdcsOE/IvEp6rYADNvu5y7Uo8PjkknLasyDwZtavI+yaiFRABIEE/tUaqmHA==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr109671681pgj.4.1564510606703;
        Tue, 30 Jul 2019 11:16:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v6 57/57] ALSA: x86: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:57 -0700
Message-Id: <20190730181557.90391-58-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 sound/x86/intel_hdmi_audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5fd4e32247a6..cd389d21219a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1708,10 +1708,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not get irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_mmio) {
-- 
Sent by a computer through tubes

