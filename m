Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD27C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8421841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbfDQGw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:52:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDQGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:52:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so30340541wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 23:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wqT51UCaJqyBHY6jSboM83rXeBX5SWOBpSyoLTsbg2M=;
        b=EqH2p9N0hIQ8AB4xkK9NgsJKnKECgdXoWot5GeIbbxY3dOzjLbxRba1fv5JEUhi0X+
         K9X/FG67CznYCD+gb5VOijySNmAV85tbeTtEKo5P8jfIKH7LAWBDPYwNTScoazL1FCzA
         xpp7ncNfi8BEmrUeRjDjxMgvOQsfabvQS7J1fguZXHsmROCAWuPTXHYl00K90rp4OenH
         06vyuf2mwQFLlsZJedrElwm45d6mV0U8IRcmLSTpyt50oF02ZLi2O/ZR1Se0gYeeudfX
         97SNt18vZTfUhaBCZwF3A5EfVmWELxkUn5hjRQ3bKVHgxl2y++ZIaDVzSu21OOuoWrDj
         Ed9A==
X-Gm-Message-State: APjAAAXHREsu2tuBT7ADyO6lGtsVZJyMKGci7u9yAvGLCTRqu4INqwzQ
        HzOACsdWWP0bUhWexIZFrZX9u4qt
X-Google-Smtp-Source: APXvYqzi964KAh8piM5F78gRHFy9HA/pcEgmUGY3e9mk/Bz2ly8waTworAqRPLzn6pT8ZWRbrQwJ3Q==
X-Received: by 2002:adf:f286:: with SMTP id k6mr52151121wro.137.1555483974853;
        Tue, 16 Apr 2019 23:52:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id f15sm67955752wru.21.2019.04.16.23.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 23:52:54 -0700 (PDT)
Subject: Re: [PATCH v4] tty: rocket: Remove the rp_ioctl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190416145300.28212-1-huangfq.daxian@gmail.com>
 <06427d24-535b-e116-51e0-d98565a8fda1@suse.cz>
 <20190417064629.GA19549@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f297d82a-f1ba-c985-a2ad-397e26902e78@suse.cz>
Date:   Wed, 17 Apr 2019 08:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417064629.GA19549@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 04. 19, 8:46, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2019 at 08:27:41AM +0200, Jiri Slaby wrote:
>> On 16. 04. 19, 16:53, Fuqian Huang wrote:
>>> --- a/drivers/tty/rocket.c
>>> +++ b/drivers/tty/rocket.c
>> ...
>>> -/*  IOCTL call handler into the driver */
>>> -static int rp_ioctl(struct tty_struct *tty,
>>> -		    unsigned int cmd, unsigned long arg)
>>> -{
>>> -	struct r_port *info = tty->driver_data;
>>> -	void __user *argp = (void __user *)arg;
>>> -	int ret = 0;
>>> -
>>> -	if (cmd != RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl"))
>>> -		return -ENXIO;
>>> -
>>> -	switch (cmd) {
>>> -	case RCKP_GET_STRUCT:
>>> -		if (copy_to_user(argp, info, sizeof (struct r_port)))
>>> -			ret = -EFAULT;
>>> -		break;
>>
>> I am not sure what Greg meant, but I had only this particular ioctl on
>> mind when I was writing about removal. The other ones might be used _in
>> theory_. Even though they are not exposed to userspace either. So if
>> they are not source of potential issues, I would keep them:
> 
> I was just meaning that one specific ioctl, not the whole thing.
> 
> Although dropping all of these custom ioctls is probably the right thing
> to do in the long-run, for now, let's just get rid of the problem one.

So could you rework the patch to remove only the one? And in a separate
patch, introduce a printk_ratelimited warning to every "case *:" (i.e.
no warning in the "default" case) in rp_ioctl about depreciation of the
ioctl?

thanks,
-- 
js
suse labs
