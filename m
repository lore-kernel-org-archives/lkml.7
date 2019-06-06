Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1258AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4A42083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QPTyen8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFFJLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:11:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36319 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfFFJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:11:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1589592wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFFiWiswwMAP2/zS9AcnxfH/DQ8DZRfvIKcFfeVoWd8=;
        b=QPTyen8evzfqRjQmlvPvJZOCE0vsYQOJWgFZjqQcUrDpKwKZdpgiGLskYh71r8ENgZ
         7Yl6dhCJNS9qbOGUW95uoMwnciVXML9VsnDGMWBBjB2Le2MpKgs+t2F6KMWHDLe6QkZv
         P8zGywBnSYSMgARqG9LG4Wxc2sNCvHp81DBsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFFiWiswwMAP2/zS9AcnxfH/DQ8DZRfvIKcFfeVoWd8=;
        b=VL6JICCejb4t2AQGJf4sDHmZlDceKxYviFPqJ7lUZSX36kKE3YutZ8YDvQeGOsFuQw
         2v266pACT2NoRlqbbkVNVN1yNgDQluUo3SICy5aiJ5mgNFyogiF3jav4krImO3BEnj2V
         POIx8TBiu4tjfKShU9jTfNdbixAnOjmppGcptbVu1tDz++vyXD5PtjwHGnFwgZ5LDAxJ
         4x4U7zxTI/c7qo5X2EnRymWXXBcKkoat+rKi5rgMwN4+2sIC0NA3zOCSYSm4GI/Qv2dU
         z3Zzsk+9DuxMze3FQkj8w3Zx7r93hEg58RoD0dTyqMlySErpGp5+OwmaWQ0LxluMKquh
         W0Pg==
X-Gm-Message-State: APjAAAUUrUA6jSDhGJ3ZnS6nrWlZW5LAi6blo1ZDzNZD8mSJnnMqkwCc
        xoHHkWYfyOThJR5VlkYsRng/sw==
X-Google-Smtp-Source: APXvYqyVaE/rWyCq+axw/VdIAT6k32Vloq1VT0fMZ+ySyVJkExReP4MoGP7RkKps7Ya8XJilyPZMPg==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr13487600wrv.89.1559812304120;
        Thu, 06 Jun 2019 02:11:44 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id t7sm525162wrx.65.2019.06.06.02.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:11:43 -0700 (PDT)
Date:   Thu, 6 Jun 2019 11:11:37 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] Documentation/atomic_t.txt: Clarify pure
 non-rmw usage
Message-ID: <20190606091137.GA6039@andrea>
References: <20190524115231.GN2623@hirez.programming.kicks-ass.net>
 <tip-fff9b6c7d26943a8eb32b58364b7ec6b9369746a@git.kernel.org>
 <20190606084421.GA5523@andrea>
 <20190606090439.GK3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606090439.GK3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:04:39AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 10:44:21AM +0200, Andrea Parri wrote:
> > On Mon, Jun 03, 2019 at 06:46:54AM -0700, tip-bot for Peter Zijlstra wrote:
> > > Commit-ID:  fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> > > Gitweb:     https://git.kernel.org/tip/fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> > > Author:     Peter Zijlstra <peterz@infradead.org>
> > > AuthorDate: Fri, 24 May 2019 13:52:31 +0200
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Mon, 3 Jun 2019 12:32:57 +0200
> > > 
> > > Documentation/atomic_t.txt: Clarify pure non-rmw usage
> > > 
> > > Clarify that pure non-RMW usage of atomic_t is pointless, there is
> > > nothing 'magical' about atomic_set() / atomic_read().
> > > 
> > > This is something that seems to confuse people, because I happen upon it
> > > semi-regularly.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Link: https://lkml.kernel.org/r/20190524115231.GN2623@hirez.programming.kicks-ass.net
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > 
> > I'd appreciate if you could Cc: me in future changes to this doc.
> > (as currently suggested by get_maintainer.pl).
> > 
> > This is particularly annoying when you spend time to review such
> > changes:
> > 
> >   https://lkml.kernel.org/r/20190528111558.GA9106@andrea
> 
> Sure, I hadn't realized the LKMM entry had appropriated this file, I
> considered it part of the ATOMIC entry there.

Thanks.  Well, that was not a 'secret', c.f.,

  70b83069f70d ("tools/memory-model: Add informal LKMM documentation to MAINTAINERS")

  Andrea
