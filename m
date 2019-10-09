Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C413206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJIMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:42:09 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:40335 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbfJIMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:42:08 -0400
Received: from [IPv6:2001:983:e9a7:1:2801:e038:f2c3:e060] ([IPv6:2001:983:e9a7:1:2801:e038:f2c3:e060])
        by smtp-cloud7.xs4all.net with ESMTPA
        id IBI4igcHMjZ8vIBI5iHvcM; Wed, 09 Oct 2019 14:42:06 +0200
Subject: Re: [PATCH] media: usb: fix memory leak in af9005_identify_state
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190913235505.9164-1-navid.emamdoost@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <6de2396d-eaa4-5cb4-9a1d-f253503bcf48@xs4all.nl>
Date:   Wed, 9 Oct 2019 14:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190913235505.9164-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLR4WciaWbeoS3Yos5GxYJIYmG+CkYSY8MFAZMNwyIwy02S+lvjZoCiLqmMKLJ2sRxGrxxUf3YlVIh9spOObjW6Mkn5GfPcOMxFjS1Zgsf0cE27gHNQ4
 DLUUwKKFKlE8HLFtAoNyittqEOj3kUymYF3smqo/zy7tlaYXz0yjRNlbTmM01Dpz4ePxCDOUyDIFxBBhgHzaJCsztqz5R4nbfBbW0lwqljj1H6FhSIKDhr0q
 zQsM3v03AJ8zgOzt7Ggv5brZeMSN3sgVcGxe9rVnuKRjB0fIji/GZfa1IrSdlCl8gWf2pf+80vwctq/Mx4RcGrcPQCFtR3UnWg2yZ0H/nyooiWjcTIdiq8hh
 9Ms+LrJj1CREbX5wQvZnqre4qWPnLsGBNfib6P0BnaXegoOloH7hZDJp+7Vo9b9Ab5Zj1X4OD8ogxvJRgJfJxX8fuaiGxLgJECMz1hJ3TVPulzrJjB8tlttJ
 +ooedRqTkwoiAsA1MA1+uC18DWVG0oRIle8bnZiCtbWVYBYMQELB9gUVmRqqVXZ5Ymj0nT/yxuSClLWoa/2sXQpjaKOa7eY9yebZs35ADAnwcqvP9cCL87El
 e1eSKTu7aYWpIzXDOIsi28Y7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/19 1:55 AM, Navid Emamdoost wrote:
> In af9005_identify_state when returning -EIO the allocated buffer should
> be released.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/media/usb/dvb-usb/af9005.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
> index 02697d86e8c1..aee500beaab6 100644
> --- a/drivers/media/usb/dvb-usb/af9005.c
> +++ b/drivers/media/usb/dvb-usb/af9005.c
> @@ -975,8 +975,10 @@ static int af9005_identify_state(struct usb_device *udev,
>  		*cold = 1;
>  	else if (reply == 0x02)
>  		*cold = 0;
> -	else
> +	else {
> +		kfree(buf);
>  		return -EIO;
> +	}

Why not just set ret = -EIO; here?

You only need to add a

	if (!ret)
>  	deb_info("Identify state cold = %d\n", *cold);

before this line.

So this becomes:

        else
                ret = -EIO;
        if (!ret)
                deb_info("Identify state cold = %d\n", *cold);

Regards,

	Hans

>  
>  err:
> 

