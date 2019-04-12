Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0642084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wcBH+37N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDLNpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:45:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40747 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfDLNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so12024663wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cr4z6ZEvJ0E/tRj3gBnqXG8/hg0nGD8grCsnU1bR/Tk=;
        b=wcBH+37NgpYnPP2SCvHO5FiRF3JfiXT/cxBOzMimqsslHUz/M5pCjOt7Z1n+9LOBJc
         DDqsIPizzXNG8UabDqasLglncqqZ8a/m6N1VYAMyl0xEVjeOZeDOMZkvZ+TRFNiSZzuV
         T4ODjzTxC/559nPEp3nUiZ5Fc41SdzuwsKbfc1wwxQ8/626OJEaXVj41nCweW2y6wGgr
         7loXt8KWC6/7XZIm0Hq4XnlCFLzAWg+/N6SH4oqWolIASWbbMx1oRtg8vVFsRepQ+k0r
         PWN+63CtK0dGACIj8fi/ZR3pE2qWyRluZS7u5IdIfOz/U5eFZ69iEWKpQxtns8U0ZQVT
         gdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cr4z6ZEvJ0E/tRj3gBnqXG8/hg0nGD8grCsnU1bR/Tk=;
        b=Xn+j5zNIA+skdQmD0XdtmY+OFuq/0kFG2442lGp5H0wbK1+HPRfA9R3WnVBw6LbvhM
         IxmqgViXrerpbuWVdEBIgtsal1bZ/iXw+J5ZCuHStbJSPUza28orpQZoev+SidyKMKsH
         aTfkI8cBVMuRQf/hRbdffzN3nX32rf0ycVC/qiu7eLTWXputYy6VxXAGrbR/lBJMXSKu
         fvhnnlYkHc67uIrI4EsqxH1qcKUYH094VFIxzts0SlnwG4cggmPruoSzpXMV7C18+SPG
         6MHBvbxnanaIFpUsvUBLp+oBdNjNrOLKe8tpIaeYXP3Ih9UkHUhitXBfrbpOKDb+G+yW
         Taag==
X-Gm-Message-State: APjAAAXDNkoiH0aH1abxLaeHU2wbznthpz1FdTi6FVyCw+4pCtnlZ5hw
        3r9rBcYyeQNPffadQevsmoJXIQ==
X-Google-Smtp-Source: APXvYqxg60+VXaOJhJMYQuOPTJcsIroV5Ka44zOB9G/hDb6hnD7NHlBzaAXCcA1rC04yxBuGoAk8ug==
X-Received: by 2002:adf:f805:: with SMTP id s5mr38405001wrp.178.1555076686738;
        Fri, 12 Apr 2019 06:44:46 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 4/5] ARM: dts: da850-evm: enable cpufreq
Date:   Fri, 12 Apr 2019 15:44:36 +0200
Message-Id: <20190412134437.14864-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412134437.14864-1-brgl@bgdev.pl>
References: <20190412134437.14864-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
tps6507 pmic with configurable output voltage. By default da850-evm
boards support frequencies up to 375MHz so enable this operating
point.

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

