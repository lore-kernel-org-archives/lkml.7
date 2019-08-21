Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B508622D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6I8yJx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHUQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:39:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46290 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHUQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:39:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so1602563plz.13;
        Wed, 21 Aug 2019 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JZz/nKJ1cJgQ4UieOexo+ZC6Ak4tiKQMyw5MEe0fvdc=;
        b=T6I8yJx6Ol98caKaIAK43tRitnI5lMhslocmESeYjtEgWaIz4oTvloNAssYOyKMYYq
         ckrGFxXooK39YM2uBUtS9p7FtzwYvGg0Q0bVSgwPW2FH1NYq2bgGfem2MmK7NsKjeHUU
         UL/ax2yCTVNCnSXuGd1e7YToLx6v9q0P12cEwBYCEl64gwgvtlvR1+qJKZ3igLAbrhJP
         syv6HjEB9esrvkB0GI5jCxKtCwNOyCJCn1t6dguZCfxp+aStN2wsMdoo4hHdvgeegKFG
         0SVIekvRJMdt6DNtWO+jkRIv7E2gJCD0LcBBkSqz8IopShLtR38B0kVlgZnCOzXiOuD3
         MvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZz/nKJ1cJgQ4UieOexo+ZC6Ak4tiKQMyw5MEe0fvdc=;
        b=bDKNqK8GfD1iuQs5AWGBwX6nsJMC6su4l3SDS5gO2RegF6SWYfDMOwoEFarQpNz3bj
         09ExqWTjiOzi+Ho8hUdKTOh8UJYrvmFZv3Zvr7+5AHPevH9WVAO2LsoxqFkRSvf9oe9t
         eDtygxkyIJeyAVedYrn4+jIDZlv8GO8bAl/qsDHvwlm+5Jy/Sd84bXoTXqaEBNtcG+oC
         S3wPijmIte6k50NSpHzElTtwcE9vLgEzhb4R/MDGcR9bpRpbfhw3IA+vPFflse1EuYa7
         uPZmNk4kooRQzEpRqmjGbnU5873PfSEVtDqhYcZcVzbdkImfDbnBUoQWtPH1bgj99aIi
         SDXw==
X-Gm-Message-State: APjAAAUEK/MWP2fcYLXD1JZeBFvSSpUNKAHychPPZqavB6jsRe/KQ77d
        PfBH6dRTB+y7/Ccvk0p6I/0=
X-Google-Smtp-Source: APXvYqziKRUcRBP7nEElJtM5f5gF1qT0vWwx+4WrLduJb/cf4W7woU9T9ThcHFROzOpv0Ia8+R8zww==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10mr4975086plt.264.1566405555151;
        Wed, 21 Aug 2019 09:39:15 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-176-042.mycingular.net. [166.137.176.42])
        by smtp.gmail.com with ESMTPSA id q10sm29424466pfl.8.2019.08.21.09.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:39:14 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
 <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
 <19c99a6e-51c3-68d7-d1d6-640aae754c14@gmail.com>
 <CAGETcx-XcXZq7YFHsFdzBDniQku9cxFUJL_vBoEKKhCH+cDKRw@mail.gmail.com>
 <74931824-f8a1-0435-e00a-5b5cdbe8a8a2@gmail.com>
 <CAGETcx8UHA9kNkjjnBXcf_OYXaaPO9ky60M01Cfz3NFb1c1FZw@mail.gmail.com>
 <15ab4fb0-7e69-9cc1-4a79-cff06767f7d9@gmail.com>
 <CAGETcx-F7VoQsDihvJ1FY=Pw8Rhu69zh6pBzkV4nSabwYRvbZw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <983bb329-7bb4-7401-a9f1-2b8dfe87c1b7@gmail.com>
Date:   Wed, 21 Aug 2019 09:39:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-F7VoQsDihvJ1FY=Pw8Rhu69zh6pBzkV4nSabwYRvbZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 3:09 PM, Saravana Kannan wrote:
> On Mon, Aug 19, 2019 at 9:26 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>


< snip - the stuff I snipped deserves reply, but I want to focus on just
  one topic for this reply >

>> You have a real bug.  I have told you how to fix the real bug.  And you
>> have ignored my suggestion.  (To be honest, I do not know for sure that
>> my suggestion is feasible, but on the surface it appears to be.)
> 
> I'd actually say that your proposal is what's trying to paper over a
> generic problem by saying it's specific to one or a few set of
> resources. And it looks feasible to you because you haven't dove deep
> into this issue.

Not saying it is specific to one or a few sets of resources.  The
proposal suggests handling every single consumer supplier relationship
for which the bootloader has enabled a supplier resource via an
explicit message communicating the enabled resources.  And directly
handling those exact resources.

Think about the definition of "paper over" vs "directly address".


> 
>> Again,
>> my suggestion is to have the boot loader pass information to the kernel
>> (via a chosen property) telling the kernel which devices the bootloader
>> has enabled power to.  The power subsystem would use that information
>> early in boot to do a "get" on the power supplier (I am not using precise
>> power subsystem terminology, but it should be obvious what I mean).
>> The consumer device driver would also have to be aware of the information
>> passed via the chosen property because the power subsystem has done the
>> "get" on the consumer devices behalf (exactly how the consumer gets
>> that information is an implementation detail).  This approach is
>> more direct, less subtle, less fragile.
> 
> I'll have to disagree on your claim. You are adding unnecessary
> bootloader dependency when the kernel is completely capable of
> handling this on its own. You are requiring explicit "gets" by
> suppliers and then hoping all the consumers do the corresponding
> "puts" to balance it out. Somehow the consumers need to know which
> suppliers have parsed which bootloader input. And it's barely
> scratching the surface of the problem.

OK, let me flesh out a possible implementation just a little bit.

This is focused on devicetree, as is your patch series.  For ACPI
a parallel implementation would exist.

The bootloader chosen property could be a list of tuples, each tuple
containing: consumer phandle, supplier phandle.  Each tuple could
contain more data if the implementation demands, but I'm trying to
keep it simple to illustrate the concept.

In early-ish boot a core function processes the chosen property.  For
each consumer / supplier pair, the supplier compatible could be used
to determine the supplier type.  (This might not be enough info to
determine the supplier type - maybe the consumer property that points
to the supplier will also have to be specified in the chosen property
tuple, or maybe a supplier type could be added to the tuple.)  Given
the consumer, supplier, and resource type the appropriate "get"
would be done.

Late in boot, and possible repeated after modules are loaded, a core
function would scan the chosen property tuples, and for each
consumer / supplier pair, if both the consumer and the supplier
drivers are bound, it would be ASSUMED that it is ok to do the
appropriate type of "put", and the "put" would be done.


> 
> You are assuming this has to do with just power when it can be clocks,
> interconnects, etc. Why solve this repeated for each framework when
> you can have a generic solution?

No such assumption.


> 
> Also, while I understand what you mean by "get" it's not going to be
> as simple as a reference count to keep the resource on. In reality
> you'll need more complex handling. For example, having to keep a
> voltage rail at or above X mV because one consumer might fail if the
> voltage is < X mV. Or making sure a clock never goes about the
> bootloader set frequency before all the consumer drivers are probed to
> avoid overclocking one of the consumers. Trying to have this
> explicitly coordinated across multiple drivers would be a nightmare.
> It gets even more complicated with interconnects.
> 
> With my patch series, the consumers don't need to do anything. They
> just probe as usual. The suppliers don't need to track or coordinate
> with any consumers. For example, regulator suppliers just need to keep
> the voltage rail at (or above) the level that the boot loader left it
> on at and then apply the aggregated requests from their APIs once they
> get the sync_state() callback. And it actually works -- tested for
> regulators and clocks (and maybe even interconnects -- I forgot) in a
> device I have.
> 

And same for the possible implementation I sketched above.  The equivalent
of the sync_state() callback would be done by the end of boot (potentially
repeated after each module loads) core function making a similar call.
Hand waving here about what suppliers to call.

Of course this is not the only way to implement my concept, just an
example to suggest that it might be feasible and it might work.

< snip >

-Frank
