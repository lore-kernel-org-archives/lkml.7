Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE11720B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FvfPvGDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfJVJq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:46:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:47245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbfJVJq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571737572;
        bh=YQnIZApIf+d3RC8+gJ4XAh8mf3pKoDtSYtaWU4JHfWw=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=FvfPvGDCY4u86PA4B0Ipju/7zhuRh/KbOUl5ahk+B8S0V5DJhQ91TTLTBhS8GC9Bn
         DJtMayQxDgY/MLSoUCFg8mPrjMLzAnwC+tNTKZx7sTyLNSovZTaOE2tk+Jwz0L8Feb
         Wco1dM3nL3L3P0XbHdlSPYfO/pCyLDxGOY/u/yoQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-bq ([185.75.73.113]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1hde1H3qaq-00jIuP; Tue, 22
 Oct 2019 11:46:11 +0200
Date:   Tue, 22 Oct 2019 11:46:07 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191016095338.GD4365@dell>
References: <20191003185323.24646-1-frank-w@public-files.de> <20191016095338.GD4365@dell>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <24600EAE-5379-475F-B83D-880E767F2CDA@public-files.de>
X-Provags-ID: V03:K1:zn6CtqLXymxCEpB4Z1h5hKRQMZxDbjptqj8SY/i72+7a//VKmAP
 BMNrdloz0JRUo1gU6KmNykIc8C8HFn3Pii1+bLj6e/ImqSrzmpweE3MaZ5Aj/aMixWHLZG6
 prqBNzb0IwKz5sG/i0+XGoz/yrzoPfxZlarxjCXLDWO8Hk3FM4Ltc1iIM1K4raT73q/WbEE
 seoTp7xTu4+1YjDCsJmgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6lpq+4CB3fo=:bdh66YT68Xl01DxxnCV72W
 tkREJoNo2ZCTsxa88mHMktJqBf1EO8hFqRlsKHnO+Cwuj9XJVxVSh08UynS/W0FLAV20PGE4i
 UsRNdKTXLeW37rn1hIoQ6vCTGpCjMToooBMHG65Q2f0FZfBmgNZp9f0gpbZyWLOQyeo6qvh2D
 KnsCAFab+pD+rpWqVEVePkaZs7O1bm7imhBMawElc8OYyDzYUBepRDNb2FwLbv/PFq1luTHaZ
 2+4NVZadMCnPWmdGayPDQBJq09BkyhNKHM47eAXBulHPVEn367CtLUyKtwfyBwpDAH3tHhttl
 sNnsgZxWwsMrl6MsqZ+ro9kbIdST7bk2vubsMSRHig941wAMyxar/Ov+NqLdHRonDdQ6f8fOK
 nqQX++BJwXOkZXfo/cGA4bHzw0mQacAyKm59YAAYN9gaiTScHgYJzPdgusd2V7dB4OOhjbX+d
 PipQm3iMkX6GMxebEK0nAGHpLoUZVSozXJztNAc8Zisq/USjBN7aJdWZIENbluGRJS6Qc+MXA
 2uYdpeDiJi/XEtGMWYbpLXIKTsd6AGhg7Jx0CZD7ydBqf+PftY8qjuuGkBsG2scJW932xXF05
 IYDVi3/gmsTpQoeWwbm+hAgk2RS2OAIy83Ejt/x1wLWFilZNPD4Y9KqGEiggfQ3Toh06v3CG7
 Th9Jnnf3btS+i8YxehHaA2fBsyCZilDqBsoAMdUsFRdST+6m1l8GwKZcCx7AKsRq+9ckJfB7N
 SlyMhWCEXkEHDSxU3xWqrlzdNOEODQyn5D0G8Pc6W2dfjI5rlxS7e9OYqSxdqNgEEnB+2+Z4o
 +X4EGQ/jzJ9It4CLyCsx+iwF6MI93Oztqd4dqsypTRL6nhUSLguJaYEPnNXRvm2RUWRNdK54F
 4OiW2xBO1xDj4vJB1ESZz5tthVbnO/ucXqX4KgsEVf6FrkKpfzEq0pLi7BAdAARDHHyMsfKrP
 d12LXL4tl/lTIyqbYdo1qf413Gtzj/UTEude5ACLpSAsaT+Q+hgoL5xLzfzv+ZWWTsVTm4EPg
 R6etENs1oUbPzecg3pY1Bfc1Tvykx3BT/vq/o0l2am2lx9pIr3QzoU7bVNQigmaNiYJzvuNuY
 KnYcVgnLZ27MmNKRBy57xzQboh/+aO5L146IS6pOw6b20NG3CCuZe1kzoEYWuEDp8Jz3icr55
 nG15H5wdExV4SrV9bBv6KXMmCJPL4oxE7PAT/YWjRr+cT2UYXdYKvONBXQ6abYk7+7lgR+UOd
 ErAGjaARVot8535/owLHha0eP1W8NczLfv3NQEFiYwLM5sJLig5ByhAlI/E0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will it be merged on rc-cycle?

I ask because i see it only in mfd-next but not in fixes/torvalds-master

Regards Frank

Am 16=2E Oktober 2019 11:53:38 MESZ schrieb Lee Jones <lee=2Ejones@linaro=
=2Eorg>:
>On Thu, 03 Oct 2019, Frank Wunderlich wrote:
>
>> Part 3 from this series [1] was not merged due to wrong splitting
>> and breaks mt6323 pmic on bananapi-r2
>>=20
>> dmesg prints this line and at least switch is not initialized on
>bananapi-r2
>>=20
>> mt6397 1000d000=2Epwrap:mt6323: unsupported chip: 0x0
>>=20
>> this patch contains only the probe-changes and chip_data structs
>> from original part 3 by Hsin-Hsiung Wang
>>=20
>> Fixes: a4872e80ce7d2a1844328176dbf279d0a2b89bdb mfd: mt6397: Extract
>IRQ related code from core driver
>
>I've fixed this line to use the standard formatting=2E
>
>> [1]
>https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=3D16=
4155
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/mfd/mt6397-core=2Ec | 64
>++++++++++++++++++++++++---------------
>>  1 file changed, 40 insertions(+), 24 deletions(-)
>
>Applied, thanks=2E
>
>--=20
>Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>Linaro Services Technical Lead
>Linaro=2Eorg =E2=94=82 Open source software for ARM SoCs
>Follow Linaro: Facebook | Twitter | Blog
>
>_______________________________________________
>Linux-mediatek mailing list
>Linux-mediatek@lists=2Einfradead=2Eorg
>http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-mediatek
