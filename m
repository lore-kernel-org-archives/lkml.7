Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB221206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lgrnbfU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgAIKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:15:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgAIKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:15:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so6686685wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCtmiCqI2P9xqNVNxOtkPbW3MhGrPJGbIhxNJ1nkAW0=;
        b=lgrnbfU1H/MNfYfjNyPKCLX8Dupk4Xxp802m2khDE6FAH+jUO/Q3rujArNbNp2srK6
         AfNTQhK48EeK13IfM0XUEaJdZp95ZAuuWu9Pntf0yr3/sp6bThHoHwsonQ/DSRIRC0/l
         Iu5Gp1tC3S1tnQ/3MbLIqdHeOdxG7vfRUjitNgCPvGzAa8l94U+hzydiaLVTk8knZD/i
         N3HVpz8pngzUeuEzphEVCNcsRI7dzQPoQ87bbf2zHSgiyiyo77hRZhx3o/NvtzcV7/P6
         /fQx0nCINET1HpGXUBhr5qqwuRBsOOa0hullENg6hfApAy9N0TTTx0by95HdDWYRf/s0
         +A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCtmiCqI2P9xqNVNxOtkPbW3MhGrPJGbIhxNJ1nkAW0=;
        b=AEG0kx/apSVQ/+DFq7IdNSQmt//+CkMGK9LFQExdQze5Kh8VqViK59vDPoedxrfCRk
         cgtQ0N0rxYLwkmxFbtx528meDvO1puHmLuf5XeXYxhLVlGvlqKUIgPrJb40T6wPdBIJO
         iIw+MehBUIYwXCdDAFl1FVkMiXheYX7ZqsG6Hkwn2lbpRBJEq84rmdeBYPb7TCzjweD1
         7smiKaYZp1f7RWr+TCn0HLgD+5b4gvCsmI0LlY65yV3FoA2epmVF73a0rNIcSNkWwMMj
         F5/aV7tiDdmA/QjoN7Gf3Boope2PiJ6gEYILunUXs0qx1A7a09fMrgqj70+8EBFgDs4B
         aW5g==
X-Gm-Message-State: APjAAAW/FqMEr6986KPtlUIbu7B/USVbw7r3AiGU+i6/AWSL5xb+VMqU
        +pCEJdCaO8ztGMhi9EXp3Qm0jA==
X-Google-Smtp-Source: APXvYqztrhFHOZkOTr83Eod3hS6kUXgxLZedODaQHDCw+HCLHCGGyJQ6p/fPteX91I44SSRh4Tqxhg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr9946380wrx.244.1578564937945;
        Thu, 09 Jan 2020 02:15:37 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q19sm2250460wmc.12.2020.01.09.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:15:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: g12-common: parkmode_disable_ss_quirk on DWC3 controller
Date:   Thu,  9 Jan 2020 11:15:32 +0100
Message-Id: <20200109101535.26812-1-narmstrong@baylibre.com>
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

The bug has been reproduced by Jun Li <lijun.kernel@gmail.com> and confirmed
by Thinh Nguyen <Thinh.Nguyen@synopsys.com> with the explanation:
> The GUCTL1.PARKMODE_DISABLE_SS is only available in dwc_usb3 controller 
> running in host mode. This should not be set for other IPs.
> This can be disabled by default based on IP, but I recommend to have a 
> property to enable this feature for devices that need this.

Changes since v1 at [1]:
- added rob review tag
- added Thinh Nguyen in commit log

[1] https://lore.kernel.org/linux-amlogic/20191014141718.22603-1-narmstrong@baylibre.com

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

