Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB6D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E2QGT0oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfEQLPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:15:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46243 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfEQLPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:15:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190517111527euoutp02b207028fab6b9b6482301ceb3adebf30~fdCvfZ9B42424024240euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:15:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190517111527euoutp02b207028fab6b9b6482301ceb3adebf30~fdCvfZ9B42424024240euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558091727;
        bh=7itc/Tsj38VfPootqwov7TD6uWj2U4nO35LvfFfV/GE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E2QGT0oRgfAPcmBKG10JGEHZ2uZdR1PTJ1f2bxPYQ6AcyiFG1/oKMqyQ3cXWFLMlj
         on2ge0+kr0rgkL7m2bPGUPBhi+O/GDwPu9T+7vck1SBb1f0oDQrXmJ1gBDa5BnI1Np
         KNr8nnzdQvw1LcRs7fWGV8U8YQaSTMoVlo2sHKQY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190517111527eucas1p272bf3dcffa2a37843e5f9e96d7731c0d~fdCuyQ7y60037100371eucas1p29;
        Fri, 17 May 2019 11:15:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5B.7C.04325.EC79EDC5; Fri, 17
        May 2019 12:15:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190517111526eucas1p276da7e2da16f43ad01af8c131625fd80~fdCuEB9Hl2430424304eucas1p2-;
        Fri, 17 May 2019 11:15:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190517111526eusmtrp1e5bde9ea420ce63239ce8eb8a124039b~fdCt2AXiO0516905169eusmtrp1e;
        Fri, 17 May 2019 11:15:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-39-5cde97ce4a85
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.A2.04140.EC79EDC5; Fri, 17
        May 2019 12:15:26 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190517111525eusmtip2ca85ca604046903469dffad083e71bcb~fdCtakRpo1557715577eusmtip2t;
        Fri, 17 May 2019 11:15:25 +0000 (GMT)
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ccde81df-95e1-7496-52a2-aaf7a303c1fe@samsung.com>
Date:   Fri, 17 May 2019 13:15:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yw1xzhnqu0r4.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87rnpt+LMTjdZ2SxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzNZ/Ll3h9WB0+PWnXqPTas62Tz2z13D
        7vHm9Cl2j43vdjB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV0bTr8ksBZOlK87O+M3awLhc
        rIuRk0NCwERi+pX/jF2MXBxCAisYJebs3c0G4XxhlNjV9oMZwvnMKLFucR8LTMuFN6dZIBLL
        GSWW7nsH5bxllDhw4xsbSJWwgJfEsnPXwWwRAVOJHbMugs1lFljGLPFrziZWkASbgKFE19su
        sCJeATuJpXebwOIsAqoSG7puMnUxcnCICsRILPoMVSIocXLmE7ArOAU0Je6v+ghWziwgL9G8
        dTYzhC0ucevJfCaQXRIC59glFv67wwhxtovEiak3WSFsYYlXx7ewQ9gyEqcn97BANDQzSjw8
        t5YdwulhlLjcNAOq21ri8PGLrCAXMQOtXr9LHyLsKPHm7h6wQyUE+CRuvBWEOIJPYtK26cwQ
        YV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GLjvNRy
        veLE3OLSvHS95PzcTYzAZHX63/GvOxj3/Uk6xCjAwajEwyvgczdGiDWxrLgy9xCjBAezkgjv
        hve3Y4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUw7uFd
        Ys3T47nEYmfsHPuWFLF5wZpbp4ocnu/3b9KjjZX7Hx95fr6bx/x03ru87uXt/RtKF/rWnZqx
        3iD3repU27dXWprPrLRJdamddX7V0n2lFsuZjz7jMjFmdN0b+Kkq13njQr/Nye0hH73VG+2C
        GXvDdAVdZ/pd0az3nh0fvdme6c4N6UVVSizFGYmGWsxFxYkAyEpOBVIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7rnpt+LMWh4xGKxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzNZ/Ll3h9WB0+PWnXqPTas62Tz2z13D
        7vHm9Cl2j43vdjB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXkbTr8ksBZOlK87O+M3awLhcrIuRk0NCwETiwpvTLF2MXBxC
        AksZJeYdu84OkZCRODmtgRXCFpb4c62LDaLoNaPE7Id7WEASwgJeEsvOXWcDsUUETCV2zLoI
        VsQssIxZ4ujto4wQHc2sEo/enQGrYhMwlOh62wVm8wrYSSy92wS2gkVAVWJD100mEFtUIEbi
        xNQt7BA1ghInZz4B28YpoClxf9VHsHpmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfss
        JC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmB8bjv2c8sOxq53wYcYBTgY
        lXh4BXzuxgixJpYVV+YeYpTgYFYS4d3w/naMEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD
        U0deSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGs8WzvJ6yF3l7
        2k//l8pzRvBKWEjE/CXv026E+9oa+HLdU9hwKic5a45mb9vuT40qr26Jbvv0NpRjwi+TH/Mj
        F7Bsst+TFqBw6EnJ/3aVJ3XNd7uVz+9mvL6D8/a2XScPrrPdvs3ihmOt2efDR6J5wx3FzhwR
        ilx0MmOWs/m2XWx7Ux87aX6+rMRSnJFoqMVcVJwIAKZqpoHlAgAA
X-CMS-MailID: 20190517111526eucas1p276da7e2da16f43ad01af8c131625fd80
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
        <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
        <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
        <VI1PR04MB5327FAC12E4A3D403E8D92128B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <5d0abe9c-613c-d39b-6746-78e5e5c2bbc5@samsung.com>
        <yw1xzhnqu0r4.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Måns

On 2019-05-13 12:06, Måns Rullgård wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>
>> Hi Peter,
>>
>> On 2019-05-13 11:23, Peter Chen wrote:
>>>> On 2019-05-13 11:00, Peter Chen wrote:
>>>>>> On 2019-05-10 05:10, Peter Chen wrote:
>>>>>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>>>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>>>>>>> added support for attaching devicetree node for USB devices. The
>>>>>>>>> mentioned commit however identifies the given USB device node only
>>>>>>>>> by the
>>>>>> 'reg'
>>>>>>>>> property in the host controller children nodes. The USB device
>>>>>>>>> node however also has to have a 'compatible' property as described
>>>>>>>>> in Documentation/devicetree/bindings/usb/usb-device.txt. Lack for
>>>>>>>>> the 'compatible' property check might result in assigning a
>>>>>>>>> devicetree node, which is not intended to be the proper node for the given
>>>> USB device.
>>>>>>>>> This is important especially when USB host controller has
>>>>>>>>> child-nodes for other purposes. For example, Exynos EHCI and OHCI
>>>>>>>>> drivers already define child-nodes for each physical root hub port
>>>>>>>>> and assigns respective PHY controller and parameters for them.
>>>>>>>>> Those binding predates support for USB devicetree nodes.
>>>>>>>>>
>>>>>>>>> Checking for the proper compatibility string allows to mitigate
>>>>>>>>> the conflict between USB device devicetree nodes and the bindings
>>>>>>>>> for USB controllers with child nodes. It also fixes the
>>>>>>>>> side-effect of the other commits, like 01fdf179f4b0 ("usb: core:
>>>>>>>>> skip interfaces disabled in devicetree"), which incorrectly
>>>>>>>>> disables some devices on Exynos based boards.
>>>>>>> Hi Marek,
>>>>>>>
>>>>>>> The purpose of your patch is do not set of_node for device under USB
>>>>>>> controller,
>>>>>> right?
>>>>>>
>>>>>> Right.
>>>>>>
>>>>> Do you mind doing it at function exynos_ehci_get_phy of ehci-exynos.c?
>>>> I don't mind fixing it in ehci-exynos, but frankly so far I have no
>>>> idea how to do it.  The problem is that newly created USB devices
>>>> get of-node pointer pointing to a node which if not intended for
>>>> them. How this can be fixed in ehci-exynos?
>>>>
>>>    
>>> Can't be workaround by setting of_node as NULL for EHCI controller or
>>> for PHY node at exynos_ehci_get_phy?
>> Ah, such workaround? I will check, but this will need to be done with
>> care, because have a side effect for other subsystems like regulators or
>> clocks.
>>
>> BTW, What's wrong with proper, full verification of USB device nodes?
> Your approach so far doesn't address the actual problem of a conflict
> between the generic USB DT bindings and those for the Exynos host
> controller.  If you fix that, the validation issue goes away.

Well, the issue caused by the Exynos binding conflict will go away, but 
there still will be a chance that wrong node might be assigned to the 
USB device, especially if partially incorrect data will be stored in the 
device tree. For example, it may happen that on some boards the 
different USB chip is mounted, which require different parameters. The 
code only relies on the reg property and device number, while the 
bindings define compatible string with proper exact vendor/product ids.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

