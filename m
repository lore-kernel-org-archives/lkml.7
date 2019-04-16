Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636BBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B45B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RG7wZxCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfDPVyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40757 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfDPVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so10985445plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HGU4dCKpXPQnSBrDR2ECEUC1qmGkGpsIfBVYvSfbAc=;
        b=RG7wZxCW8Z6YRFTWDTOwvUtZpsmFe9M0LLHCuTQ92Xx3GKtPCDP+vTPWgTlMTphJAG
         K2ngJz9rExe3KSMZvT2dGJZ0UwEvJC2B5PB+FrRftE9FZZqZfUIOASNsVMCq/EAeSXLN
         wDzRSVJYzW1w2mH49a0NUDrFuoggMbB33M2OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HGU4dCKpXPQnSBrDR2ECEUC1qmGkGpsIfBVYvSfbAc=;
        b=qOpEwFaMC1dff4zyY5+/jD28BNDrGofkBTPkBeXakGFkpt0mS6VwfLYv9kRut8iyhg
         S252wtjCHjmLeASC4ueoQCHOMJBXZ0JDU6lXGSi6Wna61pYcm3A7CM3FSTU+4/sCXUAj
         mmVlZVbVAqJXPily8ByQ551RS72e3WfoZdouR16xrlEgAz4opKriFH7Pe2FsytDldgvt
         W2AvXJ5spSNYPulqO4FammhZqt8DXnfLNGYbmCYvzONRFhfZBCMv1vcTHMUEcVpwbn0e
         Ufof4rhIzOmlvG63Dhs/Szl7mzYORqKiwudaUE6Bl1cfhgkupXJy4V3CsDCT1sgFjM+z
         LVnw==
X-Gm-Message-State: APjAAAU5GkU0IY5OOMNEJoPYHR6XHHOuVR6BPv9vyLwIXTKATW2mHV8T
        IyZFMqUphu/0DV36enBlGsT3Yw==
X-Google-Smtp-Source: APXvYqzyFpMWEmeYMmrX9KaorHnS7Ur0BIgPYvvV0Vvlt8QvOPOjbOuGAegmy11626TgNUuOgto1sQ==
X-Received: by 2002:a17:902:1681:: with SMTP id h1mr71653830plh.102.1555451651706;
        Tue, 16 Apr 2019 14:54:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b6sm8156770pgt.58.2019.04.16.14.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:10 -0700 (PDT)
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
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] usb: dwc2: Another attempt handling rk3288's remote wake quirk
Date:   Tue, 16 Apr 2019 14:53:47 -0700
Message-Id: <20190416215351.242246-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another attempt to upstream the code to unwedge the rk3288's
"host" USB port when it sees a remote wakeup.  Previously I attempted
this [1] and it appears that Randy Li made some attempts too [2] which
resulted in at least the PHY bindings for the USB PHY landing as well
as the USB PHY support.  Nice!

Hopefully this addresses previous comments and could land this time?

[1] https://lkml.kernel.org/r/1446236275-12698-2-git-send-email-dianders@chromium.org
[2] https://lkml.kernel.org/r/1472939729-15187-4-git-send-email-ayaka@soulik.info

Changes in v2:
- Cancel the work when dwc2 is freed (Matthias).

Douglas Anderson (4):
  dt-bindings: usb: dwc2: Document quirk to reset PHY upon wakeup
  usb: dwc2: optionally assert phy reset when waking up
  ARM: dts: rockchip: Hook resets up to USB PHYs on rk3288.
  ARM: dts: rockchip: Add quirk for resetting rk3288's dwc2 host on
    wakeup

 Documentation/devicetree/bindings/usb/dwc2.txt |  2 ++
 arch/arm/boot/dts/rk3288.dtsi                  |  7 +++++++
 drivers/usb/dwc2/core.h                        |  5 +++++
 drivers/usb/dwc2/core_intr.c                   | 12 ++++++++++++
 drivers/usb/dwc2/hcd.c                         | 18 +++++++++++++++---
 drivers/usb/dwc2/platform.c                    |  9 +++++++++
 6 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.21.0.593.g511ec345e18-goog

