Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55487C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD60207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nrtSGimh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfJCOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:01:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfJCOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:01:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so1568920pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=876AH/g0tuUTbiBA2yyLEOyqGbxYhU6MzL7z+qZy1Es=;
        b=nrtSGimhbEUSrLHC4xuRBlfgA4KKx/6UC4RgNn/m7LZZT8speP1gcA/3X9nnBoFx+t
         ILiFjuK+sySg4HdoEME4M8j2CiFYepfSP97WoHkzhZuYedUu6wMu5q2ZNN7I6tpW6Vik
         zs706DZXTgG2BYmpwnIvEWl663XXqp/Mhe7SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=876AH/g0tuUTbiBA2yyLEOyqGbxYhU6MzL7z+qZy1Es=;
        b=sRDEp8uln3EiVjGo5ZDQIwCIMzZ2o5UPfP+USrpHmP6F+cLbOi7UpccBhAt4G02EhY
         bSvS2STErOEepFl1xBgO9mgJtOQl3xPtNwYBcEW/7cr3SxHZx+2B8Ik+eFEpShvrrtMk
         fCc8hHErhLMwK72JapD3h/OvBsdT+bfh0+R0xPZZI+syFoDA4lyT/pXl+04K3YSSOWXt
         Ca3gg+HFZ0LLFiAtIwpU9KFySF8fkxXNlghrl7fMCNR3JnDX3uchoZVZJiYxsnTleEcY
         iBx80mDV+ewSN39XBIqYxLi2LcMX9ouTXp5Tggg8qtKsgtif1NJSe7JCjTiOENSTKXKG
         4mOw==
X-Gm-Message-State: APjAAAViHa7C9RcSgPr7sPJcxf1vNXsjY1qjtQ2m6RyrC+/9Q8QYjaw5
        M3UWwI+7bl0TpL2q5HPQyZuF6w==
X-Google-Smtp-Source: APXvYqzf9cL9E0f1QDGQe+yuGP4T7h33qq0SFtLKgdd8IOYJ+LvDQJKKpSJCD8IlPVdcr18GHUu2gw==
X-Received: by 2002:a17:902:968e:: with SMTP id n14mr3320374plp.339.1570111285323;
        Thu, 03 Oct 2019 07:01:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o185sm5038868pfg.136.2019.10.03.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 07:01:24 -0700 (PDT)
Date:   Thu, 3 Oct 2019 10:01:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003140123.GF254942@google.com>
References: <20191003014310.13262-1-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25408.1570091957@warthog.procyon.org.uk>
 <20191003090850.1e2561b3@gandalf.local.home>
 <20191003133315.GN2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003133315.GN2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 06:33:15AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 03, 2019 at 09:08:50AM -0400, Steven Rostedt wrote:
> > On Thu, 03 Oct 2019 09:39:17 +0100
> > David Howells <dhowells@redhat.com> wrote:
> > 
> > > paulmck@kernel.org wrote:
> > > 
> > > > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > > > +({									\
> > > > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > > > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > > > +	__tmp;								\
> > > > +})  
> > > 
> > > Does it make sense to actually use xchg() if that's supported by the arch?
> 
> Historically, xchg() has been quite a bit slower than a pair of assignment
> statements, in part due to the strong memory ordering guaranteed by
> xchg().  Has that changed?  If so, then, agreed, it might make sense to
> use xchg().

For the kfree_rcu() performance testing I was working on recently, replacing
xchg() with a pair of assignment statements in the code being tested provided
a great performance increase (on x86).

thanks,

 - Joel

