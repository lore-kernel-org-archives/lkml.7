Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE4B2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EtBAz1CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfHLQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:48:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56810 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CGmPFa126458;
        Mon, 12 Aug 2019 11:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565628505;
        bh=K2kWznbWIdZ/ricVAmUmB19KtEM09fU55kzjXYmQvME=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EtBAz1CBkH6KcNuHZ+Xzm2pfaPkKbZD01UtweuaQzS5/iMmyGZ3UADy2KWVd9o/HU
         HdfJuEV/QBDS7wWe3EFjlqJ5dpmbrFARrTynOdIS2Knqb5eNkdxR4GLd5/M8y+Ru0l
         APAEACMfboFZtCAGY99C7YtiMJo+DWXjnVMBuYeg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CGmP2G090732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 11:48:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 11:48:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 11:48:25 -0500
Received: from [10.250.88.190] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CGmOjZ130439;
        Mon, 12 Aug 2019 11:48:24 -0500
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181024011909.21674-1-s-anna@ti.com>
 <1cc3d697-6fde-901b-2e35-2e2b53b44425@ti.com>
 <2ef5e274-df09-c3a0-41ed-a945d1902eaf@ti.com>
 <92dc4403-8782-8dbf-b912-cc832ac748a7@ti.com>
 <ea1efb4e-43be-4efc-10f8-9d182313bf12@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <292d913f-7f4e-52ee-13bc-36014acee646@ti.com>
Date:   Mon, 12 Aug 2019 12:48:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ea1efb4e-43be-4efc-10f8-9d182313bf12@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 12:39 PM, Suman Anna wrote:
> On 8/12/19 11:36 AM, Andrew F. Davis wrote:
>> On 8/12/19 12:28 PM, Suman Anna wrote:
>>> On 8/12/19 10:47 AM, Andrew F. Davis wrote:
>>>> On 10/23/18 9:19 PM, Suman Anna wrote:
>>>>> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
>>>>> printing the vring buffer address. This prints only a hashed
>>>>> pointer even for previliged users. Use "%pK" instead so that
>>>>> the address can be printed during debug using kptr_restrict
>>>>> sysctl.
>>>>>
>>>>
>>>>
>>>> s/previliged/privileged
>>>
>>> Bjorn,
>>> Can you fix this up when applying.
>>>
>>>>
>>>> You describe what the code does, but not why you need this. %pK is used
>>>> for only about 1% of pointer printing, why do you want to leak this
>>>> address to userspace at all?
>>>
>>> Andrew,
>>> Default behavior of %pK is same as %p, but it does allow you to control
>>> the print. The reason is clearly mentioned in the last sentence in the
>>> patch description.
>>>
>>
>>
>> Let me rephrase then, why would you ever set 'kptr_restrict' to anything
>> other than 0, or why do you want to be able to leak this address to
>> userspace at all? If the answer is just because you can, then all 12,000
>> instances of %p in kernel could be converted for the same reason.
> 
> It is a dev_dbg statement, so it is already under dynamic debug control.
> We would only ever use it during debug.
> 


Most pointer printings are in debug statements..

I'm simply not seeing what this helps us do. The DMA address I can
understand, it may be given to a remote core so we may want to verify it
is the same on both sides, but the actual virtual kernel address is of
no value to us, a hash to track it across uses is just as good.

Andrew


> regards
> Suman
> 
>>
>> Andrew
>>
>>
>>> regards
>>> Suman
>>>
>>>>
>>>> Andrew
>>>>
>>>>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> ---
>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> index f29dee731026..1345f373a1a0 100644
>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>>>  		goto vqs_del;
>>>>>  	}
>>>>>  
>>>>> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>>>>> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
>>>>>  		bufs_va, &vrp->bufs_dma);
>>>>>  
>>>>>  	/* half of the buffers is dedicated for RX */
>>>>>
>>>
> 
