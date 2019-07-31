Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726ACC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FD2208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KOwU/VDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfGaMOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:14:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46961 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfGaMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so69395831wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BOF17YQQWl12xZ1QhY8MZFUcVRdvZruqxl9AoPVourc=;
        b=KOwU/VDLfH4d9hcV47fA2w/uqwOYT2FS68Y+GEZgeAIxQeMzox1GTF+0nrmfbwgok6
         lFKgs6HQrZ5vHJV79TS3uRpfM7LBBpF/8oOwgSPwJoZn4uSGVeyYfnWNtxTN0cCnSKnA
         fwLcqzDLNkSmAbYJFRKWbisb1VHFrT9BBYe1njiRWWCpIVjSFXkGFjmG8l7ix6YGmBuO
         jmb5mztHtAF8AeFgsBIRAXSHH7dLXHH2WTPiyN1yejHwdxPZrwqe+2OU49FlyeZkQ6rT
         E+OVoUnb/VSTVGanCM84e147CCmhwhG/RaHrkLmA2+q2AMN+jbaHINtHsTQGrCX8cYtO
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BOF17YQQWl12xZ1QhY8MZFUcVRdvZruqxl9AoPVourc=;
        b=I32rApOLf/ZQ1/JLyQM6qVOnzGvYGxF/TxB82QWQVNUneW1JcGEdRSvEZOGWR35kcZ
         ZD1d1cJKkvaDCYqhzlBe/RLwdHcJll8tzDrdIS0FBc4z/6aADJ+sDm/fXkdhFdQNtQ3y
         HtWcCsCngped3ol4h/sV2QV6tEJGRvsyvmK+4MQXm2BdWPeOy5tMGSl4TFtdQikbWfsV
         YmP6PVEyG4IiWDMYWJ95ADtgzRI7AQzlxuH8GBzkWkfMgtwSnP6FI+4Lo4G0er9wVcVH
         zA5ZfRESX7pLRqpvVbAc7H6KdIX8gdZLY8S+j5vtzQ/h4i4odJzpv9/UmM13Pf2MRZpN
         u8oA==
X-Gm-Message-State: APjAAAWQgDHhR07YIdUwxgHxOpZRE15hVd4dafCsTgPxlJWNUy5jQGkH
        5AJFELGCY4Jh2k7sTtsEs0zSDA==
X-Google-Smtp-Source: APXvYqw5Af6krHH2u8yfiDYnUo0PUK03ieMfQQIWsJDDVp5cTQO8+Z6dt5o79L+VaM5ofBQMkgnbuQ==
X-Received: by 2002:adf:c803:: with SMTP id d3mr61363995wrh.130.1564575258197;
        Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: amlogic: odroid-n2: add minimal thermal zone
Date:   Wed, 31 Jul 2019 14:14:08 +0200
Message-Id: <20190731121409.17285-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 81780ffcc7f0..4bd8d6d0c972 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -20,6 +20,19 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		soc_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp 0>;
+		};
+		ddr_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp 1>;
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.17.1

