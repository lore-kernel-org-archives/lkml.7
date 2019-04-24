Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D368218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfDXMpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:45:12 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:59691 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730253AbfDXMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:45:11 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JHGph9yFhNExlJHGthR1s1; Wed, 24 Apr 2019 14:45:08 +0200
Subject: Re: [PATCH v9 2/4] [media] cxusb: implement Medion MD95700 digital /
 analog coexistence
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <07fc8594c942ab527275b29121869ffe77bc1d83.1553903063.git.mail@maciej.szmigiero.name>
 <9ee14d2c-e8ea-5c3f-1194-f20f25678735@xs4all.nl>
 <75f07882-1553-b7d8-c15e-9e7cbc19996f@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <fb8a5994-4eb7-11b0-d617-52ebecfe4ec0@xs4all.nl>
Date:   Wed, 24 Apr 2019 14:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <75f07882-1553-b7d8-c15e-9e7cbc19996f@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfErZcLucoJGWftH7m3x1xXTfBqm74eqbh3U1ohfzk8lXj9PwFsHJKHYZjdjB96cfkzvfJpzaUXJsyLfb3Ck2d0QiMn+zc0MxVatUTZ/bozy3VErDReDQ
 Gzq5jSigB/d1TWjWmdR1ndinVswGM/wzNcX+OnSnL2e+qIvCRZpoORxGtUU2t0N/F0EWbkgmASEcuiLSEkY4oUurLgYZEDJ48lLoIeYmsszgyAwhW3JQnNCV
 2sszpOerLddbpEdDmAi54Fs9NQqoQJKTjWf8N5hTzq9/N2cunN+Y09MmdRsUaz9bIWiUMN+i/nJh9hITGx1xb8dWSBfozIUsJ18XsLHZCh/1gOLVv7nSFl/n
 MTI2HQPw5vh0KEByCiBB4SE56qdX8OJw0n/YO83BKh6hofKEX8XvCLxsEnbw301vWCrWcJN/QuHqOtOOFl189rE/q2Te9K6U+tX2t9JBahZJlFzwF/M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 1:38 AM, Maciej S. Szmigiero wrote:
> On 12.04.2019 10:56, Hans Verkuil wrote:
>> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>>> This patch prepares cxusb driver for supporting the analog part of
>>> Medion 95700 (previously only the digital - DVB - mode was supported).
>>>
>>> Specifically, it adds support for:
>>> * switching the device between analog and digital modes of operation,
>>> * enforcing that only one mode is active at the same time due to hardware
>>> limitations.
>>>
>>> Actual implementation of the analog mode will be provided by the next
>>> commit.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>> ---
> (..)
>>> @@ -259,7 +293,7 @@ static int cxusb_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>>>  
>>>  static u32 cxusb_i2c_func(struct i2c_adapter *adapter)
>>>  {
>>> -	return I2C_FUNC_I2C;
>>> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>>
>> Was this change needed for the medion? While it is probably right, I am hesitant to
>> apply such a change in case it will break existing boards.
> 
> The cx25840 driver checks for these I2C functions at the probe time and
> returns -EIO if its i2c host doesn't support them.
> 
> The early version of this patch actually removed this SMBus check from
> the cx25840 driver, however it was decided that adding such extra
> capability to the cxusb driver is actually safer, see the end of this
> message:
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg37363.html
> 
>>> index 8056053c9ab0..01987ec5e0c5 100644
>>> --- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>>> +++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>>> @@ -15,6 +15,7 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>  {
>>>  	struct dvb_usb_adapter *adap = dvbdmxfeed->demux->priv;
>>>  	int newfeedcount, ret;
>>> +	bool streaming_ctrl_no_urb;
>>>  
>>>  	if (adap == NULL)
>>>  		return -ENODEV;
>>> @@ -24,12 +25,16 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> +	streaming_ctrl_no_urb = adap->props.fe[adap->active_fe].caps &
>>> +		DVB_USB_ADAP_STREAMING_CTRL_NO_URB;
>>>  	newfeedcount = adap->feedcount + (onoff ? 1 : -1);
>>>  
>>>  	/* stop feed before setting a new pid if there will be no pid anymore */
>>>  	if (newfeedcount == 0) {
>>>  		deb_ts("stop feeding\n");
>>> -		usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>> +
>>> +		if (streaming_ctrl_no_urb)
>>
>> Is this test right? Shouldn't it be !streaming_ctrl_no_urb in order to keep the
>> current (non-medion) behavior?
>>
>>> +			usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>>  
>>>  		if (adap->props.fe[adap->active_fe].streaming_ctrl != NULL) {
>>>  			ret = adap->props.fe[adap->active_fe].streaming_ctrl(adap, 0);
>>> @@ -38,6 +43,9 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>  				return ret;
>>>  			}
>>>  		}
>>> +
>>> +		if (!streaming_ctrl_no_urb)
>>
>> And then this would have to be inverted as well.
> 
> The newly added flag "DVB_USB_ADAP_STREAMING_CTRL_NO_URB" has the
> following meaning:
> If it is set the order of operations in dvb_usb_ctrl_feed() looks like
> this:
> 1) Call the driver streaming_ctrl(1) callback to enable streaming,
> 2) Submit DVB data URBs,
> (streaming happens)
> 3) Kill DVB data URBs,
> 4) Call the driver streaming_ctrl(0) callback to disable streaming.
> 
> This is needed for Medion because:
> a) The device could already be open in the analog mode when
> streaming_ctrl(1) tries to acquire it in the digital mode.
> In this case it is important that no DVB URBs are scheduled before
> giving the callback chance to report an error,
> 
> b) The device could get open in the analog mode as soon as
> streaming_ctrl(0) drops the last digital mode reference to it so all
> DVB data URB must have already been terminated at this point.
> 
> If the aforementioned flag is unset, however, the order of operations in
> dvb_usb_ctrl_feed() looks like this:
> 1) Submit DVB data URBs,
> 2) Call the driver streaming_ctrl(1) callback to enable streaming,
> (streaming happens)
> 3) Call the driver streaming_ctrl(0) callback to disable streaming,
> 4) Kill DVB data URBs.
> 
> Previously, the order was always like this:
> 1) Submit DVB data URBs,
> 2) Call the driver streaming_ctrl(1) callback to enable streaming,
> (streaming happens)
> 3) Kill DVB data URBs,
> 4) Call the driver streaming_ctrl(0) callback to disable streaming.
> 
> You can see that this was asymmetric - streaming_ctrl(1) is called with
> data URBs already active but they are killed before streaming_ctrl(0)
> gets called, so switching only the submit part on "STREAMING_CTRL_NO_URB"
> would make this flag operation only half-correct.
> 
> I have audited existing drivers that use dvb-usb framework and none of
> them do anything besides a synchronous USB control transfer or a
> synchronous USB bulk transfer to an endpoint different from the one that
> DVB data uses in streaming_ctrl(0) callback.
> Additionally, streaming_ctrl(1) and streaming_ctrl(0) paths are usually
> very similar in the driver code, so if streaming_ctrl(1) runs fine with
> data URBs being already active there is no reason to think
> streaming_ctrl(0) will have a problem with this.

Is there anything wrong with always doing:

1) Call the driver streaming_ctrl(1) callback to enable streaming,
2) Submit DVB data URBs,
(streaming happens)
3) Kill DVB data URBs,
4) Call the driver streaming_ctrl(0) callback to disable streaming.

Regards,

	Hans

> 
> Note that DVB data URBs are handled fully inside the dvb-usb framework
> and individual drivers don't access them.
> 
> Furthermore, in case the streaming_ctrl(1) callback fails the
> dvb_usb_ctrl_feed() function returns an error to its caller while
> leaving the already-submited URBs still active.
> They will then endlessly resubmit themselves in their completion
> callback.
> This further points out that streaming_ctrl() callback is not considered
> of need to be strongly ordered with respect to the DVB data URBs
> submission or cancellation.
> 
>>> +			usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>>  	}
>>>  
>>>  	adap->feedcount = newfeedcount;
>>> @@ -56,8 +64,10 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>  	 * for reception.
>>>  	 */
>>>  	if (adap->feedcount == onoff && adap->feedcount > 0) {
>>> -		deb_ts("submitting all URBs\n");
>>> -		usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>>> +		if (!streaming_ctrl_no_urb) {
>>> +			deb_ts("submitting all URBs early\n");
>>> +			usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>>> +		}
>>>  
>>>  		deb_ts("controlling pid parser\n");
>>>  		if (adap->props.fe[adap->active_fe].caps & DVB_USB_ADAP_HAS_PID_FILTER &&
>>> @@ -80,6 +90,10 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>>  			}
>>>  		}
>>>  
>>> +		if (streaming_ctrl_no_urb) {
>>> +			deb_ts("submitting all URBs late\n");
>>> +			usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>>> +		}
>>>  	}
>>>  	return 0;
>>>  }
> 
> 
>>
>> Regards,
>>
>> 	Hans
>>
> 
> Thanks and best regards,
> Maciej
> 

