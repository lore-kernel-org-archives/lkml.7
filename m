Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C40206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iAutK9hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfDPVyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfDPVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so10994755pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsFf4LEh0pktHURaMfPnlhrkOmI1Owbh5PPEFMjaE6c=;
        b=iAutK9hipedEuHpce3EVCQiVHg1QIADXgE6iqLm1r6d1fj7U2UxC7EQiQB9cxDi8Ii
         SfBS68X6Kezeq3ah8uFonHpSA+3J6bahOeI5qcPe3sJRjsHoOFtB8xueB7usSKAPIseB
         t4vRGdujBdSPadp44iYqSkCoHtvKGS+e621f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsFf4LEh0pktHURaMfPnlhrkOmI1Owbh5PPEFMjaE6c=;
        b=oLWOl5RY/UQXSd8Fd00VmkfA8zVjqLhEoj3GZMtdlpLHSeP6FP81UawK6XTPeGdLJU
         VRy/VC59JvwmVQujdBgqYfbTedxH3S0J43b2dBUzd9ZOmoipwAllwJj914+2wI1ddve1
         vU+4Nq9s+PLdUVwK4ZISUcPGzqsigjY8DT5xVr8P+JtL2xif1PdaKfQSZjk+IIZNWI48
         C/KjscMSIbFIvQ/dr22ZMZwBFYcekEqALI9ITMX3jxKuAgXaAVTLf06i2wbUbNgOAKRu
         6C3ArFC/3bJxvubvRN5uRkwbjSlq3S+pSubMgloIo6dec89jxGCdEy3rwj289YcjDu8/
         Wa6g==
X-Gm-Message-State: APjAAAWG+NEWc/0h1GAFzaETwMW0luPwAmnaq+ld03Y4Y1H/4s2JAHNj
        Qm++dSztY7imltkIG6vxKprQUA==
X-Google-Smtp-Source: APXvYqx9Echs2wcQSIcKJnQgMM0GXGhmDvbnb5yHOmCUV3xMZ9JzJrqQ4WwBfzBGesIzMap8lN9mAQ==
X-Received: by 2002:a63:4144:: with SMTP id o65mr75004207pga.241.1555451653028;
        Tue, 16 Apr 2019 14:54:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b6sm8156770pgt.58.2019.04.16.14.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:12 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: usb: dwc2: Document quirk to reset PHY upon wakeup
Date:   Tue, 16 Apr 2019 14:53:48 -0700
Message-Id: <20190416215351.242246-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190416215351.242246-1-dianders@chromium.org>
References: <20190416215351.242246-1-dianders@chromium.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2: None

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
2.21.0.593.g511ec345e18-goog

