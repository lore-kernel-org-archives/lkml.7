Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C266C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1F20693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bjW4Iynx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNJ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:57:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38856 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:57:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id x13so4222154ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXeqVAoGvBVydv+RhfxK9GaqekG4Esi7VZP8mLTr20g=;
        b=bjW4IynxhuC6+hPAsGklPNK8kDi1FJlv6096njp84hJdKvWHdzM89rUWS+kQtMQlUC
         3VfukUdCWwvGe1sRNHi1IdJBBgHpMke0l+yIJUikgaVt6RqwUPNLaNDlzft2NNXePANt
         dhlehwgj6ECzvqA3vbxQ/D8/Gx0zZ/4T8KfSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXeqVAoGvBVydv+RhfxK9GaqekG4Esi7VZP8mLTr20g=;
        b=lpjFBOw3NOOp2wFkzICTFYquEoLj06g6LlBzhxr6z/F8R9+fj1r16jU5qV4mnM9s9N
         NmZ0jGR6a+xnAed7SV7w8XtaVKvxtREkE+C1/mAq7yYWQFbp+c4fC6edHFqIIQW9RBzv
         NT3XWjhY9KveXZHCmcvUuxItnkiSi1kFMFn0ARuhqvkQSeTI2ORpwvy2iul8eF6nNIrp
         ASQs8bce10rPinwdBzawpSJT0QfUj5VtwKCYyLSmF3GwfSwHVrM9tsAXFg0IYFNR1hA8
         9rn5ZRY0iH1Pfn+OZUotO9QTg8f4tzLqGlogBHC5aMGJM5Vqu4ljkhmkL3cCY7LBjCHQ
         EEGg==
X-Gm-Message-State: APjAAAXdj/PieV/JRqCIWJJSVV2Js8vBjnc0sBiRwXiP76x37K0Ox+xc
        mToKrWlVDFFfU2mQsasXXsnMZg==
X-Google-Smtp-Source: APXvYqyXy1IAUn4PHisgLHarAflG+aOsxAY/8Dk4EclU9cpqzEavnluiiCjcFfqvH58UFuNtwf0fEQ==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr637718lji.148.1552557436908;
        Thu, 14 Mar 2019 02:57:16 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h3sm2608993lfj.25.2019.03.14.02.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 02:57:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-2-linux@rasmusvillemoes.dk>
 <20190314092929.65amwzsaswcvsexl@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8b2903c9-e56b-ea22-41b2-d6f96bec1d96@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 10:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314092929.65amwzsaswcvsexl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 10.29, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 09:26:12PM +0100, Rasmus Villemoes wrote:
>> --- a/drivers/leds/trigger/ledtrig-netdev.c
>> +++ b/drivers/leds/trigger/ledtrig-netdev.c
>> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
>>  		trigger_data->net_dev = NULL;
>>  	}
>>  
>> -	strncpy(trigger_data->device_name, buf, size);
>> +	memcpy(trigger_data->device_name, buf, size);
>> +	trigger_data->device_name[size] = '\0';
> 
> This is open-coding
> 
> 	strlcpy(trigger_data->device_name, buf, size);

No. size here is the number of bytes userspace wrote, which never (well,
almost never, they could do something odd) contain a nul byte. Passing
that as size to strlcpy would guarantee that we chopped off the last
character from the user input. And while I do think the generic sysfs
layer guarantees that the PAGE_SIZE buffer is zeroed before reading from
userspace, I don't really want to rely on buf being a nul-terminated
string (which it must be if using strlcpy - remember that that does a
full strlen() to compute its return value). If anything, one could do
strlcpy(, buf, size+1), but IMO copying the actual characters the user
wrote, then explicitly making that into a nul-terminated string is much
more straight-forward.

Rasmus
