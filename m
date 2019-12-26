Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D8C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8642080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n0N0a8W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfLZJ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:57:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLZJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:57:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so4808087wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 01:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZCVwsdNusn35k9dtRa2QFLzjbX+kQx5eXmmmXDwk4S0=;
        b=n0N0a8W3Ohe7CamYqnfWzwvIO5gtNcBHITgKM0r0ow7zB+CibGjPCaZS8Ghqm7wxdx
         BaQUUezTvXySdb2AV7B+y4WhI1qmnHh7Vy5XfFh/Z6xdAd3xO0IlOEWZ9rTZR5Hpkzi8
         Y3wuYSe8/mpW/Ty7IcStATjPjcYTwXFNtfWgQ0bGFc7JdvsdQ72rfw402qZpA94QS9gI
         z5PthbLgBDTL+NLQk1JO5rqcyTS7UwzExYTDg2lwkBUI99w1DiOILvzO10KFZ+cUletF
         XKXIifsOPDCAQU/Iw3DnmvLlbB9ON5QuZugNnxUu7K+vWD/wbXgLZDJO1+U3DUXvkpB1
         nPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZCVwsdNusn35k9dtRa2QFLzjbX+kQx5eXmmmXDwk4S0=;
        b=nc+S5KZVq0uq4n8d+IWst2jSoMeIiI3RJC6Y11kxJOkA2A9MyXCHxEOdqWk+P8ALXd
         jMKZVJ4nZIGcZ6sRS991Q5zk/NPlIigcEHclFBE7Max/oRhZ9YW2/rknmh/LJo0dxI+c
         ORH/aAVuk3W1AL/LkJ2Nwh5+TKx7GygcuR5Teu9TmElRtAKbEsSM55VmIR4IJxUSIJWT
         i5KK0nC1oVpqB4isue32wDOHPpEZOEmPUejXrzv2+tAXNz8fVPp+w65n7EnQaqeDd9k0
         TsZTt1vFo5YgRR6H2qoFG9OYiY3D07hlhvS0xWZ6ZwEWT44p3hlW7PWaUmPOYrI6GYeW
         mdwA==
X-Gm-Message-State: APjAAAWgBLmTFJ/40u8tFCNhbCLCw7FRIPjqUJ8dzb87/e+BExv8uBWJ
        7ovkqy/3ruvhG85jsv8WhYz/rg==
X-Google-Smtp-Source: APXvYqyLAIuz9sClbrMRrocB1W5zqs27UiqD9u07C9i5HwQZpfFqgT3ahQH+J9l+Pjju2Dixl1gnCA==
X-Received: by 2002:a05:600c:30a:: with SMTP id q10mr12798628wmd.84.1577354260380;
        Thu, 26 Dec 2019 01:57:40 -0800 (PST)
Received: from localhost ([2a01:e0a:1a5:7ee0:1e09:f4bb:719a:3028])
        by smtp.gmail.com with ESMTPSA id v22sm7772006wml.11.2019.12.26.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 01:57:39 -0800 (PST)
References: <20191224173942.18160-1-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PCI: amlogic: Make PCIe working reliably on AXG platforms
In-reply-to: <20191224173942.18160-1-repk@triplefau.lt>
Date:   Thu, 26 Dec 2019 10:57:39 +0100
Message-ID: <1jblrvpfxo.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 24 Dec 2019 at 18:39, Remi Pommarel <repk@triplefau.lt> wrote:

> PCIe device probing failures have been seen on AXG platforms and were due
> to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit in
> MIPI's PHY registers solved the problem. This bit appears to control band
> gap reference.
>
> As discussed here [1] one of these shared MIPI/PCIE PHY register bits was
> mistakenly implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
> a PHY driver to control this bit through syscon subsystem instead, as well
> as setting the band gap one in order to get reliable PCIE communication.
>
> While at it adding this PHY make AXG code close to G12A one thus allowing
> to remove some specific platform handling in pci-meson driver.
>
> Please note that CLKID_MIPI_ENABLE removable will be done in a different
> serie.
>
> Changes since v2:
>  - Remove shared MIPI/PCIE device driver and use syscon to access register
>    in PCIE only driver instead
>  - Include devicetree documentation
>
> Changes sinve v1:
>  - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
>  - Add a PHY driver for PCIE_PHY registers
>  - Modify pci-meson.c to make use of both PHYs and remove specific
>    handling for AXG and G12A
>
> [1] https://lkml.org/lkml/2019/12/16/119
>
> Remi Pommarel (5):
>   phy: amlogic: Add Amlogic AXG PCIE PHY Driver
>   PCI: amlogic: Use AXG PCIE PHY
>   arm64: dts: meson-axg: Add PCIE PHY node
>   dt-bindings: PCI: meson: Update PCIE bindings documentation
>   dt-bindings: Add AXG PCIE PHY bindings

Hi Remi,

Usually, you should put the dt documentation first in the series.
This way the properties are documented before being used

>
>  .../bindings/pci/amlogic,meson-pcie.txt       |  22 +--
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  51 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   9 +
>  drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
>  drivers/phy/amlogic/Kconfig                   |  11 ++
>  drivers/phy/amlogic/Makefile                  |   1 +
>  drivers/phy/amlogic/phy-meson-axg-pcie.c      | 185 ++++++++++++++++++
>  7 files changed, 287 insertions(+), 108 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

