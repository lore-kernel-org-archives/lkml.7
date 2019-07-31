Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF611C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34520651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yyn7RWwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGaKUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:20:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43518 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfGaKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:20:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so31617029pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2O775qpjwYqwjNNK1jAWRm9r82jKhpePG9GnlR7OY0Q=;
        b=Yyn7RWwAm3JMCXDcDeGBxlaI8XMQIA7FHvASa9guSVH5L7xlXw0b2zl5bASLjFlBrD
         BNq04z6h80T08oj9ruwe1tr4he/+Y8CcouibUt5l4M07hNrarc/BzT45M+ohvaQ35kyI
         8kyE/kbWoHb31fZ5jKIxodukMPslx+uW3psTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2O775qpjwYqwjNNK1jAWRm9r82jKhpePG9GnlR7OY0Q=;
        b=JRrV34qrDPP+1061HejNtw0DCozykAGdP3YVoh/CWE1CqGSRMvTTBOcMCJNapFulZn
         Af8MPNZA54B2BY+4MAa4m5YFxq5AAa0e3E4CluMElowHZZMycKxr7yOZYt9B+pEi3swc
         vwfWNWM6GgLjcc8ZQ7eMd5GWnofSuHPMw21NTjRA1FFnkF63mZBNP4o5VL1VUogqflQW
         /nUV2/g1VL1fhqvLZShI0IZZJMGRu5W8PVFKjiO0qD8eDSFhGjlPJIkNg5c5xd0JV2Vi
         Qeq8/EIRcBv7yVYPxbZMSqDmCYlGx6jfO6OrhJG37I+NMv2tHlm6jruFyCSd4Or+y2rD
         z6Bw==
X-Gm-Message-State: APjAAAUzmZl8r5eBOVlPJ6MnBoAzTpBFAQZX5VtYTO2quZkuAh01CId8
        NaKXh7O8qqDtR566IjpQFscqUQ==
X-Google-Smtp-Source: APXvYqwmgXRoUHYDivjjY1EWCO27W2YnDH7ba8VG7ljSozY+4a0KgWIr40lvoUBMMr627+3GTZe0Bg==
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr2190902pjb.49.1564568416276;
        Wed, 31 Jul 2019 03:20:16 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 3sm71161776pfg.186.2019.07.31.03.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:20:15 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 1/5] phy: Add phy ports in attrs
Date:   Wed, 31 Jul 2019 15:49:51 +0530
Message-Id: <1564568395-9980-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add phy ports bitmask to contain enabled PHY ports.
set and get APIs added to set and get phy ports value.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 include/linux/phy/phy.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f14..b8bca1d 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -109,10 +109,12 @@ struct phy_ops {
 /**
  * struct phy_attrs - represents phy attributes
  * @bus_width: Data path width implemented by PHY
+ * @phy_ports: Bitmask of enabled ports
  * @mode: PHY mode
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			phy_ports;
 	enum phy_mode		mode;
 };
 
@@ -225,6 +227,14 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+static inline int phy_get_phy_ports(struct phy *phy)
+{
+	return phy->attrs.phy_ports;
+}
+static inline void phy_set_phy_ports(struct phy *phy, int phy_ports)
+{
+	phy->attrs.phy_ports |= phy_ports;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
-- 
2.7.4

