Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E64EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131DB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KoiFJSzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfDOI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:58:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57647 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:58:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190415085807euoutp01f5df0c625c276a1aaebd218fa79bbb3c~Vmhsg297b2599225992euoutp01y
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:58:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190415085807euoutp01f5df0c625c276a1aaebd218fa79bbb3c~Vmhsg297b2599225992euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555318687;
        bh=6XXiOul6e30Kf92QvUW+776xXgAjshulGmat7JvNX94=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KoiFJSzRWc3YzGHGjfHnCJYXYdp/ZCS2wTzoEn6ehRQxU9fZryvsWdCfy+oX1DGpc
         lyDKwb9VvnjdB3IgOSCXuyUUwyacaGgk1kVAphg+CbZRIT8erIvWl8Udo2sqRaSOQP
         acmBqT3ivuYvSfEWAU4Ep3SEQH4LEDGWasR6iC3o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190415085806eucas1p2b57c61b1c0bd573d15c8fd0635c6df61~Vmhrz4IW61004610046eucas1p24;
        Mon, 15 Apr 2019 08:58:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.2E.04298.E9744BC5; Mon, 15
        Apr 2019 09:58:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190415085806eucas1p13dfb48ba4f6fe1ac91c5c3b5457946b2~VmhrBmk_M0336503365eucas1p1e;
        Mon, 15 Apr 2019 08:58:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190415085805eusmtrp118d1946efd98c15483743ffca23f16da~VmhqyAz9G1228812288eusmtrp1W;
        Mon, 15 Apr 2019 08:58:05 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-14-5cb4479ecb05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.6D.04146.D9744BC5; Mon, 15
        Apr 2019 09:58:05 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190415085805eusmtip142fe34bce163a353c13d9840b44215b6~VmhqOL5772043320433eusmtip1Y;
        Mon, 15 Apr 2019 08:58:05 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
Date:   Mon, 15 Apr 2019 10:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415081300.24831-2-ronald@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87rz3LfEGDy4r2zR2zSdyeLwoheM
        Fle+vmezOPX1L5tF8+L1bBaT7k9gseicuITd4uanb6wWl3fNYbN48Vza4sW9t0wWJ75NY3Lg
        8fi86hWrx85Zd9k9ZnfMZPWY0inhMe9koMf+uWvYPe53H2fy6NuyitFj770tLB6fN8l5zGjf
        xhrAHcVlk5Kak1mWWqRvl8CV8f3AHfaCRUIV95r8Gxgb+bsYOTkkBEwkPiw6ywxiCwmsYJS4
        /tQBwv7CKPHpjVsXIxeQ/ZlRYvarZ0wwDfNvn2eESCxnlHi8ZysrhPOWUeLXv59sIFXCAiES
        z/eeZAFJiAjMZpI4PnU2E4jDLPCCUWLy0zMsIFVsApoSfzffBOvgFbCTaF59AyjOwcEioCrx
        crUISFhUIELi/rENrBAlghInZz4Ba+UUsJI41b0FLM4sIC/RvHU2M4QtLnHryXyoUxs5JDas
        sIWwXSRmdR1nhrCFJV4d38IOYctInJ7cwwJh10vcX9HCDHKnhEAHo8TWDTuhGqwlDh+/yApy
        GzPQzet36UOEHSVWL57DCBKWEOCTuPFWEOIEPolJ26YzQ4R5JTrahCCqFSXun90KNVBcYumF
        r2wTGJVmIXlsFpJnZiF5ZhbC3gWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC09zp
        f8c/7WD8einpEKMAB6MSD++Fys0xQqyJZcWVuYcYJTiYlUR4BTqAQrwpiZVVqUX58UWlOanF
        hxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhgnxLZcn7TBZB2H+FPrtcJTVrc8zODZ
        99nMOzJru3RiuPTUW9HZJivYBf9OeBjo37wjt0Dz7tc5H+Sq81yaV55X2XhxWd2hkOYspfTy
        zl8PrVZN3XkqdoW9Qpd988eV62Qd3m0TTbnp5nLBYVP/5Ft/giJ2Fr5j9k30y3kmtWfuoxO2
        a/d2SXkpsRRnJBpqMRcVJwIA5up/IW8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7pz3bfEGFw8oGnR2zSdyeLwoheM
        Fle+vmezOPX1L5tF8+L1bBaT7k9gseicuITd4uanb6wWl3fNYbN48Vza4sW9t0wWJ75NY3Lg
        8fi86hWrx85Zd9k9ZnfMZPWY0inhMe9koMf+uWvYPe53H2fy6NuyitFj770tLB6fN8l5zGjf
        xhrAHaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX
        8f3AHfaCRUIV95r8Gxgb+bsYOTkkBEwk5t8+z9jFyMUhJLCUUeLuhhvMEAlxid3z30LZwhJ/
        rnWxQRS9ZpS4sesRC0hCWCBE4vnekywgCRGB+UwSt37+YwdxmAVeMUrcXz8Nau5eRombV2Yx
        gbSwCWhK/N18kw3E5hWwk2hefQOonYODRUBV4uVqEZCwqECExJn3K1ggSgQlTs58AmZzClhJ
        nOrewgpiMwuoS/yZd4kZwpaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJL
        i3PTc4sN9YoTc4tL89L1kvNzNzEC43vbsZ+bdzBe2hh8iFGAg1GJh/dC5eYYIdbEsuLK3EOM
        EhzMSiK8Ah1AId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4Hpp68knhDU0NzC0tDc2NzYzML
        JXHe8waVUUIC6YklqdmpqQWpRTB9TBycUsBoEhOekR0x4TT/4S07znc0KU++biRVMvfr6hjX
        KdqH1e3+hl+Y1Pti3rUrdmrKqTtiHx+blu18UaFt1gwf7gWd/g8lVjpPYf28p/ris9b6xdFK
        6fLceXm+07XKfqtW5Zeq/l69L/+fsvJmNuVn7lJGPBOVN+89u8dOWJD3p5r/qf3pUs22b8SU
        WIozEg21mIuKEwEZVBOUBQMAAA==
X-CMS-MailID: 20190415085806eucas1p13dfb48ba4f6fe1ac91c5c3b5457946b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac
References: <20190415081300.24831-1-ronald@innovation.ch>
        <CGME20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac@epcas2p4.samsung.com>
        <20190415081300.24831-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.2019 10:12, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
>
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
>
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).
>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


If there are no objections I will take it to drm-misc tomorrow.


 --
Regards
Andrzej
