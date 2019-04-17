Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F468C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E753921773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UvNGYIt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfDQBAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:00:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21518 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfDQBAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:00:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190417010041epoutp0246539d4eea9e3371a5b9ae55a8b0d42f~WHTZ0U_9P1843318433epoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190417010041epoutp0246539d4eea9e3371a5b9ae55a8b0d42f~WHTZ0U_9P1843318433epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555462841;
        bh=gFSzDPmZ6OIbDZ7CyVIsPACv6gFEgILFdlLDH78ll9E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UvNGYIt346z8tQ+VEPgWl7uhOsbXMUIyPW1tkeGellRyfpcHO29ZzZw7fTz1NAc0V
         jNVBA79oWA8QJ8HDYLFmOZ/vMVuYvJnRwFTZfCSUkBvkQGmTmB6U4BVenWujLxNduo
         33MmopIM+eNk3Rz3q+l/p+sCOXy+dNLjOm04Dl8k=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417010038epcas1p25d2b860c5fdbce315938239c92f2b1b2~WHTXHoByp1437114371epcas1p2o;
        Wed, 17 Apr 2019 01:00:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.4E.04257.FAA76BC5; Wed, 17 Apr 2019 10:00:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190417010030epcas1p3d0d4394f6ac90a7edb6ca5d7673947bc~WHTQdF_U70436904369epcas1p3c;
        Wed, 17 Apr 2019 01:00:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417010030epsmtrp1124191dbf6014d9063dc2879f342e51f~WHTQcUlUG2500725007epsmtrp1J;
        Wed, 17 Apr 2019 01:00:30 +0000 (GMT)
X-AuditID: b6c32a38-a3dc09c0000010a1-cb-5cb67aaf60d7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.B8.03662.EAA76BC5; Wed, 17 Apr 2019 10:00:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417010030epsmtip20354ea3469e20d07f28c43f6a043b9af~WHTQT5ppM0293502935epsmtip2W;
        Wed, 17 Apr 2019 01:00:30 +0000 (GMT)
Subject: Re: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking
 on devfreq initialization failure
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
Message-ID: <c7bca00a-98a0-f3af-78a2-e006c50cd621@samsung.com>
Date:   Wed, 17 Apr 2019 10:01:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7f187635-a42e-02cf-899f-996702602785@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD1Y9vtFq2uRWXsD8U1xlAtspTCokAkHilqYiMxXiS40hUIPdZu
        i4qaKBgtqKDixXofJIohEARTikpE5PAOhIRoEIN4G4yixoOIbRcj/9437828mfmGwNRVuIbI
        sjk5h421UHiw7Pqd8AhdZe711Mj2QS1z9fNLxOwWL8iYh3kfFUyH9xTODBxoQkzBVxFnnu26
        jDM/vWdkTFFFOz5fafR0X0LGOrFbYTyQ348bi2rKkXGgeopJvjY7PpNjzZwjjLOl281ZtowE
        amlK2oI0Q0wkraPjmFgqzMZauQRq4TKTbnGWxdcQFZbDWly+kIkVBGpOYrzD7nJyYZl2wZlA
        cbzZwsfxEQJrFVy2jIh0u3UuHRkZZfAJ12dn9rg7EC+O3uL2vJLvRIXKQqQkgIyG5ktFskIU
        TKhJD4K6vFuYn1CTXxCcb90uEd8RHO8rwf9l5Lc+RhJxE8Htew8w6fEJwdG6Qwq/KoTkIa9+
        l9xPTCD/IPjiPSH3Exi5Br7dLgt44KQWGt52BcqOI6dB54+XyI9VZCJcazkt82MZOQM8p1sD
        8YnkauhprpJLmvHQVtoX0CjJBLjprsWl+qHwtO9skISnQn7tyUB3QA7h4O49opBmWAiDh+uR
        hEPgfUvNcFwD74r3DONtcKWtCZeS3QhqGp7IJUIPDWUlPgfC5xAOld45ktlY6P+2X+4PA6kC
        9x61pJ4OHS+6gyQ8GS7uLRheoxHuvjgRdBBNE0eMI44YQRwxgvjf7BySlaNJHC9YMziB5qNH
        fnc1ClyrlvGgG4+WNSKSQNQY1ajB2lS1nM0RtlobERAYNUGVZK5JVavM7NZczmFPc7gsnNCI
        DL5tH8I0E9Ptvtu3OdNoQ5Rer2ei6RgDTVOhqsr5C1LVZAbr5LI5jucc//KCCKVmJ7JqPCEV
        sTFvFN3jZ4m/Z319HvVhXfiFJezGAqy4R5fHlWxOnr4bK7UWe5PnLV8xdUOcd8jwZlX8Pt1K
        7SLkKT1pamvvLY91NVYnxa7f5H3Y+fbdwX7vqnB8c0WtXi/en5w0+9jFiqFfr+urcga+7/jT
        JZhSNhCJTXxorn3mljFOmpIJmSytxRwC+xe/8CVMwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO66qm0xBv8nWFis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl3O+4zFgwi7uiY8dT1gbGLs4uRk4OCQETieYT
        5xm7GLk4hAR2M0psvH6OCSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSM3c1M4LUCAsUSDTtbmQF
        SYgINDFJfH7YAtbMLBAp0f+omxWiYy6TxI8ps5hBEmwCWhL7X9xgA7H5BRQlrv54DDaJV8BO
        YvPxuSwgNouAqsSOuSfA4qICERJn3q9ggagRlDg58wmYzSlgK7G3YysbxDJ1iT/zLjFD2OIS
        t57MhzpCXqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfm
        pesl5+duYgRHmZbWDsYTJ+IPMQpwMCrx8K74uTVGiDWxrLgy9xCjBAezkgivY8qWGCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MHAxhpay7DkqYms2u
        f5fRvfN2l56gmkzg0/PR9kH6TUEznRvWOW06cj4nT37L34OiP3wPz7efXFZ+Wilmssf9ydOM
        ZSs6WFvM8y1Xpmjliydcma+wXWJD8M5EOQWnqM02eeEff++JYGDQzjOuSt/65N2s9Qrv/eIc
        nqZtF9I4EXs64fz6CU+VWIozEg21mIuKEwH9p6n7rgIAAA==
X-CMS-MailID: 20190417010030epcas1p3d0d4394f6ac90a7edb6ca5d7673947bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0@epcas3p3.samsung.com>
        <20190415145505.18397-7-digetx@gmail.com>
        <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
        <7f187635-a42e-02cf-899f-996702602785@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 16. 오후 11:29, Dmitry Osipenko wrote:
> 16.04.2019 5:32, Chanwoo Choi пишет:
>> Hi,
>>
>> patch6/7/8/9 are for handling of exception handling in probe() function.
>> Actually, I'm not sure that there are special reason to split out
>> the patches. I think that you can squash patch6/7/8/9 to only one patch.
> 
> Indeed, I was rebasing and reordering patches multiple times and looks like there is no reason not to squash these patches now.
> 
>> Also, even if patch6/7/8/9 handle the exception handling in probe(),
>> the tegra_devfreq_probe() doesn't support the restoring sequence
>> when fail happen. I think that if you want to fix the fail case of probe(),
>> please add the restoring sequence about following function.
>> - clk_disable_unprepare()
>> - clk_notifier_unregister()
>> - dev_pm_opp_remove()
> 
> When all of 6/7/8/9 patches are applied, the clk_notifier_register() becomes the last invocation of the probe function and clk_enable() is kept at the first place of the probe order. Hence the sequence you're suggesting is already incorrect because error-unwinding order usually should be opposite to the probe order. It looks to me that the current final result of these patches is already correct.

You're right. When I replied it, I have not considered the order.
Sorry, it made you some confusion.

> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
