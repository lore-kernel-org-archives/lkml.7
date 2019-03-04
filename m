Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A372C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5285B20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p1nDVfBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCDK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:26:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35422 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCDK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:26:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24APNE1125711;
        Mon, 4 Mar 2019 04:25:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551695123;
        bh=DTCWO1Mh8rcJ3Wv71Zn2pvbPG2rDg0CmGLKV/AWDgiM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=p1nDVfBJIa5C4ENBk/Xsfs7eYsxlP76kOhuz0BNNpzGxuoOsmJPQCCkIn7sgaGmVq
         ygOeiD1+1rBksGZVYaDWFycZ090Lu5ToRee+KbpYnLVux6p+7GqlcYzzioelxNCdy8
         /hLMNWc8hFoD829MACptF8wmMfGMPFaSnP8UX5JQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24APN38122195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 04:25:23 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 04:25:19 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 04:25:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24APFeO011419;
        Mon, 4 Mar 2019 04:25:16 -0600
Subject: Re: [PATCH v4 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT
 buffer.
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-7-git-send-email-pawell@cadence.com>
 <67da432f-9c95-d644-65b5-dbc5b942d24c@ti.com>
 <BYAPR07MB47091C199971D677DE0FBB84DD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <e8616274-b0a8-6e59-b6fa-a68fed58bad7@ti.com>
 <BYAPR07MB470939C6F100336BAF6C41BFDD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87va1dbokp.fsf@linux.intel.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <70967a02-2f02-9ac8-e205-cdbfac5fbbae@ti.com>
Date:   Mon, 4 Mar 2019 12:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87va1dbokp.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/02/2019 09:14, Felipe Balbi wrote:
> 
> Hi,
> 
> (please break your emails at 80-columns)
> 
> Pawel Laszczak <pawell@cadence.com> writes:
>>>> One more thing. Workaround has implemented algorithm that decide for which
>>>> endpoint it should be enabled.  e.g for composite device MSC+NCM+ACM it
>>>> should work only for ACM OUT endpoint.
>>>>
>>>
>>> If ACM driver didn't queue the request for ACM OUT endpoint, why does the
>>> controller accept the data at all?
>>>
>>> I didn't understand why we need a workaround for this. It should be standard
>>> behaviour to NAK data if function driver didn't request for all endpoints.
>>
>> Yes, I agree with you. Controller shouldn’t accept such packet. As I know this
>> behavior will be fixed in RTL.
>>
>> But I assume that some older version of this controller are one the market,
>> and driver should work correct with them.
>>
>> In the feature this workaround can be limited only to selected controllers.
>>
>> Even now I assume that it can be enabled/disabled by module parameter.
> 
> no module parameters, please. Use revision detection in runtime.
> 

This is about whether to enable or disable the workaround.
By default we don't want this workaround to be enabled.

I'm debating whether we should have this workaround at all or not.

It has the following problems.

1) It ACKs packets even when gadget end is not ready to accept the transfers.
2) It stores these packets in a temporary buffer and then pushes them to the
gadget driver whenever the gadget driver is ready to process the data.
3) Since the gadget driver can become ready at an indefinite time in the
future, it poses 2 problems:
 a) It is sending stale data to the sink. (problematic at next protocol level?)
 b) If this temporary buffer runs out we still hit the lock up issue.

I think the right solution is to make sure that the gadget driver is always
reading all the enabled OUT endpoints *or* (keep the OUT endpoints disabled
if gadget driver is not ready to process OUT transfers).

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
