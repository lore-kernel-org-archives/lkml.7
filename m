Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A255FC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7566A20989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Oqv2ZY/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfEJJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:43:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36085 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfEJJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:43:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190510094344euoutp02dc045df1bcdbd1b1677b53333f8e8a65~dSRqKO-tF0205702057euoutp02W
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:43:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190510094344euoutp02dc045df1bcdbd1b1677b53333f8e8a65~dSRqKO-tF0205702057euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557481424;
        bh=bHCPYmsbOMRDm07/+P+9nfNSK+fdU9Y72lYDY30HA6Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Oqv2ZY/lH3tL4XYcFliVktKMTModE1WFtnNQpjXkrl50pivUC7wgDR4VL3X2iy8k+
         7xhtXqDHD/ZFghlCbkgeWTFXv0/r05k6HBu6A9/IjJw61w+O0HA7mF407a8e95vKKy
         2u9iIQiv2bs37wRbXabFfRjiqo+IS9GnhudJAPUg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190510094343eucas1p2ca568971e1990e14e0c3f3f1029b4537~dSRpkemWd1868218682eucas1p2e;
        Fri, 10 May 2019 09:43:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 82.CF.04325.FC745DC5; Fri, 10
        May 2019 10:43:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190510094342eucas1p15535afc4fd20f3813653678e46259177~dSRopN6QB1889518895eucas1p1d;
        Fri, 10 May 2019 09:43:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190510094342eusmtrp15f3a8d0accb060ed3beae50935dacc2d~dSRoavnDy2266422664eusmtrp17;
        Fri, 10 May 2019 09:43:42 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-35-5cd547cfc7cd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.DE.04140.EC745DC5; Fri, 10
        May 2019 10:43:42 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190510094342eusmtip170d44ce943714f616bb8fe06bce77e22~dSRn7lEJA0773207732eusmtip1Y;
        Fri, 10 May 2019 09:43:42 +0000 (GMT)
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
To:     Peter Chen <peter.chen@nxp.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
Date:   Fri, 10 May 2019 11:43:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG++/e3Xsdzf6bhQeLkkVCUmoWccGUtMCRBn2KMKNm3nx/aVPz
        JSyUfFlmZcHmMCoDi6VOzdS0jGa5ynL5Ei4pSVBLm2KZTFEsr1fLb7/znOdwngOHIeTPxW5M
        TGIKp05UxSsoCdnQPtu50xr8Mdyn5qc7W6s3idnceyaKtVpraLanuYxi9dZWEVtecYlgR1/O
        IHZmUCdi5wc+i/c7Kfs/X1DWGQsp5fNblbTS3vGWVtZONImUxfVGpJyq23yEDpPsi+TiY9I4
        tXfAKUl0YVMdneyQpT9+lUNfRDZnLXJiAO+Bykc2WoskjBw/QFCgfyIWit8IJvNNSCimELR0
        68UrIzWWekpo3EfQ9W1ieX4cwc2ZdyLe5YIPQUVnH8XzenwMdAsdJG8icC4Bjb0vCL5B4V2g
        HdcumaQ4AOyzY0tM4m0wc123yAyzAYdD+dSyRQZvSodInp3wCZgb0yKeCbwFGsfLCIFdoX/o
        tojfBbiThrtDrZQQ+yA4RotJgV1gzFJPC7wJOm4UkcJALoLBzipaKIoQ9OTokeDygzZLl5hP
        RODtYGr2FuRAsH95KuJlwM5gG5cJIZyhpEFHCLIUCvLkgtsDDJbqf2tffOgmriGFYdVphlXn
        GFadY/i/9w4ijciVS9UkRHGa3YncOS+NKkGTmhjldTopoQ4tvlXHgmW6CbXOR5gRZpBirZRd
        1xsuF6vSNBkJZgQMoVgvVe9YlKSRqoxMTp10Up0az2nMaCNDKlylWWu+HpfjKFUKF8dxyZx6
        pStinNwuom72zFy0JP1hVYnsaP3ZybZq//Yi31Dk5hgO8TDGluRH+ATl9X9/Jgnusv3+NJvi
        l/2+ryCk5UClPeyZv3taoO+F16xjhHqf3PbrR773SFBoY1a7y7DssKFsMO6KLmJvgT1Gd37g
        6nR27J+3W1GLK/Z86WKFTLqUMnt5JmmLLitITbRqlyeh1qj+Agu2Ld1SAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rn3K/GGMzfrmSxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzNZ/Ll3h9WB0+PWnXqPTas62Tz2z13D
        7vHm9Cl2j43vdjB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXkbnjk3sBd8FK7YebWJvYLzB18XIySEhYCKx4fgWti5GLg4h
        gaWMEkcnbGCBSMhInJzWwAphC0v8udYFVfSaUeJSwwVmkISwgJfEsnPXgRIcHCICERJ7LuWB
        1DALNDNL3GxoY4domM8k8edxPxtIA5uAoUTX2y4wm1fATuLNz1dgNouAqsSPidPBbFGBGIkT
        U7ewQ9QISpyc+QTsIk6BWInfr7oYQWxmATOJeZsfMkPY8hLb386BssUlbj2ZzzSBUWgWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDo3Hbs55YdjF3vgg8xCnAw
        KvHwWvBfiRFiTSwrrsw9xCjBwawkwlukAxTiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDi
        yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwMj/Y+d2MzNZ7Rk/
        j/TMEZb8KCcjeTNlzcGif/P87MW+9vZa6dx67fAn5WPzJG+OpWJZhc+ZxN+FmKbOvuB7KsVJ
        8rNWmZLprpuf572c2R0w20K9W9BqZ7CODUNXFF+/kMDN7on3e3f9PdB3b8Xs9zxKX3Q3B5/8
        Frbz8//5QcHZXpUVxvX/LiixFGckGmoxFxUnAgD0Y0HX5AIAAA==
X-CMS-MailID: 20190510094342eucas1p15535afc4fd20f3813653678e46259177
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>
        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2019-05-10 05:10, Peter Chen wrote:
>
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>> added support for attaching devicetree node for USB devices. The
>>> mentioned commit however identifies the given USB device node only by the 'reg'
>>> property in the host controller children nodes. The USB device node
>>> however also has to have a 'compatible' property as described in
>>> Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
>>> 'compatible' property check might result in assigning a devicetree
>>> node, which is not intended to be the proper node for the given USB device.
>>>
>>> This is important especially when USB host controller has child-nodes
>>> for other purposes. For example, Exynos EHCI and OHCI drivers already
>>> define child-nodes for each physical root hub port and assigns
>>> respective PHY controller and parameters for them. Those binding
>>> predates support for USB devicetree nodes.
>>>
>>> Checking for the proper compatibility string allows to mitigate the
>>> conflict between USB device devicetree nodes and the bindings for USB
>>> controllers with child nodes. It also fixes the side-effect of the
>>> other commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled
>>> in devicetree"), which incorrectly disables some devices on Exynos
>>> based boards.
> Hi Marek,
>
> The purpose of your patch is do not set of_node for device under USB controller, right?

Right.

> I do not understand how 01fdf179f4b0 affect your boards, some nodes under
> the USB controller with status is not "okay", but still want to be enumerated?

Please look at the ehci node in arch/arm/boot/dts/exynos4.dtsi and then 
at the changes to that node in arch/arm/boot/dts/exynos4412-odroidx.dts. 
Exynos EHCI controller has 3 subnodes, which matches to the physical 
ports of it and allows the driver to enable given PHY ports depending on 
which physical port is used on the particular board. All ports cannot 
not be enabled by default, because PHY controller has limited resources 
and shares them between USB host and USB device ports.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

