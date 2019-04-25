Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C8C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39120878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfDYH0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:26:12 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:57291 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfDYH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:26:11 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JYlhhQLy4ZVjxJYlkhdgV8; Thu, 25 Apr 2019 09:26:09 +0200
Subject: Re: [PATCH v9 2/4] [media] cxusb: implement Medion MD95700 digital /
 analog coexistence
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Sean Young <sean@mess.org>
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <07fc8594c942ab527275b29121869ffe77bc1d83.1553903063.git.mail@maciej.szmigiero.name>
 <9ee14d2c-e8ea-5c3f-1194-f20f25678735@xs4all.nl>
 <75f07882-1553-b7d8-c15e-9e7cbc19996f@maciej.szmigiero.name>
 <fb8a5994-4eb7-11b0-d617-52ebecfe4ec0@xs4all.nl>
 <f673844e-e2a5-3d4c-df8a-eb71100b626d@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <05dbc46f-d467-1f63-b1e6-16e4d65b1ac8@xs4all.nl>
Date:   Thu, 25 Apr 2019 09:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f673844e-e2a5-3d4c-df8a-eb71100b626d@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDt5uxMEo3YVcnBFT54E02KLPHRJYoDiuuI+JqJtgTezOL9vAdZf2ySpbPfChZm7xcqmGA6iasr5QThpMsCF2It3UusqjeOG6PkuXWWcN5KUcGHaI3fZ
 5iLemsVYoU0vQi9ucEMH+3zD876zi1tYCWdhK/QXU78c8jN2cJBseWtmS6gO4FXrPCiz52swZpaN4xR1rFxc076/hAdSL6ApYAUwfyUEKKXR5UbBEd1B1/+s
 ebDBHiLg10mVl5/K6icgQBqaZMU4yGiPXealDWSz8RFOW6tn3q2J3mul6SjWGMHTFXJUZAp7AURN45vktgv3y7ZgaWKOlhITHE+943C9lEkH9gDPhl1FpKa4
 8hAFDiv9jH/qcW5crr0u29jNDDDwyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 10:02 PM, Maciej S. Szmigiero wrote:
> On 24.04.2019 14:45, Hans Verkuil wrote:
>> On 4/16/19 1:38 AM, Maciej S. Szmigiero wrote:
>>> On 12.04.2019 10:56, Hans Verkuil wrote:
>>>> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>>>>> This patch prepares cxusb driver for supporting the analog part of
>>>>> Medion 95700 (previously only the digital - DVB - mode was supported).
>>>>>
>>>>> Specifically, it adds support for:
>>>>> * switching the device between analog and digital modes of operation,
>>>>> * enforcing that only one mode is active at the same time due to hardware
>>>>> limitations.
>>>>>
>>>>> Actual implementation of the analog mode will be provided by the next
>>>>> commit.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>>>> ---
> (..)
>>>>> index 8056053c9ab0..01987ec5e0c5 100644
>>>>> --- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>>>>> +++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>>>>> @@ -15,6 +15,7 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>>>  {
>>>>>  	struct dvb_usb_adapter *adap = dvbdmxfeed->demux->priv;
>>>>>  	int newfeedcount, ret;
>>>>> +	bool streaming_ctrl_no_urb;
>>>>>  
>>>>>  	if (adap == NULL)
>>>>>  		return -ENODEV;
>>>>> @@ -24,12 +25,16 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>  
>>>>> +	streaming_ctrl_no_urb = adap->props.fe[adap->active_fe].caps &
>>>>> +		DVB_USB_ADAP_STREAMING_CTRL_NO_URB;
>>>>>  	newfeedcount = adap->feedcount + (onoff ? 1 : -1);
>>>>>  
>>>>>  	/* stop feed before setting a new pid if there will be no pid anymore */
>>>>>  	if (newfeedcount == 0) {
>>>>>  		deb_ts("stop feeding\n");
>>>>> -		usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>>>> +
>>>>> +		if (streaming_ctrl_no_urb)
>>>>
>>>> Is this test right? Shouldn't it be !streaming_ctrl_no_urb in order to keep the
>>>> current (non-medion) behavior?
>>>>
>>>>> +			usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>>>>  
>>>>>  		if (adap->props.fe[adap->active_fe].streaming_ctrl != NULL) {
>>>>>  			ret = adap->props.fe[adap->active_fe].streaming_ctrl(adap, 0);
>>>>> @@ -38,6 +43,9 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>>>  				return ret;
>>>>>  			}
>>>>>  		}
>>>>> +
>>>>> +		if (!streaming_ctrl_no_urb)
>>>>
>>>> And then this would have to be inverted as well.
>>>
>>> The newly added flag "DVB_USB_ADAP_STREAMING_CTRL_NO_URB" has the
>>> following meaning:
>>> If it is set the order of operations in dvb_usb_ctrl_feed() looks like
>>> this:
>>> 1) Call the driver streaming_ctrl(1) callback to enable streaming,
>>> 2) Submit DVB data URBs,
>>> (streaming happens)
>>> 3) Kill DVB data URBs,
>>> 4) Call the driver streaming_ctrl(0) callback to disable streaming.
>>>
>>> This is needed for Medion because:
>>> a) The device could already be open in the analog mode when
>>> streaming_ctrl(1) tries to acquire it in the digital mode.
>>> In this case it is important that no DVB URBs are scheduled before
>>> giving the callback chance to report an error,
>>>
>>> b) The device could get open in the analog mode as soon as
>>> streaming_ctrl(0) drops the last digital mode reference to it so all
>>> DVB data URB must have already been terminated at this point.
>>>
>>> If the aforementioned flag is unset, however, the order of operations in
>>> dvb_usb_ctrl_feed() looks like this:
>>> 1) Submit DVB data URBs,
>>> 2) Call the driver streaming_ctrl(1) callback to enable streaming,
>>> (streaming happens)
>>> 3) Call the driver streaming_ctrl(0) callback to disable streaming,
>>> 4) Kill DVB data URBs.
>>>
>>> Previously, the order was always like this:
>>> 1) Submit DVB data URBs,
>>> 2) Call the driver streaming_ctrl(1) callback to enable streaming,
>>> (streaming happens)
>>> 3) Kill DVB data URBs,
>>> 4) Call the driver streaming_ctrl(0) callback to disable streaming.
>>>
>>> You can see that this was asymmetric - streaming_ctrl(1) is called with
>>> data URBs already active but they are killed before streaming_ctrl(0)
>>> gets called, so switching only the submit part on "STREAMING_CTRL_NO_URB"
>>> would make this flag operation only half-correct.
>>>
>>> I have audited existing drivers that use dvb-usb framework and none of
>>> them do anything besides a synchronous USB control transfer or a
>>> synchronous USB bulk transfer to an endpoint different from the one that
>>> DVB data uses in streaming_ctrl(0) callback.
>>> Additionally, streaming_ctrl(1) and streaming_ctrl(0) paths are usually
>>> very similar in the driver code, so if streaming_ctrl(1) runs fine with
>>> data URBs being already active there is no reason to think
>>> streaming_ctrl(0) will have a problem with this.
>>
>> Is there anything wrong with always doing:
>>
>> 1) Call the driver streaming_ctrl(1) callback to enable streaming,
>> 2) Submit DVB data URBs,
>> (streaming happens)
>> 3) Kill DVB data URBs,
>> 4) Call the driver streaming_ctrl(0) callback to disable streaming.
> 
> In principle this should be fine - looking at the existing drivers
> doesn't reveal anything in their streaming_ctrl(1) callbacks that could
> depend on URBs submission order.

OK, then please switch to this in v11. I think this is a much cleaner
solution.

Sean, do you have cxusb hardware that you can use to test this when v11
is posted? Just to verify that nothing breaks.

Regards,

	Hans

> 
>> Regards,
>>
>> 	Hans
>>
> 
> Thanks,
> Maciej
> 

