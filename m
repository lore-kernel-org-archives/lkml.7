Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A140C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5D62073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cAKtD1Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfLDTOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:14:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33466 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLDTOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:14:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4JDxBK000406;
        Wed, 4 Dec 2019 13:13:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575486839;
        bh=INvrPZI5l4kkjk9uHY07YAmvrsfziEoknfrwIChpOz8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=cAKtD1TvJwPuHmdqJGLoZN/AHr7XxMIhG01lF19iVzEUCJ0GGnbV+mbb9h9nIMj/W
         y3bI2aTrNRSNjFhyj5hJ2L4g3T1uLfBC7zUr/DjtAUFOhSRJwcpjosKeG5llno/xsZ
         nrnpIrHZ0ZCiOc6iNnXtjcCOqqbOQKoWXjX5n6ts=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4JDxm9125014;
        Wed, 4 Dec 2019 13:13:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 13:13:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 13:13:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4JDtxj035343;
        Wed, 4 Dec 2019 13:13:55 -0600
Subject: Re: [PATCH v6 03/15] drm/bridge: tc358767: Simplify polling in
 tc_link_training()
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
 <20190619052716.16831-4-andrew.smirnov@gmail.com>
 <0d84fa72-bc96-9b88-cd89-c04327109e0e@ti.com>
Message-ID: <bdf4df0a-06d7-2ccb-9e8a-0c0ad55871ec@ti.com>
Date:   Wed, 4 Dec 2019 21:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0d84fa72-bc96-9b88-cd89-c04327109e0e@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 20:27, Tomi Valkeinen wrote:
> Hi Andrey,
> 
> On 19/06/2019 08:27, Andrey Smirnov wrote:
> 
>> @@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
>>   static int tc_wait_link_training(struct tc_data *tc)
>>   {
>> -    u32 timeout = 1000;
>>       u32 value;
>>       int ret;
>> -    do {
>> -        udelay(1);
>> -        tc_read(DP0_LTSTAT, &value);
>> -    } while ((!(value & LT_LOOPDONE)) && (--timeout));
>> -
>> -    if (timeout == 0) {
>> +    ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
>> +                  LT_LOOPDONE, 1, 1000);
> 
> This seems to break DP at least with some monitors for me. I think it's just a timeout problem, as 
> increasing the values helps.
> 
> Using ktime, I can see that during link training, the first call takes ~2ms, the second ~7ms. I 
> think this worked before, as udelay(1) takes much longer than 1 us.

Also the timeout in tc_aux_link_setup takes ~500us for me, and max is 1000us. So it works, but I 
think it's a bit tight.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
