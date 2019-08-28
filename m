Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E892C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546B32053B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8Wo5R1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfH1IsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:48:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1IsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:48:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so1593906wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lh087UDN3bHwxNKU9oXqXSmgDMXMIewzXIKR9m+6i0E=;
        b=V8Wo5R1gkblbmEBDK8foSh7C8UDtmz4d0IduZExmjWX/5IB95wO3kIXkuEoGhrZfEH
         L4H0pBBEJbHaUC8rJ9oAlPItBkDc137JyPrs4bGEaDbmUcknCxqVixzEYbiGA0tnaS4L
         NYkXtgo3FO3XYNGTGrJisbxOoQDaE0Qzs20m0+fEo2BCdhg5vj5TWvOuR4qaUeToYlC9
         vjsbILLTw5rhfyHlSFy6LHBIMVv9idAS0aptNCnv5kyuoRFbJju58nUWXVsAo01L+JPu
         aNbsuPL8QbptuLmqEQ9Tbp9m3YoE0oHfBiBCorWXxDVeN1QNsdVPKrOnGQvXSe9tGYD9
         w22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lh087UDN3bHwxNKU9oXqXSmgDMXMIewzXIKR9m+6i0E=;
        b=Fbmzqbgx75sRoRrDIumvvBv64lTx5dKbYgiMNk7hGDuq+916ApDakx2UCLztQR2gZM
         WlR11FPLFGQgYU8BGg7bN5WQxlwdhXZd2pkm9pUf7/Ad6551Z0a9mBrZBsREYZThmYU9
         k5Zxw32sIoJ8ncj1a04pbyjIlDGc9ttS5+l9BN3TIR7uMW457tHmosc5uly//iNleFEa
         PVX2G88BerNVowhF/sZtUDIyhD+JEEbDoeR3v27ogDb4l7ogzg6DLYHMNtozLM7VEm+r
         TsHIg+d72zoLBXnhHgjvdSnEm/N+caA5Y63z6uFluzbPdHmeJ00pbO80+7Ky+58B6Zpq
         IkmA==
X-Gm-Message-State: APjAAAXIw3sgpv1OJv/piZoXkEOLc0zmZYHXgMfNdbg2KhdneuxqCZQx
        EigzrDhnuOq9LQ8++7DMpTiW3IygMmg=
X-Google-Smtp-Source: APXvYqw11HbEWphGzvuO4I/UDjUNi1JYA+PodKeI/bgO/Z9c9hO+gqsdJmZDyLNbvSJsSL/ArGZH0w==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr3127105wrn.37.1566982085434;
        Wed, 28 Aug 2019 01:48:05 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u6sm1488731wmm.26.2019.08.28.01.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 01:48:04 -0700 (PDT)
Subject: Re: [PATCH 4/5] misc: fastrpc: fix double refcounting on dmabuf
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
 <20190823100622.3892-5-srinivas.kandagatla@linaro.org>
 <CAC8LzUAnz+RZYh+bBbJbXJYP3QDq4H1847W8rJxj-aF1B1J9QQ@mail.gmail.com>
 <cb003c11-d331-a2c7-1eb4-a89ba025f4c6@linaro.org>
 <d545f7fc-fc97-c250-b9d2-ebfbc9709780@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6a34823b-4a1d-c7de-a4c7-87587705708b@linaro.org>
Date:   Wed, 28 Aug 2019 09:48:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d545f7fc-fc97-c250-b9d2-ebfbc9709780@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/2019 08:50, Jorge Ramirez wrote:
> On 8/27/19 23:45, Srinivas Kandagatla wrote:
>> On 23/08/2019 16:23, Jorge Ramirez-Ortiz wrote:
>>> can you add me as a co-author to this patch please?
>> No problem I can do that if you feel so!
> yes please. thanks!
> 
>>> since I spent about a day doing the analysis, sent you  a fix that
>>> maintained the API used by the library and explained you how to
>>> reproduce the issue I think it is just fair. > the  fact that the api
>>> could be be modified and the fix be done a bit
>>> differently- free dma buf ioctl removed- seems just a minor
>>> implementation detail to me.
>> No, that's not true, this is a clear fastrpc design issue.
> IMO the ioctls defines the contract with userspace and the contract
> establishes that userspace must call deallocate. the kernel wrongly
> implemented to that contract since it doesn't handle the cases where
> userspace can't send the release calls which leads to memory leaks. this
> is what I meant by and implementation issue.
> 
> if we had many fastrpc users, rolling out the design change that you
> propose - removing an ioctl- would definitively have an impact. But
> since that is not yet the case, there is not doubt that your patch makes
> more sense.

Exactly before it make a way into other projects!

> 
> but my point was that there is not a huge gap in efforts between doing
> one or the other.

Thats not the point, point is about right fix!

> 
>> Userspace is already doing a refcount via mmap/unmap on that dmabuf fd,
>> having an additional api adds another level of refcount which is totally
>> redundant and is the root cause for this leak.
> yes it is redundant but is not the root cause for this leak. the root
> cause is that the driver doesnt handle the case where userspace didnt or
> was not able to call release (and that is no more than adding allocated
> buffers to a list and clean on exit)

I don't agree with you on that. We should not take an extra refcount in 
first place in driver.

let me explain it one more time!

dmabuf has to be mmaped in userspace app before it is used, and
"Memory mappings that were created in the process shall be unmapped 
before the process is destroyed" so the refcount is taken care by 
mmap/unmap automatically.

--srini


> 
