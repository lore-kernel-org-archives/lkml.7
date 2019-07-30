Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B25C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF37216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GV9K5BkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfG3SRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbfG3SQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so11433148pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esFlUhCptDaWsW0v+X0craB1CNFJYps3K4bWgEnCePY=;
        b=GV9K5BkAy9wGdDD6oWn+1HJFE+ISkUbed5XqU9gEC4s9US0JqZLWCPZTRdPQYDoHNc
         rIfH2V2gzSUdS67p4oCPgoP7iGqBg8yyrGYTuulbLj9TXtR84tZzj06ca73c0yEi9Hor
         OXgzFGpIwGoH93vqWViIaoYXAE3z83KUDYeIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esFlUhCptDaWsW0v+X0craB1CNFJYps3K4bWgEnCePY=;
        b=snvGlX06iGQTOFFCpt33uuObw4uFITF8VSTpkUs0V83WPblTr+qHbYRtjAGfc8IZj+
         A1qXZ8vNt1iVnklCGfm/T6KSJA+lBdPe++0OIk3Zzqzh6sZLt8f0E5GEYbkqxvrkSvey
         x0V3K0LgUIIUX10r7oXo9pw5EkFS1qlog2fFu4Cu/Dqt2oPHBdIcDbxJ5vurKldJdSwv
         nDOSRiWWIVt09Li3FhFYP0TT2195L754x9w9H3Jtlciy7KMri0QtJRqLvq85GT/wYD4x
         zzRoMi/SOygoHuW6H+XftQUAQsEGFqkDZcdZnJgKiTaiNT7lBlyUE+pu1zKUiYDkgNjd
         ZFvA==
X-Gm-Message-State: APjAAAX+SeBROTaGwfG6d7Prsby4FNpjd0XW5rAa+5tMztZZKvKlPPIN
        yaElWz2vJHuxxdzJKG0UbSVQ48hBHF3zgA==
X-Google-Smtp-Source: APXvYqwtoIKdacZ5zLpKXHjF6IHA+Pp6SRbe6vrRSajOM6VEBh7rEC181vgN4wE/eZqSNzhsT/vvQw==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr113399970pgr.52.1564510603340;
        Tue, 30 Jul 2019 11:16:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Roman Kiryanov <rkir@google.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v6 53/57] platform/mellanox: mlxreg-hotplug: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:53 -0700
Message-Id: <20190730181557.90391-54-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
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

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Darren Hart (VMware)" <dvhart@infradead.org>
Cc: Roman Kiryanov <rkir@google.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/platform/mellanox/mlxreg-hotplug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index f85a1b9d129b..706207d192ae 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -642,11 +642,8 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 		priv->irq = pdata->irq;
 	} else {
 		priv->irq = platform_get_irq(pdev, 0);
-		if (priv->irq < 0) {
-			dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-				priv->irq);
+		if (priv->irq < 0)
 			return priv->irq;
-		}
 	}
 
 	priv->regmap = pdata->regmap;
-- 
Sent by a computer through tubes

