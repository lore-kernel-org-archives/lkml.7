Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E299206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IM0yuPDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfFGW5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:57:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42386 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfFGW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:57:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1878469pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fQlA8w20R5VYZeUdU67NBQKZzit/borpu7F/JFKTVzY=;
        b=IM0yuPDjItT0iIlSWfas5Kn7G0w0rqLoPR/JNCZuwiW0KwUbQIs+GXWnbuNKDI8AAI
         AyK56ydbb+pLrOe6BKysFUtSwObOTZAatwkihE+DcXc1pgWywkplktpY798CmVTiz4Xd
         m8lkeF3X5m6DNTJn9T39gMhsZ2eAB3FnCpysbsvso/rb3JCBhNiZJtcIxdk2BR8So3pg
         O9YiuuYOvThcvTUDIFkk4/XYezBug9WheFvtTwgM5WwtkDv5ZcM8rgKGkg0AsxaUyJBX
         r0ECyhmRJrQBd9aQ3XwUL8n+WSK/zUs71OAn3JdmWWW+dXthPS2S5W82XXG+zZyVG8jE
         ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fQlA8w20R5VYZeUdU67NBQKZzit/borpu7F/JFKTVzY=;
        b=XIhwifmj/XNp2mh5YziGOGZxAxhWBbxK+ZYxoR9P12AMOFs/vLziTJKvtzjem/19VV
         jfv/B/s4/yFAvQeyOkVlAYujx9GNwxtMc4kdEvtPZ1oRinq/HmtWwcmJg1Dv28eBgA4/
         cCE3nn6VEk1xcDtIh+vNfc8joxmTw3JuQfgpsS9JhJCtJam3i0qqg/UKXFaHrOok/Jd4
         OvcfOe1WvtDpLa0UGSwFgA0Hxa1z1rGOaWaBrlmQ6nUffOsr6mOdezKIDgOKvGq/w9Ja
         tIuDx7HbCAWL6ENirFHbQlhVyHpTDv29+7B0O4PcVvjOovFF+wzSnMNfBcIJP9vvvaOD
         1Z9g==
X-Gm-Message-State: APjAAAUagPa5/Xra12rEkb+DQe11vw2Bhnom7N9qYUKXCo+ALQt+yuyO
        JF5ehCqDMAqA/LeFiKw+E3X1CYsmk9Q=
X-Google-Smtp-Source: APXvYqyhwQrMI0ehAWXsYruJsRs4Nc0Y05HWieJ4GsaKFrNkMltfnzDyY/rsRuJnvVzrOHRqgC/hPQ==
X-Received: by 2002:a62:2643:: with SMTP id m64mr59689157pfm.46.1559948232972;
        Fri, 07 Jun 2019 15:57:12 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id d19sm2765467pjs.22.2019.06.07.15.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:57:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] phy: meson-g12a-usb3-pcie: disable locking for cr_regmap
In-Reply-To: <20190605090215.29905-1-narmstrong@baylibre.com>
References: <20190605090215.29905-1-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:57:11 -0700
Message-ID: <7hh891atrs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Locking is not needed for the phy_g12a_usb3_pcie_cr_bus_read/write() and
> currently it causes the following BUG because of the usage of the
> regmap_read_poll_timeout() running in spinlock_irq, configured by regmap fast_io.
>
> Simply disable locking in the cr_regmap config since it's only used from the
> PHY init callback function.
>
> BUG: sleeping function called from invalid context at drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c:85
> in_atomic(): 1, irqs_disabled(): 128, pid: 60, name: kworker/3:1
> [snip]
> Workqueue: events deferred_probe_work_func
> Call trace:
>  dump_backtrace+0x0/0x190
>  show_stack+0x14/0x20
>  dump_stack+0x90/0xb4
>  ___might_sleep+0xec/0x110
>  __might_sleep+0x50/0x88
>  phy_g12a_usb3_pcie_cr_bus_addr.isra.0+0x80/0x1a8
>  phy_g12a_usb3_pcie_cr_bus_read+0x34/0x1d8
>  _regmap_read+0x60/0xe0
>  _regmap_update_bits+0xc4/0x110
>  regmap_update_bits_base+0x60/0x90
>  phy_g12a_usb3_pcie_init+0xdc/0x210
>  phy_init+0x74/0xd0
>  dwc3_meson_g12a_probe+0x2cc/0x4d0
>  platform_drv_probe+0x50/0xa0
>  really_probe+0x20c/0x3b8
>  driver_probe_device+0x68/0x150
>  __device_attach_driver+0xa8/0x170
>  bus_for_each_drv+0x64/0xc8
>  __device_attach+0xd8/0x158
>  device_initial_probe+0x10/0x18
>  bus_probe_device+0x90/0x98
>  deferred_probe_work_func+0x94/0xe8
>  process_one_work+0x1e0/0x338
>  worker_thread+0x230/0x458
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x1c
>
> Fixes: 36077e16c050 ("phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>
