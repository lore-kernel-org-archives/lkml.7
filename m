Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA331C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C0C208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="c5i0CndM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfEHQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:26:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34353 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEHQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:26:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so2210276pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0oFZG4f7HJO+ERWWpCdCvMECN1hBHKXTqijgUivnq8=;
        b=c5i0CndMjmSXAkq3RkmPjkKSY6wap+HLlQqr8phD0UrE2QvaciXJkTSMJaTN2xNSzN
         iWZQlovltuZrUDfxEexT0ycYd1QBFbFTdLIDi1cSEbIyFMlZqm6uaC0cCm+RiXrEmcdA
         TchzuiDHvE9PyPLOHlVP6eOZ4GjmrJ25w5WX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0oFZG4f7HJO+ERWWpCdCvMECN1hBHKXTqijgUivnq8=;
        b=mA2vUuWrR4IWbRmqxN/NBtR0ClxcEixVHcZpr7rEY64GeARR5wrFCkwjYXJKN0losp
         V/YCPqfV8dGMnTjhuVDYvunQE5UyFWnUJRT+Ponkyl+1ysXSQKRuGXnzBZ8Q8JPlx6D9
         KKXiY+e1oP1LzCjC4ssD2NpuXqkevJyPyUF5r56NyZ2zQF6W+EWaxfkMySxS0YooyGnl
         3nm9HlaoUqdBCG2ggm4bQzZxK1nX496qUif6d6P5I9RVYZ/jy5JFePddrYBBVk5Gi2c0
         mm7BRtvqppq0PBwiLcpqfs3ulZBqAWXxCKsVEFmoG4D2eGdj4MdV7+1gWytsci2++wpq
         u+lA==
X-Gm-Message-State: APjAAAWCcE05S7DEEy8V+oH7wU5LxF2UAwHWFnZoYbD1/9D4rElBnH8M
        cbX/CkFbOCzA1YsUkXejKSm+HQ==
X-Google-Smtp-Source: APXvYqzGwHmkxNFE7tuybjve16hQ4MXiWJJu4QxG//lUWDJcpw9VKXyuppFbKgw7IQkpezRrnX08/Q==
X-Received: by 2002:a63:3746:: with SMTP id g6mr48049952pgn.422.1557332798078;
        Wed, 08 May 2019 09:26:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g24sm26535910pfi.126.2019.05.08.09.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:26:36 -0700 (PDT)
Date:   Wed, 8 May 2019 12:26:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Message-ID: <20190508162635.GD187505@google.com>
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507000453.GB3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 05:04:53PM -0700, Paul E. McKenney wrote:
> On Sat, May 04, 2019 at 10:03:10PM -0400, Joel Fernandes (Google) wrote:
> > I believe this field should be called field_count instead of file_count.
> > Correct the doc with the same.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> But if we are going to update this, why not update it with the current
> audit_filter_task(), audit_del_rule(), and audit_add_rule() code?
> 
> Hmmm...  One reason is that some of them have changed beyond recognition.

It seems to me that these 3 functions are just structured differently but is
conceptually the same.

There is now an array of lists stored in audit_filter_list. Each list is a
set of rules. Versus in the listRCU.txt, there is only one global.

The other difference is there is a mutex held &audit_filter_mutex
audit_{add,del}_rule. Where as in listRCU, it says that is not needed since
another mutex is already held.

> And this example code predates v2.6.12.  ;-)
> 
> So good eyes, but I believe that this really does reflect the ancient
> code...
> 
> On the other hand, would you have ideas for more modern replacement
> examples?

There are 3 cases I can see in listRCU.txt:
  (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
                this is the best possible usage of RCU.
  (2) action taken outside of read_lock, in-place updates
                this is good as long as not too many in-place updates.
                involves copying creating new list node and replacing the
                node being updated with it.
  (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
                                  protected by a per-entry lock. reader
				  aborts if object is stale.

Any replacement example must make satisfy (3) too?

The only example for (3) that I know of is sysvipc sempahores which you also
mentioned in the paper. Looking through this code, it hasn't changed
conceptually and it could be a fit for an example (ipc_valid_object() checks
for whether the object is stale).

The other example could be dentry look up which uses seqlocks for the
RCU-walk case? But that could be too complex. This is also something I first
learnt from the paper and then the excellent path-lookup.rst document in
kernel sources.

I will keep any eye out for other examples in the kernel code as well.

Let me know what you think, thanks!

 - Joel


> > ---
> >  Documentation/RCU/listRCU.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
> > index adb5a3782846..190e666fc359 100644
> > --- a/Documentation/RCU/listRCU.txt
> > +++ b/Documentation/RCU/listRCU.txt
> > @@ -175,7 +175,7 @@ otherwise, the added fields would need to be filled in):
> >  		list_for_each_entry(e, list, list) {
> >  			if (!audit_compare_rule(rule, &e->rule)) {
> >  				e->rule.action = newaction;
> > -				e->rule.file_count = newfield_count;
> > +				e->rule.field_count = newfield_count;
> >  				write_unlock(&auditsc_lock);
> >  				return 0;
> >  			}
> > @@ -204,7 +204,7 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
> >  					return -ENOMEM;
> >  				audit_copy_rule(&ne->rule, &e->rule);
> >  				ne->rule.action = newaction;
> > -				ne->rule.file_count = newfield_count;
> > +				ne->rule.field_count = newfield_count;
> >  				list_replace_rcu(&e->list, &ne->list);
> >  				call_rcu(&e->rcu, audit_free_rule);
> >  				return 0;
> > -- 
> > 2.21.0.1020.gf2820cf01a-goog
> > 
> 
