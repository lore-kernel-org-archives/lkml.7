Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76930C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461C720663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ae2qOiDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCDKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:39:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44009 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCDKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so4937981wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=ae2qOiDbhee4RPPzRPkZKkKxwAOTQF/asyRDofppn8TnwxUAwXb3Wgvx6XPMbnaIU1
         uodcvHMYF8LlMecizXko1SbLoKWbIsLB5/ISaAr0eHXApyNZA3Fj64r7YEfYv9Zk57DQ
         KRr8mlFzHliQPUAUeUGBgXa7J9UzpU/pLennzGW2xZ2TAif9yEKBD4piqI00a+875Fyq
         dWamkxkGMmG2McLwe6ptL17REKF/MrInCHwX2p5/uCklBONL6tRbzvdHz4zrhe2Ybym8
         NwjO8jg2kJlP/GLDwaJKtWI+eEVvdsAH8NkzWYzXjUVEBZP+aQBWT19EW1fdmROhFidr
         SFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=cjMLaqkgI89/j85Zv1cdQJ+kfaBX8yeLJG02fWObUy3wgVGo7PjGHUizMBEtzYWJBY
         /PT+DUDq9B3pa3/ExoR1n9olHMOx34DG+/y9MBldgySgx7sQ4+75il2DA4yYjavlWQQw
         CfDP7MGbZeGugWC94TRD7e210r7wIkHSNXLQ0NYrSN7vIqyitocw/bja2Xp0tz7IeBWO
         xPmSAVZaLVy2xmN1PlPGJi7kZLi3nk7cr23isbuAQF1G6QPoi4eZKinfQFCkT0XlX5Za
         jF8lOCc6NbqNBibDw30s9dGFVpOeMeYtHKxBnroi7/yB9zps7/FxwuCGMPxvJYWeRFUg
         bFtQ==
X-Gm-Message-State: APjAAAVYARlwO+wg/B9ozLlS2XQWrMpNWGD3Pz57OoTyBpM+p41hcjs9
        xDlJ4wj2jpMn3mAhu/yuC0wEVA==
X-Google-Smtp-Source: APXvYqzr/0bpdiSQx6K3wQBGBTtdiy8QH2VuNRkP4ZwuTVFnmC63uEqpOAiWynvE01J29qOFKgQiDw==
X-Received: by 2002:adf:b784:: with SMTP id s4mr12037871wre.155.1551695932593;
        Mon, 04 Mar 2019 02:38:52 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:51 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Mon,  4 Mar 2019 11:38:41 +0100
Message-Id: <20190304103846.2060-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the specific compatible string for the DWC2 IP found in the
Amlogic G12A SoC Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..e150b7b227c9 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -14,6 +14,7 @@ Required properties:
   - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
   - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
+  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
   - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
   - "st,stm32f4x9-fsotg": The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs
-- 
2.20.1

