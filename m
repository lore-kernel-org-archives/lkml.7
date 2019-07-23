Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC6821734
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sD2pMxV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfGWPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:36:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42231 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfGWPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:36:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723153628euoutp02f193ae91544dcf0c626dbdfbe1ddd92d~0E0w71e1A1032310323euoutp023
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723153628euoutp02f193ae91544dcf0c626dbdfbe1ddd92d~0E0w71e1A1032310323euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563896188;
        bh=O8Vpty1gSXpURAMJeyha589DoPW5AsCUoN3Phq7m0bQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sD2pMxV8phuw+L+S0NCf6X8gOWxsFoctTPgPZdWenO7/Py7Ntn08g8f7LZ1cW8I+P
         ZG3/kE39mx04K0FwaYhIrFw4VER+7/WhL3OMrNKsjJuueUT5cNj7iQuDzrEpHM66N4
         w0pzwUXvPt/klxY3vjbcnCTUKEXBn1Z4rPO53jdE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723153628eucas1p1336ba2d87e17a6d8a0729f684d7deba6~0E0wiawIZ0734507345eucas1p14;
        Tue, 23 Jul 2019 15:36:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.A4.04298.B79273D5; Tue, 23
        Jul 2019 16:36:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723153627eucas1p2c178db48c92e5864bce982f507560eff~0E0v34sWN1825618256eucas1p2e;
        Tue, 23 Jul 2019 15:36:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723153627eusmtrp154562d96acfb5e1e7a9c49d1ef420b70~0E0vp5NTM2233722337eusmtrp1Y;
        Tue, 23 Jul 2019 15:36:27 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-27-5d37297b11a1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.D1.04140.B79273D5; Tue, 23
        Jul 2019 16:36:27 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190723153626eusmtip1ee9fba930d829abc318b10176215dd76~0E0vSOsu80838408384eusmtip1b;
        Tue, 23 Jul 2019 15:36:26 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: nvidia: Remove extra return
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adaplas@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <92c45f9b-015a-d6f0-bb27-558580fb4d35@samsung.com>
Date:   Tue, 23 Jul 2019 17:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb-LmG4PrWCXfmDqor2bgxyFJRt5Yg0vmNgE9zvaw+S3Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87o1muaxBleaGC1+dn9hs7jy9T2b
        xbWrDcwWJ/o+sFpc3jWHzeLSx0NMDmweO2fdZfe4332cyePzJrkA5igum5TUnMyy1CJ9uwSu
        jO29h5gKljBXLPy3ia2B8TJTFyMnh4SAicS9o9/AbCGBFYwSZ+cIdDFyAdlfGCX+31/HBOF8
        ZpT41dvDCNNx8NkXdojEckaJU4snsEI4bxklvk97AlYlLGAncXTRPFYQW0RAW2Lu4V/MIDaz
        wBJGifu7xUFsNgEriYntq8DqeYHq51x+yQJiswioSlxt7AG7SVQgQuL+sQ2sEDWCEidnPgGr
        4RQIlGhuPg81U1zi1pP5TBC2vMT2t3OYQQ6SEFjELvFn0zGos10kbn66wQJhC0u8Or6FHcKW
        kTg9uYcFomEdo8TfjhdQ3dsZJZZP/scGUWUtcfj4RaAzOIBWaEqs36UPEXaUeLvyBCNIWEKA
        T+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK5knMCrNQvLaLCTvzELyziyEvQsY
        WVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEppnT/45/2sH49VLSIUYBDkYlHt4KJvNY
        IdbEsuLK3EOMEhzMSiK8gQ1msUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGan
        phakFsFkmTg4pRoYjaZvq/v15PIrswtpjede3OVb9m/j5rLgQyYRSfm93xgufxU5rW5XxxDY
        Hedzdkc60yYFFdFY9ufWH3/+k7vWpuHjPjV/dZ2jxhFTRgvvjIT7CYGTG223x/ennzycXsCj
        vKHJZuEyNmGdwy/rTz27GqN6eFlC1bmZHBcfPL7f/jX7UP17Kd4XSizFGYmGWsxFxYkAxn6m
        zS8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7rVmuaxBpNOCVn87P7CZnHl63s2
        i2tXG5gtTvR9YLW4vGsOm8Wlj4eYHNg8ds66y+5xv/s4k8fnTXIBzFF6NkX5pSWpChn5xSW2
        StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gdt7DzEVLGGuWPhvE1sD42Wm
        LkZODgkBE4mDz76wdzFycQgJLGWUWLnhP3MXIwdQQkbi+PoyiBphiT/Xutggal4zSkztOM4O
        khAWsJM4umgeK4gtIqAtMffwL2aQImaBJYwSf+fMZYLouMcosaf1KDNIFZuAlcTE9lWMIDYv
        UPecyy9ZQGwWAVWJq409YCeJCkRInHm/ggWiRlDi5MwnYDanQKBEc/N5sDnMAuoSf+ZdgrLF
        JW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ
        +bmbGIGRte3Yzy07GLveBR9iFOBgVOLhrWAyjxViTSwrrsw9xCjBwawkwhvYYBYrxJuSWFmV
        WpQfX1Sak1p8iNEU6LmJzFKiyfnAqM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2a
        WpBaBNPHxMEp1cBY47D3l0/ZcXUzX93LKd4HjmonnLoksKWTK1VN3jFfk/9T6ZW4P11L7/Q9
        Ln31QHvRpAlbinzMM5RK4oL7H3jXTX6Tvs/+RvHp444TLu3PPOO0xcPohb9sdvOUi1XxrwJW
        99ybUX6S0SLKbZ9w1LTPk/odlrxwtpxyaf/W067WDU9Lio9e+WyhxFKckWioxVxUnAgADfOP
        8sICAAA=
X-CMS-MailID: 20190723153627eucas1p2c178db48c92e5864bce982f507560eff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722082644epcas3p40d41c7bc15b725e25a882e9209bd25c6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722082644epcas3p40d41c7bc15b725e25a882e9209bd25c6
References: <1562781795-3494-1-git-send-email-jrdr.linux@gmail.com>
        <CGME20190722082644epcas3p40d41c7bc15b725e25a882e9209bd25c6@epcas3p4.samsung.com>
        <CAFqt6zb-LmG4PrWCXfmDqor2bgxyFJRt5Yg0vmNgE9zvaw+S3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/19 10:26 AM, Souptick Joarder wrote:
> On Wed, Jul 10, 2019 at 11:28 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> Minor cleanup to remove extra return statement.
>>
> 
> Any comment on this patch ?
> 
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
