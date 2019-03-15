Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8F218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCOWpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:45:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35374 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfCOWpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:45:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so11967259qte.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1desbg+ukI+naaiM7ELhS+Ow/DETnl1YLN2CWTkNo5s=;
        b=S6qxBVhAOl23KIASoOulbTLGSW/7nN5M7Rv+rSHmnsvaLPDEnSX2F2ymHIx0ivNrQG
         daR0lR4lPIoOTpRYnIpIZQkoCMTosD9uQOColjz9imSJIUKvKzhO9l9/IEcfw8ja05Dy
         cFsPQrGrzlJUQro4wWoNT8JhDcnRkkY5ZV9JIqR46pJ3nNIAdKYZGFEFQyn7HUbil3R+
         CIonp4/iIeLaxjJqp8S2J8mXNYNtj8XMwzMdBvpvZLvCO+cB0zN/NDnob1k9kZjUZDO3
         W9JIcwhNBbjaD19Cs6M4xJsb9NiuvoU9s0dE5cBRV6CL9TEU9t2hOeHVqxqmtGh2SWHu
         fKJA==
X-Gm-Message-State: APjAAAU/46VyVGudEpoDIFNrZ/fXu9IweJAwebolCmuPsMJo3GGWJtXk
        8CCUHB5+DFo4WeljPkr0auuTcA==
X-Google-Smtp-Source: APXvYqyWHwjqnzbh4RT4CkpuGFGxNr62/ff4XDh7w06noUhhu+uGdvOAZJJ4U507MwjclkxS+VrQGw==
X-Received: by 2002:aed:3622:: with SMTP id e31mr2905494qtb.97.1552689900543;
        Fri, 15 Mar 2019 15:45:00 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id g123sm5302956qkg.0.2019.03.15.15.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 15:44:59 -0700 (PDT)
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
 <CALAqxLXho_rwsdAY9u3=oTXukQnTzqfP_EFmwgdZm+A1bQRVuw@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <86b9ef2e-99f7-ad8c-dbfc-418c1538a0a8@redhat.com>
Date:   Fri, 15 Mar 2019 15:44:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLXho_rwsdAY9u3=oTXukQnTzqfP_EFmwgdZm+A1bQRVuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 2:29 PM, John Stultz wrote:
> On Fri, Mar 15, 2019 at 1:18 PM Laura Abbott <labbott@redhat.com> wrote:
>>
>> On 3/5/19 12:54 PM, John Stultz wrote:
>>> +DMA-BUF HEAPS FRAMEWORK
>>> +M:   Laura Abbott<labbott@redhat.com>
>>> +R:   Liam Mark<lmark@codeaurora.org>
>>> +R:   Brian Starkey<Brian.Starkey@arm.com>
>>> +R:   "Andrew F. Davis"<afd@ti.com>
>>> +R:   John Stultz<john.stultz@linaro.org>
>>> +S:   Maintained
>>> +L:   linux-media@vger.kernel.org
>>> +L:   dri-devel@lists.freedesktop.org
>>> +L:   linaro-mm-sig@lists.linaro.org  (moderated for non-subscribers)
>>> +F:   include/uapi/linux/dma-heap.h
>>> +F:   include/linux/dma-heap.h
>>> +F:   drivers/dma-buf/dma-heap.c
>>> +F:   drivers/dma-buf/heaps/*
>>> +T:   git git://anongit.freedesktop.org/drm/drm-misc
>>
>> So I talked about this with Sumit privately but I think
>> it might make sense to have me step down as maintainer when
>> this goes out of staging. I mostly worked on Ion at my
>> previous position and anything I do now is mostly a side
>> project. I still want to see it succeed which is why I
>> took on the maintainer role but I don't want to become blocking
>> for people who have a stronger vision about where this needs
>> to go (see also, I'm not working with this on a daily basis).
>>
>> If you just want someone to help review or take patches
>> to be pulled, I'm happy to do so but I'd hate to become
>> the bottleneck on getting things done for people who
>> are attempting to do real work.
> 
> I worry this will make everyone to touch the side of their nose and
> yell "NOT IT!" :)
> 
> First of all, thank you so much for your efforts maintaining ION along
> with your attempts to drag out requirements from interested parties
> and the numerous attempts to get collaborative discussion going at
> countless conferences! Your persistence and continual nudging in the
> face of apathetic private users of the code probably cannot be
> appreciated enough!
> 
> Your past practical experience with ION and active work with the
> upstream community made you a stand out pick for this, but I
> understand not wanting to be eternally stuck with a maintainership if
> your not active in the area.  I'm happy to volunteer as a neutral
> party, but I worry my limited experience with some of the more
> complicated usage would make my opinions less informed then they
> probably need to be.  Further, as a neutral party, Sumit would
> probably be a better pick since he's already maintaining the dmabuf
> core.
> 

Honestly if you're doing the work to re-write everything, I
think you're more than qualified to be the maintainer. I
would also support Sumit as well.

> So I'd nominate Andrew, Liam or Benjamin (or all three?) as they all
> have more practical experience enabling past ION heaps on real devices
> and have demonstrated active interest in working in the community.
> 

I do think this would benefit both from multiple maintainers and
from maintainers who are actively using the framework. Like I
said, I can still be a maintainer but I think having some comaintainers
would be very helpful (and I'd support any of the names you've
suggested)

> So, in other words... NOT IT! :)

I think you have to shout "Noes goes" first. :)

> -john
> 

Thanks,
Laura

P.S. For the benefit of anyone who's confused,
https://en.wikipedia.org/wiki/Nose_goes
