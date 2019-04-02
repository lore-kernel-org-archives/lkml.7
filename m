Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DCB2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TwFtjGnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfDBSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:40:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33572 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfDBSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:40:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so6811943pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QX3WmO3z+LdgwO9J+1/fdWqAW7fq2Y7yHthIv1sOONg=;
        b=TwFtjGnUlRbjWg0cZuXgTNn/4lVvzivuxSUKmM36CR7cn0oCDHcVMle8OhW36i9gdk
         KmOkbU0ZiipElWNJ/WkGlhTTG80uUIJqYRCoczQGZR9EN+E/ywrk0DyhcwJDT84H1Yye
         IejTpRJewdlen5AqRGgIq64rvLFmU2G5msri8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QX3WmO3z+LdgwO9J+1/fdWqAW7fq2Y7yHthIv1sOONg=;
        b=lqKuCQau4Gyucfn6zPTx72CLebUgku50X+j6PtW9VQ0yIP7TAxmO84t6bktsn26a2b
         jPdFdbYRVQG8AEJXetjakaoJY1u8V0lYP2Fhj8ZQBkyptaOlrUARQTvVdxDBRQSrMvSP
         xWxw+AnzwqyPVzwWNfk6iolK2rexx0yetjPw9S7IaHyYKp1xeZzZQ0hCbTQd0Veo2HaK
         JR3jD6gxEpcm88F1KwP6gbEwI6NvLPYR8mahbqOdKYL//XtyY6EWAQvQ7zkigLDTaKok
         9notFQWRJPIJc4xb72cuUXhfmcOUwRc9QdJF7PEXjc1F7/Ln++HqQRd0xJy9LTuMuouv
         dWCA==
X-Gm-Message-State: APjAAAWgn7sdgP+Ol9Xuut45A8KpjMqHYoKofxYIOtqQvbyqvyarUaHl
        oyq66V7t46WaC92eItW3NGwLcQ==
X-Google-Smtp-Source: APXvYqxhvZs/f8cmeX+KXx1aWW6+8GF2PCWYSh7jrkRdLw33Di/UXPKK9ZukAOz5f7Gqj7iqdtF2ZQ==
X-Received: by 2002:a63:e402:: with SMTP id a2mr59794423pgi.268.1554230456850;
        Tue, 02 Apr 2019 11:40:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v82sm31468142pfa.170.2019.04.02.11.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 11:40:55 -0700 (PDT)
Date:   Tue, 2 Apr 2019 14:40:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm@lists.01.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Message-ID: <20190402184054.GA18150@google.com>
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402152334.GC4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:23:34AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> > ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
> > 
> > > Hello!
> > > 
> > > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> > > by loadable modules.  The reason for this prohibition is the fact
> > > that using these two macros within modules requires that the size of
> > > the reserved region be increased, which is not something we want to
> > > be doing all that often.  Instead, loadable modules should define an
> > > srcu_struct and invoke init_srcu_struct() from their module_init function
> > > and cleanup_srcu_struct() from their module_exit function.  Note that
> > > modules using call_srcu() will also need to invoke srcu_barrier() from
> > > their module_exit function.
> > 
> > This arbitrary API limitation seems weird.
> > 
> > Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> > while implementing them with dynamic allocation under the hood ?
> 
> Although call_srcu() already has initialization hooks, some would
> also be required in srcu_read_lock(), and I am concerned about adding
> memory allocation at that point, especially given the possibility
> of memory-allocation failure.  And the possibility that the first
> srcu_read_lock() happens in an interrupt handler or similar.
> 
> Or am I missing a trick here?

Hi Paul,

Which 'reserved region' are you referring to? Isn't this region also
used for non-module cases in which case the same problem applies to
non-modules?

thanks!

 - Joel

