Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0CCC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136CE21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nCgo7IYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJHNYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:24:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41093 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfJHNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:24:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191008132420euoutp01b301fe134f7db6a8387681969aef22e0~LrsYZw6Cc2203922039euoutp01_
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 13:24:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191008132420euoutp01b301fe134f7db6a8387681969aef22e0~LrsYZw6Cc2203922039euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570541060;
        bh=Ob1Na4W4T90eV8j0YqGB5NBJ6UrQf6fMR9mVLlx9hhw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nCgo7IYz1TWaLHYa52sUL/O9rler0R8vLsNYMo3y5hpYnKuZoY/2vqT7Ht4NwvVja
         K6Jze2JVETi96V5cLRDTZDWZCAiHAoU1VmNm6Nlrp+YhfZEfoGDLzqpo5BR8pa/1KU
         0fZmUmE3lY3j6Mgy4jzb+ke1TVZNnB2ymdixUlMU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191008132420eucas1p2477fe55bd0955c16161bd7902774b0bd~LrsX-rr2a3151731517eucas1p2y;
        Tue,  8 Oct 2019 13:24:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.12.04374.40E8C9D5; Tue,  8
        Oct 2019 14:24:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008132420eucas1p2667e629e69d2ebd5953e12db59310d44~LrsXm2jxh2657326573eucas1p2z;
        Tue,  8 Oct 2019 13:24:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191008132420eusmtrp1d11b204830bd986678526ae9a1d81d1b~LrsXmJ76d2042520425eusmtrp1T;
        Tue,  8 Oct 2019 13:24:20 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-2b-5d9c8e040063
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.9E.04117.30E8C9D5; Tue,  8
        Oct 2019 14:24:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191008132419eusmtip15df08db38d5589c35b0c9fa22a9d9a1c~LrsXK_Cse2389723897eusmtip1_;
        Tue,  8 Oct 2019 13:24:19 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
Date:   Tue, 8 Oct 2019 15:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008124736.GJ4382@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXd2zo7D6XGaPmhajOhDkU0qOTkTtT6M+hJ9iKjUZh6neG3H
        u0WG91maimVzmRQ2b4Wt5S0VbzhEVLTwmqHoBzEGeStKp7UdBb/9nsv/eZ7/y0ti4k7cjYyK
        S2RUcYoYCSHkNw/8GTnFL9IGS+d07nT5whJBN6wuIrp6rQKnR0ebBPT8y2ke/etrPo/+0q4l
        6IrRLh79rn9OQH/YlAcI5W2aOYFcX19AyL9NdBDyYrNUXmSoR/J1vedV4qbQL5yJiUpmVKf9
        7wgj83SVWEKuXaq+uxPLRLO2akSSQJ2FmpwraiQkxVQtguHcdpwLNhBMF5YSXLCOwPS5iqdG
        tlaFMcuMuIIOQclmGd9SEFMmBI+6cAs7URFQurJhzTtT16CquQGzMEYZeDCYlWJhgvKFkrx6
        ZGER5Q/rHTNWLZ86Bk09P6z9h6gbsDbfh3M9jjD4Ysk605byhr6/3Tg3Uwr9r7V77AozS694
        HB+BFpMWsxwK1IgApkaeEZyDS1Ci78E5doIVo0HA8WEYKnvM5wTvEZjzl/fULQh0ZTt7ahn0
        Gcdw7vUCIbsxnEN7mDI5covtobT5OcalRZCfK+aEx6HpbROxv0rdVoc9RRLNAWuaA3Y0B+xo
        DtipRvx65MoksbFKhj0Tx6R4sYpYNilO6XU3PlaP/n+qoR3jZivq2g7rRRSJJHaigHRtsBhX
        JLNpsb0ISEziLPKsqQgWi8IVaemMKj5UlRTDsL3IneRLXEUZNvO3xJRSkchEM0wCo9qv8khb
        t0w0vbzbrkzLzjpnGPO9H1Ew6VIuS90KcglhpZ8uTI2sRqu+U/cCn2R6eLSG6Vo7Hcyy6wvj
        IeejhrcLg4uTWY83nj6XZx865ExUIhTw++OkTH173BA0VC7YfbDVXL1I+dQZpX4nQxuP7jS6
        TpZGuRR1G3K7Ltba7MoGoDj1Z8aqhM9GKrxPYCpW8Q8fTSFdUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7osfXNiDX7NZrKY+vAJm8Xqj48Z
        LRZ8msFqcf78BnaLB3NvMll8u9LBZHF51xw2ixnn9zFZrD1yl91i41cPBy6PnbPusntsWtXJ
        5nHn2h42j/6/Bh59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5r
        ZWSqpG9nk5Kak1mWWqRvl6CX0b58NnNBG0/FpgN7mRsYb3N2MXJySAiYSBxv/svYxcjFISSw
        lFHi88H3TF2MHEAJGYnj68sgaoQl/lzrYoOoec0o8b77DitIQlggTeL+4ceMILaIQJDE5nmb
        2UFsZoEtTBL3/yRBNHxgkph76zELSIJNwEpiYvsqsAZeATuJz3tugQ1iEVCR2HDwNTOILSoQ
        IXF4xyyoGkGJkzOfgPVyChhKHP51gBVigZ7Ejuu/oGxxiVtP5jNB2PIS29/OYZ7AKDQLSfss
        JC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBkbjv2c8sOxq53wYcYBTgY
        lXh4HarmxAqxJpYVV+YeYpTgYFYS4ZVbOiNWiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OB
        SSOvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjg9hL7ykOpk+V
        Bdd2f5NurjnRb1c/6eaUcrdrR1e6SYmvZ+XQMTbV8OiOiDh2J9FbyXi3lwW3wJq4xWqKPl/3
        T9Ks/H4/9OTriEnrV646tEpY4sNMPp8bb3YFdq78xseYeNV3ySupeT/8n0qe519/aNriJ5ti
        liQpJ+15t6dM/C5H++4kRTsBJZbijERDLeai4kQAOk+I/eICAAA=
X-CMS-MailID: 20191008132420eucas1p2667e629e69d2ebd5953e12db59310d44
X-Msg-Generator: CA
X-RootMTR: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
        <20191008101709.13827-1-m.szyprowski@samsung.com>
        <20191008115025.GF4382@sirena.co.uk>
        <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
        <20191008120611.GG4382@sirena.co.uk>
        <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
        <20191008124736.GJ4382@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/8/19 2:47 PM, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 02:38:55PM +0200, Marek Szyprowski wrote:
> 
>> Then if I get it right, the issue is caused by the commit 7f93ff73f7c8 
>> ("opp: core: add regulators enable and disable"). I've checked and 
>> indeed reverting it fixes Peach Pi to boot properly. The question is if 
>> this is desired behavior or not?
> 
> That doesn't seem ideal - either it's redundant for regulators that need
> to be marked as always-on anyway or it's going to force the regulators
> on when a device could do runtime PM (eg, if the same code can run on
> something like a GPU which can be turned off while the screen is off or
> is displaying a static image).

Commit 7f93ff73f7c8 ("opp: core: add regulators enable and disable")
currently can be safely reverted as all affected users use always-on
regulators. However IMHO it should be possible to enable always-on
regulator without side-effects.

When it comes to setting regulator constraints before doing enable
operation, it also seems to be possible solution but would require
splitting regulator_set_voltage() operation on two functions:

- one for setting constraints (before regulator_enable() operation)

- the other one actually setting voltage (after enable operation)

Unfortunately this is much bigger task and doesn't seem to be -rc
time material so I'm in favor of just applying Marek's fix as it is
for now.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
