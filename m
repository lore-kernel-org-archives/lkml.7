Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E43C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C10218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FY7pzPFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCTU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:27:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45081 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfCTU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:27:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so2709854pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yOP4kBeaoZXWEwRI+mKfBI9bQmDoLp3KE37zQ33rsaY=;
        b=FY7pzPFC6Vjrpd6t0AghbNbXghbdsKwH/U8vRM+uXfOGDKFtgxy73/VLqGmGWzCh2F
         rKuMFp8RanWp2n8qnnaQJaJoO4kG/BiM3Q6m+K1luTd0TriPU6SseefIUIXKe+CvLVKV
         ilyV5rZj0BEyNItn8UHQjLXokCfzTzS63A+lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yOP4kBeaoZXWEwRI+mKfBI9bQmDoLp3KE37zQ33rsaY=;
        b=HTe4ffFrXfRK/pOPkKi4x+ECJV+SvZvQv6XMPbLBzVgnH00i3XdhI+nGtemUNQzo5B
         5uwn47tUxO+yifM8xUZuoEPVwWk846G6grYcWJ5AYNPYsERCtY13wr45CPMo61tAGefv
         W0Byf4rwFbbKS1hDBbNTpVFtJfZwCKEBXYPDl+wNkmlatJzga1d9ZJrMWwrzQGsjGIoM
         Q2a50oVF1ltXqYIjJQnajQ26wzmvQuWvwxpuu6ZQJtbmHw9i98DTXjTN2Qb3An+ntSBZ
         NwpEKl1ESOKYwJ6nc6xvnIHT/RIxUTO8CYJ/jEcwpn399lZLBIz+DPGfn/0rWcrPPPvb
         wRWw==
X-Gm-Message-State: APjAAAV8MgnxWpaRrRouvDeEnWFDljWXq9LmKPZ0mYE3chG+kHP6Bujh
        N/LZxpQ3C97h50a91YlxqCvm7A==
X-Google-Smtp-Source: APXvYqxgTdLrLDkLttVWWjBMy36+1YTt8b82Zf0CxunSVjEZM1Hl9Mh1xE6Mh5I1a6EsSljzR3ytHQ==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr10088065pla.259.1553113625143;
        Wed, 20 Mar 2019 13:27:05 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e14sm399317pgv.68.2019.03.20.13.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:27:04 -0700 (PDT)
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
Message-ID: <d23fb974-2486-a138-4aae-3575f730c4fd@broadcom.com>
Date:   Wed, 20 Mar 2019 13:27:02 -0700
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

I assume it wasn't pulled in by the scsi maintainers. I'll go ping them.

-- james

