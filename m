Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CD3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WqG2z5+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHLPBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:01:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53849 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfHLPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:01:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190812150112euoutp016092a71cd38a9485a0eb40c0073529aa~6NPrRCv0O2774127741euoutp01x
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:01:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190812150112euoutp016092a71cd38a9485a0eb40c0073529aa~6NPrRCv0O2774127741euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565622072;
        bh=qznjP4qVWzE05zhmh0IbTpbILayuGEfZCP07QFBwoDI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WqG2z5+U7Gddy4vPKTJPWbjsqiRKb3wPAu1oRGNURWuzBQq+ny1hFg8yelBEkZywS
         xrWT9oJBaEqTyzRs2/GJAXLVH4R8C1BLJciLhKKdSIS1lJLioxWPogi0nB/j73Sx7f
         Vyic3k3Vtt5vb1WedIUuJmIC1eqHHphZzBp2CWKI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190812150111eucas1p27307bb1b50a55c5d4c235dd38dbed2ed~6NPq26r5P1456714567eucas1p2M;
        Mon, 12 Aug 2019 15:01:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.AD.04309.73F715D5; Mon, 12
        Aug 2019 16:01:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190812150111eucas1p15e410ada5aa0dbfe7f22571ced5446f7~6NPqFkxVP3165131651eucas1p1V;
        Mon, 12 Aug 2019 15:01:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190812150110eusmtrp1f27af81f4f470999602ec5b16eb9a91b~6NPp3NZ260893308933eusmtrp1i;
        Mon, 12 Aug 2019 15:01:10 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-4a-5d517f37ef84
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7E.F8.04117.63F715D5; Mon, 12
        Aug 2019 16:01:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190812150110eusmtip212baa546b2daf4e82305d59731fa0b9d~6NPpd8w9G1835118351eusmtip2Y;
        Mon, 12 Aug 2019 15:01:10 +0000 (GMT)
Subject: Re: [PATCH v4] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <26447daa-b183-1121-b2a8-c295d7e3468d@samsung.com>
Date:   Mon, 12 Aug 2019 17:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <94b4ef23-282d-44e4-d21e-60c8a33c342c@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87rm9YGxBi+uqFisvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC2KyyYlNSezLLVI3y6BK+PcnCnMBbc4Kv50NTI3MP5g62Lk5JAQMJH41fOd
        uYuRi0NIYAWjxI4jFxkhnC+MEn27J7NAOJ8ZJVZO/cYI0/LgyA92iMRyRokzX3dDVb1llHjV
        sIMVpEpYIFBi8dWl7CC2iICcxMfWq2BzmQW2MUocPf0KLMEmYCUxsX0V2FheATuJedeWgNks
        AqoSO3uuMIHYogIREvePbWCFqBGUODnzCQuIzSlgK7Hm/1ZmEJtZQFzi1pP5TBC2vMT2t3PA
        PpIQOMQucerdPWaIu10kXuw5zAJhC0u8Or6FHcKWkTg9uYcFomEdo8TfjhdQ3dsZJZZP/gcN
        KGuJw8cvAp3BAbRCU2L9Ln2IsKPEvqXLWEDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrE
        hmUb2GDWdu1cyTyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10v
        OT93EyMwMZ3+d/zLDsZdf5IOMQpwMCrx8FYkBMYKsSaWFVfmHmKU4GBWEuEt+RsQK8SbklhZ
        lVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHROb93xpvl/4ojPobt
        uxboeLoq9uazibt/6vwuS3c5wM53Ys8RVZ81t36KH1U9dq9MSUTpt9EZHvcZAV8F1TdJtvmn
        Mn3MMD63cflpxYI+71zPmRwNL3bd/5g72WSH4FrmFzM7/rRo/FMKvpKvK2wfYJTrf21fx9z8
        spL/3pyrI3T+HWJqTfyixFKckWioxVxUnAgAZy7y6EgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7pm9YGxBlsO6FusvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+PcnCnMBbc4Kv50NTI3MP5g62Lk5JAQMJF4cOQHexcjF4eQwFJGid1f3zN1MXIA
        JWQkjq8vg6gRlvhzrYsNouY1o8SEl09YQBLCAoESi68uZQexRQTkJD62XmUEKWIW2MYo8fXa
        dEaIjk5miefL34OtYxOwkpjYvooRxOYVsJOYd20JmM0ioCqxs+cKE4gtKhAhceb9ChaIGkGJ
        kzMhtnEK2Eqs+b+VGcRmFlCX+DPvEpQtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMw23Hfm7Zwdj1LvgQowAHoxIPb0VCYKwQ
        a2JZcWXuIUYJDmYlEd6SvwGxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTBF5JfGGpobm
        FpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYM1fG8n+ao3LSI6e5zHaHX9jE
        V18izX/vPFN/au7Pxy4HTBUYXy3TYqvaa8fTsmqFmmJbU2i2wYlpjAs0bvCt3xAvo3D8lsWd
        yTPKuDiZviUWH+Nv6BEOfXdJwfvU/vMNcUcm/3sd3ztthxl3iy3fVr1wiW2qRn6ft776+HVi
        AL/jZ7XO3fYZSizFGYmGWsxFxYkAk0ALqdkCAAA=
X-CMS-MailID: 20190812150111eucas1p15e410ada5aa0dbfe7f22571ced5446f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
References: <20190811153643.12029-1-max@enpas.org>
        <CGME20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5@epcas1p1.samsung.com>
        <d9fa8aca-62a4-5d4a-b63f-bdd628e6b304@enpas.org>
        <4729c030-549e-8797-f947-1620cd61d516@samsung.com>
        <27f3bb2f-e4b8-cfc9-26da-d0984f1bf37b@enpas.org>
        <da84c857-2c2d-29ec-5e72-e719277faa2d@samsung.com>
        <94b4ef23-282d-44e4-d21e-60c8a33c342c@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/19 4:26 PM, Max Staudt wrote:
> On 08/12/2019 02:15 PM, Bartlomiej Zolnierkiewicz wrote:
>>> What's a good way to do that, given that we now have module_exit()> defined and an exit function is void?
>>
>> What about something like this:
>>
>> static bool xsurf_present;
>> ...
>> static int __init pata_buddha_late_init(void)
>> ...
>> 		if (pata_buddha_probe(z, &xsurf_ent) == 0 &&
>> 		    xsurf_present == false)
>> 			xsurf_present = true;
>> ...
>> static void __exit pata_buddha_exit(void)
>> ...
>> 	if (xsurf_present)
>> 		return -EBUSY;
>> ...
>>
>> ?
> 
> Okay, so we're talking about the same idea. Great!
> 
> Unfortunately, pata_buddha_exit() is void, and thus can't fail. According to Documentation/kernel-hacking/hacking.rst this is by design.

You are of course right and the example code is broken
(+ I need more caffeine).

> Any other ideas? We could also continue to disallow unloading completely until MFD support comes along.
Yes, this would also be OK.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
