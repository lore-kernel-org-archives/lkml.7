Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA1C10F0F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D69218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gtZgeMLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCNOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34430 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfCNOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id y18so4346985lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRwFdE13s8Q6PG8Mo5e/XaK0pY3ZbFPh1fheC9WehV0=;
        b=gtZgeMLNIFZyr2rsu5BZQATbu3VfApodl6aSheQzxpYOcOFmNSImOjJ2EFjXDeQZc2
         ZCP6uH9FdlMjtl/CaDXYwlBtCeUD3Qdo+bZ3qjW7AhVr6yySiCi1ba0orINGSLmYPefA
         oi5KHFQHyH1/sxf8eTg2FfDGsihFBm5TDDvTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRwFdE13s8Q6PG8Mo5e/XaK0pY3ZbFPh1fheC9WehV0=;
        b=bb/AayYjB/gO3JKT1/FEcm7eOWpjrok3odzT80aQPW8A2cc7UdF/GdPoyfBLcdGPBZ
         446pTiNd1U6s+oge8n1IMkeYSMPgFKo5ycprHs+xK+0tAcN/VTQORVtoXe/uCwZ6Fdx7
         n0BTZ7Uhpvd3AuISzocOR6n+E/vZzY8URspgW6X7rzNDgLTvVsXAYnnpmraGdQ8ewp3L
         MPYlw6aFrw8i/9sYn7jYFipHcpTF7R8tu/96NUagSMc+Uptfds11R4rMnjhf+R0UioR0
         v2/UFQzExO+C1OMHty5uiDg/Njro+z+xeb7czREiB9LLhZiE6SpxQbFXou1q2grTX9hJ
         19cw==
X-Gm-Message-State: APjAAAV+o6wh+XDXa+4XzZdPaaDOVSEr35lsxV+VE5E0prWhLq4HD5AE
        DkdMYzNjo4viLjVETt5mIdG20Q==
X-Google-Smtp-Source: APXvYqynhqB6HIqdb62d4RSaMgU6ggzsu0hl24V0NZA58ENcdyLGOLWgqA+A7MZfF4zQLdvneTzV9g==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr5547536lfk.25.1552572384960;
        Thu, 14 Mar 2019 07:06:24 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 1/6] leds: netdev trigger: use memcpy in device_name_store
Date:   Thu, 14 Mar 2019 15:06:14 +0100
Message-Id: <20190314140619.3309-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140619.3309-1-linux@rasmusvillemoes.dk>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If userspace doesn't end the input with a newline (which can easily
happen if the write happens from a C program that does write(fd,
iface, strlen(iface))), we may end up including garbage from a
previous, longer value in the device_name. For example

# cat device_name

# printf 'eth12' > device_name
# cat device_name
eth12
# printf 'eth3' > device_name
# cat device_name
eth32

I highly doubt anybody is relying on this behaviour, so switch to
simply copying the bytes (we've already checked that size is <
IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
still have to strip a trailing newline.

This is also preparation for future patches.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 3dd3ed46d473..8d476b92f58c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev = NULL;
 	}
 
-	strncpy(trigger_data->device_name, buf, size);
+	memcpy(trigger_data->device_name, buf, size);
+	trigger_data->device_name[size] = 0;
 	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
 		trigger_data->device_name[size - 1] = 0;
 
-- 
2.20.1

