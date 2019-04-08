Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE48C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mJO8uxCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDHJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:38:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:38:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so13512473wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F6de1zOqVElmQeCk7fGLmBoT3MjihPuW5aUU6GvNCC4=;
        b=mJO8uxCXtJ6kuPAimWUfdQTKLAsjadJbMUPYUUuMneF/e8INZFc0U4tyVPYNxZSlWO
         DdsNyA6u6VNnEdCEycd604+9ZhAyaZPDtp9p79dHu1MCk8wK8SQH2owaszCaC1dgl8AA
         2GOVZmARKH3qreerPbzJuPWC9AxDVGIHHOClMX6el8xV5uXOMIj2B4IJBR0JvZ05W7ck
         pwTsLkL6TuFhPo4eEqjvVHmcRgjQobr7vSS3VcxOBbHYPXARF1/MfPZdaKmXpuKdBaoS
         Ml6XUv2e6YbOskiNtR/LZ2PZifbx9oZXOsecGr6wJvcXi8PSWDLmZ82OFZ1uHruo32uz
         a1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F6de1zOqVElmQeCk7fGLmBoT3MjihPuW5aUU6GvNCC4=;
        b=tO9vY+rIO6Aef2S3etiMSIwHJu/Z8IN6YZ5ihNheQENOB6qtPJumyC4jeyOmm7gI5z
         mVpvU8Czl0r86ktlTGyW9fWmXLrPNHO6i2npmM8NIVyysjlQnklW/QIQ4SXg6XNQ0IOM
         sGOn9z/LdBhY3UZaH4m/vaQPxwYNAFL5RhFjwtfiW6LkBaJnpFaLjeORpiOCjlNNJBh3
         LssslEGGuxCM5s8zi7CNSmwRgy72fHWPq6JjhPg7JOPG2ejEE+kxNy2qOU4jSl0ymv1k
         b3Je4l661nHR3jMFwlubna0tqo/OsgAzkplHW4vKcGmxO+XUi68Xt8YUiaNhQP0SSgex
         VoiQ==
X-Gm-Message-State: APjAAAX7CKK3Zi5CoWHzrJmlifY3OJLmD+4x3MMmPlOCg4Xs/KIdqTyj
        ARabzWbD/Z0wTKoUD6fZPRjJEbW3ph5tvg==
X-Google-Smtp-Source: APXvYqxkhqhoibk3KVATiPt0ruGqZayW+DbceZSh7ov8aV8LoyX7v3yL6qkAfJJCLtYm44Ud5QbdFg==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr16803433wmj.60.1554716298364;
        Mon, 08 Apr 2019 02:38:18 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a187sm13930254wma.32.2019.04.08.02.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:38:17 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] arm64: meson: Add support for USB on Amlogic G12A
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190325093943.29138-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <76726909-8395-666a-a96f-c9b8712b12b2@baylibre.com>
Date:   Mon, 8 Apr 2019 11:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Felipe, Minas,

Gentle ping about these remaining patches, who is supposed to
pick them ?

Thanks,
Neil

On 25/03/2019 10:39, Neil Armstrong wrote:
> This patchset adds support for USB on Amlogic G12A SoCs.
> 
> This patchset is composed with :
> - bindings of the PHYs
> - bindings of the USB Control Glue
> - PHY Drivers
> - USB Control Glue driver
> 
> Device Tree nodes will be added in a separate patchset.
> 
> The Amlogic G12A USB Complex is composed of :
> - 2 USB Controllers :
>  * DWC3 for USB2 and USB3 Host functionality
>  * DWC2 for USB2 Peripheral functionality
> - 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
> - 1 USB3 PHY shared with PCIE funcionnality
> - A Glue to control PHY routing, setup and OTG detection
> 
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
> 
> This drivers supports the on-probe setup of the OTG mode, and manually
> via the USB Role interface. The IRQ mode change detect is yet to be added
> in a future patchset, mainly due to lack of hardware to validate on.
> 
> Changes since v4 at [3]:
> - remove remaining phy_put/clk_put() of patch 8
> - handled phy_power_off/on() in suspend/resume
> - Collected review tag on patch 8
> 
> Changes since v3 at [2]:
> - Documented and replaced magic values in USB2 PHY driver
> 
> Changes since v2 at [1]:
> - Collected review tags
> - Removed syscon.h in usb2 phy driver
> - Added comment on the USB3/PCIe switch
> - Renamed dwc3_meson_g12a_usb_init_mode in glue driver
> - Changed indentation in dwc3_meson_g12a_role_set
> - Switched to of_get_compatible_child in glue code
> - Added devm_add_action_or_reset() to disable clock in case of probe failure
> - Checks priv->vbus before enabling regulator
> - Switched phy_init/phy_power_on
> - Removed priv->phys[i] NULL checks in suspend code
> - Removed clk_disable_unprepare/clk_put in remove code
> 
> Changes since v1 at [0]:
>  - USB2 PHY Bindings: collected tags and updated commit log
>  - USB3/PCIE PHY Bindings: collected tag and updated reset list
>  - DWC2 Compatible: collected tags
>  - DWC3 Glue Bindings:
>    - removed clock-names and reset-names for single entries
>    - removed ports graph for PHYs and replaced by phys list with phy-names
>    - added dr_mode and optional vbus-supply
>    - fixed example
>  - USB2 PHY Driver: removed USB_SUPPORT and otg.h include
>  - USB3/PCIE PHY Driver: removed USB_SUPPORT, fixed comment and unused reg variable
>  - USB Glue Driver:
>    - Moved debugfs I/F to USB_ROLE_SWITCH framework
>    - Integrated USB Glue Control Registers offset
>    - Removed of graph parsing to use devm_phy_optional_get()
>    - Fixed PHY mode handling and OTG switching
>    - Simplified PHY calls by removing the NULL test
>    - Added optional vbus regulator handling
> 
> [1] https://lkml.kernel.org/r/20190212151413.24632-1-narmstrong@baylibre.com
> [2] https://lkml.kernel.org/r/20190304103846.2060-1-narmstrong@baylibre.com
> [3] https://lkml.kernel.org/r/20190318101153.7531-1-narmstrong@baylibre.com
> [4] https://lkml.kernel.org/r/20190318132655.30040-1-narmstrong@baylibre.com
> 
> Neil Armstrong (8):
>   dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
>   dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
>   dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
>   dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
>   phy: amlogic: add Amlogic G12A USB2 PHY Driver
>   phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
>   usb: dwc2: Add Amlogic G12A DWC2 Params
>   usb: dwc3: Add Amlogic G12A DWC3 glue
> 
>  .../bindings/phy/meson-g12a-usb2-phy.txt      |  22 +
>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt |  22 +
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 +++
>  .../devicetree/bindings/usb/dwc2.txt          |   1 +
>  drivers/phy/amlogic/Kconfig                   |  22 +
>  drivers/phy/amlogic/Makefile                  |   2 +
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c     | 341 ++++++++++
>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 413 ++++++++++++
>  drivers/usb/dwc2/params.c                     |  12 +
>  drivers/usb/dwc3/Kconfig                      |  10 +
>  drivers/usb/dwc3/Makefile                     |   1 +
>  drivers/usb/dwc3/dwc3-meson-g12a.c            | 604 ++++++++++++++++++
>  12 files changed, 1538 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
> 

