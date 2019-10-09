Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55383C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A2206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KU6Cu6zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfJIK3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:29:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42080 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfJIK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:29:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191009102901euoutp023f5b6babe914ef0f4c02e659d1cdba2a~L88mHiq2x1939319393euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:29:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191009102901euoutp023f5b6babe914ef0f4c02e659d1cdba2a~L88mHiq2x1939319393euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570616941;
        bh=RjVamniFkfeOGzt7mIaiNyYX24tD48iUqzHFqWM0BC8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KU6Cu6zZGnPTk15T79pz7PNiyyAkN7niXph8/o6xXMESHMFZg+0K09WUypMJFqr+3
         cwNi/BaxrzxLy3eDFHBHd8LZYwNTieT7z7TIyf2NMk+q+at6EknDCOSBPN95M/PnXl
         Cn1kPxkzQRKoGbhGWaIAajHvQMaBedad5NTUAxV0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191009102901eucas1p25226f22d6c8588af2101c8d63792cd54~L88lulTNG0143901439eucas1p21;
        Wed,  9 Oct 2019 10:29:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 64.90.04469.D66BD9D5; Wed,  9
        Oct 2019 11:29:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191009102901eucas1p25cda59b5e451ebcec58335362e0fa20d~L88lTE7UV2092020920eucas1p2a;
        Wed,  9 Oct 2019 10:29:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191009102901eusmtrp1c9b8e2f253065c2b1455e722485d47bc~L88lSb_pl1811418114eusmtrp1Z;
        Wed,  9 Oct 2019 10:29:01 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-47-5d9db66d2450
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.8D.04166.C66BD9D5; Wed,  9
        Oct 2019 11:29:00 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191009102900eusmtip1e4c1d6915ecf22e24b169e8967ca850a~L88kuQqgH1345313453eusmtip1a;
        Wed,  9 Oct 2019 10:29:00 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
Date:   Wed, 9 Oct 2019 12:29:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008180750.GT4382@sirena.co.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87q52+bGGrT9lLPYOGM9q8XUh0/Y
        LFZ/fMxoseDTDFaL8+c3sFs8mHuTyeLblQ4mi8u75rBZzDi/j8li41cPBy6PnbPusntsWtXJ
        5nHn2h42j/6/Bh59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMalxH1PBIpaKyY93szQwrmTu
        YuTgkBAwkZjWXt/FyMUhJLCCUaLp5Wl2COcLo8S+5Z8ZIZzPjBL3Xi0DcjjBOh6fmMkOYgsJ
        LGeUWD+rFKLoLaPEm0VvWUESwgJpEpNefWEBsUUE3CXeTJjHBGIzCxxjknjzXAHEZhMwlOh6
        28UGYvMK2ElsuvcFrJdFQEXi8/3bYPWiArES934cZ4aoEZQ4OfMJ2ExOoN6jyy4yQsyUl9j+
        dg4zhC0ucevJfCaQgyQETrFLfHpynh3iaheJHU++QX0gLPHq+BaouIzE6ck9LBANzYwSD8+t
        ZYdwehglLjfNgOqwljh8/CIrKMSYBTQl1u/Shwg7SrStPg8NSD6JG28FIY7gk5i0bTpUmFei
        o00IolpNYtbxdXBrD164xDyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgx
        t7g0L10vOT93EyMwTZ3+d/zTDsavl5IOMQpwMCrx8DpUzYkVYk0sK67MPcQowcGsJMK7aBZQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA2OcTZGU/Eyv
        8LSo1bs7o5yEQty+Jt+rWNaip5S05TlXX9+iZRFmLd4Xsv8t83h81H3ye8m3v0McmkUqFnMe
        rnTbXi8hsCv3xUGHzhIHr8fic+33Gb5ddcTqd/mP+XufsSz79bj3d/7WSVkhsVyLt9WGC7qk
        zNt/Mte/rXVTyOz4wvwHLV+EHyqxFGckGmoxFxUnAgDnY84rTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7o52+bGGtw4ZGWxccZ6VoupD5+w
        Waz++JjRYsGnGawW589vYLd4MPcmk8W3Kx1MFpd3zWGzmHF+H5PFxq8eDlweO2fdZffYtKqT
        zePOtT1sHv1/DTz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvY1LjPqaCRSwVkx/vZmlgXMncxcjJISFgIvH4xEz2LkYuDiGB
        pYwSbQ/OQyVkJE5Oa2CFsIUl/lzrYoMoes0osf7CabCEsECaxP3DjxlBbBEBd4k3E+YxgRQx
        Cxxjklh4bC0LRMcNFomGCc1gY9kEDCW63oKM4uTgFbCT2HTvC9gkFgEVic/3bwN1c3CICsRK
        bNprBlEiKHFy5hMWEJsTqPXosotgy5gFzCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGoVlI2mch
        aZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNz27Gfm3cwXtoYfIhRgINR
        iYfXoWpOrBBrYllxZe4hRgkOZiUR3kWzgEK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wb
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGOfX1N4X+RL45WwJ
        S/PDncyi4Uc4UutuuL7L3fK0obX8j/7ZFcu+/qpoilf50qhz8neF9nWLeezGKbNeiQnXPjn3
        OFppzrWS+zcbjLmVrzj8lTWYeXlDRalY9+3F8WvdbuluXBx61Onaj2BWG6OnBZL9JRcfSnp7
        OPTuzY4Lu8PKz87x4dQZSyWW4oxEQy3mouJEAKCM9cHjAgAA
X-CMS-MailID: 20191009102901eucas1p25cda59b5e451ebcec58335362e0fa20d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
References: <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
        <20191008120611.GG4382@sirena.co.uk>
        <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
        <20191008124736.GJ4382@sirena.co.uk>
        <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
        <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
        <20191008161535.GN4382@sirena.co.uk>
        <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
        <20191008171747.GS4382@sirena.co.uk>
        <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
        <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
        <20191008180750.GT4382@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 08.10.2019 20:07, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 09:00:29PM +0300, Dmitry Osipenko wrote:
>> Properly handling case of a disabled coupled regulator certainly will be
>> useful, but looks like there are no real users for that feature right
>> now and thus no real testing is done.
> Right, sorry - I missed the double negative there.

Okay, then what is the conclusion, as I got lost a bit? How do you want 
this issue to be fixed?

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

