Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B124C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4775208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bIRBaOT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfFUHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:09:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:15272 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfFUHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:09:26 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190621070922epoutp019ce5976af5253fa0e8efb2a49ae197d5~qJQ3gvYBu1743217432epoutp01n
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:09:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190621070922epoutp019ce5976af5253fa0e8efb2a49ae197d5~qJQ3gvYBu1743217432epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561100962;
        bh=mssAlzN3bpN6iKMvQmKFUfLb9lcsDNmvcv98ATjLwIo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bIRBaOT/iLtomOXhSM8THbZSx8O9XqENzzuEKAo6nibuKl4a0WtU7g+K4or/HaJKO
         8Pc2eDXW5+HeJ5mOhyXORtRgPaQpX3HjUMeOx/yM0tLkSBYb4a5ujLPT+pCJpIZBjM
         /Nc7boTRW+hjicN8gxwst9vGpRs+xfX2b3Us0tQU=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621070919epcas1p218ef7a90779be1c62c9930d2cdab0262~qJQ1La8eS1191911919epcas1p2V;
        Fri, 21 Jun 2019 07:09:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.74.04142.E928C0D5; Fri, 21 Jun 2019 16:09:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190621070917epcas1p1e8477af4b2414414e073a0d2e44ed0d0~qJQzaBjAk2266722667epcas1p17;
        Fri, 21 Jun 2019 07:09:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190621070917epsmtrp1451e76a71c1d07005d3ec452986a353e~qJQzZYJO32822028220epsmtrp1K;
        Fri, 21 Jun 2019 07:09:17 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-16-5d0c829e08c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.44.03692.D928C0D5; Fri, 21 Jun 2019 16:09:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190621070917epsmtip1644c9d17cb738f81bc5a10f54c2506b8~qJQzQn7Su2634526345epsmtip1X;
        Fri, 21 Jun 2019 07:09:17 +0000 (GMT)
Subject: Re: Pointers on using the extcon-adc-jack driver
To:     George Hilliard <ghilliard@kopismobile.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <325a11c4-15a2-0d10-ea09-714f89bad5b6@samsung.com>
Date:   Fri, 21 Jun 2019 16:11:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALM8J=fc78yP8OdLHziEWjxidAtv5xPxOx=fLKXhUTfFrrzkKg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTT3deE0+swZzHIharls9js7i8aw6b
        xe3GFWwOzB5zL7UzefRtWcXo8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        ZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xoU369kKHnFVNO2/ydbAeJWji5GTQ0LARGLepScs
        XYxcHEICOxglXn/sYYZwPjFKvO3ezgThfGOUmHzqFiNMy4/mH1CJvUBVV5oYIZz3jBKTnn5l
        BakSFrCUeHPjPVsXIweHiECUxMdPTiBhZgEFiV/3NoGVsAloSex/cYMNxOYXUJS4+uMx2AJe
        ATuJXxees4C0sgioSiy9Kg4SFhWIkPiycxNUiaDEyZkgZ3NycAoESjw8dIAFYry4xK0n85kg
        bHmJ5q2zmSFuPsImcXe2GITtIrF+YjM7hC0s8er4FihbSuJlfxuUXS2x8uQRNpC3JAQ6GCW2
        7L/ACpEwlti/dDITyG3MApoS63fpQ4QVJXb+nssIsZdP4t3XHlaQEgkBXomONiGIEmWJyw/u
        MkHYkhKL2zvZJjAqzULyzSwkH8xC8sEshGULGFlWMYqlFhTnpqcWGxYYIcf1JkZwEtQy28G4
        6JzPIUYBDkYlHt4Ds7hjhVgTy4orcw8xSnAwK4nw8uTwxArxpiRWVqUW5ccXleakFh9iNAWG
        9URmKdHkfGCCziuJNzQ1MjY2tjAxNDM1NFQS543nvhkjJJCeWJKanZpakFoE08fEwSnVwDjJ
        0/Zzx+cZMyZabOq/ef/4lnfN1smZO8+ULEtl6/7X8/u8+BW1lLsHfn2YvKnMM7GwmVv83qkL
        t1tkeu/ufdTPeERasVdi5duWbYuTjsZUMhfdbvqhnJu76ZJk99/jMyou2CfGRlR231Dn2/Sl
        eQbbhOPLpp//Hbj5rvM1mXOnb9SyLpykf1paiaU4I9FQi7moOBEADO58OpgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO7cJp5YgzO95harls9js7i8aw6b
        xe3GFWwOzB5zL7UzefRtWcXo8XmTXABzFJdNSmpOZllqkb5dAlfGhTfr2QoecVU07b/J1sB4
        laOLkZNDQsBE4kfzD6YuRi4OIYHdjBI/Nu5hgkhISky7eJS5i5EDyBaWOHy4GKLmLaPE5RuX
        GEFqhAUsJd7ceM8GYosIREl8nfEaLM4soCDx694mVoiGJYwSxxuugiXYBLQk9r+4AdbAL6Ao
        cfXHY7A4r4CdxK8Lz1lAlrEIqEosvSoOEhYViJCYvauBBaJEUOLkzCdgNqdAoMTDQwdYIHap
        S/yZd4kZwhaXuPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM
        81LL9YoTc4tL89L1kvNzNzGCI0JLcwfj5SXxhxgFOBiVeHgPzOKOFWJNLCuuzD3EKMHBrCTC
        y5PDEyvEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDo+q5
        sBUXsgy2cSxxi1r1o8j490bXnr7UqkfLF5Yuk7Wa+f6G8e33R9+3OTJoKX+yvabz9pF8wbEI
        iRNT+W7+8Di89838prum5xaZtzzzyPHRTM7Q298kv1ekxn3rxjefInUmfdVoKtu9RvAr2+FV
        y+Q1+D+GrThb6WuiPXf/csf5zXtkQ4tbviqxFGckGmoxFxUnAgD0KP2uhAIAAA==
X-CMS-MailID: 20190621070917epcas1p1e8477af4b2414414e073a0d2e44ed0d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190612175938epcas5p225fcd23edc6411190a68834cb4edda2e
References: <CGME20190612175938epcas5p225fcd23edc6411190a68834cb4edda2e@epcas5p2.samsung.com>
        <CALM8J=fc78yP8OdLHziEWjxidAtv5xPxOx=fLKXhUTfFrrzkKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 19. 6. 13. 오전 2:59, George Hilliard wrote:
> I have question about using the extcon-adc-jack code, which uses an
> ADC to provide an extcon device.  This is exactly what I need for my
> hardware.
> 
> Currently it seems like it's set up to only be called from other C
> "platform" code, although I can't find any examples of such code on
> the internet at all, never mind in the kernel tree.  I am interested
> in putting this driver in the device tree for my board.  Would you be
> amenable to patches adding device tree support for this driver (and
> maybe other related extcon drivers)?  Or have I overlooked the
> "correct" way to use this module?
> 

Until now, extcon-adc-jack driver has not yet supported the dt-binding
on the latest mainline kernel. Actually, extcon-adc-jack has the similar
issue with extcon-gpio about dt-binding.

When I tried to do it[1] for extcon-gpio dt bidnings and someone
tried it[2] again, but, it was not finished. You can check the threads[1][2].

[1] https://lkml.org/lkml/2015/10/21/8
[2] https://lore.kernel.org/patchwork/patch/681550/

In order to support the dt-binding for extcon-adc-jack,
have to find the proper compatible name indicating the device connector
and defines the properties to get the ADC value from devicetree.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
