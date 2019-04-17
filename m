Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC0C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC69220821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mHl224np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfDQAyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:54:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46848 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbfDQAyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:54:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417005416epoutp01cfe3409ab18cbc6ddb069c7857c13166~WHN0DAzRT3134431344epoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:54:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417005416epoutp01cfe3409ab18cbc6ddb069c7857c13166~WHN0DAzRT3134431344epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555462456;
        bh=h9kwG1nuIxgcf5dKKIjlV7sEvuNhgv8hGEQVmtt2IWE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mHl224nppuikhKzoNFZkxqSR8hryubuRLfoHJNc5RKAKzd3u+ha5OWVedfNGUza6H
         DXJvtvRajWA/P3Ba+VuAilARayssrDsMxyt78iVxfeJf4Z44+22CuP9vtRAWY+c9vW
         k87LkZRmwTNXgb8+dTVUM4VEg7d78IPHdLQF2DIc=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190417005412epcas1p395c61f1092577e21657af3a12f5ff075~WHNvyRYYS1696816968epcas1p3q;
        Wed, 17 Apr 2019 00:54:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.45.04108.23976BC5; Wed, 17 Apr 2019 09:54:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417005410epcas1p42e51060afe7e39394bf86d7b2dbd6d83~WHNts2EaY2565425654epcas1p4k;
        Wed, 17 Apr 2019 00:54:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417005410epsmtrp2cc969a9dfb1bd1a60d0154b00fb874ed~WHNtr91tG1474414744epsmtrp2D;
        Wed, 17 Apr 2019 00:54:10 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-89-5cb6793291a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.5A.03692.13976BC5; Wed, 17 Apr 2019 09:54:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417005409epsmtip1e1401edc1b51bec4836f155f56bdaf22~WHNteeeNS2966629666epsmtip1u;
        Wed, 17 Apr 2019 00:54:09 +0000 (GMT)
Subject: Re: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory
 barrier with the read barrier
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0a30e6e2-bc98-e5fc-1d85-bece1f7cd6a9@samsung.com>
Date:   Wed, 17 Apr 2019 09:55:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ef32d1f-895a-5006-5760-bf2c070bc6e2@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se2xLYRT37ba3t4vy6Yajf1BXhE02u5tyxyrzCA1Cwz/IkrnWm3ZZX+lt
        ZfOIsnlsmMeC6RrGNvOIlGVl6rGYecwr24osKGLEM1sYC7KYtndi//3OOb9zfuf3fYcilBdI
        FZVrdfIOK2emyVjJxZsJSUmpBRezUoLHVezZr52ILfKckLAPt36RscGAl2R79jQjtvi7h2Sf
        bzlFsr8CRyVs6bl2MlOuawhVI91lT0im21PYRepK688gXU/dWL10dV6GiecMvEPNW3Nshlyr
        UUsvXpE9L1szPYVJYtLZGbTayll4LT1/iT5pQa45vBCtXseZXeGUnhMEeursDIfN5eTVJpvg
        1NK83WC2p9uTBc4iuKzG5BybZSaTkpKqCRPX5JnudnpJe8eIfN/1PuRGgWElSE4BngYh/3Np
        CYqllLgBgbe2WiYG3xC0VTxFYtCLoP2lm/zXcqi4hhQL1xDsfeweCLoRvOkOoQgrDhuh5PCV
        6OB4/AfBt0C5NFIg8Cr4caOGiGASJ0Ljh47o2OF4PDz52RltVuDZUPW+KMqR4InQ8bo2mh+J
        V8Kr2+elImcEtBx5K4lgOdZC++9CQpw/Gp69PRYj4nFQ6K8gIksA7ifhfuktJHqYDx+D/YSI
        4+DTnXqZiFXQ03VtwOcGON3STIrNOxHUN7ZKxUIaNNaUhRWosEIC+AJTRbFh0PVjtzSSBqyA
        nduVInsCBF+HYkQ8Bqp2FA+M18FV3x/ZPjTeM8iOZ5AFzyALnv9ilUhyBo3i7YLFyAuMXTP4
        v+tQ9FwT0xvQ7UdLmhCmED1UMaTPn6WUcuuEAksTAoqg4xVzDPVZSoWBK1jPO2zZDpeZF5qQ
        Jvza+wnVyBxb+PitzmxGk5qWlsZOY6ZrGIYerfBlzstSYiPn5PN43s47/vXFUHKVG5W/v9Vf
        yW2hFtZ6985NMOUvO9xZlPyq+lJL1UG9eZbTdWJ1cHJFWfz1/G3+tooOX2DK8s0vJt97t6/y
        y41a+WKy9afiszbjSLxfF1vz0r1pVeYEvXr4R9yrWbt0EtPslX3gxhJEX3LdFKag7cGixu5L
        vSel2+N+HcBF57iyjbtaU2mJYOKYRMIhcH8BzxlHgMQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnK5h5bYYgy9HLSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyTjyew1ZwQ7Bi/b4/jA2Mu/i6GDk5JARMJKZ1
        LmUDsYUEdjNKTHvECRGXlJh28ShzFyMHkC0scfhwcRcjF1DJW0aJWV9aWEBqhAXSJbqm72YF
        SYgINDFJfH7YwgSSYBaIlOh/1M0K0TGXSWLu7KNgHWwCWhL7X9wA28YvoChx9cdjRhCbV8BO
        YvHzFmYQm0VAVeLGg+VgcVGBCIkz71ewQNQISpyc+QTM5hSwlbj0q5kZYpm6xJ95l6BscYlb
        T+ZDHSEv0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgmNMS3MH4+Ul8YcYBTgYlXh4V/zcGiPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwrJ4vJC//Pn2fg+tU3
        ru/FX4XdKms1RNUe/69fMuHv/nVm4hftRbKz55/0FdjOfctQM+JsLo+q+t49mo8L1tt+Wdsm
        rORdMoP/1+L6tf2bl6f8fXy19kdzV/WJshOTfWyWNj57KivreL0ofPYu2cnhaXcjJ/Epbqpx
        uRmef15y/SOX4D3fI7qUWIozEg21mIuKEwEahB1ArQIAAA==
X-CMS-MailID: 20190417005410epcas1p42e51060afe7e39394bf86d7b2dbd6d83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd@epcas1p2.samsung.com>
        <20190415145505.18397-6-digetx@gmail.com>
        <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
        <1ef32d1f-895a-5006-5760-bf2c070bc6e2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 16. 오후 10:57, Dmitry Osipenko wrote:
> 16.04.2019 11:00, Chanwoo Choi пишет:
>> Hi,
>>
>> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>>> The write memory barrier isn't needed because the BUS buffer is flushed
>>> by read after write that happens after the removed wmb(), we will also
>>> use readl() instead of the relaxed version to ensure that read is indeed
>>> completed.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra-devfreq.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index d62fb1b0d9bb..f0f0d78f6cbf 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>>  static void actmon_write_barrier(struct tegra_devfreq *tegra)
>>>  {
>>>  	/* ensure the update has reached the ACTMON */
>>> -	wmb();
>>> -	actmon_readl(tegra, ACTMON_GLB_STATUS);
>>> +	readl(tegra->regs + ACTMON_GLB_STATUS);
>>
>> I think that this meaning of actmon_write_barrier() keeps
>> the order of 'store' assembly command without the execution change
>> from compiler optimization by using the wmb().
> 
> The IO mapped memory is strongly-ordered on ARM, hence all readl/writel accesses are guaranteed to be ordered by default. I think wmb() here is just a cut-n-pasted relic from old downstream driver.

OK.

> 
>> But, this patch edits it as following:
>> The result of the following two cases are same?
>>
>> [original code]
>> 	wmb()
>> 	read_relaxed()
>>
>> [new code by this patch]
>> 	readl_relaxed()
>> 	rmb()
> 
> Yes, the result is the same. The wmb() is not just about IO accesses, but about all kind of memory accesses and at least on Tegra30 it is quite expensive operation because it translates into L2XO cache syncing (arm_heavy_mb) + dsb(). It should be more efficient to flush out writes with a read-back and then wait for that read operation to be completed.
> 
> 

OK. Thanks for explanation.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
