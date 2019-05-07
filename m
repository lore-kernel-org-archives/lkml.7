Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7472121479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfEGIMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:12:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42420 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfEGIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:12:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id f23so14042078otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQ6dv2i93HZ0YYfKZpbV9MkWY21B58FCrXMAN8Dpx2E=;
        b=dZIlEjfY4liPM3W2qTMdmD+JxskOfa9Bul07lgqcCrnp45rYhbjJ6QWCFBgD08ai4a
         JtbbnHwz4yZ8jQV7Eb+Ryc94rylxIInI1RoCR2xyKGMS35F5CnSsiNv9oO+zVBwBpf4t
         ELFgHhxyYHttctizB6mPVsGOCLkElyEAvStY+vtmO37BDBV1+v66gPnXzahl8fyxGxLr
         +exUYA/p/NswjW9QCqqZyjKcigYRS0OiZYDNiqNLgkOhAeFKegZmw1E/veMTzHSsenjl
         XskfmfkwldNk7N3TijO/N7Fv+V+VjmLyIEZDvzYnxbJwM9oR+i4nmyfSA/fXbU9MAjUx
         TS9w==
X-Gm-Message-State: APjAAAUTZigACLwZoLg1Tj8yOStVCqbo7B+24J+MM1uJcHB2DhHv8ISI
        wVeDtD2ksLlr+12vDh8aYwI=
X-Google-Smtp-Source: APXvYqxazZcvVgW8B8Abx61RE3d6GpWO8pSjTz4Bl2xHSbS/zPSIG/vaJXjunEVO9ubN+ITWd3WpFw==
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr3196049otp.151.1557216760884;
        Tue, 07 May 2019 01:12:40 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id k60sm5643992otc.42.2019.05.07.01.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:12:40 -0700 (PDT)
Date:   Tue, 7 May 2019 01:12:36 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507081236.GA1531@sultan-box.localdomain>
References: <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507074334.GB26478@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:43:34AM +0200, Greg Kroah-Hartman wrote:
> Given that any "new" android device that gets shipped "soon" should be
> using 4.9.y or newer, is this a real issue?

It's certainly a real issue for those who can't buy brand new Android devices
without software bugs every six months :)

> And if it is, I'm sure that asking for those patches to be backported to
> 4.4.y would be just fine, have you asked?
>
> Note that I know of Android Go devices, running 3.18.y kernels, do NOT
> use the in-kernel memory killer, but instead use the userspace solution
> today.  So trying to get another in-kernel memory killer solution added
> anywhere seems quite odd.

It's even more odd that although a userspace solution is touted as the proper
way to go on LKML, almost no Android OEMs are using it, and even in that commit
I linked in the previous message, Google made a rather large set of
modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
What's going on?

Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845. If PSI were
backported to 4.4, or even 3.18, would it really be used? I don't really
understand the aversion to an in-kernel memory killer on LKML despite the rest
of the industry's attraction to it. Perhaps there's some inherently great cost
in using the userspace solution that I'm unaware of?

Regardless, even if PSI were backported, a full-fledged LMKD using it has yet to
be made, so it wouldn't be of much use now.

Thanks,
Sultan

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/configs/sdm845_defconfig?h=LA.UM.7.3.r1-07400-sdm845.0#n492
