Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C8CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4FF2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ION8LIsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfJUMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:44:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbfJUMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:44:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id r141so3063582wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCkJW8hsmdyLXFt6MhpHpJY81uuJvP6lUEoz3ZFYt/w=;
        b=ION8LIsvfEy5SqihAZKz7LKPRfMSL7i6m0aEyJki29pNZWbjKk5IQCX6MEmGEpqUcY
         5L+aW90H+eyc7YrYq8Qxq76oXlq2KQ0ybB+GYKjfDtZrVzKyb8ZAVtMxwfox5VhVXu4e
         KPc4VgpUhHqqgCdP74oIbZHVw3MIkmloiw5RXczIk0Et1UGrFB/fibdaR48SvB4pzDSa
         9Q0607kMFH4qSDLamWjbbYmbqvcuL6Sh6dt1QSjNRhQ114snxRNfxAl131lB1AR5G49e
         tFcH0mpJdVSBZesAxS3+pfYZHIctHKmrZBWbDNyXOuQCQ2iljgU6e6zV3LYDoHgsdobQ
         U6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCkJW8hsmdyLXFt6MhpHpJY81uuJvP6lUEoz3ZFYt/w=;
        b=r0X9qnbCDZ0zopmhaA7iDmUnk75JHI4hm06/yJ6/CY4A7wt9TARhF6ylqef3B/dll8
         HpDb1aamG6bY6jThOuFUwHiPIfFjTVEUFtuavLYKeit9i4x0AJppXzmdtb//Gh4Nfnoh
         cz+3AXH/HobtS+4bBrBXKq1JUM1c6wwhfh2NUx8imojWkDWhr+XbporBhQS6wEkG70u+
         3ca+qqzVeXMkVyLQT3AO/h9JZ32pYFsk5F6lL0pT7ygm7zpDQnNTvnO0LGExykUg5ewF
         A7oDuJNk/CVmEsKUxV8R424ZTKmyf2aQo4mwRjPaASYi5QAEhiQgtGs0J65VZwcLzygr
         kz1A==
X-Gm-Message-State: APjAAAV6OPPXwh0A6azx8lIgTcsnzAjI+WOyYRemkSg3deImXM+Yck41
        7YpSDv88KlfkExsRNggS4TwE0w==
X-Google-Smtp-Source: APXvYqx0+yUmRQS7ukveB8lxPxiZgZjPrOEofvzcha2EYE39MifDue4d8z23bg2kYvWFW5FqkLtuaw==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr6671242wmd.103.1571661881081;
        Mon, 21 Oct 2019 05:44:41 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a17sm10216150wmb.8.2019.10.21.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:44:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 6/6] MAINTAINERS: update the list of maintained files for max77650
Date:   Mon, 21 Oct 2019 14:44:28 +0200
Message-Id: <20191021124428.2541-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021124428.2541-1-brgl@bgdev.pl>
References: <20191021124428.2541-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DT bindings for MAX77650 MFD have now been converted to YAML.
Update the MAINTAINERS entry for this set of drivers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e51a68bf8ca8..aba7de45a7ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9903,8 +9903,8 @@ MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/*/*max77650.txt
-F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	Documentation/devicetree/bindings/*/*max77650.yaml
+F:	Documentation/devicetree/bindings/*/max77650*.yaml
 F:	include/linux/mfd/max77650.h
 F:	drivers/mfd/max77650.c
 F:	drivers/regulator/max77650-regulator.c
-- 
2.23.0

