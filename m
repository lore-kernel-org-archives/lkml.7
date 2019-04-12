Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA41206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rrJYI59E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDLCO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:14:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37471 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDLCO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:14:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so4314332ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8kRx93ectFWXcSNcjkU4/T/wBP1uUZGQw57faxP67+U=;
        b=rrJYI59EQAwJCtT1+JfZPi07BvbxjErI6m0X3x5x+OdRxgplUPIz1Cvb9zH2oEHRAW
         Z5SR2RBC2YGFggh0WZ+yMyiSBounKJrRELALCDJq6yD6WicqqiBdhaR7AL6TSPqC4G9a
         eclkara+isWz1QlJd+xmNax6WgPXy1fhR+34U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kRx93ectFWXcSNcjkU4/T/wBP1uUZGQw57faxP67+U=;
        b=HvrNHn5eGdDjAQ9jarLWiuKs0+obW7/z2cHIVeCqriiu+xsdQTwpPEuqcHWYi/zJQ6
         bh58N96HtwraP78qBXBXJHNzrbxWxOq9jW2fqcReyAWfqfyD4qw/traOXO9pEv6aerPi
         3rptj5zBNhc+BoalShdL1LCu1jaxx1fYNSlr27b13yp9e18ZmmHo2kRV/CrE7FlAAx8g
         AsTdvaWnmLfI+M4A9uyS9kIwk5eO8FD1tJS2YbKMTVrGssObAnnOlSWIRvJ/B9GARlra
         9JrfzP37XE8wF+ZGbXSTeAPgI2frLg7yAlKZoAsps+Vfe6PK+yDBay6T5UOTwz9zWXCK
         N/4g==
X-Gm-Message-State: APjAAAUnI0myo42PkXqD8kSMjBEpWimP6Vm1HCbMVVwEGl6wPXyFNQkf
        /8yJ3pwhFTLpZS/bTIkbk21amA==
X-Google-Smtp-Source: APXvYqw3Q3lQnWetrFiYEhEDNFe10NOprelRS6sMhlaXAHQogU3FejtbvOv6LvuuTB3qvONe8NxQ+A==
X-Received: by 2002:a17:902:9048:: with SMTP id w8mr54995254plz.195.1555035265115;
        Thu, 11 Apr 2019 19:14:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b2sm49572685pfo.150.2019.04.11.19.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 19:14:24 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:14:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] module: Make srcu_struct ptr array as read-only
Message-ID: <20190412021422.GA208673@google.com>
References: <20190411202421.131779-1-joel@joelfernandes.org>
 <20190411213155.GD14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411213155.GD14111@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 02:31:55PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 11, 2019 at 04:24:21PM -0400, Joel Fernandes (Google) wrote:
> > Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
> > modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
> > of srcu_struct pointers, which is used by srcu code to initialize and
> > clean up these structures and save valuable per-cpu reserved space.
> > 
> > There is no reason for this array of pointers to be writable, and can
> > cause security or other hidden bugs. Mark these are read-only after the
> > module init has completed.
> > 
> > Tested with the following diff to ensure array not writable:
> > 
> > (diff is a bit reduced to avoid patch command getting confused)
> >  a/kernel/module.c
> >  b/kernel/module.c
> >   -3506,6 +3506,14  static noinline int do_init_module [snip]
> >  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> >  #endif
> >  	module_enable_ro(mod, true);
> > +
> > +	if (mod->srcu_struct_ptrs) {
> > +		// Check if srcu_struct_ptrs access is possible
> > +		char x = *(char *)mod->srcu_struct_ptrs;
> > +		*(char *)mod->srcu_struct_ptrs = 0;
> > +		*(char *)mod->srcu_struct_ptrs = x;
> > +	}
> > +
> >  	mod_tree_remove_init(mod);
> >  	disable_ro_nx(&mod->init_layout);
> >  	module_arch_freeing_init(mod);
> > 
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: paulmck@linux.vnet.ibm.com
> > Cc: rostedt@goodmis.org
> > Cc: mathieu.desnoyers@efficios.com
> > Cc: rcu@vger.kernel.org
> > Cc: kernel-hardening@lists.openwall.com
> > Cc: kernel-team@android.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Queued for testing and further review, thank you, Joel!

Thanks a lot! I also just saw you added the rcutorture module to be built as
a part kselftests which is really cool ;-)

thanks,

 - Joel

