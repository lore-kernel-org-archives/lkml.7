Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001CEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40E42077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDWJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:41:29 -0400
Received: from foss.arm.com ([217.140.101.70]:52682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfDWJl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:41:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B08C374;
        Tue, 23 Apr 2019 02:41:28 -0700 (PDT)
Received: from [10.37.12.155] (unknown [10.37.12.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1802E3F557;
        Tue, 23 Apr 2019 02:41:26 -0700 (PDT)
Subject: Re: [PATCH v2 19/36] coresight: Introduce generic platform data
 helper
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-20-git-send-email-suzuki.poulose@arm.com>
 <20190422180957.GC6402@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c401cd25-18f4-bd28-9429-48c1cf39a98c@arm.com>
Date:   Tue, 23 Apr 2019 10:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190422180957.GC6402@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/2019 07:09 PM, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Mon, Apr 15, 2019 at 05:04:02PM +0100, Suzuki K Poulose wrote:
>> So far we have hard coded the DT platform parsing code in
>> every driver. Introduce generic helper to parse the information
>> provided by the firmware in a platform agnostic manner, in preparation
>> for the ACPI support.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c       | 13 +++-----
>>   drivers/hwtracing/coresight/coresight-etb10.c      | 11 +++----
>>   drivers/hwtracing/coresight/coresight-etm3x.c      | 12 +++-----
>>   drivers/hwtracing/coresight/coresight-etm4x.c      | 11 +++----
>>   drivers/hwtracing/coresight/coresight-funnel.c     | 11 +++----
>>   drivers/hwtracing/coresight/coresight-platform.c   | 36 ++++++++++++++++------
>>   drivers/hwtracing/coresight/coresight-replicator.c | 12 +++-----
>>   drivers/hwtracing/coresight/coresight-stm.c        | 11 +++----
>>   drivers/hwtracing/coresight/coresight-tmc.c        | 13 +++-----
>>   drivers/hwtracing/coresight/coresight-tpiu.c       | 11 +++----
>>   include/linux/coresight.h                          |  7 ++---
>>   11 files changed, 66 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>> index 14d1cf5..65b86ec 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -503,17 +503,14 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct coresight_desc catu_desc;
>>   	struct coresight_platform_data *pdata = NULL;
>>   	struct device *dev = &adev->dev;
>> -	struct device_node *np = dev->of_node;
>>   	void __iomem *base;
>>   
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata)) {
>> -			ret = PTR_ERR(pdata);
>> -			goto out;
>> -		}
>> -		dev->platform_data = pdata;
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata)) {
>> +		ret = PTR_ERR(pdata);
>> +		goto out;
>>   	}
>> +	dev->platform_data = pdata;
>>   
>>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata) {
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 6e6e9aa..cd61b54 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -681,14 +681,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct etb_drvdata *drvdata;
>>   	struct resource *res = &adev->res;
>>   	struct coresight_desc desc = { 0 };
>> -	struct device_node *np = adev->dev.of_node;
>>   
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata))
>> -			return PTR_ERR(pdata);
>> -		adev->dev.platform_data = pdata;
>> -	}
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>> +	adev->dev.platform_data = pdata;
>>   
>>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata)
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>> index fa2f141..fa2164f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>> @@ -790,20 +790,16 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct etm_drvdata *drvdata;
>>   	struct resource *res = &adev->res;
>>   	struct coresight_desc desc = { 0 };
>> -	struct device_node *np = adev->dev.of_node;
>>   
>>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata))
>> -			return PTR_ERR(pdata);
>> -
>> -		adev->dev.platform_data = pdata;
>> -	}
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>>   
>> +	adev->dev.platform_data = pdata;
>>   	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
>>   	dev_set_drvdata(dev, drvdata);
>>   
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 75b923f..998b9f3 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -976,18 +976,15 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct etmv4_drvdata *drvdata;
>>   	struct resource *res = &adev->res;
>>   	struct coresight_desc desc = { 0 };
>> -	struct device_node *np = adev->dev.of_node;
>>   
>>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata))
>> -			return PTR_ERR(pdata);
>> -		adev->dev.platform_data = pdata;
>> -	}
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>> +	adev->dev.platform_data = pdata;
>>   
>>   	dev_set_drvdata(dev, drvdata);
>>   
>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
>> index 1085f31..2590744 100644
>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>> @@ -185,14 +185,11 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>>   	struct funnel_drvdata *drvdata;
>>   	struct resource *res = &adev->res;
>>   	struct coresight_desc desc = { 0 };
>> -	struct device_node *np = adev->dev.of_node;
>>   
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata))
>> -			return PTR_ERR(pdata);
>> -		adev->dev.platform_data = pdata;
>> -	}
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>> +	adev->dev.platform_data = pdata;
>>   
>>   	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata)
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 4c31299..25a1838 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -230,23 +230,17 @@ static int of_coresight_parse_endpoint(struct device *dev,
>>   	return ret;
>>   }
>>   
>> -struct coresight_platform_data *
>> +static struct coresight_platform_data *
>>   of_get_coresight_platform_data(struct device *dev,
>> -			       const struct device_node *node)
>> +			       struct coresight_platform_data *pdata)
>>   {
>>   	int ret = 0;
>> -	struct coresight_platform_data *pdata;
>>   	struct coresight_connection *conn;
>>   	struct device_node *ep = NULL;
>>   	const struct device_node *parent = NULL;
>>   	bool legacy_binding = false;
>> +	struct device_node *node = dev->of_node;
>>   
>> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> -	if (!pdata)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	/* Use device name as sysfs handle */
>> -	pdata->name = dev_name(dev);
>>   	pdata->cpu = of_coresight_get_cpu(node);
>>   
>>   	/* Get the number of input and output port for this component */
>> @@ -298,5 +292,27 @@ of_get_coresight_platform_data(struct device *dev,
>>   
>>   	return pdata;
>>   }
>> -EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
>>   #endif
>> +
>> +struct coresight_platform_data *
>> +coresight_get_platform_data(struct device *dev)
>> +{
>> +	struct coresight_platform_data *pdata;
>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>> +
>> +	if (IS_ERR_OR_NULL(fwnode))
>> +		return NULL;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* Use device name as sysfs handle */
>> +	pdata->name = dev_name(dev);
>> +
>> +	if (is_of_node(fwnode))
>> +		return of_get_coresight_platform_data(dev, pdata);
> 
> Now that I'm looking a patch 26, returning a coresight_platform_data pointer is
> a little weird here.  Function of_get_coresight_platform_data() simply fills in
> the pdata and should probably be returning an error code rather than a
> pointer.  If of_get_coresight_platform_data() returns 0 then pdata is returned.s, 

Yes, that makes sense. I will fix it.

Cheers
Suzuki
