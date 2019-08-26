Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DC92087E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QvjxXF7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfHZIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:55:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46312 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfHZIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:55:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190826085537euoutp013a815b2874aaad24efd0f10936c22a53~_bSesIOEy1606616066euoutp01k
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190826085537euoutp013a815b2874aaad24efd0f10936c22a53~_bSesIOEy1606616066euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566809737;
        bh=4/G5wg4DJNiOKBA319u2NGoaV2LPWGLsqRRCL6/5HbQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QvjxXF7zVrmfXunVZqkZ4ls/9lxHpgBFLiopFUbjZzdEcpgvUurcbFNEbEjxmWwTA
         mK/MtritHyvmnE3JAAd85YS4XiqvZJVtNQ2lC/VtDX5X5PqyOUNTVKZAon/H0mcKha
         3D2jx8p2t6jZOpNk8ZBMVbKd3Ctz+DTkHbpw5yWo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190826085536eucas1p1943cfcfb3497665cba5f208d711d68db~_bSd0SaSu2548625486eucas1p15;
        Mon, 26 Aug 2019 08:55:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.79.04374.88E936D5; Mon, 26
        Aug 2019 09:55:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190826085535eucas1p290033f348e272069bffd17dbad137cfe~_bSdA_5zZ0746807468eucas1p2b;
        Mon, 26 Aug 2019 08:55:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190826085535eusmtrp2c82f1e0dd63676a43fb028d6db854908~_bScy0dBl3154031540eusmtrp2F;
        Mon, 26 Aug 2019 08:55:35 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-14-5d639e88d97b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.E7.04117.78E936D5; Mon, 26
        Aug 2019 09:55:35 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190826085534eusmtip287a9a55fd9201dbd54a99efc6132d4d9~_bScSNjKf2034120341eusmtip2V;
        Mon, 26 Aug 2019 08:55:34 +0000 (GMT)
Subject: Re: [PATCH v2 1/2 RESEND] usb: core: phy: add support for PHY
 calibration
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a380a635-e036-1a18-bc0f-947931f8735c@samsung.com>
Date:   Mon, 26 Aug 2019 10:55:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808094128.27213-2-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv7r1a0+tUPJkUDFQqX1pJ3LTMwmLUh/rQlyzJq17U1Cmb
        07Qvli/NISa+lK6a4csUy7clpmKLNtDMcr4QmWSaOElxIWhCoZbbxfLb73+e/+F/zuGhMLFF
        6E0lyTM4hZxNkRDOeFf/r+FAtS4u+kj3RzHTUdUmZPoL50gmr66NYBo2viLGYmknmfHexwRT
        ZTEKmFp9Aca0dkySTH/tIM7kGSqEEbtlPdopUmYtLSdldX0LApmhuYiQvX7ynJSVdDYjWXvn
        Ji5bMey/TEU5n4znUpIyOUVweIxz4otPZiJ91PuW2jSD56IlTw2iKKBDoO/OOQ1ypsR0E4KN
        od9CXqwiGNZOC3ixgmC9vBjTICdHx8KrbVcjgtXqeZwXNgRmYxeyu9zpK/Bswkra2YOOgPqG
        L4TdhNElGHS+XXKYCFoKGpuGsLOIDod8m8URgdO+MLZhdDR70tehZ4mPFtFuMFg9h9vZacs/
        22AW2hmjD8BL22OMZy+YnKtxzA30LAnT3cs4P3ckWHP1BM/usDjQSfLsA396thvyEHwbbiF5
        UYxg/G4V4l1hYB4YFdpvhtEHoa03mC+fgcaiIpI/pQtM2Nz4IVygrOshxpdFoC4U824/0A60
        /ot9MzKGlSKJdsdq2h3raHeso/2f+xThzciLUylTEzjlMTmXFaRkU5UqeUJQXFqqAW19s6HN
        gZ/dyLgea0I0hSR7RDGquGixkM1UZqeaEFCYxEOUEsxGi0XxbHYOp0i7oVClcEoT2kfhEi/R
        7V0z18R0ApvBJXNcOqfYfhVQTt65KH3zYotp0/1Bh8p4NUw+7hOin6/0yDmrqEymCxZO+LHh
        TRd0/rqlH41lIdLvl9j3h7GQrNrzUnLklNPC8cio4Hwvl5q1wDxXtdD6zjYV+rl+7aj/oqpv
        lVKNLk4P3hzUF0YsgzqA1N1vOW15FLchMHzwDd0be4+pyKICPEdcJbgykZUewhRK9i8lYCSB
        YgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7rt85JjDaYfkrbYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrc4tugki0XzpimsDtweO2fd
        Zfd4OmEyu8fiPS+ZPDat6mTz2D93DbtH35ZVjB4btvxj8fi8SS6AI0rPpii/tCRVISO/uMRW
        KdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/P1w2wFF6UqOg49YGlgfCPa
        xcjJISFgIvFy7y/WLkYuDiGBpYwS+7r2MkMkZCROTmtghbCFJf5c62KDKHrNKNG4cxpYkbBA
        iMTqG0/ZQWwRAQeJJUvvgBUxC0xgltj6+yA7RMdRRonP3bPAOtgEDCW63oKM4uTgFbCTaHl7
        HizOIqAqcenvPrBJogIxEvvObGeHqBGUODnzCQuIzQlU/2jpYbCTmAXMJOZtfsgMYctLbH87
        B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        43fbsZ9bdjB2vQs+xCjAwajEw5tQmhwrxJpYVlyZe4hRgoNZSYQ3Rz8xVog3JbGyKrUoP76o
        NCe1+BCjKdBzE5mlRJPzgaklryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFM
        HxMHp1QD48L/mfLVgTtm6rpHyXKJB2cUuFxL2ZzREOjrNmuV65vDapYN+Zxtm6f4HoqVK/xp
        tfrh0t0r36vqvlsaUZryjvUoi7r5FvYvN29uffRPlcPq9XO7qPpoiQpuV+k6f+lffHMuXuXx
        f6+W8OYvX07lr9U9e5YxVXw9fnajgNX87WE5ntHX3l5tV2Ipzkg01GIuKk4EAKvISLj1AgAA
X-CMS-MailID: 20190826085535eucas1p290033f348e272069bffd17dbad137cfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
        <CGME20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5@eucas1p2.samsung.com>
        <20190808094128.27213-2-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 2019-08-08 11:41, Marek Szyprowski wrote:
> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
> done after every USB HCD reset. Generic PHY framework has been already
> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
> phy: add calibrate method"). This patch adds support for it to generic
> PHY handling code in USB HCD core.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>

Greg: any chance to give it this a try in -next? If not, maybe You can 
point someone whose review will help?


> ---
>   drivers/usb/core/hcd.c |  7 +++++++
>   drivers/usb/core/phy.c | 21 +++++++++++++++++++++
>   drivers/usb/core/phy.h |  1 +
>   3 files changed, 29 insertions(+)
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 88533938ce19..b89936c1df23 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2291,6 +2291,9 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>   	hcd->state = HC_STATE_RESUMING;
>   	status = hcd->driver->bus_resume(hcd);
>   	clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
> +	if (status == 0)
> +		status = usb_phy_roothub_calibrate(hcd->phy_roothub);
> +
>   	if (status == 0) {
>   		struct usb_device *udev;
>   		int port1;
> @@ -2864,6 +2867,10 @@ int usb_add_hcd(struct usb_hcd *hcd,
>   	}
>   	hcd->rh_pollable = 1;
>   
> +	retval = usb_phy_roothub_calibrate(hcd->phy_roothub);
> +	if (retval)
> +		goto err_hcd_driver_setup;
> +
>   	/* NOTE: root hub and controller capabilities may not be the same */
>   	if (device_can_wakeup(hcd->self.controller)
>   			&& device_can_wakeup(&hcd->self.root_hub->dev))
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 7580493b867a..fb1588e7c282 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -151,6 +151,27 @@ int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>   }
>   EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
>   
> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
> +{
> +	struct usb_phy_roothub *roothub_entry;
> +	struct list_head *head;
> +	int err;
> +
> +	if (!phy_roothub)
> +		return 0;
> +
> +	head = &phy_roothub->list;
> +
> +	list_for_each_entry(roothub_entry, head, list) {
> +		err = phy_calibrate(roothub_entry->phy);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
> +
>   int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>   {
>   	struct usb_phy_roothub *roothub_entry;
> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
> index dad564e2d2d4..20a267cd986b 100644
> --- a/drivers/usb/core/phy.h
> +++ b/drivers/usb/core/phy.h
> @@ -18,6 +18,7 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>   
>   int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>   			     enum phy_mode mode);
> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub);
>   int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>   void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

