Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE3C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BE6217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLQwxhfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfDQAec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:34:32 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43797 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:34:32 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190417003429epoutp04f7bfe8269b1405f9a1a107eae344f76c~WG8iGmbhV2423024230epoutp04G
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:34:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190417003429epoutp04f7bfe8269b1405f9a1a107eae344f76c~WG8iGmbhV2423024230epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555461269;
        bh=tbWmozOrRkmGMW+0O9oihzfZoSl6iHoooARQ4HSqkck=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sLQwxhfgBj5B8gFUD5HSpgkC0GLmELYtFxNlA4N5O4rv6RfaZP5Z+vL1TPiIhbspi
         K1etKWliSmlvFUtkdiTLLj7xIDrRlWXfSj7uAaw6zTq5gDWTSUQNwYJGLWd4UCcke9
         EcCZDpsgkxWlSDxn1HXpG+H8WLQwlJvu2e/rjkOQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417003427epcas1p2644ced819498a4794d31bf893e97ea10~WG8f5uyOo3111531115epcas1p2D;
        Wed, 17 Apr 2019 00:34:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.9D.04108.B8476BC5; Wed, 17 Apr 2019 09:34:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190417003418epcas1p2e06364d1e3d26a8378631c0d8b7d33ac~WG8YXfm_N3110031100epcas1p2y;
        Wed, 17 Apr 2019 00:34:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417003418epsmtrp1035eb7ed2deb65df9520c8c600d7dade~WG8YUE55J1476014760epsmtrp1D;
        Wed, 17 Apr 2019 00:34:18 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-72-5cb6748bee0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.79.03692.A8476BC5; Wed, 17 Apr 2019 09:34:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417003418epsmtip2f559475b3138126d29dcc08b00868d74~WG8YFXOWH2315823158epsmtip2r;
        Wed, 17 Apr 2019 00:34:18 +0000 (GMT)
Subject: Re: [PATCH v2 12/19] PM / devfreq: tegra: Avoid inconsistency of
 current frequency value
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
Message-ID: <f83171df-3d48-e15e-42ea-7a0903e6c015@samsung.com>
Date:   Wed, 17 Apr 2019 09:35:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2d2f7c42-2cad-3b49-eaf3-810f94b3dc77@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnm53ybYYg47XAharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZK
        Lj4Bum6ZOUAHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS
        83OtDA0MjEyBChOyMxa0f2Mq6JKu2LHvEWMDY7dYFyMnh4SAicTe1ysZuxi5OIQEdjBK3Lt2
        jwXC+cQo8WnpMWYI5xujROP/NiaYls+td6Ba9jJKTNx0gB3Cec8ocXvFRlaQKmGBZIm5jcfY
        QBIiAv+AZu2aAZZgFoiU+HpwKTOIzSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdxJobs8DWsQio
        Suye+AOsV1QgQuL+sQ2sEDWCEidnPmEBsTkFbCWuNf5kg5gvLnHryXwmCFteonnrbLAfJASa
        2SVm/P/ACvGDi0TnqXfMELawxKvjW9ghbCmJl/1tUHa1xMqTR9ggmjsYJbbsvwDVbCyxf+lk
        oA0cQBs0Jdbv0odYxifx7msPK0hYQoBXoqNNCKJaWeLyg7vQoJOUWNzeyQZhe0jMvTiFdQKj
        4iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJ8b2IEJ1ctyx2Mx875HGIU4GBU4uFl
        +LM1Rog1say4MvcQowQHs5IIr2PKlhgh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA9M/Hkl
        8YamRsbGxhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqYODilGhg3/J7vK/120q6U+Wue
        xCQ+PPTb+KjFwoi8ANu53r3V98q6EtQ1Djc9mHKeQTIlwDyjsXSS8J/3Km4RT+wWB84NNTtt
        vv//2Y0XeMXO2c6I1Hl45kVgs4BT8tM33zZOTBM6zX2e8TS3oWEA/yp777RymxX7a5X7PkSn
        30nS3sMsrrdebmkx4wMlluKMREMt5qLiRAA06p6ixAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvG5XybYYg8f/dS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyFrR/Yyrokq7Yse8RYwNjt1gXIyeHhICJxOfW
        O4xdjFwcQgK7GSVWb57IBpGQlJh28ShzFyMHkC0scfhwMUTNW0aJdzs/sIPUCAskS8xtPMYG
        khARaGKS+PywhQkkwSwQKdH/qJsVomMek8SRyZeZQRJsAloS+1/cANvAL6AocfXHY0YQm1fA
        TmLNjVlgzSwCqhK7J/5gBbFFBSIkzrxfwQJRIyhxcuYTMJtTwFbiWuNPNohl6hJ/5l1ihrDF
        JW49mQ91hLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIjjItzR2Ml5fEH2IU4GBU4uFd8XNrjBBrYllxZe4hRgkOZiURXseULTFCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MLZ4fhHTs2xROfx6
        8fmjzbt/Kgq4+T3wPvBt7Zvfp/f/cWzavGSt3/YWIanfrz0vZYfPfrLzXlz22Vf5C4okhOZK
        b3NsvvFA9gjzDwPt1D93+m9KOCbyscxnfchw/Pjd8FMKTaFr/buOfjnsm1fK23Q7buXcO0K/
        GG53C+7lSKiJleWIPt4YzqTEUpyRaKjFXFScCACQGNFJrgIAAA==
X-CMS-MailID: 20190417003418epcas1p2e06364d1e3d26a8378631c0d8b7d33ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029@epcas1p4.samsung.com>
        <20190415145505.18397-13-digetx@gmail.com>
        <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
        <2d2f7c42-2cad-3b49-eaf3-810f94b3dc77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 17. 오전 12:40, Dmitry Osipenko wrote:
> 16.04.2019 10:15, Chanwoo Choi пишет:
>> Hi,
>>
>> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>>> The frequency value potentially could change in-between. It doesn't
>>> cause any real problem at all right now, but that could change in the
>>> future. Hence let's avoid the inconsistency.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra-devfreq.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index a668e4fbc874..f1a6f951813a 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -496,13 +496,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>>  {
>>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>>  	struct tegra_devfreq_device *actmon_dev;
>>> +	unsigned long cur_freq;
>>>  
>>> -	stat->current_frequency = tegra->cur_freq * KHZ;
>>> +	cur_freq = READ_ONCE(tegra->cur_freq);
>>>  
>>>  	/* To be used by the tegra governor */
>>>  	stat->private_data = tegra;
>>>  
>>>  	/* The below are to be used by the other governors */
>>> +	stat->current_frequency = cur_freq * KHZ;
>>>  
>>>  	actmon_dev = &tegra->devices[MCALL];
>>>  
>>> @@ -513,7 +515,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>>  
>>>  	/* Number of cycles in a sampling period */
>>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
>>> +	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>>>  
>>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>>  
>>>
>>
>> The read/write access of tegra->cur_freq is in the single routine
>> of update_devfreq() as following. I think that there are no any
>> potential problem about the inconsistency of tegra->cur_freq.
> 
> No, that's wrong assumption. The tegra->cur_freq is changed by the clock notifier that runs asynchronously with the devfreq driver when EMC clock rate is changed by something else in the kernel. 
> 
>> IMHO, if there are no any problem now, I'm not sure that we need
>> to apply this patch.
>>
>> update_devfreq()
>> {
>> 	devfreq->governor->get_target_freq()
>> 		devfreq_update_stats(devfreq)
>> 			tegra_devfreq_get_dev_status()
>> 				stat->current_frequency = tegra->cur_freq * KHZ;
>>
>> 	devfreq_set_target()
>> 		tegra_devfreq_target()
>> 			clk_set_min_rate(emc_rate, )
>> 				tegra_actmon_rate_notify_cb()
>> 					tegra->cur_freq = data->new_rate / KHZ;
>> 		
>> 			clk_set_rate(emc_rate, )
>> 				tegra_actmon_rate_notify_cb()
>> 					tegra->cur_freq = data->new_rate / KHZ;
>> }
>>
>>
> 
> The cur_freq value is changed by the clock notifier that runs asynchronously with the rest of the devfreq driver. Hence potentially compiler may generate two separate fetches of the cur_freq value, then the clock rate could be changed by other CPU core simultaneously with tegra_devfreq_get_dev_status() or kernel may re-schedule preemptively, changing the clock rate in-between of the two fetches.
> 
> 

Thanks. I understand why have to consider the inconsistency of clock
which is used on the multiple points.

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
