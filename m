Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A4D20835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PApQDIIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCUAlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:41:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43037 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCUAlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:41:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so3112047pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4aI4SJHH602DupFT7MxwaqqPzwrs0NFzgzeDudrc8o=;
        b=PApQDIICAa+wBRbmWw5Ab27dtG7560yO85eHgn+hXJFnOA7A5Fu910792I1d3IRBfz
         vULekoWEsD95Edbq9mCwDWy5nM8o1dltAWjpwqh3zMRyWdfN2GwRuXVIGMIvEoY8yJIR
         kcmQNcezqh2lWRgMc6th5iTx9kAMjhck9CjO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4aI4SJHH602DupFT7MxwaqqPzwrs0NFzgzeDudrc8o=;
        b=MBOlPLHE6UfC+EErfT9hEtFPayN4CLyugrktdEek3EWS3QE0GB7Sv8UneYNZlwVVdU
         ztLEtUA/fV7ywQM4iMnM4KsyoZgbq3qfuuQrGQXkPTPK5nZ5bvNkz0qn+2p0joDt/EcT
         K6ImNwfLgFfn1DMx3EUhv9QXGGnytHL45/E9JPVu26mcjozHFd5qwtsZELjGfpPbp2xs
         LYJOivSBHwc01FEEKoaXBVxBflO5swIiyrPmbp4U9zGGlX7/CtkuzPbTeGugPaRVHAn4
         bsGJ3faOJ2nKs5mF3Q566JPedZ3k8yN7uPByVCojhNQJCG4KBF/iQoyhK24mLxaFP+2P
         538A==
X-Gm-Message-State: APjAAAUe70jlOT2GoS2yQYnrWx2xFKxqk2bDLS4FC73Vnm5km0oTRhSq
        Rmzg6P3H1thQX5/KBgij0DIscA6ebU0=
X-Google-Smtp-Source: APXvYqxfMO1Wsy2dO7jcnq7aTQgupUs491bJfGMhGrPK2oKTpWZn8YqQCXrs8mfdB/pvEHt/BgRICQ==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr770684pgh.177.1553128867761;
        Wed, 20 Mar 2019 17:41:07 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o76sm9742155pfa.156.2019.03.20.17.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:41:06 -0700 (PDT)
Subject: Re: [PATCH 5/8] scsi: lpfc: change snprintf to scnprintf for possible
 overflow
To:     Greg KH <greg@kroah.com>
Cc:     Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-5-w@1wt.eu>
 <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
 <de134f7c-7516-cfb4-7cd2-6d96b45bdb48@broadcom.com>
 <20190320173951.GA27003@kroah.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <b97dbda0-9b4d-9e04-1051-db29f5b269e6@broadcom.com>
Date:   Wed, 20 Mar 2019 17:41:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320173951.GA27003@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/2019 10:39 AM, Greg KH wrote:
> On Tue, Jan 15, 2019 at 02:41:17PM -0800, James Smart wrote:
>> On 1/14/2019 5:15 PM, Kees Cook wrote:
>>> On Sat, Jan 12, 2019 at 7:29 AM Willy Tarreau<w@1wt.eu>  wrote:
>>>> From: Silvio Cesare<silvio.cesare@gmail.com>
>>>>
>>>> Change snprintf to scnprintf. There are generally two cases where using
>>>> snprintf causes problems.
>>>>
>>>> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
>>>> In this case, if snprintf would have written more characters than what the
>>>> buffer size (SIZE) is, then size will end up larger than SIZE. In later
>>>> uses of snprintf, SIZE - size will result in a negative number, leading
>>>> to problems. Note that size might already be too large by using
>>>> size = snprintf before the code reaches a case of size += snprintf.
>>>>
>>>> 2) If size is ultimately used as a length parameter for a copy back to user
>>>> space, then it will potentially allow for a buffer overflow and information
>>>> disclosure when size is greater than SIZE. When the size is used to index
>>>> the buffer directly, we can have memory corruption. This also means when
>>>> size = snprintf... is used, it may also cause problems since size may become
>>>> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
>>>> configuration.
>>>>
>>>> The solution to these issues is to use scnprintf which returns the number of
>>>> characters actually written to the buffer, so the size variable will never
>>>> exceed SIZE.
>>>>
>>>> Signed-off-by: Silvio Cesare<silvio.cesare@gmail.com>
>>>> Cc: James Smart<james.smart@broadcom.com>
>>>> Cc: Dick Kennedy<dick.kennedy@broadcom.com>
>>>> Cc: Dan Carpenter<dan.carpenter@oracle.com>
>>>> Cc: Kees Cook<keescook@chromium.org>
>>>> Cc: Will Deacon<will.deacon@arm.com>
>>>> Cc: Greg KH<greg@kroah.com>
>>>> Signed-off-by: Willy Tarreau<w@1wt.eu>
>>> I think this needs Cc: stable.
>>>
>>> Reviewed-by: Kees Cook<keescook@chromium.org>
>>>
>>> -Kees
>>>
>>
>> Reviewed-by:  James Smart <james.smart@broadcom.com>
> What ever happened to this patch?  Did it get dropped somehow?
>
> thanks,
>
> greg k-h

I talked with them and will make sure it's pulled in shortly.

-- james


