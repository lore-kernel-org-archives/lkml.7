Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A92BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196922146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ehn/I4B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfGASZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:25:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36991 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGASZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:25:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so4525299pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=727aBBfWqYrKy3zdRdkTXxLgWwNQre9utWIB8UaiK2g=;
        b=Ehn/I4B4HkIjvHy6V9HxTRXh3F8YWylu8ympYyLVqIQxwF/qtaM/RDmkvNnTNQbdoQ
         MOFe3neeigVp0ZlIqijol7rr9IKmlQzgxVUOy++18cE2QEElAiMYSoOcKxqTNtyQ1PG0
         z6axRHN3bwo8z7KVbfu0m/73XA9Bx+wc8BqyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=727aBBfWqYrKy3zdRdkTXxLgWwNQre9utWIB8UaiK2g=;
        b=pMRTCgRN8JFwMh0V3KgB8OCxOG7OHR8hVRFB5jzR/mARZnK8OlSFAwqEfdA0dPQXAm
         pG1eAZzOgFi4aasGEg3v+NmLtFpWDL2sk+aL9lvpdXNF0hyeBpC/XiKZbMvD4u737f1F
         LrVy+4P0PckUxksUwZxwjRdyOAkTi2mJ7eLLoW/qVyziItWL6EcDnEs/6XGk7jsRdfHT
         euPRaEMthhBJXc9440WV1Ni+TodZbWXdbo5vaZ3uCdxfbSFjA731a4NLQkamvJkR36Xj
         3Xxbas4sYYeV4omJKl9zBE7vy/oEt9IU9KcgWu+c8/ZPgCK3MuoXIYxm2bLvMNhfBp6j
         vAlA==
X-Gm-Message-State: APjAAAXx154qPG3r3vfqVGDWwRwxm2HReWEZwyuHD0THVNIzJSFL5OWX
        ieLe4JhTaz/6J6Nk74zVKXpYxw==
X-Google-Smtp-Source: APXvYqxbjX3RJLpO0anArjOh5JUBRzWK/fY7e05ZbhUnH9NIahw6rvOQWHz+4F/sxkMdBuuda3lNGg==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr22771702pgc.328.1562005521251;
        Mon, 01 Jul 2019 11:25:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y68sm12576238pfy.164.2019.07.01.11.25.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 11:25:20 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:25:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] Convert struct pid count to refcount_t
Message-ID: <20190701182519.GA125555@google.com>
References: <20190628193442.94745-1-joel@joelfernandes.org>
 <CAG48ez11aCEBmO=DM58+Rk7cthW1VWK2O35GWsSJWwQ_fQJ6Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez11aCEBmO=DM58+Rk7cthW1VWK2O35GWsSJWwQ_fQJ6Fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 07:48:26PM +0200, Jann Horn wrote:
> On Fri, Jun 28, 2019 at 9:35 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > struct pid's count is an atomic_t field used as a refcount. Use
> > refcount_t for it which is basically atomic_t but does additional
> > checking to prevent use-after-free bugs.
> [...]
> >  struct pid
> >  {
> > -       atomic_t count;
> > +       refcount_t count;
> [...]
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..89c4849fab5d 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -37,7 +37,7 @@
> >  #include <linux/init_task.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/proc_ns.h>
> > -#include <linux/proc_fs.h>
> > +#include <linux/refcount.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/idr.h>
> >
> > @@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
> 
> init_struct_pid is defined as follows:
> 
> struct pid init_struct_pid = {
>         .count          = ATOMIC_INIT(1),
> [...]
> };
> 
> This should be changed to REFCOUNT_INIT(1).
> 
> You should have received a compiler warning about this; I get the
> following when trying to build with your patch applied:

Thanks. Andrew had fixed this in patch v1 but Linus dropped it for other
reasons. Anyway, I should have fixed this in my resubmit.

Sorry, I'll fix and resend!

 - Joel


