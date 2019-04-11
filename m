Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C72C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A970206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0Lx5wbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKTgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:36:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43140 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:36:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id w3so6249880edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jEzlwrGRnqy8YNoygKZ3oMFd6EOHf4c4I1zi7jdUWtE=;
        b=M0Lx5wbIw4PTRl7+WxZuP/FT9pz1O0Lc8X1BQS6lyysAI/zq9NhufsQ89NlArizmrS
         HV3/DVIi+T4V6/YDxeAX8bxjWwaI/5yWjY6dl92TKDw29bQTzLQPK6vMVeF3g1HL+THE
         zqlmsfDsNtT5aTT5cJ9dfpYm8gwYYrEu5/L5ohKo3q8qYiSbFVlzmmcNmexS8hjMEwgh
         MU/YwK+uFgQgYR6EC//3DL2ZgSIsGTwL+G9dFazPbAPe0Z1NcxSpwHolSV5bXg6gngAW
         zQmDg+/sITRxZNtSfxcX0OFS64tcODkVrPbCt4n6FO6kjBRkisw9BTEjRKGo3AxqJQEX
         0bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jEzlwrGRnqy8YNoygKZ3oMFd6EOHf4c4I1zi7jdUWtE=;
        b=AYmDy9XfDhSgue0C3OiRIGYQkDeZn3wTDreSJF31VeDswCV5lnBtAsTAAb3/4ciLVM
         /q/W6X0kMZyYJPi7wxtGjKzbNUgsehqdmlLaK3Hphbmau1jhvTn2jKaVII7HWsti95H0
         Fe99Frm6FVFnHsHGLDv+BCgreLjCfl7r5CAk4OWzUSHf8NKuBcI2STUUzYRzjPbT1eSP
         e/7XjkiHlek+zr3mYwAWL3AcstzbbRKPrldA/Mt4bZv9LbY7t/kDaw39BH1L9Mcqu3Ox
         iI41RPwuBMj1N0Lu82Q7FkIOdbwFPqtr2T0LuRc9AkHRB5NFr6y1RwmMdwTxK/rxGLph
         TQUw==
X-Gm-Message-State: APjAAAWAhi6siEOs3OmESWPnLG8GfInY+vENTH5g1IzmMO1Xdyc4wabQ
        661S7bRA0N9G+3JMgAF3QQk=
X-Google-Smtp-Source: APXvYqzUEQdimdABmYxO3HOQX4vKwXL8SQl87csNDKb88IdkGm+Zqc1MqsOgJmgnYd/jtIMadRoSWQ==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr28609316ejr.101.1555011377573;
        Thu, 11 Apr 2019 12:36:17 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id h11sm5238359eds.44.2019.04.11.12.36.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Apr 2019 12:36:16 -0700 (PDT)
Date:   Thu, 11 Apr 2019 12:36:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190411193614.GA8469@archlinux-i9>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch>
 <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:20:56PM +0200, Daniel Lezcano wrote:
> On 10/04/2019 22:07, Tony Lindgren wrote:
> > Hi,
> > 
> > * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
> >> can you ask for an acked-by before pulling a patch in your tree?
> > 
> > I certainly do ask and wait for acks where possible :)
> 
> Ok, I may have missed them.
> 
> > Note that I have not applied this patch. I just added
> > Keerthy to Cc on this thread so maybe you misread the
> > message earlier. My comment "seems like no other
> > takers" was for Ladislav regarding somebody picking up
> > his earlier work, not for picking up this patch :)
> 
> Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
> above I could have miss your call.
> 
> > In any case, I've been waiting for you guys to pick up
> > the patch, here's my ack if you're waiting for it:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> The patch does not apply. Is it aligned with tip/timers/core ?
> 

The commit this fixes is in timers/urgent and it doesn't look like that
has been backmerged into timers/core.

Nathan

> >> On 04/04/2019 16:17, Tony Lindgren wrote:
> >>> * Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
> >>>> Hello Nathan,
> >>>>
> >>>> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
> >>>>> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
> >>>>> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
> >>>>> static because its prototype was not defined in a header. Unfortunately,
> >>>>> this causes a build warning on multi_v7_defconfig because this function
> >>>>> is not used anywhere in this translation unit:
> >>>>>
> >>>>> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
> >>>>> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
> >>>>>
> >>>>> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
> >>>>> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
> >>>>> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
> >>>>> Make unexported functions static"), which is probably where this should
> >>>>> have happened.
> >>>>
> >>>> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
> >>>> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
> >>>> function being removed here). It is a part of an attempt to add event capture
> >>>> for OMAP. Of course I would like this functionality to be implemented, but
> >>>> as I do not have a time to continue, I cannot really object removing this
> >>>> function.
> >>>>
> >>>> Just in case you'd be interested in finishing this task ;-)
> >>>
> >>> Well seems like no other takers :) We can always find the missing
> >>> function in git history when needed, so I suggest we apply this.
> >>>
> >>> Adding Keerthy to Cc as he just posted a similar patch.
> >>>
> >>> Regards,
> >>>
> >>> Tony
> >>>
> >>
> >>
> >> -- 
> >>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
