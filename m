Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B33218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iNMu0LcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDLWmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:42:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDLWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 18:42:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so5801651plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWLUeccQHJNmQbwFQHETrVq/WCQE28hsAbD/ch2jk/0=;
        b=iNMu0LcBBkEoblkNikvLsoe0iRPOEcYwdGkme5UBFA+0XD/4tIOYO3Vx+bjaKXVji7
         M9To4tbMSajbIxOowKsnAp4q+36Y4WzW03NdM1LpN81G934TCBDxl1SozQCahv/f3raJ
         4+lFk6UNxhDm3Ecv5oEwAFbQCwkJy4u1t8ZN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWLUeccQHJNmQbwFQHETrVq/WCQE28hsAbD/ch2jk/0=;
        b=BNVp2hHVaTvG5cvRdfzfd0QYAqvdbPkviaEdubH7Y0RNSYHkA9d2fdQOuFf+ahO8OX
         cpY0ab5CvwLpbdbV1zABjrRH7vuLQAvZXypDUCXn7QbmZJ7zf+twVd2Tj/GNOv0/6QzL
         qJ8JKldP6/ETdeLYz3PnU0SAiTBUI6kFXLjWJx03OE+mP2psO0JXjgn84zYDo68GvCZm
         IqtJi4pDOIC8JDrdWDsmSbF59OdweyNRoUVewmW5XktMKVMzKHf4sI2AFd8pll+Ywww7
         T3vv1Majey1PJn6zkBLjdNA6OvdF6Urg+G58nEw6tnrfwHmEKcZnVOHAh1dAxFW+DwcL
         ntEQ==
X-Gm-Message-State: APjAAAWbQ/ylSPICyCRRwvHf4bSE58O9BxUrQw14XT+688odL9uAhP6b
        Xw01LMni8948yrNPbxss3SYfqw==
X-Google-Smtp-Source: APXvYqxcV0ZgFhV+rNuPFw2kv/DYtmiXsbIMqoDb86eGxEMGMKNVH9kszsGPxxLMa87ZWhMQFr0SUg==
X-Received: by 2002:a17:902:e508:: with SMTP id ck8mr58797653plb.96.1555108936236;
        Fri, 12 Apr 2019 15:42:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j22sm57170579pfn.129.2019.04.12.15.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 15:42:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        mka@chromium.org, ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/4] dt-bindings: usb: dwc2: Document quirk to reset PHY upon wakeup
Date:   Fri, 12 Apr 2019 15:41:46 -0700
Message-Id: <20190412224149.106971-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412224149.106971-1-dianders@chromium.org>
References: <20190412224149.106971-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3288 there's a hardware quirk where we need to assert
the reset signal to the PHY when we get a remote wakeup on one of the
two ports.  Document this quirk in the bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..f70f3aee4bfc 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -37,6 +37,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
 - g-rx-fifo-size: size of rx fifo size in gadget mode.
 - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
 - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
+- snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
+                          we detect a wakeup.  This is due to a hardware errata.
 
 Deprecated properties:
 - g-use-dma: gadget DMA mode is automatically detected
-- 
2.21.0.392.gf8f6787159e-goog

