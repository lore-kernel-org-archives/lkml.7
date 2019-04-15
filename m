Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01990C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA120830
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfDOXit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:38:49 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48242 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfDOXis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:38:48 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1hGBBT-0006se-GU; Tue, 16 Apr 2019 01:38:43 +0200
Subject: Re: [PATCH v9 2/4] [media] cxusb: implement Medion MD95700 digital /
 analog coexistence
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <07fc8594c942ab527275b29121869ffe77bc1d83.1553903063.git.mail@maciej.szmigiero.name>
 <9ee14d2c-e8ea-5c3f-1194-f20f25678735@xs4all.nl>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 PA==
Message-ID: <75f07882-1553-b7d8-c15e-9e7cbc19996f@maciej.szmigiero.name>
Date:   Tue, 16 Apr 2019 01:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9ee14d2c-e8ea-5c3f-1194-f20f25678735@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2019 10:56, Hans Verkuil wrote:
> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>> This patch prepares cxusb driver for supporting the analog part of
>> Medion 95700 (previously only the digital - DVB - mode was supported).
>>
>> Specifically, it adds support for:
>> * switching the device between analog and digital modes of operation,
>> * enforcing that only one mode is active at the same time due to hardware
>> limitations.
>>
>> Actual implementation of the analog mode will be provided by the next
>> commit.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
(..)
>> @@ -259,7 +293,7 @@ static int cxusb_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>>  
>>  static u32 cxusb_i2c_func(struct i2c_adapter *adapter)
>>  {
>> -	return I2C_FUNC_I2C;
>> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> 
> Was this change needed for the medion? While it is probably right, I am hesitant to
> apply such a change in case it will break existing boards.

The cx25840 driver checks for these I2C functions at the probe time and
returns -EIO if its i2c host doesn't support them.

The early version of this patch actually removed this SMBus check from
the cx25840 driver, however it was decided that adding such extra
capability to the cxusb driver is actually safer, see the end of this
message:
https://www.mail-archive.com/linux-media@vger.kernel.org/msg37363.html

>> index 8056053c9ab0..01987ec5e0c5 100644
>> --- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>> +++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
>> @@ -15,6 +15,7 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>  {
>>  	struct dvb_usb_adapter *adap = dvbdmxfeed->demux->priv;
>>  	int newfeedcount, ret;
>> +	bool streaming_ctrl_no_urb;
>>  
>>  	if (adap == NULL)
>>  		return -ENODEV;
>> @@ -24,12 +25,16 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>  		return -EINVAL;
>>  	}
>>  
>> +	streaming_ctrl_no_urb = adap->props.fe[adap->active_fe].caps &
>> +		DVB_USB_ADAP_STREAMING_CTRL_NO_URB;
>>  	newfeedcount = adap->feedcount + (onoff ? 1 : -1);
>>  
>>  	/* stop feed before setting a new pid if there will be no pid anymore */
>>  	if (newfeedcount == 0) {
>>  		deb_ts("stop feeding\n");
>> -		usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>> +
>> +		if (streaming_ctrl_no_urb)
> 
> Is this test right? Shouldn't it be !streaming_ctrl_no_urb in order to keep the
> current (non-medion) behavior?
> 
>> +			usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>  
>>  		if (adap->props.fe[adap->active_fe].streaming_ctrl != NULL) {
>>  			ret = adap->props.fe[adap->active_fe].streaming_ctrl(adap, 0);
>> @@ -38,6 +43,9 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>  				return ret;
>>  			}
>>  		}
>> +
>> +		if (!streaming_ctrl_no_urb)
> 
> And then this would have to be inverted as well.

The newly added flag "DVB_USB_ADAP_STREAMING_CTRL_NO_URB" has the
following meaning:
If it is set the order of operations in dvb_usb_ctrl_feed() looks like
this:
1) Call the driver streaming_ctrl(1) callback to enable streaming,
2) Submit DVB data URBs,
(streaming happens)
3) Kill DVB data URBs,
4) Call the driver streaming_ctrl(0) callback to disable streaming.

This is needed for Medion because:
a) The device could already be open in the analog mode when
streaming_ctrl(1) tries to acquire it in the digital mode.
In this case it is important that no DVB URBs are scheduled before
giving the callback chance to report an error,

b) The device could get open in the analog mode as soon as
streaming_ctrl(0) drops the last digital mode reference to it so all
DVB data URB must have already been terminated at this point.

If the aforementioned flag is unset, however, the order of operations in
dvb_usb_ctrl_feed() looks like this:
1) Submit DVB data URBs,
2) Call the driver streaming_ctrl(1) callback to enable streaming,
(streaming happens)
3) Call the driver streaming_ctrl(0) callback to disable streaming,
4) Kill DVB data URBs.

Previously, the order was always like this:
1) Submit DVB data URBs,
2) Call the driver streaming_ctrl(1) callback to enable streaming,
(streaming happens)
3) Kill DVB data URBs,
4) Call the driver streaming_ctrl(0) callback to disable streaming.

You can see that this was asymmetric - streaming_ctrl(1) is called with
data URBs already active but they are killed before streaming_ctrl(0)
gets called, so switching only the submit part on "STREAMING_CTRL_NO_URB"
would make this flag operation only half-correct.

I have audited existing drivers that use dvb-usb framework and none of
them do anything besides a synchronous USB control transfer or a
synchronous USB bulk transfer to an endpoint different from the one that
DVB data uses in streaming_ctrl(0) callback.
Additionally, streaming_ctrl(1) and streaming_ctrl(0) paths are usually
very similar in the driver code, so if streaming_ctrl(1) runs fine with
data URBs being already active there is no reason to think
streaming_ctrl(0) will have a problem with this.

Note that DVB data URBs are handled fully inside the dvb-usb framework
and individual drivers don't access them.

Furthermore, in case the streaming_ctrl(1) callback fails the
dvb_usb_ctrl_feed() function returns an error to its caller while
leaving the already-submited URBs still active.
They will then endlessly resubmit themselves in their completion
callback.
This further points out that streaming_ctrl() callback is not considered
of need to be strongly ordered with respect to the DVB data URBs
submission or cancellation.

>> +			usb_urb_kill(&adap->fe_adap[adap->active_fe].stream);
>>  	}
>>  
>>  	adap->feedcount = newfeedcount;
>> @@ -56,8 +64,10 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>  	 * for reception.
>>  	 */
>>  	if (adap->feedcount == onoff && adap->feedcount > 0) {
>> -		deb_ts("submitting all URBs\n");
>> -		usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>> +		if (!streaming_ctrl_no_urb) {
>> +			deb_ts("submitting all URBs early\n");
>> +			usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>> +		}
>>  
>>  		deb_ts("controlling pid parser\n");
>>  		if (adap->props.fe[adap->active_fe].caps & DVB_USB_ADAP_HAS_PID_FILTER &&
>> @@ -80,6 +90,10 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
>>  			}
>>  		}
>>  
>> +		if (streaming_ctrl_no_urb) {
>> +			deb_ts("submitting all URBs late\n");
>> +			usb_urb_submit(&adap->fe_adap[adap->active_fe].stream);
>> +		}
>>  	}
>>  	return 0;
>>  }


> 
> Regards,
> 
> 	Hans
> 

Thanks and best regards,
Maciej
