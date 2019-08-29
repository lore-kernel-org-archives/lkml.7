Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A49C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E00233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nlhbbyFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2K1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:27:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35505 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2K1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:27:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829102737euoutp02ee14fa6a66673dc741a1bb03e7705ccc~-XeqaXaS10517405174euoutp02J
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:27:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829102737euoutp02ee14fa6a66673dc741a1bb03e7705ccc~-XeqaXaS10517405174euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567074457;
        bh=9mw6EhXjiZTgR4tgh+0rgLvVqetCCIjPFmyy3xD9Zt8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nlhbbyFjgIVDQkk5cRIUuTP3Hp4K7ykq+6iPI+RoxWifDm8KvIO4Whg/bt3WA108U
         Mep0VmIEGgFNfzmfXz0Rx2+tEGY7qHAr1y0dvIh5/HU3NkTIvv2WExzVq+LrRVFFEQ
         y7Y+xoDdeXepZ89FLnkuJXMVwon1ow9xPGbCeLgQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190829102736eucas1p26f00a8b5cbec5e6458bd109191abadc7~-XepowlgG0884608846eucas1p2f;
        Thu, 29 Aug 2019 10:27:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F3.F2.04469.898A76D5; Thu, 29
        Aug 2019 11:27:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190829102735eucas1p26e9c4beb5218a7639e5ddecd14fbd11f~-Xeo1w5Jp0455704557eucas1p2O;
        Thu, 29 Aug 2019 10:27:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190829102735eusmtrp25b46b49e3f212529264d77641853278f~-XeonntHM2206722067eusmtrp27;
        Thu, 29 Aug 2019 10:27:35 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-32-5d67a898e6b6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.CF.04166.798A76D5; Thu, 29
        Aug 2019 11:27:35 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190829102735eusmtip2eda6e6d0e0dda98bcbd45254021c0075~-XeoHbbTg0687606876eusmtip2d;
        Thu, 29 Aug 2019 10:27:35 +0000 (GMT)
Subject: Re: [PATCH v2 1/2 RESEND] usb: core: phy: add support for PHY
 calibration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <91b0a341-e561-43f5-3daa-c6aaf33e3287@samsung.com>
Date:   Thu, 29 Aug 2019 12:27:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829102113.GA20823@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bvdq/L2eM0PKwomxUUpZmGF0yzlw+jIPzgF8uVt7xNSadu
        WlpElmlpVqMibVqKkopv0zG0mSSumKjkTCu0NEwcYTgK7c1Sq+vN8tvv/M//POd/4KEJea9Y
        QSdo0zidlk1USqRks33GsbWoWqPeZjcpmKYik5ix545TTHaFScI8mHuLGIejkWIGWkskTJHj
        sYgpr8whmIam1xRjL+8imWzzbXHEcpXVOEKpnIZblKqibUKkMtfkSVTt9+oo1XVLDVI1WuZJ
        1bR5TSR9SLozjktMOMXpAsJjpfHW7jEy5ap7RnHLNJmFxt3ykRsNOBh+fG+T5CMpLcfVCHpG
        Oiih+Ixgvm/wbzGN4KdhglwceTs6hHiW4yoEd0tTBZMLQeudehHf8MJRUDvopHj2xkFw45lx
        4SUCFxPQ7pwU8w0JDoR8V76EZxkOh/Kq2T/DNE3iDVA4tJ+XV+IYsE4WEILFE7ruji+EcMMB
        4Mi9tMAEXgstrhJCYB94PV4q4ncBnqDg5bUXYiH1PjDnlIkE9oIPnRZK4NXwy7o4kI3gXW89
        JRQFCAYuFiHBFQpPOp+L+XQE3gSm1gBB3g1VeXkULwP2gEGXpxDCA242FxKCLIMruXLBvRGM
        nQ3/1nb09RMGpDQuOc245BzjknOM//eWIbIG+XDp+iQNpw/Ucqf99WySPl2r8T+enGRGf35Z
        z3zn1EP0pf+YDWEaKd1lNHtCLRezp/SZSTYENKH0lo2t59RyWRybeYbTJR/VpSdyehtaRZNK
        H9nZZaOH5VjDpnEnOS6F0y12RbSbIgvtCNljP7TCqbuI1qkn0HDm+bn37zyCFdGVUkNVaeKV
        /X3owGp61rEPqbulT+eqbbUzyV935Rnq/HJXRDeHvS9TmOrDnFMR3d8OhoQPh8U7vGM+3YsK
        tX58ZLH27mXPba+14/I38oxXfrLUWMubWt89QVuCL6jvFx+JdLVc9o3UKkl9PBu4mdDp2d/k
        3nvVYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7rTV6THGtz5oWyxccZ6VotjbU/Y
        LZoXr2ezWPr3HqPF+fMb2C0u75rDZjHj/D4mi0XLWpkt1m28xW5xbNFJFovmTVNYHbg9ds66
        y+7xdMJkdo/Fe14yeWxa1cnmsX/uGnaPvi2rGD02bPnH4vF5k1wAR5SeTVF+aUmqQkZ+cYmt
        UrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexs5Tj1gKunkqZm//zNLA+ISz
        i5GTQ0LAROLeg5uMXYxcHEICSxklJjXOZYRIyEicnNbACmELS/y51sUGUfSaUeL61qtMIAlh
        gRCJ1TeesoPYIgLGEv1nZ4HZzAJzmSUWNrhCNPxkknj5YynYJDYBQ4mutyCTODl4BewkFi3/
        AzSIg4NFQFVi+k0vkLCoQIzEvjPb2SFKBCVOznzCAmJzCuhLnG9rYYGYbyYxb/NDZghbXmL7
        2zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJ
        ERi724793LyD8dLG4EOMAhyMSjy8CclpsUKsiWXFlbmHGCU4mJVEeB+ppMYK8aYkVlalFuXH
        F5XmpBYfYjQF+m0is5Rocj4wreSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgt
        gulj4uCUamCMPPDMY9n9DuUHx957WovWaKwImbTPw/oAA1eyQiHPevGcsJOy7RIvzN+etCwX
        n/1HvGHT5AKtu8dVrqftZ99yKeH5IoPWU+xF//zrey9P+v8o8V/RusVH2570+XE/thAuODbX
        6Nsa8coU879dt3IspCN3xzOJC/yw2JStwSDq8Tj3uKpu9CslluKMREMt5qLiRAB8Jjxw8wIA
        AA==
X-CMS-MailID: 20190829102735eucas1p26e9c4beb5218a7639e5ddecd14fbd11f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
        <CGME20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5@eucas1p2.samsung.com>
        <20190808094128.27213-2-m.szyprowski@samsung.com>
        <a380a635-e036-1a18-bc0f-947931f8735c@samsung.com>
        <20190828204146.GA21235@kroah.com>
        <e801e7a4-f525-baae-4c02-d271db308b5f@samsung.com>
        <20190829102113.GA20823@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019-08-29 12:21, Greg Kroah-Hartman wrote:
> On Thu, Aug 29, 2019 at 07:26:50AM +0200, Marek Szyprowski wrote:
>> Hi Greg,
>>
>> On 2019-08-28 22:41, Greg Kroah-Hartman wrote:
>>> On Mon, Aug 26, 2019 at 10:55:33AM +0200, Marek Szyprowski wrote:
>>>> Hi Greg
>>>>
>>>> On 2019-08-08 11:41, Marek Szyprowski wrote:
>>>>> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
>>>>> done after every USB HCD reset. Generic PHY framework has been already
>>>>> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
>>>>> phy: add calibrate method"). This patch adds support for it to generic
>>>>> PHY handling code in USB HCD core.
>>>>>
>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>>>> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
>>>> Greg: any chance to give it this a try in -next? If not, maybe You can
>>>> point someone whose review will help?
>>> Ah crap, this is me, not the PHY maintainer :(
>>>
>>> Can you resend this and I will be glad to review it.  But it would also
>>> be good to get Felipe's review as well.
>> No problem, I will resend it again in a few minutes. Felipe already
>> acked it: https://lkml.org/lkml/2019/8/8/460
> I don't see the resend, did I miss it?

I looks so: https://lkml.org/lkml/2019/8/29/31

> And can you add Felipe's ack to it?

Yes, I've already did that.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

