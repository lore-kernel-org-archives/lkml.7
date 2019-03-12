Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F48BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22EB214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552381403;
	bh=v248JJMXJY6wLM5dwWANT8G5TwfcN5HpJeh9FcXefxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wnjmqE0x0VeMuwSSNsV+b+RJlx4FfQEpx/zQ3Hdb77T6ys/To5Yxq+d7D11Cb1Gl+
	 UPnixlf3ia87XjStAbxxovHdbAoBToiWbN1c3rCHD7zlxFNb/8px4G/NVjkQ6CstWB
	 dnM2f01OCoM3gMckxaPBzgRMA+onXWgDKcGTLYD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCLJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:03:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37512 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfCLJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:03:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so1803044otp.4;
        Tue, 12 Mar 2019 02:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwOUZMiUpH3pxZ5BHg87iltRm9+5vY4QtYyme1y0Bk0=;
        b=lyumlJgjCr4skfJcLz/kwbbCi8iehcLr20eV0H0BhyEFXP7VAgdWXFTSnkZB1BLuCw
         W5nawVtEOrC/i+NTHBN6sMsaf8F1uhvt53uWHgybYIV7V720K7mof9buOUPOnmGnbmS0
         NiNX6vtvA1QWJO3uoSmieyhB4DU9rTQe5YoqMruY6f8oeXsidaTEycIQ5KFUZqUExaOg
         daqt724BkDu/zNpoT3rVgaSysXNRYr9lRSk4K27e88sVwhU0Yz0E/LEKJ9yGLH5OovPo
         +QS5cPn+0sGhi3VOgv/cUJ+aeti48ZdpD2/6+Lu+tQD+gB+agBgdrcIk3vVH18mNp35t
         Y1kw==
X-Gm-Message-State: APjAAAUy6++DFtTCqJhb4KfAy+hPFo4wG0GjlB6TcRK1OAfLeNkXkunB
        OwLMUEy2Nd5/QhhA22IOE6N6h05ixpRhAtNMRNk=
X-Google-Smtp-Source: APXvYqzJeZs875D/zWJOzKjCrbzLP8uBtEYAW4EIYoJlcMJ3fOlkBuygsFwyqmai26vzOKei3vfsOBxYkv4W5YAj6kY=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr22701431otj.119.1552381400598;
 Tue, 12 Mar 2019 02:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan> <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
In-Reply-To: <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Mar 2019 10:03:13 +0100
Message-ID: <CAJZ5v0iP5Gv2i36qUx9NFJ4YjrcsvGiwu0gO7i79L0K2LOQZzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhaosheng Sun <sunzhaosheng@hisilicon.com>,
        jean.xupeng@hisilicon.com, yuwei3@hisilicon.com,
        gengyanping@hisilicon.com, peter.panshilin@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> > On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > > wakeup_source_remove() is the counterpart of wakeup_source_add() helper
> > > and must undo the initializations done by wakeup_source_add(). Currently
> > > the timer is initialized by wakeup_source_add() but removed from
> > > wakeup_source_drop(), which doesn't look logically correct. Also it
> > > should be okay to call wakeup_source_add() right after calling
> > > wakeup_source_remove(), and in that case we may end up calling
> > > timer_setup() for a potentially scheduled timer which is surely
> > > incorrect.
> > >
> > > Move the timer removal part to wakeup_source_remove() instead.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/base/power/wakeup.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index f1fee72ed970..18333962e3da 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -118,7 +118,6 @@ void wakeup_source_drop(struct wakeup_source *ws)
> > >     if (!ws)
> > >             return;
> > >
> > > -   del_timer_sync(&ws->timer);
> > >     __pm_relax(ws);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_drop);
> > > @@ -205,6 +204,8 @@ void wakeup_source_remove(struct wakeup_source *ws)
> > >     list_del_rcu(&ws->entry);
> > >     raw_spin_unlock_irqrestore(&events_lock, flags);
> > >     synchronize_srcu(&wakeup_srcu);
> > > +
> > > +   del_timer_sync(&ws->timer);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_remove);
> > >
> > >
> >
> > I've merged it with the [2/2], rewritten the subject and changelog and
> > queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> > source timer cancellation").
>
> Okay, thanks. We (Android guys) want this to be backported into 4.4+
> kernels via the stable tree. Can we mark this for stable in the commit
> itself ? Else I would be required to send this separately for all the
> kernels. I should have marked it for stable initially though, sorry
> about forgetting then.

Queued up with a CC-stable tag for 4.4 an later, thanks!
