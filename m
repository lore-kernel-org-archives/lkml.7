Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B12183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u4q3BTrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfDRMsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44117 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbfDRMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so2795663wrv.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEmzBEboKIGTezlbO3ot+XflyRscqj5u91q4CMrx2UE=;
        b=u4q3BTrLMqXm/Udjmd/qNWIWU8LJmqNEWfZ3DyyFFKrNQpGn0lG0+w0L+C4tnUQydO
         3AHjv8xfkLSJ6JAGPQP3IlDtzIMjv9uchYFdmG7PmUfvu0PNJmymrLHREDEacb4xoJx+
         DrzfxAuWfPq0c6DktTV9NnyICRHLinKHWFkubv+TqtEXOZlNAAvLgHbIX7/1M74JdOFa
         YssBzaSYUNhlb7OuV1ttUIVstPqcYfH9g2pIiylu9qNqi6quFHZZPVzM68/rnKxw9ZDn
         lrRlgQVGZPuCl90Tdv5jMAW/0dhZI+huzzG9F9UkuLn/UdVcTIk1wKU3SsBZthLnyTeg
         p4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEmzBEboKIGTezlbO3ot+XflyRscqj5u91q4CMrx2UE=;
        b=HxIfEZVLcLUqBtuCD3ejfMm0cHsEQmCzxg0uHaQUyEQtZXTGFKc75tYYXNzj4J29oD
         3hQRIKS+onMEnPq2/dfoAuZjZ3Ix6clifS04Uxowlu4r8wkXsbssEhl/VHrhu4TkQXfm
         SRts5RDt/HEA20XIOSUX7gWVHnlcGnEHJUgGOgXDPnhUnW+ywuNaHujd0UuUU1cQK7tQ
         YwJzRDpOX7Y8Vwo6xnTfDs/OQ3pAUopGnn5sBOe/8LxRvqcun/Nb2ClZxSgtczd+b9tu
         jWbyqGtOIDIGc/R6JPAcn7yFM+0lnlssBpN5Gg+XTAR0awhMlYNJIqtj3fm49KB2Cd3j
         qGOg==
X-Gm-Message-State: APjAAAUVBEFf51AYLFuJiIfE3GIc+NZh/jNHKfTgqk1pepZrYkQjEQMt
        j9PY1CAV0WDkTkvNxaxjA8f0pg==
X-Google-Smtp-Source: APXvYqwNUgYTLOwXqXYz4vTrM0NN+0xqSjHKC1RpVZCz5Zf0JHeJBz/Yb3OEX/2GORWOvyzSmLljAQ==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr38287929wro.293.1555591683176;
        Thu, 18 Apr 2019 05:48:03 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1256823wrw.70.2019.04.18.05.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:48:02 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] pinctrl: generic: add new 'drive-strength-uA' property support
Date:   Thu, 18 Apr 2019 14:47:56 +0200
Message-Id: <20190418124758.24022-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418124758.24022-1-glaroque@baylibre.com>
References: <20190418124758.24022-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drive-strength-uA property support to allow drive strength in uA

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/pinconf-generic.c       | 2 ++
 include/linux/pinctrl/pinconf-generic.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index b4f7f8a458ea..87393e9452b4 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -39,6 +39,7 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH, "output drive strength", "mA", true),
+	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH_UA, "output drive strength", "uA", true),
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "usec", true),
 	PCONFDUMP(PIN_CONFIG_INPUT_ENABLE, "input enabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL, false),
@@ -167,6 +168,7 @@ static const struct pinconf_generic_params dt_params[] = {
 	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
 	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+	{ "drive-strength-uA", PIN_CONFIG_DRIVE_STRENGTH_UA, 0 },
 	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
 	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
 	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 6c0680641108..72d06d6a3099 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -55,6 +55,8 @@
  *	push-pull mode, the argument is ignored.
  * @PIN_CONFIG_DRIVE_STRENGTH: the pin will sink or source at most the current
  *	passed as argument. The argument is in mA.
+ * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
+ *	passed as argument. The argument is in uA.
  * @PIN_CONFIG_INPUT_DEBOUNCE: this will configure the pin to debounce mode,
  *	which means it will wait for signals to settle when reading inputs. The
  *	argument gives the debounce time in usecs. Setting the
@@ -112,6 +114,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
 	PIN_CONFIG_DRIVE_PUSH_PULL,
 	PIN_CONFIG_DRIVE_STRENGTH,
+	PIN_CONFIG_DRIVE_STRENGTH_UA,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_INPUT_ENABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
-- 
2.17.1

