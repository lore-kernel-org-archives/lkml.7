Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419F5206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJX07Igz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfGaKUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:20:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35702 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfGaKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:20:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so31633133pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmBxdiW7S2WiXQ4zlUGo+/gbkMEWIhLilBouSwb9Zms=;
        b=HJX07IgzuA3T2hq6Y26IP9Rn+7DO6LW+EcnXufRcqpZX4JAJUmAvVnptuZWkMbvsry
         ESPOby87HWI3S8sEhCDQLCFGNSrCq5QBUcehvat5GmpdHGUyTmtjYoR9RGB85BdPbW9I
         EpeJ7fKEpL8jHSFdoXFCCiagfU4ap+R6B8c/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rmBxdiW7S2WiXQ4zlUGo+/gbkMEWIhLilBouSwb9Zms=;
        b=TJZBJoIBFaev+7DelzpZe6wGX0ujUNZz104/VXvNLy578UYephJJDZDvhEHDkcTjSe
         a5E9rSAKgvrrwZ9DQuRvYWCt++ic9kyD1GK7mzKCehoFgQTfR/4cufwAuGs6TeDuCb3b
         FBcRztOIh0YxVZwpQTWO+aSYDR+Fiz3HGZ08Et8EVsaNJ/7DEETDPFpTzBSvvE+ixwuY
         DbCUoA8vt33MX+Haon4Y2m8p7bZMfUw/pxH1JAY+znI/oDkZyMHhdq5pYRk59aP71uKH
         Cg6p5K3H7mqWuW4xCf7XNLmWgN0I++Gusd592eEvKLc/uXiu20RteTHHldFNOyJAPPrp
         7rtA==
X-Gm-Message-State: APjAAAXFymklnOXFui9RLa72P7/V5wF8ACXaTbrQeWeawza5bgIuTuxm
        tODaldSzet8u7vZhEZDEjMHtOQ==
X-Google-Smtp-Source: APXvYqxIook3htLQsXXlA83hjcsGEZbtTQ038Kp8tgnmjDpYGMt7dCACN9TE2RD9YTyaG4BJePLbDA==
X-Received: by 2002:a17:90a:8984:: with SMTP id v4mr2166486pjn.133.1564568427244;
        Wed, 31 Jul 2019 03:20:27 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 3sm71161776pfg.186.2019.07.31.03.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:20:26 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: usb-xhci: Add platform specific compatible for Stingray xHCI
Date:   Wed, 31 Jul 2019 15:49:54 +0530
Message-Id: <1564568395-9980-5-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Platform specific compatible, because xHCI of this SoC has an issue
with HS port which has to reset on disconnect event.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 97400e8..ee1f051 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -22,6 +22,7 @@ Required properties:
       device
     - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 or RZ/G2 compatible
       device
+    - "brcm,sr-xhci" for Stingray SoC
     - "xhci-platform" (deprecated)
 
     When compatible with the generic version, nodes must list the
-- 
2.7.4

