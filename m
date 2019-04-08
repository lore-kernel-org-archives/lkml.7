Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D00920B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E4FwahmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDHH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:59:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38607 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:59:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so13582145wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRrlCr9wFt5+t8SsfrW8nzdrvKLJ7bDsystP/rm2nsE=;
        b=E4FwahmUqHYEjwgtG/wBlxdN0Jdqpfz8iZLGJX2w76Vyy81mYFx5hwhxfLBLbBqjS7
         QWo2X/1g74bbKD+heXO1vnzHpAryvFLjrNp5K/0EWgL+yTt/9UtEj8wl9NORQGtv0ow0
         OxsYUJREQu8p1mQ7w8h0r1f4bb+1GefEidhswoJDR2glQbzorLwIVzzlKkZCYrUiyy31
         YX4hiwB8Ls3AX5hVZWVd7tJhJZPRE63J8F1L4DRLPfKGpuOCvgYQvMGKGvTdZey8u1oe
         3RLgo5nRWkJPoMIEDbgZ9RQZwymXAXbvtRVdOC/YFWdWpKt+hGuecbYAm1XqUj7ole1A
         AUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRrlCr9wFt5+t8SsfrW8nzdrvKLJ7bDsystP/rm2nsE=;
        b=i9lCwykqgdSWf+AeGY9sfeeK38N9icRqjhcz0kwpLlvijZvDQmp8L3fkmiVCAle3yo
         ASNurxmvcZjc/jnslGqBMT8LTD7sakmVnvGtC/el07eN9n59B4/P7uXdiaCho34O0c7O
         3YFDcbaq86FYawkU6yZ1bGlBAur01PWVDEHaZ33AJZZ0lsdTULIre82qjyws0IAsYwsB
         L14iJNZy8PS1nkkfiFeU9z221y8YTXbfSte0xjmPjrYg6DkauGZfJ6HcahnCQioPxqwA
         tFGkg+CW8hyLmlENFzzm9hOC+OLqo2lc48qavF86Vfdd4wQEVXYz3SZW0gztp/XNR/hW
         o9Vg==
X-Gm-Message-State: APjAAAVlLoJN+ZrrYiMTdHPNmbzuR1ZfCVxyHI3KwLI2/wetr+RE8/Py
        XaQh15NCTRsSouZLwsvJ3XoHNPDen5w=
X-Google-Smtp-Source: APXvYqzoAa6q8RLCqB7ziPahScxeeEflKSjnM2SWqWiSzeWoA13dAOdnTi0vUAtnxl8kGkgdSxXr0w==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr16543228wmj.31.1554710375107;
        Mon, 08 Apr 2019 00:59:35 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-12-194.w90-86.abo.wanadoo.fr. [90.86.215.194])
        by smtp.gmail.com with ESMTPSA id o17sm31658711wrw.73.2019.04.08.00.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 00:59:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/3] ARM: dts: da850-evm: enable cpufreq
Date:   Mon,  8 Apr 2019 09:59:23 +0200
Message-Id: <20190408075924.2284-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408075924.2284-1-brgl@bgdev.pl>
References: <20190408075924.2284-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
tps6507 pmic with configurable output voltage, so all operating points
can be enabled.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f04bc3e15332..f94bb38fdad9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -191,6 +191,19 @@
 	};
 };
 
+&cpu {
+	cpu-supply = <&vdcdc3_reg>;
+};
+
+/*
+ * The standard da850-evm kits and SOM's are 375MHz so enable this operating
+ * point by default. Higher frequencies must be enabled for custom boards with
+ * other variants of the SoC.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.21.0

