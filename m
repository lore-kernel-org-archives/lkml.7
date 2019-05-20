Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E26E206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFNW8y7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfETR4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41915 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfETR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so7130197pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CUjhStx9Q1czDRNZdSf4vceu5KbZk+h2BQP0hsuERo=;
        b=MFNW8y7mNTo6N1VqA5T5Mo6RzW9jVYQYoQ6qYJl5we7NYdFnZFDyx0sLkY0ogXYLwn
         enWsfvygO1Z23KozLJnz0N3qWtFlricRqhBNrAnq4nJz3++GH7QK0Drjjj2wHUSWnds0
         fpeGcp4z76OpMh6bXOsowHGITGPi2pbzJqyJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CUjhStx9Q1czDRNZdSf4vceu5KbZk+h2BQP0hsuERo=;
        b=LLFBgvxpm0Rop5L3TEiv2ymBZAkvJ2BCfK5l04XvhF6KwAj5doP73YVDyqQmcWBQev
         Z3hMWHJbufZgfOe2xHPkxyKuweUO7QNvo5QhmgdeWGqFFhYtyLnyRvKE+Zx5n1z5KSVz
         MuUkKHCIk0VuTumcnYdh9q8dD0/jawZ95h10N+aI4ZDNQiT5n46R44m1OpG03idtf7+g
         Hoq4UIa/XQJIzmEhzX/UspRnamX9TCsfNDuT2++Uyw/mBdAgl13QuXQRSIoG3DlY/YD3
         KuaguUfPF5K/5RBd/GS/g8gYUdXpA6kUJGnvyKoFP8IpFc6It2DYDu8O3QUSo3g4VvrA
         ILDg==
X-Gm-Message-State: APjAAAUK8GF7c0illsMBjA7RtxZsRjrUzsNJxmvyZxivMO4XxNlnjdLc
        qjFhwo/FYYKo0P6D3IQW4J896A==
X-Google-Smtp-Source: APXvYqx8PLoZmRIV8cyPnbkbGG132pIi5rrVAVnCDXIAjwYFv8VXCCCG4c1elHrOmzAQBdfYcMChEw==
X-Received: by 2002:a62:6341:: with SMTP id x62mr80813484pfb.63.1558374973618;
        Mon, 20 May 2019 10:56:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm16852723pgq.1.2019.05.20.10.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:56:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/3] Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
Date:   Mon, 20 May 2019 10:56:03 -0700
Message-Id: <20190520175605.2405-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520175605.2405-1-dianders@chromium.org>
References: <20190520175605.2405-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs with a dwc2 USB controller may need to keep the PHY on to
support remote wakeup.  Allow specifying this as a device tree
property.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
For relevant prior discussion on this patch, see:

https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org

I didn't make any changes from the prior version since I never found
out what Rob thought of my previous arguments.  If folks want a
change, perhaps they could choose from these options:

1. Assume that all dwc2 hosts would like to keep their PHY on for
   suspend if there's a USB wakeup enabled, thus we totally drop this
   binding.  This doesn't seem super great to me since I'd bet that
   many devices that use dwc2 weren't designed for USB wakeup (they
   may not keep enough clocks or rails on) so we might be wasting
   power for nothing.
2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
   it more obvious that this property is intended both to document
   that wakeup from suspend is possible and that we need the PHY for
   said wakeup.
3. Rename this property to "snps,can-wakeup-from-suspend" and assume
   it's implicit that if we can wakeup from suspend that we need to
   keep the PHY on.  If/when someone shows that a device exists using
   dwc2 where we can wakeup from suspend without the PHY they can add
   a new property.

NOTE FOR REPOST:
- In v2 Rob said [1] he'd prefer something based on the SoC
  compatibility string, but that doesn't work because not all boards
  will have the regulator setup / board design / suspend logic
  necessary to make this work.

[1] https://lkml.kernel.org/r/20190430012328.GA25660@bogus


Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 49eac0dc86b0..aafff3a6904d 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -42,6 +42,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
 - g-rx-fifo-size: size of rx fifo size in gadget mode.
 - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
 - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
+- snps,need-phy-for-wake: If present indicates that the phy needs to be left
+                          on for remote wakeup during suspend.
 - snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
                           we detect a wakeup.  This is due to a hardware errata.
 
@@ -58,4 +60,5 @@ Example:
 		clock-names = "otg";
 		phys = <&usbphy>;
 		phy-names = "usb2-phy";
+		snps,need-phy-for-wake;
         };
-- 
2.21.0.1020.gf2820cf01a-goog

