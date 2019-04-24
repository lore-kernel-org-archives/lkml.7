Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DEC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D372077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfDXOJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:29 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:55731 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbfDXOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:27 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JIaOhARvoNExlJIaRhRKnm; Wed, 24 Apr 2019 16:09:24 +0200
Subject: Re: KASAN: use-after-free Read in dvb_usb_device_exit
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org
References: <000000000000789d3d058653d9bb@google.com>
 <1555326745.13626.10.camel@suse.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9cfe433e-426e-19d1-9cb8-5bc2ba17145b@xs4all.nl>
Date:   Wed, 24 Apr 2019 16:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555326745.13626.10.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOe0FKDAdfm4bCG9AcSQKiJm7NixvEhPlu5RsWbkU0Oi2psahmum5efVyXtmw+1tMAIE0oGT5FBncyWwuBSF0mbcEbGtAnS/apqfkHQaORuQnL+RexMl
 5zo7pkMI688dCF1q0dMPMifNaFw5Ma0dGMVyUUHSL/Uhw5Bb8M3HC9QVmcTToqEz18xECeozHX5Qv6CDhIug4ZkldhdUOPL+dKaR8KsguJAjyrBBxjZ/DUup
 WHgAewX4IYE+NOMvoLTIxnetr1Ql6QMeGQ84eUqe84OCPP0pVCQrVl1PQHPkQsboLavtv9GFaKe4De83WNgP6pSyN4nn7NGCPUcsVtdP9V6Z3offU0hpu5bJ
 LyzuZa5KPLyuWV2eHcujXWXMQeZgsICAajU/n47e/OJ1pL9kCqF8pDoPtyTjBbBhVsvS0JZhFquizlyjOhaYy0FeK8zzqKmhHMjLNQ62OKdOlA4suTV3RqYb
 XiPgIUUOCijkc50P6q4QydKbDm+6FUhQ/v96zOOdLZq6eZtZ0w8ZW25s7nDiJob2p6Iz7lmFKAZSBQ7rwC5riY7gKjmamCLb98q9i0MOT51H8U72GPRUNXLp
 3Au3RjhYe4gmOaZ4GTZ6h2cr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 1:12 PM, Oliver Neukum wrote:
> On Fr, 2019-04-12 at 04:46 -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
>> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1643974b200000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
>> dashboard link: https://syzkaller.appspot.com/bug?extid=26ec41e9f788b3eba396
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f5efa7200000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1395a0f3200000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
>>
>> dvb-usb: schedule remote query interval to 150 msecs.
>> dw2102: su3000_power_ctrl: 0, initialized 1
>> dvb-usb: TeVii S421 PCI successfully initialized and connected.
>> usb 1-1: USB disconnect, device number 2
> 
> Hi,
> 
> proposed fix. If nobody objects, I will submit it.
> 
> 	Regards
> 		Oliver
> 
> From d6097d205ac61745334b79639d3b8b910ae66c71 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Mon, 15 Apr 2019 13:06:01 +0200
> Subject: [PATCH] dvb: usb: fix use after free in dvb_usb_device_exit
> 
> dvb_usb_device_exit() frees and uses teh device name in that order
> Fix by storing the name in a buffer before freeing it
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 99951e02a880..2e1670cc3903 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -288,13 +288,18 @@ void dvb_usb_device_exit(struct usb_interface *intf)
>  {
>  	struct dvb_usb_device *d = usb_get_intfdata(intf);
>  	const char *name = "generic DVB-USB module";
> +	char identifier[40];
>  
>  	usb_set_intfdata(intf, NULL);
>  	if (d != NULL && d->desc != NULL) {
>  		name = d->desc->name;
> +		memcpy(identifier, name, 39);
> +		identifier[39] = NULL;
>  		dvb_usb_exit(d);

Why not just move this to after the info()? You'll need to repeat the
'if' in that case, but that way there is no need to memcpy anything.

Regards,

	Hans

> +	} else {
> +		memcpy(identifier, name, 39);
>  	}
> -	info("%s successfully deinitialized and disconnected.", name);
> +	info("%s successfully deinitialized and disconnected.", identifier);
>  
>  }
>  EXPORT_SYMBOL(dvb_usb_device_exit);
> 

