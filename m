Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57ACC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCA522CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KRwEw9SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2F05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:26:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43975 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2F04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:26:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829052654euoutp020d955540a2386a2aae96ccd11165c8d2~-TYGVxFzh3222332223euoutp02a
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:26:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829052654euoutp020d955540a2386a2aae96ccd11165c8d2~-TYGVxFzh3222332223euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567056414;
        bh=ud38pDUS0GE9KNvFshwlkbt9yfmFvMbiwz5ZT7qfMOw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KRwEw9SU/pQh9KH07RWXNBYEVpIWwKeefOraBFuxxb7XSxIhaCoWZPG3jwz6otn3V
         7zQlLhYp6kkwBEHTkxQe7UggwamkVd3ukjD2PjLrBFawGSf/JTHQ2pmomeIz+KWLCD
         T8kvhSY3DqrbhoHo4iBgm1pImamjgdN2lEIC/pAw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190829052653eucas1p1f79dc95ff2bc27601282d143f5cb35c9~-TYFcusC-3167831678eucas1p1a;
        Thu, 29 Aug 2019 05:26:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.EA.04469.D12676D5; Thu, 29
        Aug 2019 06:26:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190829052652eucas1p28a14dc8645c7df7fdc7a957916d0304d~-TYEsS3gC1619516195eucas1p26;
        Thu, 29 Aug 2019 05:26:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190829052652eusmtrp20f89d1ad335c9a228c55a595a5deef30~-TYEeI9Ie3025630256eusmtrp2C;
        Thu, 29 Aug 2019 05:26:52 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-fe-5d67621d9da3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.BC.04117.C12676D5; Thu, 29
        Aug 2019 06:26:52 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190829052651eusmtip2164dcae62bcd932742edcc33319dc177~-TYD-Zovc1396713967eusmtip2R;
        Thu, 29 Aug 2019 05:26:51 +0000 (GMT)
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
Message-ID: <e801e7a4-f525-baae-4c02-d271db308b5f@samsung.com>
Date:   Thu, 29 Aug 2019 07:26:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828204146.GA21235@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87qySemxBmvXslpsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVscW3SSxaJ50xRWB26PnbPu
        sns8nTCZ3WPxnpdMHptWdbJ57J+7ht2jb8sqRo8NW/6xeHzeJBfAEcVlk5Kak1mWWqRvl8CV
        cXr7MtaCzZwVvcsOMTcwnmPvYuTkkBAwkTj87RlbFyMXh5DACkaJvtY+ZgjnC6PEmkeNLBDO
        Z0aJLye2AjkcYC0zD1RAxJczSiz7vI8NZJSQwFtGiYfdriC2sECIxOobT8FWiAgYS/SfncUO
        0sAsMJtZYv/TN6wgCTYBQ4mut11gzbwCdhL3rk1lBLFZBFQlHqz4xARiiwrESOx808MMUSMo
        cXLmE7AjOAX0JRr3eoCEmQXkJba/ncMMYYtL3HoynwnitUfsEivXZEPYLhLtDbtYIGxhiVfH
        t0C9LyPxfydIPReQ3Qx0/7m17BBOD6PE5aYZjBBV1hKHj19kBVnMLKApsX6XPkTYUWJ5Zyc7
        JFD4JG68FYS4gU9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIHpuF5JtZSL6ZhbB3
        ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMA0dvrf8U87GL9eSjrEKMDBqMTDy5GY
        FivEmlhWXJl7iFGCg1lJhPeRSmqsEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp
        2ampBalFMFkmDk6pBkZG1q3WmQfEeFafPDKLuVrBa8qp9yvuNdZ6aR6c5ha50uWF4pquLS7C
        HRMO3BNcZ3ln6bXAmWeqfYPnBgolaJ+ZH/Q04WfPHIXr0myX+abfOPqU8b6TxnfWO44bdupM
        k8lzFljy3n6af4PGy+ovk4J+2tWsTstyE7rSlN9t4jwnvSnvnILlVFklluKMREMt5qLiRABt
        u2xaXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7oySemxBi3X+C02zljPanGs7Qm7
        RfPi9WwWS//eY7Q4f34Du8XlXXPYLGac38dksWhZK7PFuo232C2OLTrJYtG8aQqrA7fHzll3
        2T2eTpjM7rF4z0smj02rOtk89s9dw+7Rt2UVo8eGLf9YPD5vkgvgiNKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOL19GWvBZs6K3mWHmBsYz7F3
        MXJwSAiYSMw8UNHFyMUhJLCUUeLDwjamLkZOoLiMxMlpDawQtrDEn2tdbBBFrxklzvyfwQiS
        EBYIkVh94yk7iC0iYCzRf3YWmM0sMJdZYmGDK0TDfCaJq/P/gTWwCRhKdL0FmcTJwStgJ3Hv
        2lSwOIuAqsSDFZ/ANosKxEjsO7OdHaJGUOLkzCcsIJdyCuhLNO71gJhvJjFv80NmCFteYvvb
        OVC2uMStJ/OZJjAKzULSPQtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kR
        GLnbjv3csoOx613wIUYBDkYlHt6E5LRYIdbEsuLK3EOMEhzMSiK8j1RSY4V4UxIrq1KL8uOL
        SnNSiw8xmgL9NpFZSjQ5H5hU8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB
        9DFxcEo1MHZ0SAZszy5NDLA2O7ZYe8ODOR+OXpc8/+DppcKdCWt1THLmmE+d5twZs688Y/qB
        +q+drQlPs1INE0J/Jig07FEo95fPenyic//7FVm5O5J2lzL8fqnJMrFmtX7tKd3pDOwrJLRO
        d52X1lAKlL1w6PKtibPVmD8eKfvGvObbb6+vyjfE2Hg5xJRYijMSDbWYi4oTAZJaCoXyAgAA
X-CMS-MailID: 20190829052652eucas1p28a14dc8645c7df7fdc7a957916d0304d
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019-08-28 22:41, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 10:55:33AM +0200, Marek Szyprowski wrote:
>> Hi Greg
>>
>> On 2019-08-08 11:41, Marek Szyprowski wrote:
>>> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
>>> done after every USB HCD reset. Generic PHY framework has been already
>>> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
>>> phy: add calibrate method"). This patch adds support for it to generic
>>> PHY handling code in USB HCD core.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
>> Greg: any chance to give it this a try in -next? If not, maybe You can
>> point someone whose review will help?
> Ah crap, this is me, not the PHY maintainer :(
>
> Can you resend this and I will be glad to review it.  But it would also
> be good to get Felipe's review as well.

No problem, I will resend it again in a few minutes. Felipe already 
acked it: https://lkml.org/lkml/2019/8/8/460

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

