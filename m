Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A627DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C0F20643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SQoxYEXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDCBTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:19:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45232 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfDCBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:19:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so7134183plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDL9TQHWzWnUT5ddhZWuvPgdGvI1/IDqVVyhmwzPbB4=;
        b=SQoxYEXcCIp+/NXAUuKRbJGARgQU7vX9j/J7jcyCh9rJZs8M10N6jqwKv98+jwNEO7
         RQQaO7yPNeh50AF7rNj7xYzWQngcMAkOjAxtQIheUCkWn7FldvGQ/RgvMR5zOV3uncSc
         gmEB18Q8KvEkcpqwlygKgXDIlqokqz9KqtiNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDL9TQHWzWnUT5ddhZWuvPgdGvI1/IDqVVyhmwzPbB4=;
        b=PtzZb8pXjxknd/FZr639Q6tNbMbqeAd+oLV0zwcdLv2+00YKw7d2V2QJEWQtPd917E
         iw8JSaJW0WZ1Mqtal7WJ1ohMNCYn4gbGGahuiQ8Nrml6gv/34KhUbmi80Rn27/A/WVR3
         50uT3YgThaFfq8hnm2Bf0EzUXbS1gKTriRdTL3QXAkCPOkgojjywrTfoNgLawM2K2Vlf
         FPh6PFm08gIuxaj/LLClVj8IykQfaWS7exD8ughpe5zA77M1SKz6ZgJqXiI2LVPrfePL
         +AHyUsXMyZ/mxbIYacjSbZGuH5Gp3Q1ORTHxefVgfByFrt0dxFSw52P8iQZiEhS+Vr+3
         XxUA==
X-Gm-Message-State: APjAAAXFoBMcxog1Ov4SqyyBXJv4AiABM/3CtijS+F7Tx0O4R1R07h5r
        6RELAO8/4heIj8XMe2lQ3XPfeg==
X-Google-Smtp-Source: APXvYqyBOY69BQV7djywt2b8QNly1KPFFH9485dnpGrYkuE2xxik1wGVOeDXxJBEiVHQzMNoXcVIYg==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr54423243plx.221.1554254354854;
        Tue, 02 Apr 2019 18:19:14 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:19:14 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 9/9] arm64: dts: Stingray: Add NIC i2c device node
Date:   Tue,  2 Apr 2019 18:18:30 -0700
Message-Id: <20190403011830.3254-10-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC i2c device node.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 35c4670c00d1..69306fbd14b4 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,22 @@
 			status = "disabled";
 		};
 	};
+
+	nic-hsls {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0  0x0 0x7fffffff>;
+
+		nic_i2c0: i2c@60826100 {
+			compatible = "brcm,iproc-nic-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x60826100 0x100>,
+			      <0x60e00408 0x1000>;
+			brcm,ape-hsls-addr-mask = <0x03400000>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1

