Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82760C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5045D2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WEU3oqFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHNJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:10:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfHNJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:10:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E98gBC051496;
        Wed, 14 Aug 2019 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TNfNRRKJgbXv7UuZJo39ZwJD8vTIpc3kkLpNrGx/jZc=;
 b=WEU3oqFIDbauuFkn2Z4Zj55MKAreETQepZfadI63N7c9H3nRG0VLn3V2QLmS1n7IHDJy
 pvpKgtbZoiksHZMQYZd/7bAnei/VAlo0Jg93kM6DCL02zEwMXuOqpWd1Y/V1GU55Zf5L
 dwmaLqe7VHj4eY7Jdzy5lK8SYC8g/QM5XK7iR7Ui+rzSZK3iIygOSztXg865qQU1qzzm
 +PgsJLQZ9FDLMpXt6rAgR6f58/wWoFV9djD0P/jQ5jL6HcarZQP5660pbXaxWZM+ANfa
 lRxR2pVC822YT/YvjO5s0ssqv9AgmUYqdpkZ1j3psY4oYy4tVwf3OYQdId1Dwo78ZW+6 Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvpbptr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 09:09:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E97toh101805;
        Wed, 14 Aug 2019 09:09:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ubwrh1xmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 09:09:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7E99U1i025522;
        Wed, 14 Aug 2019 09:09:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 02:09:30 -0700
Date:   Wed, 14 Aug 2019 12:09:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Hui Peng <benquike@gmail.com>, security@kernel.org,
        alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wenwen Wang <wang6495@umn.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Message-ID: <20190814090921.GO1935@kadam>
References: <20190814023625.21683-1-benquike@gmail.com>
 <s5hzhkcb6dh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhkcb6dh.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 08:36:42AM +0200, Takashi Iwai wrote:
> On Wed, 14 Aug 2019 04:36:24 +0200,
> Hui Peng wrote:
> > 
> > The `uac_mixer_unit_descriptor` shown as below is read from the
> > device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> > accessed from index 0 to `bNrInPins` - 1, the current implementation
> > assumes that descriptor is always valid (the length  of descriptor
> > is no shorter than 5 + `bNrInPins`). If a descriptor read from
> > the device side is invalid, it may trigger out-of-bound memory
> > access.
> > 
> > ```
> > struct uac_mixer_unit_descriptor {
> > 	__u8 bLength;
> > 	__u8 bDescriptorType;
> > 	__u8 bDescriptorSubtype;
> > 	__u8 bUnitID;
> > 	__u8 bNrInPins;
> > 	__u8 baSourceID[];
> > }
> > ```
> > 
> > This patch fixes the bug by add a sanity check on the length of
> > the descriptor.
> > 
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> > ---
> >  sound/usb/mixer.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 7498b5191b68..38202ce67237 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
> >  	struct usb_audio_term iterm;
> >  	int input_pins, num_ins, num_outs;
> >  	int pin, ich, err;
> > +	int desc_len = (int) ((unsigned long) state->buffer +
> > +			state->buflen - (unsigned long) raw_desc);
> > +
> > +	if (desc_len < sizeof(*desc) + desc->bNrInPins) {
> > +		usb_audio_err(state->chip,
> > +			      "descriptor %d too short\n",
> > +			      unitid);
> > +		return -EINVAL;
> > +	}
> >  
> >  	err = uac_mixer_unit_get_channels(state, desc);
> >  	if (err < 0) {
> 
> Hm, what is the desc->bLength value in the error case?
> 
> Basically the buffer boundary is already checked against bLength in
> snd_usb_find_desc() which is called from obtaining the raw_desc in the
> caller of this function (parse_audio_unit()).
> 
> So, if any, we need to check bLength for the possible overflow like
> below.
> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -744,6 +744,8 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
>  		return -EINVAL;
>  	if (!desc->bNrInPins)
>  		return -EINVAL;
> +	if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
> +		return -EINVAL;

VERSION 1 and 2 already have a different check:

	if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
		return 0; /* no bmControls -> skip */

So something is possibly off by one.  It's just version 3 which doesn't
have a check.

regards,
dan carpenter

