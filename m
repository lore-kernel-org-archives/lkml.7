Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32243C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107F920656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfEGQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:53:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33080 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:53:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id m204so7251937oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Les20PwGqp+bpDrgm0vkN1QrGvdMFh2R5hcLIBFlpD8=;
        b=dnSB+XRIjwF/l8UC7pQKw/w4k3p4XRYXQZ/QWDWgDOKaWccHR8UsdzXo8SSnP3GgK1
         haPIu5TbTWBM740z761n0cgE33Fgt1W4eiZhBKOXOIK6uliRWx0tKijSQFavpMBi3dVb
         g4d4jqxqTRec+fAiX32zImRgn/WMsYUFhJCYSgX9xYS/TbieT9lALLPJhqLo0jlT70uH
         EedWoM1e7bCBw1ugQuQ+713vvuKY2cad2z93Q8uEjTcalRx/Vq/f3NxKHkDPpltctJd1
         rVZxxXexoEjQm02WrMCeCDgK3SDE20CHvlhSsFWvMk2Qs2DC6i9giFF299kw+WdUfEgE
         AuVQ==
X-Gm-Message-State: APjAAAVa90i1K34JFXsGEiMyEZhRmVMBYu6x3t5F1G9dMs0oAGlFS4MG
        /4N2tLkMUMPOyJ/6D9SBxHU=
X-Google-Smtp-Source: APXvYqx8sIfbI/Yd4+hyeoP6avx/z10Ghv7vpqK+WFrxVb8S2qStm0EBvzmx8aLW1Yx8GgtwfEUHAw==
X-Received: by 2002:aca:bf07:: with SMTP id p7mr785143oif.140.1557248029127;
        Tue, 07 May 2019 09:53:49 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id e4sm4538586otr.50.2019.05.07.09.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:53:48 -0700 (PDT)
Date:   Tue, 7 May 2019 09:53:44 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507165344.GA12201@sultan-box.localdomain>
References: <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain>
 <20190507105826.oi6vah6x5brt257h@brauner.io>
 <CAJuCfpFeOVzDUq5O_cVgVGjonWDWjVVR192On6eB5gf==_uPKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFeOVzDUq5O_cVgVGjonWDWjVVR192On6eB5gf==_uPKw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:28:47AM -0700, Suren Baghdasaryan wrote:
> Hi Sultan,
> Looks like you are posting this patch for devices that do not use
> userspace LMKD solution due to them using older kernels or due to
> their vendors sticking to in-kernel solution. If so, I see couple
> logistical issues with this patch. I don't see it being adopted in
> upstream kernel 5.x since it re-implements a deprecated mechanism even
> though vendors still use it. Vendors on the other hand, will not adopt
> it until you show evidence that it works way better than what
> lowmemorykilled driver does now. You would have to provide measurable
> data and explain your tests before they would consider spending time
> on this.

Yes, this is mostly for the devices already produced that are forced to suffer
with poor memory management. I can't even convince vendors to fix kernel
memory leaks, so there's no way I'd be able to convince them of trying this
patch, especially since it seems like you're having trouble convincing vendors
to stop using lowmemorykiller in the first place. And thankfully, convincing
vendors isn't my job :)

> On the implementation side I'm not convinced at all that this would
> work better on all devices and in all circumstances. We had cases when
> a new mechanism would show very good results until one usecase
> completely broke it. Bulk killing of processes that you are doing in
> your patch was a very good example of such a decision which later on
> we had to rethink. That's why baking these policies into kernel is
> very problematic. Another problem I see with the implementation that
> it ties process killing with the reclaim scan depth. It's very similar
> to how vmpressure works and vmpressure in my experience is very
> unpredictable.

Could you elaborate a bit on why bulk killing isn't good?

> > > I linked in the previous message, Google made a rather large set of
> > > modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
> > > What's going on?
> 
> If you look into that commit, it adds ability to report kill stats. If
> that was a change in how that driver works it would be rejected.

Fair, though it was quite strange seeing something that was supposedly totally
abandoned receiving a large chunk of code for reporting stats.

Thanks,
Sultan
