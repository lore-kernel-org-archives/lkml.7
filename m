Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85CECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3522067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oH36a8sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfJNORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:17:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:17:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so19938405wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSSsFrkn7EdTTWu+GWp0+LGeW3aaonOPgHYuuTaEg/Q=;
        b=oH36a8sl1Y0woo+uZ+4d0YC209fG+020lXLFq2OWCB2CNdkLhDLm9/zs35CX/x2qo0
         zYI7znIKhTEadQR2tDjgQTxje1l03+eUNK8+pPUzzcqGuiY+4rNgov+W+TpwKDVb34wa
         gSojkc7hfZhAHFX5wloTc2MrIC08nBej23ayyT1Q/GQytY3rFPAHkNsW1C44GKSI+Snt
         ilTLJ99AXZjy+eHwDXCY3nLPPOAEV2ryDLikeqvttfu4IBI0TvRxOdhV7o1xXQrIr8Uv
         WqruTS/QkuTKsv/SzCjvKEdVjhkhlhE4K+lxDjwMf2n5QDY24GcYFA0chKuOp71rVzDL
         EnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSSsFrkn7EdTTWu+GWp0+LGeW3aaonOPgHYuuTaEg/Q=;
        b=QX5GfUsGksnMpwg5PTHPzmCxvmE2PXemo85DhU7604KY3aIVsaH24thir+mAJDQ/ht
         p96X4nPlBS6zHPwEAKS+H1zquSDaWppOA7d/S6VCsyk+L1yv6HyZjKWyObjxpXbAic3b
         b1d1f7gRWhr8t09vv3dcm+i6/4R7xgGsduvHBcKqtdlX6/Kh1tgqT/upZE6I/4D0CvyG
         tRQefoOuTSz3KNMar2IxX+WMXm18/Mbh6vlUU5GOwL98BOkelH4GhDa5fjQxVwv/72Pd
         DzzkKrIL6I9HdUgYNf7HSdX9hqkXacj14OG7x2lIMz0Rie/NGTis/ZAyI2cfMATe4Jro
         Jb5A==
X-Gm-Message-State: APjAAAWiIz1pw8cNsgNHgusE1rutnQCam6InhLp075j3fywNJg4XgLSS
        tYDqummcq2mmGuN5dIyDtdZghA==
X-Google-Smtp-Source: APXvYqzKPStl7+pYZiI5sC3h4CfQaz40UoOoFTnzTHrvT/VixgRr3uo24eUmfwMJhwQ+sK/e93D/3w==
X-Received: by 2002:adf:f004:: with SMTP id j4mr7541474wro.68.1571062640575;
        Mon, 14 Oct 2019 07:17:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t83sm42708624wmt.18.2019.10.14.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:17:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: g12-common: parkmode_disable_ss_quirk on DWC3 controller
Date:   Mon, 14 Oct 2019 16:17:15 +0200
Message-Id: <20191014141718.22603-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain circumstances, the XHCI SuperSpeed instance in park mode
can fail to recover, thus on Amlogic G12A/G12B/SM1 SoCs when there is high
load on the single XHCI SuperSpeed instance, the controller can crash like:
xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
usb 2-1.1-port1: cannot reset (err = -22)

Setting the PARKMODE_DISABLE_SS bit in the DWC3_USB3_GUCTL1 mitigates
the issue. The bit is described as :
"When this bit is set to '1' all SS bus instances in park mode are disabled"

Neil Armstrong (3):
  doc: dt: bindings: usb: dwc3: Update entries for disabling SS
    instances in park mode
  usb: dwc3: gadget: Add support for disabling SS instances in park mode
  arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3
    controller

 Documentation/devicetree/bindings/usb/dwc3.txt    | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 drivers/usb/dwc3/core.c                           | 5 +++++
 drivers/usb/dwc3/core.h                           | 4 ++++
 4 files changed, 12 insertions(+)

-- 
2.22.0

