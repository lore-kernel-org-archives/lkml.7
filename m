Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8209C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B33C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+n52ySm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfDWPbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:31:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47926 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:31:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NFVfec079862;
        Tue, 23 Apr 2019 10:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556033501;
        bh=+e1uHCl49NlIYwYl/77X4FaEHdgkmVrIHt2meVWcLZ0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i+n52ySmT5whPb2kkcmi/HWNv5gEUKoUNSqFr+WeR3HVi1OfLc1qWEqOZqLqhQEs+
         hU2Q55CrkSQsZYqKaZdjMX3D3K6QnVxDyQlkbR62OdQnfK3UfXJQk9pfGTY6/rG6YN
         4XYNhzfsRItZgCM0TRHiJ4OBhJ4/M9p9PEo2gHIw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NFVfEE112806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 10:31:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 10:31:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 10:31:41 -0500
Received: from [10.250.90.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NFVeRG055904;
        Tue, 23 Apr 2019 10:31:40 -0500
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <dfd59e3f-b60b-da09-bf23-a05de5f4575a@ti.com>
Date:   Tue, 23 Apr 2019 10:31:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423140150.GA10071@basecamp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian

On 4/23/19 9:01 AM, Brian Masney wrote:
> On Tue, Apr 23, 2019 at 08:49:20AM -0500, Dan Murphy wrote:
>>> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
>>> +				     int default_led_sources)
>>> +{
>>> +	u32 sources[LM3630A_NUM_SINKS];
>>> +	int ret, num_sources, i;
>>> +
>>> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
>>> +						     0);
>>> +	if (num_sources < 0)
>>> +		return default_led_sources;
>>> +	else if (num_sources > ARRAY_SIZE(sources))
>>> +		return -EINVAL;
>>> +
>>> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
>>> +					     num_sources);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < num_sources; i++) {
>>> +		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
>>> +			return -EINVAL;
>>> +
>>> +		ret |= BIT(sources[i]);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
>>> +			      struct fwnode_handle *node, int *seen_led_sources)
>>
>> Why is seen_led_sources passed in here?
>> It is initialized on the stack in lm3630a_parse_node but the variable is never referenced in that API.
> 
> It's to see all of the led-sources that are configured across all of the
> banks. If it is just in lm3630a_parse_bank(), then it won't catch the
> following invalid configuration:
> 

Ok I see what it is for now.

Not sure why it is declared as a pointer though.

Dan

> led@0 {
> 	reg = <0>;
> 	led-sources = <0 1>;
> 	label = "lcd-backlight";
> 	default-brightness = <200>;
> };
> 
> led@1 {
> 	reg = <1>;
> 	default-brightness = <150>;
> };
> 
> Brian
> 
