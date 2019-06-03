Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB213C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01B327FF9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFCMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:14:50 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:56801 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbfFCMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:14:50 -0400
Received: from [192.168.2.10] ([46.9.252.75])
        by smtp-cloud9.xs4all.net with ESMTPA
        id XlrOhLJi7sDWyXlrRhszmS; Mon, 03 Jun 2019 14:14:48 +0200
Subject: Re: [PATCH] media: cxusb-analog: Use ARRAY_SIZE for
 cxusub_medion_pin_config
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, kbuild test robot <lkp@intel.com>
References: <20190531223756.1305617-1-mail@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8512e951-03fc-34d0-6dcf-fe9667eba022@xs4all.nl>
Date:   Mon, 3 Jun 2019 14:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531223756.1305617-1-mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGmmtXUUHWs4Wy+dOqpToMDsFs7CxmiRlydZe5t0GbMerN0581bsVAZyRW8PzdOffOAs7MRwnJbXTIOXwihj+s7sPIvmPvy33D9LA7srershSdsfMgZj
 lIO2U90mRo/aVMkcSY/Va4sRZJhUrmYtw/GhZYXItXv7+IgEyO7GbG0nkQL0voyUVF6TaJgUY4s5HjyuUkNariA1gK14HeE2olOJdS53Fe818DySC1DRi60i
 oH/VxHKJWkrWMBU35rz5KqIA5t/1XrmxbSQPA0FKBDMOIuuH0Uir3QaPWgWn9OwYOd/RmoffqQOEV59rgNqXfdS6+baGbBDgLTPrNeLUnI0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Thank you for the patch, but I posted a fix for this earlier already:

https://patchwork.linuxtv.org/patch/56441/

I'll drop this patch in favor of the one above. Apologies for not
CC-ing you on my patch, I should have done that.

Regards,

	Hans

On 6/1/19 12:37 AM, Maciej S. Szmigiero wrote:
> Use ARRAY_SIZE for computing element count of cxusub_medion_pin_config
> array as suggested by the kbuild test robot.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/media/usb/dvb-usb/cxusb-analog.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
> index 9b42ca71c177..51d3cba32b60 100644
> --- a/drivers/media/usb/dvb-usb/cxusb-analog.c
> +++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
> @@ -1622,8 +1622,7 @@ int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
>  	/* TODO: setup audio samples insertion */
>  
>  	ret = v4l2_subdev_call(cxdev->cx25840, core, s_io_pin_config,
> -			       sizeof(cxusub_medion_pin_config) /
> -			       sizeof(cxusub_medion_pin_config[0]),
> +			       ARRAY_SIZE(cxusub_medion_pin_config),
>  			       cxusub_medion_pin_config);
>  	if (ret != 0)
>  		dev_warn(&dvbdev->udev->dev,
> 

