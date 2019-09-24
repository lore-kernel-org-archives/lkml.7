Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44310C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20381214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C6+uN6EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfIXS70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:59:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33693 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfIXS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:59:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1918256pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=S+NemDcyACE9qaE3AzZLyHri3U+LN0BbGdBBWP83xAQ=;
        b=C6+uN6EFptObBbReMx4otiZx5Z/xanbuyya/+Ka+EGaS1zvrzaICMGr1kf+Ke7gRpV
         PfQEj9G8xcA/t+Lqa7K71ZZ2bZOFxa7t6+gjOcc7MLayuBgYzbf/NUPAdFUEPH6PGn7n
         zpMaKwedE7HVNxymY+ZW7OR99yVBPJAXmjiR4xd4zHCObJuFL6e1foJNWo39kraazHHo
         fBoSH0k/r1oAbb3XqOfsq/2CUhpHAs47LcxEahsSFrCYlWrm6ICUE8YNl9ZJfU/IDm1Q
         v2N5MmSucHAsNvjrf9ivzpewivzKVtxO9zL+AbUZdMfpQUqTr1zU4YbYltuFYNLCh4R9
         pYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=S+NemDcyACE9qaE3AzZLyHri3U+LN0BbGdBBWP83xAQ=;
        b=RA6wOF9mR08NJxIFyU4bIIJzrskpivn3eNr/iscNgiwuYurNIq4KnDReAPxVoh11/O
         i+BPoaxzA8utXyUcc8w+j7ph5has7pjEZmP8DbnrzLSQ/KwePQ2yBNVtwENdnLD2ZB5e
         RlmbTFKLzrP+Wh8Fj5tqLezueOoz1E4oxvkTh3I9MiZE3Jx9VSDWD0Fwa36EQQ7PUfou
         5oas1fMyNJTmzqtUgcBYsaJ8K2AoqFeXxVeCkUKQSxz9FmYBIhu8sTrQUTFXE8iXhHej
         TbXplWj8RXHnRQRfBPk9kWQ0YlLziLNYU7Ax+n5tVhROYVirL+uRb4TsLcDee+pyvhOd
         6PiQ==
X-Gm-Message-State: APjAAAVsW6hNSLNzApQvt+hX8dvwmny3eGvBioV4foktBffsoIhECVTE
        iHTJw4pDecMMlXQcFGwOWY+dig==
X-Google-Smtp-Source: APXvYqwBoEwDBTyuhiKLpoZslSVm3448hn+4VMKYnLGOo9+/IWR6JjsrRaebH1qxvZxp8hANK6Y9FQ==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr4895272pfr.241.1569351563237;
        Tue, 24 Sep 2019 11:59:23 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 69sm3370025pfb.145.2019.09.24.11.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 11:59:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        lorenzo.pieralisi@arm.com, kishon@ti.com, bhelgaas@google.com,
        andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 0/6] arm64: dts: meson-g12: add support for PCIe
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
Date:   Tue, 24 Sep 2019 11:59:21 -0700
Message-ID: <7h4l117c6u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset :
> - updates the Amlogic PCI bindings for G12A
> - reworks the Amlogic PCIe driver to make use of the
> G12a USB3+PCIe Combo PHY instead of directly writing in
> the PHY register
> - adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
> - adds the PCIe Node for G12A, G12B and SM1 SoCs
> - adds the commented support for the S922X, A311D and S905D3 based
> VIM3 boards.
>
> The VIM3 schematic can be found at [1].
>
> This patchset is dependent on Remi's "Fix reset assertion via gpio descriptor"
> patch at [2].
>
> This patchset has been tested in a A311D VIM3 and S905D3 VIM3L using a
> 128Go TS128GMTE110S NVMe PCIe module.
>
> For indication, here is a bonnie++ run as ext4 formatted on the VIM3:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
>   4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++
>
> and the S905D3 VIM3L version:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
>   4G 52144  95 71766  21 47302  10 57078  98 415469  44 +++++ +++
>
> Changes since v1 at [3]:
>  - Collected Andrew's and Rob's Reviewed-by tags
>  - Added missing calls to phy_init/phy_exit
>  - Fixes has_shared_phy handling for MIPI clock
>  - Add comment in the DT concerning firmware setting the right properties
>  - Added SM1 Power Domain to PCIe node
>
> [1] https://docs.khadas.com/vim3/HardwareDocs.html
> [2] https://patchwork.kernel.org/patch/11125261/
> [3] https://patchwork.kernel.org/cover/11136927/
>
> Neil Armstrong (6):
>   dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
>   PCI: amlogic: Fix probed clock names
>   PCI: amlogic: meson: Add support for G12A
>   phy: meson-g12a-usb3-pcie: Add support for PCIe mode
>   arm64: dts: meson-g12a: Add PCIe node
>   arm64: dts: khadas-vim3: add commented support for PCIe

Queued the "arm64: dts" patches for v5.5,

Kevin
