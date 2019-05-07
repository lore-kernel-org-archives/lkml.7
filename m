Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A2C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1057720989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eohhKp0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEGUCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:02:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37034 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEGUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:02:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so13893185wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gb9u8BwK6K2VHZrF75n3DXs/h9sjtM0WB9yfdMMjAhA=;
        b=eohhKp0uJ59T4vEbRM8AblhUOv5qTWeRAMn2c9ZZJbtbBZV39LMSdRmpjRZV012Tjk
         aQlKi86yUbKUQXNoAdPT7NP58zePSKmLAzMBVVPMJYSFAUVsRkBAanek3lVReA7NaMU2
         4hse+dLfBHZKk8lAb9E9N6aU1/TXBtwhPWPLLtHxpSnS+UaUapsKrN36Kp1i0/kIQZfo
         HVo2YxHWes539ea/pnrbW5nfLgZ4wpDXlX2mpUoIMAxbGkXnEIK/za1dC5fgNbsTm6zj
         NcPTwCKtweysI+H59YIFlYEQf8sREG19TYikWeSZCBllOYodPE7GHzOjREW0aovRq4Ks
         9YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gb9u8BwK6K2VHZrF75n3DXs/h9sjtM0WB9yfdMMjAhA=;
        b=V/QwfxcEPeTWSoH45rysmXjDXwXQei487Fnc9W7C88ybkDjaD1LcidagBAp980FJAq
         tpp9izV/xW2psmKaZBuGYSNAjsU+PZTDKHDGFoeSpJRkgpiJvOFwXK42dhA25+jZv3lt
         xSZQUHeeW7uai0CL+kbHsccEfiOPDIj/D1aPbvbFPYk7ZwDoCNTTQx/IMKEJWjFL4eKT
         /qdIGvjFbGSizhEpvqzWbMRy4uXxtxLPe10NyszRNF4ZYmw2hfy3nDwU3gED1Ds9UUAp
         ZL/FHEf2o1eKlVrbP/yrn70ucNqtwfFL2IDMMYwMuRZSeCKKURFRSHtaYWAwTdYP6l46
         R1EQ==
X-Gm-Message-State: APjAAAXzJcSOflKJbtWpbiXzU+EvknObaA1tnrvLxzUbVN5SrOm7pv49
        G5OADejEBL6P5ZJqm8OlCXkvUSsRJVlKwkXTv9zqLw==
X-Google-Smtp-Source: APXvYqxs+eKVLDUCD7g1rHPBXhFirmnfKqD64Voz1LQgEtV71NQil14wxCREeOhs+iddBtqX9ipfLYX5xoI8j2bfFO4=
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr8881043wrp.320.1557259329560;
 Tue, 07 May 2019 13:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain> <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain> <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain> <20190507105826.oi6vah6x5brt257h@brauner.io>
 <CAJuCfpFeOVzDUq5O_cVgVGjonWDWjVVR192On6eB5gf==_uPKw@mail.gmail.com> <20190507165344.GA12201@sultan-box.localdomain>
In-Reply-To: <20190507165344.GA12201@sultan-box.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 May 2019 13:01:57 -0700
Message-ID: <CAJuCfpHmfccmT6SwZMqseOQh2SY7+8pXtfE1nppKkiUmayh-ug@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>
Date: Tue, May 7, 2019 at 9:53 AM
To: Suren Baghdasaryan
Cc: Christian Brauner, Greg Kroah-Hartman, open list:ANDROID DRIVERS,
Daniel Colascione, Todd Kjos, Kees Cook, Peter Zijlstra, Martijn
Coenen, LKML, Tim Murray, Michal Hocko, linux-mm, Arve Hj=C3=B8nnev=C3=A5g,=
 Ingo
Molnar, Steven Rostedt, Oleg Nesterov, Joel Fernandes, Andy
Lutomirski, kernel-team

> On Tue, May 07, 2019 at 09:28:47AM -0700, Suren Baghdasaryan wrote:
> > Hi Sultan,
> > Looks like you are posting this patch for devices that do not use
> > userspace LMKD solution due to them using older kernels or due to
> > their vendors sticking to in-kernel solution. If so, I see couple
> > logistical issues with this patch. I don't see it being adopted in
> > upstream kernel 5.x since it re-implements a deprecated mechanism even
> > though vendors still use it. Vendors on the other hand, will not adopt
> > it until you show evidence that it works way better than what
> > lowmemorykilled driver does now. You would have to provide measurable
> > data and explain your tests before they would consider spending time
> > on this.
>
> Yes, this is mostly for the devices already produced that are forced to s=
uffer
> with poor memory management. I can't even convince vendors to fix kernel
> memory leaks, so there's no way I'd be able to convince them of trying th=
is
> patch, especially since it seems like you're having trouble convincing ve=
ndors
> to stop using lowmemorykiller in the first place. And thankfully, convinc=
ing
> vendors isn't my job :)
>
> > On the implementation side I'm not convinced at all that this would
> > work better on all devices and in all circumstances. We had cases when
> > a new mechanism would show very good results until one usecase
> > completely broke it. Bulk killing of processes that you are doing in
> > your patch was a very good example of such a decision which later on
> > we had to rethink. That's why baking these policies into kernel is
> > very problematic. Another problem I see with the implementation that
> > it ties process killing with the reclaim scan depth. It's very similar
> > to how vmpressure works and vmpressure in my experience is very
> > unpredictable.
>
> Could you elaborate a bit on why bulk killing isn't good?

Yes. Several months ago we got reports that LMKD got very aggressive
killing more processes in situations which did not require that many
kills to recover from memory pressure. After investigation we tracked
it to the bulk killing which would kill too many processes during a
memory usage spike. When killing gradually the kills would be avoided,
so we had to get back to a more balanced approach. The conceptual
issue with bulk killing is that you can't cancel it when device
recovers quicker than you expected.

> > > > I linked in the previous message, Google made a rather large set of
> > > > modifications to the supposedly-defunct lowmemorykiller.c not one m=
onth ago.
> > > > What's going on?
> >
> > If you look into that commit, it adds ability to report kill stats. If
> > that was a change in how that driver works it would be rejected.
>
> Fair, though it was quite strange seeing something that was supposedly to=
tally
> abandoned receiving a large chunk of code for reporting stats.
>
> Thanks,
> Sultan
