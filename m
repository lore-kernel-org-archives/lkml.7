Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDEC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F6C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V7TZzVL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfEVGBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:01:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60314 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfEVGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:01:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190522060131euoutp014837f1f10538d01e5371604aa7d92e22~g6-D_VIBC3187031870euoutp01I
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190522060131euoutp014837f1f10538d01e5371604aa7d92e22~g6-D_VIBC3187031870euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558504891;
        bh=hmwRKXWvlgkgh8dejcjaXPbm/GM8juT5jTcoQ62euho=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V7TZzVL1G/TZQ1y7Mhe52fGvxePl0auNYxF3BjcyTLvwm652w944KGd/1QohdWWgb
         YZoj56WUU8WSKAQN8gTUjIzGSUCWv0kZ7nikuwLOyGsKHpYVWSL7tEsZwjZgYPa6wK
         bejOvma4VQbYWL7MAkypKnzJZd/DVALMlpcoapJc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190522060130eucas1p136182bb0d66dbb3cb5c3c262d122af94~g6-DPeukM1139911399eucas1p1y;
        Wed, 22 May 2019 06:01:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.B2.04325.AB5E4EC5; Wed, 22
        May 2019 07:01:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190522060129eucas1p29e860190f3cc31bcce5f9ca13bb40e65~g6-CgDXCm0710707107eucas1p22;
        Wed, 22 May 2019 06:01:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190522060129eusmtrp1fa4f77324f9269280acf0e8dfd852386~g6-CRtGjb2522625226eusmtrp1v;
        Wed, 22 May 2019 06:01:29 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-62-5ce4e5ba1a8c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.3F.04146.9B5E4EC5; Wed, 22
        May 2019 07:01:29 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190522060128eusmtip17b88b8fd6c31b7b19289862b868724e9~g6-Bnpiex3178331783eusmtip1L;
        Wed, 22 May 2019 06:01:28 +0000 (GMT)
Subject: Re: [PATCH 0/5] Exynos EHCI/OHCI: resolve conflict with the generic
 USB device bindings
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ff3f4b25-cbc0-4195-79b2-c00633f0c79c@samsung.com>
Date:   Wed, 22 May 2019 08:01:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yw1xk1ekszo9.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zln52hOjpuXF42ERYVpXgsOKJIQuR8SQhCSo5p5UPHKjlrq
        j6yh1hLTIi+bYmpestS0abZwXrKWrrxkUYiaMwuS5h+VZprkPFr+e57nfb7veV54KUw8TrhT
        CSnprDJFkSQV2uNdr1dHj+q/zcv9SwocmfbyNoKpHhwhGFVdm5AZHX1CMhP6SiFTPmoQMLUN
        eRjzY9CKGKu5TMCsz0wRTF7PIMkUr40JTzjIJqeuyjqabwplvVWPSdlP0zApa1/sFsi001Yk
        K9I1I9lSx/5I6px9SCyblJDJKv1CL9rHv9XNYmn9cEVbYSBz0bREjewooI9BT0kNoUb2lJhu
        QqAz1wh5soygoq93mywh+LVhInaePG34LeAHjQgeGp6RPLEg0FsLcJtLQsfAi6I8ZMPO9HHo
        1oxvfYXR9RjcvtYitA2EdACoLeotLKJD4UFn4VYETh+EOY1+E1OUCy2H2qVtixMMVczjNtmO
        9gKVOcQmY7QnqDq1GI/dYHK+WsAXtZCQV+nO45PwSfcI47EEFow6ksf7wHS3ELdVA1qFwDzS
        QvKkEMHE9XLEu4LhpXF8qw+2Gdym9+PlMGhSDwpsMtCO8NnixHdwhDtdZRgvi+BGvph3HwKN
        sfVfbP/Ye6wYSTW7FtPs2kazaxvN/9z7CG9GbmwGlxzHckEp7GVfTpHMZaTE+V5KTe5Am4dm
        2jCudCPDeswAoikkdRAx5q9yMaHI5LKSBxBQmNRZZBqek4tFsYqsbFaZekGZkcRyA8iDwqVu
        opw9s9FiOk6RziaybBqr3JkKKDv3XPQuYs1puDokJjzsTLBjvy5swaz9GOnOyQPP+r6aDq3X
        +S5mzOaXZjcyE+ddT0UeVnqr7uEukqhSa8TM1JDHnyjP55bvAQ7RhFdabu2q/0bdusZ6tuZN
        K77XY61uKcdz5bTRVVpljspa9gk6EJjoTIWM1Pg0z5X03frwRUuE095SnItXBBzBlJziL+1W
        GAtkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7o7nz6JMXi1Uspi44z1rBbzj5xj
        tWhevJ7N4vz5DewWl3fNYbOYcX4fk8WiZa3MFi+P/GC0+PFwOpPFn3t3WC1a9x5ht5jw+wKb
        A4/HrTv1HptWdbJ57J+7ht3jzelT7B4b3+1g8ph99wejR9+WVYwenzfJBXBE6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWc2fKAueCgRMXsmfvY
        GxjvCncxcnJICJhIbF72i6mLkYtDSGApo8Sv5zcYIRIyEienNbBC2MISf651sUEUvWaUOLbz
        NliRsECSxO6+VjBbRMBUYsesi2BFzALLmSXaN6xjgehYyyjR+mwx2Cg2AUOJrrcgozg5eAXs
        JJZs7QGLswioSjyatQvMFhWIkTgxdQs7RI2gxMmZT4AGcXBwCmhKND+0AQkzC5hJzNv8kBnC
        lpdo3jobyhaXuPVkPtMERqFZSLpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS
        83M3MQKjeNuxn5t3MF7aGHyIUYCDUYmH98G9xzFCrIllxZW5hxglOJiVRHhPn3oUI8SbklhZ
        lVqUH19UmpNafIjRFOi3icxSosn5wASTVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBceqZrLly3ToCocdn9C8sDt4Rv8tXsMebbcZ++/5kFsHipVW/tZJPTZVW
        YLrvnfv0xZ9cq1hvn1O6Hd2KbK0vZT5v++bi32r+3HnDb/7PDCVprL/n/D7wSutnLVNlTPLz
        7//X6zz0f3lGSYb/dn/VouNiaSdDe1Zl/ZdI/5GoLKdxYr5v0LYUJZbijERDLeai4kQA3fqq
        CfgCAAA=
X-CMS-MailID: 20190522060129eucas1p29e860190f3cc31bcce5f9ca13bb40e65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
References: <CGME20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12@eucas1p1.samsung.com>
        <20190521115849.9882-1-m.szyprowski@samsung.com>
        <yw1xk1ekszo9.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Måns

On 2019-05-21 15:30, Måns Rullgård wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> Dear All,
>>
>> Commit 69bec7259853 ("USB: core: let USB device know device node") added
>> support for attaching devicetree node for USB devices. Those nodes are
>> children of their USB host controller. However Exynos EHCI and OHCI
>> driver bindings already define child-nodes for each physical root hub
>> port and assigns respective PHY controller and parameters to them. This
>> leads to the conflict. A workaround for it has been merged as commit
>> 01d4071486fe ("usb: exynos: add workaround for the USB device bindings
>> conflict"), but it disabled support for USB device binding for Exynos
>> EHCI/OHCI controllers.
>>
>> This patchset tries to resolve this binding conflict by changing Exynos
>> EHCI/OHCI bindings: PHYs are moved from the sub-nodes to a standard array
>> under the 'phys' property. Such solution has been suggested by Måns
>> Rullgård in the following thread: https://lkml.org/lkml/2019/5/13/228
>>
>> To keep everything working during the transitional time, the changes has
>> been split into 2 steps. First step (patches 1-3) need to be merged before
>> the second one (patches 4-5). Patches from each step can be merged to
>> respective trees without any dependencies - the only requirement is that
>> second step has to be merged after merging all patches from the first one.
>>
>> This patchset has been tested on various Exynos4 boards with different
>> USB host controller configurations (Odroids family: X2, U3, XU3).
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>>
>> Marek Szyprowski (5):
>>    dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic
>>      PHYs
>>    ARM: dts: exynos: Add array of generic PHYs to EHCI/OHCI devices
>>    usb: exynos: add support for getting PHYs from the standard dt array
>>    ARM: dts: exynos: Remove obsolete port sub-nodes from EHCI/OHCI
>>      devices
>>    usb: exynos: Remove support for legacy PHY bindings
> You could retain compatibility with old devicetrees (which may be
> useful) by using the "phys" property if it exists and falling back
> on the old method if it doesn't.  Then you would get this sequence
> of changes:
>
> 1. Update binding definition.
> 2. Support new binding in driver, with fallback to old.
> 3. Switch dts files to new binding.

This is exactly what I did in this patchset. Until Patch #5 is applied, 
Exynos EHCI/OHCI drivers supports both ways of getting PHYs and is fully 
compatible with existing DTBs. This last patch should be applied at 
least one release later that the first 3 patches to keep everything 
working during the -rcX time.

Compatibility with so called old DTBs is not so important, because there 
are no boards with Exynos4 and Exynos5 SoCs, which would not update DTB 
together with the kernel zImage. There have been already some 
significant compatibility breaks related to those SoCs during last years.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

