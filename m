Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B530C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EAE218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9PF7Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDEMVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:21:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbfDEMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:21:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so7714590wrn.11;
        Fri, 05 Apr 2019 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwAOpYjNzXKsO8Sq287Ti3QPb3uJDsGdvAedp4I+PGE=;
        b=ia9PF7Y3edNA/gznbEWdJf89/Rm5Jbfh5AoYJ66Mqd+zfc0n7PrZ0pM+h5ucMqL3GS
         CcGYnkE9qsX0+B1aST29uhs0N9fsvY64kugAPkiF2dXdopL55gVmXB8QP4KcbbepHzzd
         eAERxxzRMCV6j7DC+KggjItWtRd+k0VVh/CY9Cz52KeudQ71mEJuy8nSddCFeJ5gNAG+
         hW+QMA9nHIFXFxKIqKc1ajP33XPSPasoPkbnR1imEmOOK1XSf3nkfS2Mqv6ONMOQGc71
         dgiDGSkYH6V5LGHOvkqwx4LOhaBpz8AhtV1ECoYLsYwtEN7x62I2zqQJht/ljOpQb4G0
         8EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwAOpYjNzXKsO8Sq287Ti3QPb3uJDsGdvAedp4I+PGE=;
        b=agf14ljXfWj4UGsK8Xh0lGLMYVZ7aAPakAd7NonUmb10ce3RiWkcJDtC65DQoJV+6c
         zXFh1wiIBGNcKGtWzoBjLZHSs9hlOSc2vSPukc48vkPBttDOziLUtX/gQ89W/2KS3YJg
         53vZL5Qs1/7g9fpwMGWTtOfWfI3Cd7wvU04vMfjSkjJOquTrSL3PcC3IvWuuQX6uZncY
         mpuYj0boqCSTwt4iSJvpbUX1Ny4bXbfrmAZIOr7JfbpnBUTw2fnjTj+oKNuncvw2NosE
         Vk7YhSDFXIBLuaNhlqA/9sdv3W1C8v3AaqO4wQk0BMY/Coi3JZ0Ih6v4hwy3yfKNS0ED
         vFRA==
X-Gm-Message-State: APjAAAV1UNzsnsoDUN4cTNA3/kdiHOs877wywY4a+bGPpCQETRKYkMTB
        FwihwVltiwY9eRKx1Ral5MQ=
X-Google-Smtp-Source: APXvYqzfJdxiRoOFFv9cAhniNvZLJzM7hPSKcJQlHELgOxjnj/dOp9pK+vEmZeUEp14XrsklW51FWg==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr8535892wrs.267.1554466894378;
        Fri, 05 Apr 2019 05:21:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id d14sm34454123wro.79.2019.04.05.05.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:21:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: vendor-prefixes: add AZW
Date:   Fri,  5 Apr 2019 14:24:45 +0200
Message-Id: <20190405122446.2101-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405122446.2101-1-peron.clem@gmail.com>
References: <20190405122446.2101-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.

Add the vendor prefix for AZW.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8b4ae37629b2..8313edbaf52e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
 avnet	Avnet, Inc.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
+azw     Shenzhen AZW Technology Co., Ltd.
 bananapi BIPAI KEJI LIMITED
 bhf	Beckhoff Automation GmbH & Co. KG
 bitmain	Bitmain Technologies
-- 
2.17.1

