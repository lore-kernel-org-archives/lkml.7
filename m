Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FCC20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qTy0iPFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEGGnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:43:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43535 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:43:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190507064309euoutp02d1dcd4826e2c787fee929fa6b71675fa~cU4IOCjU60934209342euoutp02x
        for <linux-kernel@vger.kernel.org>; Tue,  7 May 2019 06:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190507064309euoutp02d1dcd4826e2c787fee929fa6b71675fa~cU4IOCjU60934209342euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557211389;
        bh=BsqkkSMuCsEmyJ3V2rYQxYceeCfOy0Y7L6gGt4Spf3s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qTy0iPFtYmZi03/AjMneeWNEhTcO+bg9fokPCkGqxeV9tzjntEXrqXCTZ2s45A/28
         lcd2bZfi10cfNBoVTqggXsZzq1AVonbLn169S29b7XHiRScQQCJ2NAWshMb9J0KWo9
         nA17nipCYJqzl4jTvA+ZAh4NKALv03T+og1sqW7w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507064308eucas1p1d18fb0bcffeae47f0dea517ed61ad8b3~cU4HmnCz10899108991eucas1p1b;
        Tue,  7 May 2019 06:43:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.78.04325.CF821DC5; Tue,  7
        May 2019 07:43:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190507064307eucas1p1b6cfe0e7d91ed94230215a4c6e576879~cU4Gpe2d-2026920269eucas1p1R;
        Tue,  7 May 2019 06:43:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507064307eusmtrp24021940e32e21a29a66485f3f544c25e~cU4GbfT422403724037eusmtrp23;
        Tue,  7 May 2019 06:43:07 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-c6-5cd128fcb108
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.5E.04140.BF821DC5; Tue,  7
        May 2019 07:43:07 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507064306eusmtip2e3f736eaa88fef487c482ceb418ca6d6~cU4F5nhMK0504905049eusmtip2i;
        Tue,  7 May 2019 06:43:06 +0000 (GMT)
Subject: Re: [BUG BISECT] USB on Exynos4412 fails after usb: dwc2: gadget:
 Replace phyif with phy_utmi_width
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bf605524-705a-8dc1-e54c-413564efc29b@samsung.com>
Date:   Tue, 7 May 2019 08:43:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d198f061-3ed6-11d9-4e92-0e0fb2705238@synopsys.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7p/NC7GGPx9ym8x/2aSxawZp1kt
        zp/fwG5xedccNosZ5/cxWSxa1sps8W7KbWYHdo/T628yemxa1cnmMe9koMeW/Z8ZPT5vkgtg
        jeKySUnNySxLLdK3S+DKePLDq2CKSMWOmXwNjF2CXYwcHBICJhIzL1Z3MXJxCAmsYJQ4v3wv
        E4TzhVHi3ZdeKOczo0TX/adsXYycYB1tH7ZBJZYzSjzs3QLlvGWUWP7tPTtIlbBAnsT2XRPZ
        QRIiAq2MEt0N11lAHGaBb4wSc1u6WUGq2AQMJbredoHN5RWwk7hwCWQhJweLgIpEa/NzVpAL
        RQViJBZ9hioRlDg58wkLiM0p4CDRv2cN2BhmAXmJ5q2zmSFscYlbT+aDXSQhsIld4sbNuUwQ
        d7tIfDsygxHCFpZ4dXwLO4QtI/F/J0xDM9A/59ayQzg9jBKXm2A6rCUOH78IdhGzgKbE+l36
        kOBzlNj3khXC5JO48VYQ4gY+iUnbpjNDhHklOtqEIGaoScw6vg5u68ELl5gnMCrNQvLZLCTf
        zELyzSyEtQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJp/T/45/3cG470/SIUYB
        DkYlHt4JThdihFgTy4orcw8xSnAwK4nwJj47FyPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rh
        QbSQQHpiSWp2ampBahFMlomDU6qB8fyqw5+++B7Jv6hYyMF6V/1NT9Upi1Sj1J+qPn5eXuEW
        ck5+f/zr54fJLkhaxDKReW7dsaZ3Kc+Oir/0YRF74c0R927RLP/XFrMcJQ4IN5ZW8Mr5mMz8
        3CKznnmTZlTYK0Omg286lNsqxezOdmxmSGxaNLdw3fny7O82mzkvlDczfetKeC+pxFKckWio
        xVxUnAgA3vsN0ToDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7q/NS7GGBy8yWsx/2aSxawZp1kt
        zp/fwG5xedccNosZ5/cxWSxa1sps8W7KbWYHdo/T628yemxa1cnmMe9koMeW/Z8ZPT5vkgtg
        jdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLePLD
        q2CKSMWOmXwNjF2CXYycHBICJhJtH7YxdTFycQgJLGWUuLCpiR0iISNxcloDK4QtLPHnWhcb
        RNFrRolD++YwgySEBfIktu+ayA6SEBFoZZR43PkbrIpZ4BujxMkdd6BadjBKPNt4iBGkhU3A
        UKLrLcgsTg5eATuJC5d6mUBsFgEVidbm52D7RAViJE5M3cIOUSMocXLmExYQm1PAQaJ/zxqw
        GmYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6x
        kV5xYm5xaV66XnJ+7iZGYMxtO/Zzyw7GrnfBhxgFOBiVeHgf2F6IEWJNLCuuzD3EKMHBrCTC
        m/jsXIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTQV5JvKGpobmFpaG5sbmxmYWSOG+H
        wMEYIYH0xJLU7NTUgtQimD4mDk6pBkZG6W1c/lyLK99qTFjhcP/Tlwvu6hFM6cvfqx2L2lnq
        syDG56Z7X0PLp3siK0Sulv8uVZ7b9sPYcqvgFMV/adwFszsEtWo4eIsU85t3TDsQV2Wqqzl/
        btndmHsXYo4lawrIJ3bUf19cbT73zOSrwav3NE4RSnv50PMZX2CB3T4V8esL6lI0byixFGck
        GmoxFxUnAgBtvrXbzwIAAA==
X-CMS-MailID: 20190507064307eucas1p1b6cfe0e7d91ed94230215a4c6e576879
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190507062136epcas1p3729d57b9d22f834ccd2de0a081ddfbde
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190507062136epcas1p3729d57b9d22f834ccd2de0a081ddfbde
References: <20190503204958.GA12532@kozik-lap>
        <CGME20190507062136epcas1p3729d57b9d22f834ccd2de0a081ddfbde@epcas1p3.samsung.com>
        <d198f061-3ed6-11d9-4e92-0e0fb2705238@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 2019-05-07 08:21, Minas Harutyunyan wrote:
> Hi Krzysztof,
>
> On 5/4/2019 12:50 AM, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Bisect pointed commit 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif
>> with phy_utmi_width") as reason for failures of USB on Exynos4412,
>> Odroid U3 board (ARMv7, exynos_defconfig, TFTP boot with nfsroot from
>> NFSv4):
>>
>> [    4.333996] usb 1-2: new high-speed USB device number 3 using 
>> exynos-ehci
>> [    4.503942] usb 1-2: device descriptor read/64, error -71
>> [    4.793970] usb 1-2: device descriptor read/64, error -71
>> [    4.914748] usb usb1-port2: attempt power cycle
>> [    6.224267] usb 1-3: new high-speed USB device number 5 using 
>> exynos-ehci
>> [    6.393983] usb 1-3: device descriptor read/64, error -71
>> [    6.684243] usb 1-3: device descriptor read/64, error -71
>> [    6.954259] usb 1-3: new high-speed USB device number 6 using 
>> exynos-ehci
>> [    7.123980] usb 1-3: device descriptor read/64, error -71
>> [    7.413969] usb 1-3: device descriptor read/64, error -71
>> [    7.534778] usb usb1-port3: attempt power cycle
>>
>> The boot failure is effect of lack of network adapter (USB, smsc95xx).
>> Expected:
>> [    4.285831] usb 1-3: New USB device found, idVendor=0424, 
>> idProduct=3503, bcdDevice=a1.a0
>> [    4.288986] usb 1-3: New USB device strings: Mfr=0, Product=0, 
>> SerialNumber=0
>> [    4.299596] hub 1-3:1.0: USB hub found
>> [    4.300027] hub 1-3:1.0: 3 ports detected
>> [    5.895541] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, 
>> lpa 0xCDE1
>>
>> Full kernel log is here:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__krzk.eu_-23_builders_25_builds_1330_steps_14_logs_serial0&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=6z9Al9FrHR_ZqbbtSAsD16pvOL2S3XHxQnSzq8kusyI&m=OiD-VOiMNPgl24seQpn5JKZq7f85A4LNzaz8zX0YrKs&s=WBsxDt_1PXo9t9AxxJkUTTLE6zx_UDc7ac_U3EydCzI&e= 
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__krzk.eu_-23_builders_25_builds_1330&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=6z9Al9FrHR_ZqbbtSAsD16pvOL2S3XHxQnSzq8kusyI&m=OiD-VOiMNPgl24seQpn5JKZq7f85A4LNzaz8zX0YrKs&s=Lxk4ZiitEFaod88HTY0hthrdRy_TtktU53P6UDtaCoE&e= 
>>
>>
>> Let me know if you need any more details.
>>
>> Best regards,
>> Krzysztof
>>
>>
>
> But fail seen on ehci driver not dwc2.

Right, but dwc2 and ehci share common USB2 PHY on Exynos4 SoCs, although 
they use different ports of it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

