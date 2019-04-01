Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE920870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rY+N6Gg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDAESw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:18:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35496 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfDAESv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:18:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190401041848epoutp032e39be1c8fd807afac2704a449aa73d6~RPr0bgTVv0726707267epoutp03k
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 04:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190401041848epoutp032e39be1c8fd807afac2704a449aa73d6~RPr0bgTVv0726707267epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554092328;
        bh=98Tzj5VCFikTMgQSGuOBJI5ob8mqGz7TuhquX0sOYqE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=rY+N6Gg9Ccvt1ol/4ynukwV5oJK+UXOLc4HxtKZqVv7mYoWMBQkz1uZz3E65ODZ9u
         BG47oVNkKais4YJJGS7u1QoJwhfWbcas+abWJz8P5U6a1/STWGy+f9Y/KcKMDKQn0F
         2eFOLvkbwIDPJke+0jfe/CgALiXw8yv/1uFtTHps=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401041843epcas1p27d3ac46c5e195227f2d1bb58ea952df9~RPrwXPQqT0253202532epcas1p2n;
        Mon,  1 Apr 2019 04:18:43 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-c3-5ca19123ec77
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.D5.04143.32191AC5; Mon,  1 Apr 2019 13:18:43 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 4/4] devfreq: add mediatek cci devfreq
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190401041843epcms1p10a664023cf0556e42afe118a1d84daad@epcms1p1>
Date:   Mon, 01 Apr 2019 13:18:43 +0900
X-CMS-MailID: 20190401041843epcms1p10a664023cf0556e42afe118a1d84daad
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmnq7yxIUxBvuuWVpsX/+C1eLlIU2L
        61+es1rMP3KO1eLbnd9MFmeb3rBbbHp8jdXi8q45bBaXmy8yWnzuPcJosfT6RSaLphZjizOn
        L7FatO49wm4x/a6QxcavHg4CHmvmrWH02DnrLrvHplWdbB53ru1h89i8pN6j5eR+Fo8tV9tZ
        PPq2rGL0+LxJLoAzKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+gFJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2xsb7FQXzOSpm/HjD1MB4ga2LkYNDQsBE4u0X0y5GLg4hgR2MEuu3bmcG
        ifMKCEr83SEMYgoL2Eo8mFvSxcgJVKIk0XBzHzOILSygL9HxYBsjiM0moCuxdcNdFpAxIgJz
        mCROHFoB5jAL/GaWaP9ygB2kSkKAV2JG+1MWCFtaYvvyrWDdnAK+EttnfWGCiItK3Fz9lh3G
        fn9sPiOELSLReu8sM4QtKPHg525GmDkzpvyHmlktcW36YnaQxRICLYwSvaunQBXpS5yZe5IN
        xOYFWjZtzXUWkM9YBFQlFjdYQZS4SCzd9QxsPrOAvMT2t3PA4cAsoCmxfpc+zPkNG3+zo7OZ
        Bfgk3n3tYYWJ75j3BOoVNYlDu5dA1ctInJ6+EOp8D4krb76xTGBUnIUI6VlIFs9CWLyAkXkV
        o1hqQXFuemqxYYExctRuYgSnZS3zHYwbzvkcYhTgYFTi4VVgWBgjxJpYVlyZe4hRgoNZSYT3
        TP+CGCHelMTKqtSi/Pii0pzU4kOMpkDvT2SWEk3OB+aMvJJ4Q1MjY2NjCxNDM1NDQyVx3vUO
        zjFCAumJJanZqakFqUUwfUwcnFINjGVXxZ5yW2r8dr2X3y9pvuuZvURv50R17xnFL5pfGya+
        ffYkQsbxpT83v8B9pbqMqvUzrl2wjJ/KHCS+ma3myLfTgnzf7nLMZNQ8b+37P2vhpO9P5VWU
        VvF/+7JqJvsbrwruSakPNLkY7mpsl2M9N+WxS+txgfXLpNdl6sqw7kjUmnD4r+zuxUosxRmJ
        hlrMRcWJAPk2vezhAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190329064636epcas1p13633ae078ef83ceda0b8189df1399753
References: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
        <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064636epcas1p13633ae078ef83ceda0b8189df1399753@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
>of the Mediatek MT8183.
>
>On the MT8183 the CCI is supplied by the same regulator as the LITTLE
>cores. The driver is notified when the regulator voltage changes
>(driven by cpufreq) and adjusts the CCI frequency to the maximum
>possible value.
>
>Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>---
> drivers/devfreq/Kconfig              |  10 ++
> drivers/devfreq/Makefile             |   1 +
> drivers/devfreq/mt8183-cci-devfreq.c | 235 +++++++++++++++++++++++++++++++++++
> 3 files changed, 246 insertions(+)
> create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
>

1. It appears that proc_reg_uV might be used before initialization.
It would be appropriate to initialize it at the probe function.

2. Because you are already using OPP, why don't you rely on
OPP fully? (use OPP from CPUFreq drivers as well in order to get
OPP events automatically.) Anyway, this is a minor item that does
not need to be corrected.

Cheers
MyungJoo
