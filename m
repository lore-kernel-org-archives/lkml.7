Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E37C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50F121841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QmPJbJMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCTTTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:19:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46998 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:19:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so2875887qts.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mMC0KQfG735C164EcTD+oEbBbnx3mNbSvIp42P1/ag=;
        b=QmPJbJMB9wKLf1bmnt3tiF7HqCc3zU327h3UXi5c8JGotzjL+VOVDTOEXl3wAoaEIu
         9lAq+U7AMe3JsNkD/QoqLqLNVTcrH/nV+0YJxKHOpRootWoI8oATCWHjdDIFomwmlko/
         uW0bKGgZvqQgDsmQl8QAYmYpsrgerWnYApdp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mMC0KQfG735C164EcTD+oEbBbnx3mNbSvIp42P1/ag=;
        b=l1750zSrWsSzM71GwJ8Z9fgcVd6PavMxXt5Io5ZfFctCe9COJlpPawLdlmJN1zjANC
         tzL2oXfGgrQ8e4/mnO24v45MclZmOmdbOgtAOHPrpBKVSXdWXUS/86ZecReCSafX/5Mj
         PFtN23OSQGQYHwdfbixSi0aIT0VpeOcyv0zqmBS66zFDDThr54svX0PSQKRD8ufGoA4P
         8mXtFnCnnJQbIv3diYDrVFAiKKCVE4azVPIl4KjSltZBMubLY/2CycSNUI2Nr+aNwRdm
         a+0b0Zn8I4i/wyktfqGWys+2ZSLTWibkhA6prlHAVKDIHH/knnM7l6WPHgfnUYoKFFCU
         O+hQ==
X-Gm-Message-State: APjAAAWtiZn4lxQolQYKVz/9vhTWYFRpwmQ2PhgX+rHQp6aGGnHF6Q2r
        wJJD4AHPWPBpSfYDNU+SbaesyA==
X-Google-Smtp-Source: APXvYqyCvIcP3+DKbe38H1Wq95MgCtycxVep/aavFfInOZgeS5CjRORRXHM97tnnLgFhx5cd9IBy/A==
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr7586860qte.233.1553109577350;
        Wed, 20 Mar 2019 12:19:37 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 33sm1829081qtm.28.2019.03.20.12.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:19:36 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:19:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: pidfd design
Message-ID: <20190320191935.GB76715@google.com>
References: <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io>
 <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org>
 <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320185156.7bq775vvtsxqlzfn@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 07:51:57PM +0100, Christian Brauner wrote:
[snip]
> > > translate_pid() should just return you a pidfd. Having it return a pidfd
> > > and a status fd feels like stuffing too much functionality in there. If
> > > you're fine with it I'll finish prototyping what I had in mind. As I
> > > said in previous mails I'm already working on this.
> > 
> > translate_pid also needs to *accept* pidfds, at least optionally.
> > Unless you have a function from pidfd to pidfd, you race.
> 
> You're misunderstanding. Again, I said in my previous mails it should
> accept pidfds optionally as arguments, yes. But I don't want it to
> return the status fds that you previously wanted pidfd_wait() to return.
> I really want to see Joel's pidfd_wait() patchset and have more people
> review the actual code.

No problem, pidfd_wait is also fine with me and we can change it later to
translate_pid or something else if needed.

Agreed that lets get to some code writing now that (I hope) we are all on the
same page and discuss on actual code.

 - Joel

