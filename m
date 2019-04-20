Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FBC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB12087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0uuyA21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfDTTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:15:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33097 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDTTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:15:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so3929426pfo.0;
        Sat, 20 Apr 2019 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8AIIRIPpzop0M1IZdRpuE/bg4L2ja6RBvaY2qx/78c=;
        b=A0uuyA21OfkO2ZGK5ggHD6tlER667XJah0d8JxvWE7Lo8QaLil18L/9v/F8M3D8kHd
         oD8Hau7BRg0nSSuPK/rXfkwFfuqOH+HzA2PbEPqfNpFOyeZ8Ttic+KbhWJ87airLQHI3
         x8FCv9/I12xUvtVRCyBbF8YojILZlCCKNUudB7g8rmEG50hKXcB4i4Y4NJD5jlB/1+cD
         LyXhVoZSZSOZt7kydegwznjyfWaK2O+QU4qhtfHVA6IcLvCyPazNp6rAw0HohwaOnmh3
         k2qpH+f37vlrdCYZag+FtjWEU8YXknOJbMgenPR4JR+jI2czVjIUx7vjhwG9fWdU1B7B
         kMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8AIIRIPpzop0M1IZdRpuE/bg4L2ja6RBvaY2qx/78c=;
        b=GGMifQIOfYKwFkYib16RU+RKJUPdBqpMAUZ/U4lC/ULFfFKUEbo9zsduBESjyNXmvt
         z5xSkkLRd9TWVE9wcNjWdJGUiPd5bvr8tTXTSb8akwmr9c7uNz+6Oq1SG96D1kTzXwgH
         viIBGICgNzZAX/R8fyNY+Pvq8PahMLGxAxLM9DNyGZmTPc3VwZZQrBGDWCLNpqvKS/Mw
         QWYpeFYHA/uhO7GlJ5c7jSa70eBr6cWJMxuizvIwSKeSQCOeyQZsYSjCwmKchoOnIgtd
         CHNj5BIgrXPnkwCF+dAMnt2nf0tapxjxs7faUuf1ayjMgX415MFZAWVPil2MKs20Zb5Y
         vIFw==
X-Gm-Message-State: APjAAAUWJf10xq9HkwzFKQh+aQ8P6vMcQj0oGUjVkdvQsi2dZyb0ASNp
        Z+bEFHR42N3cVJz8Fn8PdPhBrLBHUkuRuas8yM9R0Q==
X-Google-Smtp-Source: APXvYqwOSfDkfoQ3q7E3HVEWwD+BhRjrAHk48ysSlFGOY+9ae9ZiGsDnU940MsVJQDjf1S9LhgZZbD6DmEn6tAIRV9Y=
X-Received: by 2002:aa7:8092:: with SMTP id v18mr11136551pff.35.1555787737945;
 Sat, 20 Apr 2019 12:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
 <20190416214634.GP31772@zn.tnic> <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
 <20190420113444.GC29704@zn.tnic> <CAM_iQpXKWDr4AbROO=ZbkxwQHkj4anA9FJAaohOqg1SCq0L7eg@mail.gmail.com>
 <20190420190442.GF29704@zn.tnic>
In-Reply-To: <20190420190442.GF29704@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Apr 2019 12:15:26 -0700
Message-ID: <CAM_iQpWedOfJLSG1zzaEqRY05GO2jnODWT8mQVAiWSsk3umQUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:04 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Apr 20, 2019 at 11:25:43AM -0700, Cong Wang wrote:
> > If you want to go that far, you can choose to use lib/bsearch.c too in
> > case you want to reinvent the wheel.
>
> Well, that doesn't give me the @to functionality which points to the
> slot where the new element should be inserted, when the search was
> unsuccessful.

No one stops you from adding it, as you are going far you can always
go further. :)


>
> > What's your point here?
>
> My point is to fix it properly. Obviously.

Of course, no one can stop you from rewriting the whole ras code by
doing it properly.


>
> > You know my fix is targeted for -stable,
>
> Well, first you sent me this:
>
> https://lkml.kernel.org/r/20190416012001.5338-1-xiyou.wangcong@gmail.com
>
> then this:
>
> https://lkml.kernel.org/r/20190416213351.28999-1-xiyou.wangcong@gmail.com


Yes, one is V1 and the other is V2. Is it hard to understand V2 is to replace
V1?


>
> Tony liked this second version more and if you look at the final result of mine:


Sorry, I have no reason to look into a 83-line change.


> it has basically *both*: the correct [min:max] range *and* the return of
> ithe ndex when found. But the algorithm this time is the correct one.

I don't review it, so I don't know. Feel free to believe you are correct here,
until someone finds a bug later.


>
> > I doubt your 83-line change could fit for -stable.
>
> My 83-line change has debug output only for experimentation. It will,
> *of* *course* be removed before committing it upstream. That's why I
> called it "a conglomerate patch" and I said "It has some debug output
> for easier debugging, that will be removed in the final version, of
> course." I guess you didn't read that either.

Why should I read a debugging patch?


>
> And the sanity_check() piece will be a separate patch, of course.
>
> In the end the diffstat will be 30-40 lines max.
>
> > Feel free to drop my patch to favor yours. I am really tired.
>
> Suit yourself. Thanks for the reporting.

There is no bug here, your code is perfect. :) Sorry for wasting
your time to believe this it is bug, it is not. :-)

Thanks.
