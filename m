Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2C221849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4uUHgQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfGSCte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:49:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43037 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSCtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:49:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so7892079pld.10;
        Thu, 18 Jul 2019 19:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WorvBG2Kr7pCnEjo5HHl27HkaqxS8UZ7aIqwdxLHP1E=;
        b=X4uUHgQDO+6EIudH3xSCwxzxAOK7xS7gps1kB1Jyohr+MjhyjT7h+oTqVylCld+nqE
         La+BHTGMXHTwYDtg+x/4UGcvZSFtc+FnAH6Ru4zKCbGP+NIyOR+4QUlHqrQ3+fcKlxRz
         MmW3i8v2KLkh8RXRBuzItAXVyLXkOfxVaZ61TV6kIADcsSpA7x2gwBD1t7yznizInMLS
         cuej01dvCS/JyHFznqiko5uat2W6bccg69k/CWlC7O/WGcvF6P7dqih2t6d5MLvfOPkc
         VD8GpNsl3B5Sai1XxVil3xJ2p4AIpCc0nVms/e7abgDzwyeXZAFX80lLx1/6542DztQj
         nbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WorvBG2Kr7pCnEjo5HHl27HkaqxS8UZ7aIqwdxLHP1E=;
        b=LK+dDwTizqBHob5PpcV32wjDzjsx3C46Wqte2x3PL/WN53guZ+wkv/lU6jm+qLUi/m
         qNmZ2z91g50x40ur4zdxO3z9NH0uuHqMam2zloHwKyPdnuu03scZ9o8YF8Zig6g7DfJ9
         7BHrsliPBk0d8XKKIaLSU2TScu6f8fC8grWB4fdKe3EfOgP3v4hzkSZhmilFfR3CLFsm
         SrXVGeZ4+kmtp08G0CJ1p8JBBafhX7Crb7ygJPNrHSieSZajGTl5pSkvoxdIiQ1hiHVH
         xm1EnUAwhU14TcG4BQHhobEqd28NbGiomGGRKncGv9hmhf0QoK/nd5+MfwBMrl7Botaw
         IpAg==
X-Gm-Message-State: APjAAAUQJ/HciaVEDrDRlihYQltMErIGEldOAx3R6EI5ZkzWxhI2lhmc
        ltWblDG3YfyKVSfINopuFrk=
X-Google-Smtp-Source: APXvYqzPUL9hVzAmJ+j1+PMWu7SOQ7AKbgL2zGpJLqV2R19DRjcSBqmwLDHAad80gjHpKwQkZeP4jQ==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr52712692plk.180.1563504572849;
        Thu, 18 Jul 2019 19:49:32 -0700 (PDT)
Received: from [192.168.21.178] (115.42.148.210.bf.2iij.net. [210.148.42.115])
        by smtp.gmail.com with ESMTPSA id i126sm30471863pfb.32.2019.07.18.19.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 19:49:32 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190702004811.136450-1-saravanak@google.com>
 <20190702004811.136450-3-saravanak@google.com>
 <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
 <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
 <9e75b3dd-380b-c868-728f-46379e53bc11@gmail.com>
 <07812739-0e6b-6598-ac58-8e0ea74a3331@gmail.com>
 <CAGETcx8YCCGxgXnByenVUb+q8pHPPTjwAjK3L_+9mwoCe=9SbA@mail.gmail.com>
 <3e340ff1-e842-2521-4344-da62802d472f@gmail.com>
 <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6d501755-7ee3-4c48-f6fc-b1416460ead0@gmail.com>
Date:   Thu, 18 Jul 2019 19:49:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 3:56 PM, Rob Herring wrote:
> On Mon, Jul 15, 2019 at 7:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 7/15/19 11:40 AM, Saravana Kannan wrote:
>>> Replying again because the previous email accidentally included HTML.
>>>
>>> Thanks for taking the time to reconsider the wording Frank. Your
>>> intention was clear to me in the first email too.
>>>
>>> A kernel command line option can also completely disable this
>>> functionality easily and cleanly. Can we pick that as an option? I've
>>> an implementation of that in the v5 series I sent out last week.
>>
>> Yes, Rob suggested a command line option for debugging, and I am fine with
>> that.  But even with that, I would like a lot of testing so that we have a
>> chance of finding systems that have trouble with the changes and could
>> potentially be fixed before impacting a large number of users.
> 
> Leaving it in -next for more than a cycle will not help. There's some

I have to agree with your scepticism of the value of -next for this
specific case.  But I think there is a _tiny_ potential of additional
testing if the feature is in more than one -next cycle.

> number of users who test linux-next. Then there's more that test -rc
> kernels. Then there's more that test final releases and/or stable
> kernels. Probably, the more stable the h/w, the more it tends to be
> latter groups. (I don't get reports of breaking PowerMacs with the
> changes sitting in linux-next.)
> 
> My main worry about this being off by default is it won't get tested.
> I'm not sure there's enough interest to drive folks to turn it on and
> test. Maybe it needs to be on until we see breakage.

Agreed, but worried about the potential disruption when breakage
occurs.

-Frank

> 
> Rob
> .
> 

