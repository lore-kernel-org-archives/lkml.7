Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D221DC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA5320815
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfEVIQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:16:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEVIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:16:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10so1172115wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L61GZ1vGWhSEJqecA5eKfOLhoaeorDC4hNTYi6dhVcY=;
        b=D+cJmbHuzT4uWZspwIy31YKH8F721lbOAduk/G1UaXA0SNkH2RcPpl/oVUGOWJ3xx2
         bHEuSf4dbOzJt5juTp/nHnObm9LMm7KdNYH1XPjKOhDzyJwU0TSMzRTTO/U3BGwaW6YQ
         9Zh8Ndc+iejWe9wVGegFFdCWogMP8vujO7wZ/ITjqzRwRpCUm4VR5YSvKHK3EPZONt4l
         eJSOZcYh6KZwvMSUdNkKygSj0G7DoYt437izcVyLpnjZNd1zvngPFBy9BgX5VKes3Z+R
         vN3OdaKnrGoP4TEX1dBPpRdgwk8UfLsgwS5Aj8p9xcjr4MvYx0Ugx2dHPh3hysl9kAT0
         X3+w==
X-Gm-Message-State: APjAAAVQ9EIhTaWU5SU1vUKOu3iXKQFz7E4GEXTs2U0hgnJ5a2/XkbYd
        di/nqc7ZuY1cHyRB+1YBZ7mXj5SG
X-Google-Smtp-Source: APXvYqzP5eAxt+QUdNKDPImk4DLyQ9IrS3d/xiCvj7cG/GwGarLagqzX4gxsF0Qj0WVblbYGVE5LMw==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr35515424wrv.266.1558512959021;
        Wed, 22 May 2019 01:15:59 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a22sm4984007wma.41.2019.05.22.01.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:15:57 -0700 (PDT)
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
Date:   Wed, 22 May 2019 10:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522080656.GA5109@zhanggen-UX430UQ>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 05. 19, 10:06, Gen Zhang wrote:
> On Wed, May 22, 2019 at 06:25:36AM +0200, Jiri Slaby wrote:
>> On 22. 05. 19, 3:40, Gen Zhang wrote:
>>> In alloc_tty_struct(), tty->dev is assigned by tty_get_device(). And it
>>> calls class_find_device(). And class_find_device() may return NULL.
>>> And tty->dev is dereferenced in the following codes. When 
>>> tty_get_device() returns NULL, dereferencing this tty->dev null pointer
>>> may cause the kernel go wrong. Thus we should check tty->dev.
>>> Further, if tty_get_device() returns NULL, we should free tty and 
>>> return NULL.
>>>
>>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>>>
>>> ---
>>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>>> index 033ac7e..1444b59 100644
>>> --- a/drivers/tty/tty_io.c
>>> +++ b/drivers/tty/tty_io.c
>>> @@ -3008,6 +3008,10 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
>>>  	tty->index = idx;
>>>  	tty_line_name(driver, idx, tty->name);
>>>  	tty->dev = tty_get_device(tty);
>>> +	if (!tty->dev) {
>>> +		kfree(tty);
>>> +		return NULL;
>>> +	}
>>
>> This is incorrect, you introduced an ldisc reference leak.
> Thanks for your reply, Jiri!
> And what do you mean by an ldisc reference leak? I did't get the reason
> of introducing it.

Look at the top of alloc_tty_struct: there is tty_ldisc_init. If
tty_get_device fails here, you have to call tty_ldisc_deinit. Better,
you should add a failure-handling tail to this function and "goto" there.

>> And can this happen at all?
> I think tty_get_device() may happen to return NULL. Because it calls 
> class_find_device() and there's a chance class_find_device() returns
> NULL.

Sure, but can class_find_device return NULL in this tty case here?

thanks,
-- 
js
suse labs
