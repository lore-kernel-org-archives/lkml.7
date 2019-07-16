Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93493C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594232187F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGbWKLlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfGPXuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:50:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39160 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfGPXuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:50:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so17049246oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrOQbwIEDkgvkVyECfpypyWkqBx3WCpbfMK+8xl2Gzk=;
        b=EGbWKLlN+cMaSvBUa2bq8KWbW/C3fnMJjXLbuqaz9ESXyExLPWEGEaMjNmb8iJI7xp
         TN9wggba2mplk8yhan28BPAPOD5UzOnu6/0u1YG/KS1PRpKdERM7cxnTs1y9c1AKa/rL
         13QTzMEro2yqHCFPfZqNDG2g/Zy/4uWNzTW+tgAoOqPbSP+0x8CDcLKTo3r/F2yFxbnO
         z1FA/n0ARp752ceEEZhTeMw6pb/zIQUC6GGjjf/KGuJQfOaMaUs8E6ieO7ZTwVy6o8f+
         jxhfDViNT5t/7WxWdSbH6ILKTm0ieeXlgbNWN5dMcaRDsFc0ALZcbrNdukp9geMzmf2s
         Ae0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrOQbwIEDkgvkVyECfpypyWkqBx3WCpbfMK+8xl2Gzk=;
        b=XprYtNHzeg3F3iiAizfajXsTy2fHHB9NFZs4mWeSBO1ie/e0/gkunxPupQcmAat5gn
         HlgSNJ+yotoQehnFzszoZqImGRJZF6mbiNCa7bHxUqUScKHtRQKBZxv1omgVl3twQKQw
         1KqVKygTOW69EEPT45ZYQ93p9r/vJPppbvkFAZ8FYwslYVqlayyR9wdQNjv9tzKG/row
         jP5C6REjj6wvov3TA4jXEA8LE9sOaEZgOJjEHPp9981UewSLkwiDK2mDlOgsJCvX+w+v
         yugQp/Q/gg1ZXF8E6Cshm4wcHyvsah9YI+XzGGbmAaSutvXotkBT0J+n4oSKiYRy9q2l
         N2aQ==
X-Gm-Message-State: APjAAAXXqTifZZQDzWjanONjv+Xlm9unD54ZKvu3MoL9TqplE7PrnNZb
        H+0YD4Cp1eZdv6do0ZbqANTtvf+ybhbNy+YlTJeDuQ==
X-Google-Smtp-Source: APXvYqwqSbihoAT7JgLCn1l4OQtvLlj1lXunKE9A+7+iAAW+BbCd+mmEMK6dQtBktcW6pbvU1KEMoi/1qwXg80cn90I=
X-Received: by 2002:aca:5106:: with SMTP id f6mr18882723oib.69.1563321014577;
 Tue, 16 Jul 2019 16:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-3-saravanak@google.com>
 <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
 <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
 <9e75b3dd-380b-c868-728f-46379e53bc11@gmail.com> <07812739-0e6b-6598-ac58-8e0ea74a3331@gmail.com>
 <CAGETcx8YCCGxgXnByenVUb+q8pHPPTjwAjK3L_+9mwoCe=9SbA@mail.gmail.com>
 <3e340ff1-e842-2521-4344-da62802d472f@gmail.com> <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
In-Reply-To: <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 16:49:38 -0700
Message-ID: <CAGETcx8FN6E3dgUrK6uk0W1g_FBk1wzohjf3W9eeVeRds0zrAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending again due to HTML. Sorry about it, the darn thing keeps
getting turned on for some reason!

On Tue, Jul 16, 2019 at 3:57 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 15, 2019 at 7:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 7/15/19 11:40 AM, Saravana Kannan wrote:
> > > Replying again because the previous email accidentally included HTML.
> > >
> > > Thanks for taking the time to reconsider the wording Frank. Your
> > > intention was clear to me in the first email too.
> > >
> > > A kernel command line option can also completely disable this
> > > functionality easily and cleanly. Can we pick that as an option? I've
> > > an implementation of that in the v5 series I sent out last week.
> >
> > Yes, Rob suggested a command line option for debugging, and I am fine with
> > that.  But even with that, I would like a lot of testing so that we have a
> > chance of finding systems that have trouble with the changes and could
> > potentially be fixed before impacting a large number of users.
>
> Leaving it in -next for more than a cycle will not help. There's some
> number of users who test linux-next. Then there's more that test -rc
> kernels. Then there's more that test final releases and/or stable
> kernels. Probably, the more stable the h/w, the more it tends to be
> latter groups. (I don't get reports of breaking PowerMacs with the
> changes sitting in linux-next.)
>
> My main worry about this being off by default is it won't get tested.
> I'm not sure there's enough interest to drive folks to turn it on and
> test. Maybe it needs to be on until we see breakage.

Android will start using this. So there's definitely going to be a lot
of motivation for people to start using this and testing this.

I'm also thinking we should start rejecting late_initcall_sync() level
clean up code in device drivers in the future and start asking them to
move to sync_state(). If this feature isn't turned on, the behavior
will default to a late_initcall_sync() level execution. But when this
is on, it'll actually work nicely with modules. So that's another way
to drive folks to it and improve things over time.

Maybe we can have this on by default in linux-next and -rc. Fix any
issues that show up and can be fixed without breaking the goal of this
series (make things work with modules). And finally turn it off by
default before it gets pulled into mainline? That way, we get the
maximum test coverage we can get, but not accidentally break anything
that wasn't tested?

Thanks,
Saravana
