Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="syxTjbct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDWTDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:03:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33168 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:03:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NJ2qqW105466;
        Tue, 23 Apr 2019 14:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556046172;
        bh=0eG3Z3S3ocYcBYBvyqgRPxOyST1uSn4qcID8FDy6xc8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=syxTjbct0RIsQkyu1ZEkpozWSknmSpNwZgMnjLXfT7vwY9CsUT4j6BMX3sDZS9P+l
         UmWhobNAOCe0SRSVOIa2gX72rTJFOOYmqmAv9VOIdf7OgpphigY+Hv2NLhI0+zQekp
         hVwN+iyidazw6/nr7pu/wByx6op2tEg4Lxi1hEt8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NJ2qNG035966
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 14:02:52 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 14:02:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 14:02:51 -0500
Received: from [10.250.90.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NJ2pT1020828;
        Tue, 23 Apr 2019 14:02:51 -0500
Subject: Re: [PATCH v5 3/3] backlight: lm3630a: add firmware node support
To:     Brian Masney <masneyb@onstation.org>
CC:     <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190418151143.26068-1-masneyb@onstation.org>
 <20190418151143.26068-4-masneyb@onstation.org>
 <dc20ab5d-8c44-78a8-3ebc-7fefe8aaf2d5@ti.com>
 <20190423140150.GA10071@basecamp>
 <dfd59e3f-b60b-da09-bf23-a05de5f4575a@ti.com>
 <20190423160019.GA10501@basecamp>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f8499848-1490-cee5-c943-fa7fb77236ce@ti.com>
Date:   Tue, 23 Apr 2019 14:02:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423160019.GA10501@basecamp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian

On 4/23/19 11:00 AM, Brian Masney wrote:
> On Tue, Apr 23, 2019 at 10:31:41AM -0500, Dan Murphy wrote:
>> On 4/23/19 9:01 AM, Brian Masney wrote:
>>> On Tue, Apr 23, 2019 at 08:49:20AM -0500, Dan Murphy wrote:
>>>>> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
>>>>> +				     int default_led_sources)
>>>>> +{
>>>>> +	u32 sources[LM3630A_NUM_SINKS];
>>>>> +	int ret, num_sources, i;
>>>>> +
>>>>> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
>>>>> +						     0);
>>>>> +	if (num_sources < 0)
>>>>> +		return default_led_sources;
>>>>> +	else if (num_sources > ARRAY_SIZE(sources))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
>>>>> +					     num_sources);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	for (i = 0; i < num_sources; i++) {
>>>>> +		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		ret |= BIT(sources[i]);
>>>>> +	}
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
>>>>> +			      struct fwnode_handle *node, int *seen_led_sources)
>>>>
>>>> Why is seen_led_sources passed in here?
>>>> It is initialized on the stack in lm3630a_parse_node but the variable is never referenced in that API.
>>>
>>> It's to see all of the led-sources that are configured across all of the
>>> banks. If it is just in lm3630a_parse_bank(), then it won't catch the
>>> following invalid configuration:
>>>
>>
>> Ok I see what it is for now.
>>
>> Not sure why it is declared as a pointer though.
> 
> It's so that lm3630a_parse_bank() can update that value with the
> led-sources that have been seen. Otherwise, the changes wouldn't make
> their way back out to the outer function.
> 

OK.  Thats another way to do it.  I may have just done a return with the value.

Otherwise

Reviewed-by: Dan Murphy <dmurphy@ti.com>

> Brian
> 
