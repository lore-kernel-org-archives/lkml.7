Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E4C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D0216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w1gNg8pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfI3NDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:03:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33300 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfI3NDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:03:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so14119883wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrIq4ZVm8xkVZyO8f5Owi3O1Tv53HlREs0EWWL4v/q4=;
        b=w1gNg8prgUP3BwyEHY0icT829DCXzmLYUhxFKoVjRtdaNyQitXh4veJvCPRIsJ1yAa
         EjV8yIaLqywn2OLOjIE1Qiqqlwb35juSylLnUYlGzVFdhIGmVX6UEhYTQ2fTS2s550ug
         +rEmahuc8qfCuv0k9jUnqAVP71g8ErK+jQyWeSZNqOb3wtPyKoNwQ4LtlLVaO2/icP9e
         Y0flzj/3RcC8NaIT8OrfJpYtb1l/UrnuoZrpD0UUN6UBwnj5EAiAAVFjgXjhHLSzMgMA
         nxidQ6CioHKdgup5Do1f2UZjKGdcLsijRVhzgFl1CPphyS5x76IeMjkY9mnL4zLR3avD
         dmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrIq4ZVm8xkVZyO8f5Owi3O1Tv53HlREs0EWWL4v/q4=;
        b=hKpRhkdK5yOOdUDP4ksWFL3kRck+OfXh4V47gfxMX/Lo+58DNhbf4jn3124l0KWkKq
         VBUOetlCzNonIJB1QDADNTb4CravS9LAVtb8A9kwWj1q7v1bD22IKtFqJ9xqTiB4ews0
         +kgF3jAXJ8JvaIQ3csdpQJWIA1pbYS3pBDOzSeh3mtXBuZgiFAhOIFzOZF/2ZQkRjFS8
         rURx3DZ3r5qJSjF21PFw1o/hM24a5vGYSu3g6TRcJCRqCsZbCYxCDlJ45giA5GAnv8pB
         8cqpRQs69M/yzB6sFqz0YxbnxAmZlhJKZXbvNbcj6ECSqsUfpvrZ2UoPhsYjZfFcMs8R
         huTg==
X-Gm-Message-State: APjAAAVsRuuE8scO82EMzyTlSToAJrxvzET5fgX3zcMjzijWOkUTS2Cu
        os9O4GQZuhL4W3mGCwUvKtdDIA==
X-Google-Smtp-Source: APXvYqzN6+yvym0aDjApdak2rnKhCxj3WgNHI4XeHwFPAGwC+jP/VsGclRBJNsmG4KVSjtE79Djsrg==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr16383235wmi.72.1569848584419;
        Mon, 30 Sep 2019 06:03:04 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:03:03 -0700 (PDT)
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
Subject: [PATCH 6/6] MAINTAINERS: update the list of maintained files for max77650
Date:   Mon, 30 Sep 2019 15:02:46 +0200
Message-Id: <20190930130246.4860-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930130246.4860-1-brgl@bgdev.pl>
References: <20190930130246.4860-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DT bindings for max77650 MFD have now been converted to yaml.
Update the MAINTAINERS entry for this set of drivers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..d60dd3729437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9902,8 +9902,8 @@ MAXIM MAX77650 PMIC MFD DRIVER
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

