Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C323C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r6efqeTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfDQLAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:00:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40622 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbfDQLAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:00:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190417110009euoutp01c3555179647fd74c185e4c3cef091b1d~WPe0XMfBs0800608006euoutp01k
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:00:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190417110009euoutp01c3555179647fd74c185e4c3cef091b1d~WPe0XMfBs0800608006euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555498809;
        bh=243QMwl36KSv1UsGav4K7QEe5bGDWq5G/HbRmXZMlms=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r6efqeTsFQSLYd0RjBfPuz810/lpP0YvdKMW0llV2rLjjLNf6DZclsRNvKVy958hH
         f8vxZFuOkRLbGNCjlfBMyJB/jGH6sWyJqrA+LuYksPToY3qZAgRM3DVqmvpPZ+L1lN
         nQfQ7x3UsEFyaTMlaNDXejnYEbHpHfqH+MXR1YGg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417110008eucas1p12da16023862338ea57066e44b4945f37~WPezdRGbg0739307393eucas1p1o;
        Wed, 17 Apr 2019 11:00:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.36.04298.83707BC5; Wed, 17
        Apr 2019 12:00:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190417110007eucas1p15b203f1b86ecf4cafde51f5b3adba813~WPeynL1142654526545eucas1p1B;
        Wed, 17 Apr 2019 11:00:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417110007eusmtrp1cb4751813e5a3f5630bdc3d1b4fbdf8c~WPeyW7dZY0128401284eusmtrp1F;
        Wed, 17 Apr 2019 11:00:07 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-ae-5cb70738f4c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.B5.04146.73707BC5; Wed, 17
        Apr 2019 12:00:07 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417110006eusmtip10ab353143f6f4891ee886dc3da83d970~WPexqV0tj1174911749eusmtip1L;
        Wed, 17 Apr 2019 11:00:06 +0000 (GMT)
Subject: Re: [PATCH 2/3] drivers: devfreq: events: extend events by type of
 counted data
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <15ec9cce-8cce-0bfb-44d2-1f8e5acaebc0@partner.samsung.com>
Date:   Wed, 17 Apr 2019 13:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <628d298a-0c44-11c9-d27b-165cdfc0d2a2@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87oW7NtjDM6/lbXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZtF694j7BaH37SzOvB7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK+P30/UsBV8NKzYsv8XewDhDvYuRk0NCwERizf4+pi5GLg4hgRWMEpeutkA5Xxgl/q3/
        wwjhfGaU2H3+KCtMy/bXvcwgtpDAckaJb+/YIIreMkpcfTKVDSQhLBAl8aDpO1i3iMBJRone
        xrusIA6zwBVGiadfFgG1c3CwCehJ7FhVCGLyCrhJ/DgjAtLLIqAqcf7mA3YQW1QgQuL+sQ1g
        i3kFBCVOznzCAmJzCthL9C/+AHYEs4C4xK0n85kgbHmJ5q2zmUFWSQh8ZJdY+H8jE8h8CQEX
        iZafRRAPCEu8Or6FHcKWkTg9uYcFwi6WaOhdyAhh10g87p8LVWMtcfj4RVaQMcwCmhLrd+lD
        hB0lvn/czgwxnU/ixltBiAv4JCZtmw4V5pXoaBOCqNaQ2NJzgQnCFpNYvmYa+wRGpVlI/pqF
        5JdZSH6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMBkdvrf8U87GL9eSjrE
        KMDBqMTDu+Ln1hgh1sSy4srcQ4wSHMxKIryOKVtihHhTEiurUovy44tKc1KLDzFKc7AoifNW
        MzyIFhJITyxJzU5NLUgtgskycXBKNTDqzt3UKpjGsE7unqTG6w33ahJXWyme8mUuKpzHKeq5
        dafVfokQ4718wty/VoTGa/xhUp9T4dT+8tPmgqnuQneec1tdXM/Rw1X+rbWR+05YjIz3C33F
        qN7vOy2dn8xbb1a45mADb91NwQOuLbsf+PF6rJTIEin24EzQ7Nj37aSWqtVn7jd1eUosxRmJ
        hlrMRcWJAJkBQpZiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7rm7NtjDOafVrDYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZtF694j7BaH37SzOvB7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P30/UsBV8NKzYsv8Xe
        wDhDvYuRk0NCwERi++te5i5GLg4hgaWMEv9udrJCJMQkJu3bzg5hC0v8udbFBlH0Gqho90IW
        kISwQJTEg6bvjCAJEYGTjBKzJ/xlAnGYBa4wSiy/NpkVomUSk8SumyCzODjYBPQkdqwqBDF5
        BdwkfpwRARnEIqAqcf7mA7BtogIREmferwBbwCsgKHFy5hMwm1PAXqJ/8QdmEJtZwExi3uaH
        ULa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERjF24793LyD8dLG4EOMAhyMSjy8K35ujRFiTSwrrsw9xCjBwawkwuuYsiVGiDcl
        sbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBCSavJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJ
        anZqakFqEUwfEwenVAMja+lExqfXY49NcdUsSMl4eLLZrPjEDOHm4JttngrXTS9tckvVYj3d
        l3j+xurSE/v5pjgESXKb7Wu9//ueWd3bz4oZT5u2r5OsuDr9qsyupUdmNRZtVliQ9He/2WHh
        T4t/K0qnfP3grCh6ds30TWK8S2I19eZ2z153w2lecdoDowrHHcEn8+/XKrEUZyQaajEXFScC
        AEcGnxD4AgAA
X-CMS-MailID: 20190417110007eucas1p15b203f1b86ecf4cafde51f5b3adba813
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda@eucas1p1.samsung.com>
        <1555487288-4777-3-git-send-email-l.luba@partner.samsung.com>
        <628d298a-0c44-11c9-d27b-165cdfc0d2a2@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 4/17/19 10:22 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
>> This patch adds posibility to choose what type of data should be counted
>> by the PPMU counter. Now the type comes from DT where the event has been
>> defined. When there is no 'event-data-type' the default value is used,
>> which is 'read data in bytes'.
>> It is needed when you want to know not only read+write data bytes but
>> i.e. only write data in byte, or number of read requests, etc.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/event/exynos-ppmu.c | 38 +++++++++++++++++++++++++------------
>>   include/linux/devfreq-event.h       |  6 ++++++
>>   2 files changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index c61de0b..e5f81a5 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -140,6 +140,7 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>   	int id = exynos_ppmu_find_ppmu_id(edev);
>>   	int ret;
>>   	u32 pmnc, cntens;
>> +	u32 evt_sel = edev->desc->data_type;
>>   
>>   	if (id < 0)
>>   		return id;
>> @@ -154,9 +155,12 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> -	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>> +	/* Check if the data type has been defined in DT, use default if not */
>> +	if (evt_sel == UINT_MAX)
>> +		evt_sel = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
>> +
>> +	/* Set the event of Read or Write or both (RDWR) data count  */
>> +	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id), evt_sel);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -357,6 +361,7 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>   	unsigned int pmnc, cntens;
>>   	int id = exynos_ppmu_find_ppmu_id(edev);
>>   	int ret;
>> +	u32 evt_sel = edev->desc->data_type;
>>   
>>   	/* Enable all counters */
>>   	ret = regmap_read(info->regmap, PPMU_V2_CNTENS, &cntens);
>> @@ -368,24 +373,28 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> +
>> +	/* Set the event of proper data type counting.
>> +	 * Check if the data type has been defined in DT,
>> +	 * use default if not.
>> +	 */
>>   	switch (id) {
>>   	case PPMU_PMNCNT0:
>>   	case PPMU_PMNCNT1:
>>   	case PPMU_PMNCNT2:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (evt_sel == UINT_MAX)
>> +			evt_sel = PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT;
>>   		break;
>>   	case PPMU_PMNCNT3:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_EVT3_RW_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (evt_sel == UINT_MAX)
>> +			evt_sel = PPMU_V2_EVT3_RW_DATA_CNT;
>>   		break;
>>   	}
>>   
>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id), evt_sel);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	/* Reset cycle counter/performance counter and enable PPMU */
>>   	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>   	if (ret < 0)
>> @@ -508,6 +517,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>   	struct device *dev = info->dev;
>>   	struct device_node *events_np, *node;
>>   	int i, j, count;
>> +	int ret;
>>   
>>   	events_np = of_get_child_by_name(np, "events");
>>   	if (!events_np) {
>> @@ -544,6 +554,10 @@ static int of_get_devfreq_events(struct device_node *np,
>>   		desc[j].driver_data = info;
>>   
>>   		of_property_read_string(node, "event-name", &desc[j].name);
>> +		ret = of_property_read_u32(node, "event-data-type",
>> +					   &desc[j].data_type);
>> +		if (!ret)
>> +			desc[i].data_type = UINT_MAX;
> 
> I think that it is not proper to use 'UINT_MAX'.
> If you want to use the default value, you can initialize
> the 'desc[i].data_type' according to the device type or compatible name.
> 
> For all exynos SoC except for exynos5433,
> 	desc[i].data_type = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
> 
> For exynos5433,
> 	desc[i].data_type = PPMU_V2_EVT3_RW_DATA_CNT;
> 
OK, I will set these default values here.

>>   
>>   		j++;
>>   	}
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>> index 4db00b0..cc160b1 100644
>> --- a/include/linux/devfreq-event.h
>> +++ b/include/linux/devfreq-event.h
>> @@ -81,14 +81,20 @@ struct devfreq_event_ops {
>>    * struct devfreq_event_desc - the descriptor of devfreq-event device
>>    *
>>    * @name	: the name of devfreq-event device.
>> + * @data_type	: the data type which is going to be counted in the register.
>>    * @driver_data	: the private data for devfreq-event driver.
>>    * @ops		: the operation to control devfreq-event device.
>>    *
>>    * Each devfreq-event device is described with a this structure.
>>    * This structure contains the various data for devfreq-event device.
>> + * The data_type describes what is going to be counted in the register.
>> + * It might choose to count e.g. read requests, write data in bytes, etc.
>> + * The full supported list of types is present in specyfic header in:
>> + * include/dt-bindings/pmu/.
> 
> Why did you make the path name as the 'pmu' instead of 'ppmu'?
The directory may contain in future other Performance Monitoring Unit
subsystems. In Exynos case we have: Platform Performance Monitoring Unit
but different SoCs might have other names, like: System PMU.
Since there is no 'pmu' in this directory, I am allocating it for
Performance Monitoring Unit and not Power Management Unit.

> 
> It might have some confusion because 'pmu' has
> the two meaning in linux kernel.
> - PMU, Power Management Unit
> - PMU, Performance Monitoring Unit
Regards,
Lukasz
> 
>>    */
>>   struct devfreq_event_desc {
>>   	const char *name;
>> +	u32 data_type;
>>   	void *driver_data;
>>   
>>   	const struct devfreq_event_ops *ops;
>>
> 
> 
