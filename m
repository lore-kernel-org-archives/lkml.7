Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A840C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239F120820
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U/GDUmKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfHHKi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:38:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38425 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:38:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808103855euoutp017a0a3b602e40a56c9d1503095d7c41ed~47Fh7po3V2663726637euoutp01L
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 10:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808103855euoutp017a0a3b602e40a56c9d1503095d7c41ed~47Fh7po3V2663726637euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565260735;
        bh=0HiA/+jOW/sZnmiRXsnY0Zqg1lv9ez9CjULE6cLislo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U/GDUmKyrH4H7oC8N9L365U+ZPeKyzMBqgQBAsql0+V0uex2QQ3vw9WyofqNhPVU7
         VaFTrF98ODZ6hSWlaHI9lWWQ+s+x74SkCRUVvnVV3qLKw56RZsaZjPdrBGT4vcEt8M
         IUe3s4SctNTGVB7yJ2AdEqRNurBahhDTthKdJAJU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808103854eucas1p1ac097c02c20788b4ad332f6daab58c84~47FhKxEnP2701327013eucas1p1G;
        Thu,  8 Aug 2019 10:38:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.7D.04309.EBBFB4D5; Thu,  8
        Aug 2019 11:38:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808103853eucas1p2567fd41b05adfb9d57cd3bb74f346f88~47FgXAOBa2915529155eucas1p27;
        Thu,  8 Aug 2019 10:38:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808103853eusmtrp296a81e8186beb6c9688db9e8f78cb2e4~47FgI4BUW2515625156eusmtrp2R;
        Thu,  8 Aug 2019 10:38:53 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-1f-5d4bfbbe4658
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A8.2E.04117.DBBFB4D5; Thu,  8
        Aug 2019 11:38:53 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808103852eusmtip1772f2ee5fb9e1ca9a86d5fb5183ce6b8~47Ffjj4au1891018910eusmtip1k;
        Thu,  8 Aug 2019 10:38:52 +0000 (GMT)
Subject: Re: [PATCH v2 2/2 RESEND] usb: dwc3: remove generic PHY calibrate()
 calls
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e489412b-ce5d-7625-34e6-1af06b834620@samsung.com>
Date:   Thu, 8 Aug 2019 12:38:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875zn8t27b.fsf@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b3bvWqTu2l4sDAYppikGQWXNMnoxw2FhKQoHbr0Mi2nsqvm
        R4Flig4r0UibRuZHyqqpa0paKX7kEqNNrQwh01qEn5CurEzLebP89zzPec57znN4SUxqEbqT
        CUmprDpJkSgTOeKtfT/MuzqWQuW7278QdHN5o5Duy7cSdG5No4iuWx5DtNncRNDD7ZUiutzc
        IaCr7+ZhtL55lKD7qvtxOtdwXXjQiWnTviOYT8WlBFPzZFLAGHSFIqbz1n2CuWrUIabJuIIz
        CwaPcPKUY1Acm5iQzqr9g2Mc4+t69FhKlSRDO/NMkINGnDXIgQRqL8zVzwo0yJGUUg0IPhYZ
        hTyxIVhanP5LFhD0TrWI1lsGqgwYX6hH0GC2EDyZRbCs6STsLhcqAsryzJgdu1KxYLWO4nYT
        Rk0LwDhgQ/aCiAoAzaxm7VkxFQyXS/UCO8YpT1iubF7Tt1BR0DZThPEeCfTftOJ27EB5g6Ww
        d82PUdsht6UC47EbjFpvryUCapKA+dp7OL/3Ybg4Ny7gsQtMmYwEj7fB77b1hlwEEy8fEDwp
        QjB8qRzxrkDoMQ2unoNcHeEDje3+vBwCN2b0hF0Gyhnezkr4JZyhpLUM42UxFORLebcXaE36
        f2O7LENYMZJpN0TTboij3RBH+39uFcJ1yI1N41RKltuTxJ7z4xQqLi1J6RebrDKg1X82sGKy
        PULtv053I4pEss3ilOehcqlQkc5lqroRkJjMVTyWfkQuFccpMrNYdXK0Oi2R5brRVhKXuYmz
        N41HSimlIpU9y7IprHq9KiAd3HNQRCcTnv2w4EVLpa9nVviE7oJK1x1mUo7cWQxZmO/18Dm2
        40oJNbQj/2tFVkOe5Kg0e14ln4p5/8q7N+HQypnCa/sG3nxuin4cEcF9O5GvzagdDJT6LgRp
        ln+6n5TIuw5UB31ofI0pz0vkAd89bP3zNotT5HGV+9Oo/f5hgU0rXlMynItXBOzE1JziD8l6
        ZM1jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7p7f3vHGnxZyG+xccZ6VotjbU/Y
        LZoXr2ezWPr3HqPF+fMb2C0u75rDZjHj/D4mi0XLWpkt1m28xW5xbNFJFovmTVNYHbg9ds66
        y+7xdMJkdo/Fe14yeWxa1cnmsX/uGnaPvi2rGD02bPnH4vF5k1wAR5SeTVF+aUmqQkZ+cYmt
        UrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextLD65gLFghWzHpzlKmB8Tpf
        FyMnh4SAicTpBZuYuxi5OIQEljJKbG49ywyRkJE4Oa2BFcIWlvhzrYsNoug1o8Tpyy/ZQBLC
        AiES01vPgzWICCRLLHzzkBWkiFngPZPEzBdrGSE6HjBKLHq/CayKTcBQouttF1g3r4CdRMvk
        dUwgNouAisTfORvB4qICMRL7zmxnh6gRlDg58wkLiM0poC5xofMIWD2zgJnEvM0PmSFseYnm
        rbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cT
        IzB+tx37uWUHY9e74EOMAhyMSjy8BSe8Y4VYE8uKK3MPMUpwMCuJ8N4r84wV4k1JrKxKLcqP
        LyrNSS0+xGgK9NxEZinR5HxgaskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBa
        BNPHxMEp1cC4hGHCdqY7iUnnubnKd2bccKmIUy2LO/Tn9P+fb7/tuDXLs2bvo4sbA3P+1B7g
        mPf12el9m7Ya3nTWLmVd8+zO4+btLmKWCSX2XSFL78X95l3B1MTQ2/rK/o187LYvG1qsTz/V
        uxgs9VdmosXP/Yl3tsVdVlEJO56uPoVdbZpxE2+9UPgl08ocJZbijERDLeai4kQA23d4w/UC
        AAA=
X-CMS-MailID: 20190808103853eucas1p2567fd41b05adfb9d57cd3bb74f346f88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
        <CGME20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf@eucas1p2.samsung.com>
        <20190808094128.27213-3-m.szyprowski@samsung.com> <875zn8t27b.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 2019-08-08 11:51, Felipe Balbi wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
>> which now successfully handles generic PHYs and their calibration after
>> every HCD reset. This fixes all the timing issues related to PHY
>> calibration done directly from DWC3 driver: incorrect operation after
>> system suspend/resume or USB3.0 detection failure when XHCI-plat driver
>> compiled as separate module.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
>> ---
>>   drivers/usb/dwc3/core.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index c9bb93a2c81e..7dd6d419254d 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   				otg_set_vbus(dwc->usb2_phy->otg, true);
>>   			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>   			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> -			phy_calibrate(dwc->usb2_generic_phy);
> are you sure you're the only one using phy_calibrate()? I don't want any
> regressions because of this :-p

Yes I've checked. In case of USB PHYs, the .calibrate method is only 
implemented by Exynos DRDUSB3 PHY driver:

# git grep \\\.calibrate drivers/phy
drivers/phy/broadcom/phy-brcm-sata.c:   .calibrate      = 
brcm_sata_phy_calibrate,
drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c: .calibrate              = 
ufs_qcom_phy_qmp_14nm_phy_calibrate,
drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c: .calibrate              = 
ufs_qcom_phy_qmp_20nm_phy_calibrate,
drivers/phy/samsung/phy-exynos5-usbdrd.c:       .calibrate      = 
exynos5_usbdrd_phy_calibrate,

(the other PHY drivers are for SATA or UFS).

To avoid the regression on Exynos it is enough to apply the 2 patches 
from this patchset together.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

