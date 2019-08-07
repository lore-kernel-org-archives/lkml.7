Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA62C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2717C22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u6jClI+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfHGQf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:35:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60517 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388758AbfHGQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:35:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190807163554euoutp02b0d46c535355cf17b0bd9618cd43f023~4sT75L_7d1404414044euoutp028
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 16:35:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190807163554euoutp02b0d46c535355cf17b0bd9618cd43f023~4sT75L_7d1404414044euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565195754;
        bh=O1Gf0PgXMaNSYNT29LQTThX7gJ1bj5gAHeIRhFaNn/8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u6jClI+FbJHWxdhgNor0zBy3VaztzXYxjqsnjUskJzHkqRe2VH2krSFhbOpl5zFgS
         WkJlrPNv9pjmyUFcbKW4YA0Xfr+vp0gfdi8X1ZDij3qcbQAv2bJbW1fgmpy6jHxKAT
         L9hl9Ms+spet6yZTfhtgmmkSGi+581a0ImI70Hz4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190807163553eucas1p12fb87d0e783adfbc7d6ca7f038524066~4sT7AgF-61950619506eucas1p1m;
        Wed,  7 Aug 2019 16:35:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.9B.04309.9EDFA4D5; Wed,  7
        Aug 2019 17:35:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807163552eucas1p2e257ece4a9db8e779817d88fed703bf5~4sT5uAvlr0939509395eucas1p2Z;
        Wed,  7 Aug 2019 16:35:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190807163551eusmtrp1a2a5e04a833822ba927687bd6f5eb364~4sT5ftJ2K2733927339eusmtrp1T;
        Wed,  7 Aug 2019 16:35:51 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-27-5d4afde9d4ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.80.04117.7EDFA4D5; Wed,  7
        Aug 2019 17:35:51 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190807163551eusmtip1147ce7d2a521109c2f2338d677ce1b91~4sT424it11682116821eusmtip1W;
        Wed,  7 Aug 2019 16:35:51 +0000 (GMT)
Subject: Re: Odroid-XU4 sound issue after suspend-resume
To:     Jaafar Ali <jaafarkhalaf@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kgene@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        sam@ravnborg.org, linux-clk@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b850da41-fd72-ec0a-52bd-4de558dd87f2@samsung.com>
Date:   Wed, 7 Aug 2019 18:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <24165241-1f65-fafa-0c59-b85cf89bc5bb@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87ov/3rFGuxdxG9x4NllZov+x6+Z
        Lc6f38Bu8bHnHqvF5V1z2CxmnN/HZLHi51ZGB3aPnbPusntsWtXJ5rFk2lU2j8+b5AJYorhs
        UlJzMstSi/TtErgy5j9eyFywhL9i/WSfBsYNPF2MnBwSAiYS93uWMncxcnEICaxglFj25CI7
        hPOFUeJY618WCOczo8TG7mmsXYwcYC2Tv4hBxJczSrz5sZcJwnnLKPHz+Uk2kLnCAhYS1z7d
        BrNFBNQlnu68AVbELLCWUeLmus0sIAk2AUOJ3qN9jCBTeQXsJGa99QQJswioSBxe94gVxBYV
        iJA4dWQeWDmvgKDEyZlPWEDKOQXsJeZ+MgYJMwuISzR9WckKYctLNG+dDfaOhMAmdom+1e+Z
        If50kdhwto8JwhaWeHV8CzuELSNxenIPC0RDM6NEz+7b7BDOBEaJ+8cXMEJUWUscPn4R7H1m
        AU2J9bv0IcKOEh++XmGEhAqfxI23ghBH8ElM2jadGSLMK9HRJgRRrSLxe9V0qBOkJLqf/GeZ
        wKg0C8lns5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmHZO/zv+
        ZQfjrj9JhxgFOBiVeHgZLnjFCrEmlhVX5h5ilOBgVhLhvVfmGSvEm5JYWZValB9fVJqTWnyI
        UZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qB0fmd3dUC4YiXrmX6ka0yn44bnH3wdPb3
        4J2/bNRMp747Zqt4zCDdI6FgocKMemMpK7fX6Uz1xXdf71p/+fuymx+9tRuuh91q/eXeWtSW
        wW2auXmVDmefym77dAshAwfGZ5Fpk1i+PL1xb0Fjp876pfZPtB5932VcLjshWKb/vMa91pki
        W4T9lViKMxINtZiLihMB6N03NjcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7rP/3rFGiz8bWJx4NllZov+x6+Z
        Lc6f38Bu8bHnHqvF5V1z2CxmnN/HZLHi51ZGB3aPnbPusntsWtXJ5rFk2lU2j8+b5AJYovRs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy5j9eyFyw
        hL9i/WSfBsYNPF2MHBwSAiYSk7+IdTFycQgJLGWUeDO7lx0iLiUxv0Wpi5ETyBSW+HOtiw2i
        5jWjxJMV7ewgCWEBC4lrn26zgdgiAuoST3feYAIpYhZYyyhxumcuE0THTUaJRU9WMYFUsQkY
        SvQe7WME2cArYCcx660nSJhFQEXi8LpHrCC2qECExKRrO1lAbF4BQYmTM5+wgJRzCthLzP1k
        DBJmBtr1Z94lZghbXKLpy0pWCFteonnrbOYJjEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW56bn
        FhvpFSfmFpfmpesl5+duYgRG2bZjP7fsYOx6F3yIUYCDUYmHl+GCV6wQa2JZcWXuIUYJDmYl
        Ed57ZZ6xQrwpiZVVqUX58UWlOanFhxhNgX6byCwlmpwPTAB5JfGGpobmFpaG5sbmxmYWSuK8
        HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYr2bd1Ov/02r25d9r1617o8TO/WZ++reNRXRxterP
        ruidd7e99Im7wij25X7WnhSXqNhp78xif/7eW5XWwG3ou24mw23hts6DX03X38iSstd74/Gp
        2EKx6mjyiVdSHVYqiUl96/306+vWyxfnbzMWSlvp4OAYU5Xwz+9Ph47zhYD14tr7CpKVWIoz
        Eg21mIuKEwHGNR3oyAIAAA==
X-CMS-MailID: 20190807163552eucas1p2e257ece4a9db8e779817d88fed703bf5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5
References: <CGME20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5@epcas2p3.samsung.com>
        <CAF-0O_4xOQNkX5ZyyVz7zZDAP9XBeUKv65T0cd+oAAV1ahLQ9Q@mail.gmail.com>
        <24165241-1f65-fafa-0c59-b85cf89bc5bb@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 10:22, Sylwester Nawrocki wrote:
> On 8/5/19 15:27, Jaafar Ali wrote:
>> Dear All,
>> Kernel 5.3-rc1
>> OS: ubuntu 18.04
>> Hardware: Odroid-XU4
>> The sound of Odroid-XU4 after suspend/resume cycle is choppy and slow. 
>> I have found a workaround, the I2SMOD register value should be set to 
>> zero after resume to force using internal codec clock (cdclkcon bit = 0),
>> also the rclk_srcrate which is obtained from the function 
>> *clk_get_rate(rclksrc) *inside *hw_params* function is not correct and 
>> must be divided by 2 to obtain proper value, i2s_resume function 
>> is modified to:
>>
>> static int i2s_resume(struct snd_soc_dai *dai)
>> {
>>         struct samsung_i2s_priv *priv = dev_get_drvdata(dai->dev);
>>         priv->suspend_i2smod = 0;//workaround-1 ,
>>         return pm_runtime_force_resume(dai->dev);
>>
>> }
>>
>> inside hw_params function, the rclk_srcrate must be halved to solve 
>> unknown problem of clock shift, so before return from hw_params we 
>> must insert:
>> if(mod == 0){
>> 	priv->rclk_srcrate = priv->rclk_srcrate / 2; //workaround-2, 
>> }
>>
>> With these two workaround sound issue was solved, but I hope we can 
>> get concrete fix.
> Thank you for the bug report. I spent some time on debugging this and
> it turned out that there is a clock mux between EPLL and the audio 
> subsystem which looses its configuration during suspend/resume cycle.
> So we end up with the I2S controller clocked from the main oscillator
> clock (24 MHz) rather than the EPLL (196.608 MHz) after system suspend/
> resume. I will post a patch for clk-exynos5420 driver shortly.

My apologies, I forgot to add you at Cc of related patches, they are 
available at patchwork:
https://patchwork.kernel.org/patch/11082423
https://patchwork.kernel.org/patch/11082427
 
Could you try and test and let me know if that fixes your issue?

-- 
Thanks,
Sylwester
