Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A675EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760EB20665
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FcgOzzaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfFSMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:02:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ri7qjhjVCgbjO6ig3doTj7RVbO2jjytVB0LcoWHrHhU=; b=FcgOzzaUp3Q5CfIuOaKoL+MDK
        KYCzrxCmEMdfjNQSrLlvvwFbZrSjOWK3jSgSFnTe+ewKfop5MWztgIuCls6ghDvHF0Qem3tYDpX/7
        AIZGONFJINJi/oYjy23u7u/yTrkGtoMRLk/IR9AJG5/yFV4c4SeCcZroBm8mbs5ENlLckoz1WK96K
        Nm+9k30Tfq9+JtM7kkfqZWWi7T9DZYxNwGc38WqEK44vn8z7W4l9EWSzv4y1Ic2LfM7KHDlimJkIA
        LiCGZk5VfImotto+QulyqEy3vwqM0SKLUITsKvVrLvUW2EDp1GxWLni53nccRpPNu2GGFUWTLzJaF
        eS+nqrQbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdZHR-0008GE-3H; Wed, 19 Jun 2019 12:01:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A0272020FD6B; Wed, 19 Jun 2019 14:01:31 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:01:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190619120131.GS3463@hirez.programming.kicks-ass.net>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
 <20190619112350.GN3419@hirez.programming.kicks-ass.net>
 <20190619113324.GO3463@hirez.programming.kicks-ass.net>
 <20190619113508.GP3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619113508.GP3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 01:35:08PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 19, 2019 at 01:33:24PM +0200, Peter Zijlstra wrote:
> > How's something like so:
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 80c7c09584cf..eba6560c89da 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3631,16 +3631,28 @@ static int complete_formation(struct module *mod, struct load_info *info)
> >  
> >  static int prepare_coming_module(struct module *mod)
> >  {
> > -	int err;
> > +	struct blocking_notifier_head *nh = &module_notify_list;
> > +	int err, nr;
> >  
> >  	ftrace_module_enable(mod);
> >  	err = klp_module_coming(mod);
> >  	if (err)
> >  		return err;
> >  
> > -	blocking_notifier_call_chain(&module_notify_list,
> > -				     MODULE_STATE_COMING, mod);
> > -	return 0;
> > +	if (!rcu_access_pointer(nh->head))
> > +		return 0;
> > +
> > +	down_read(&nh->rwsem);
> > +	ret = notifier_call_chain(&nh->head, MODULE_STATE_COMING, mod, -1, &nr);
> > +	if (ret & NOTIFIER_STOP_MASK)
> 
> It compiles _lots_ better with s/ret/err/ on.
> 
> > +		notifier_call_chain(&nh->head, MODULE_STATE_GOING, mod, nr, NULL);
> > +	up_read(&nh->rwsem);
> > +
> > +	err = notifier_to_err(err);
> > +	if (err)
> > +		klp_module_going(mod);
> > +
> > +	return err;
> >  }
> >  
> >  static int unknown_module_param_cb(char *param, char *val, const char *modname,

Rafael, how is kernel/power/user.c snapshot_open() not broken (any any
other __pm_notifier_call_chain() user)?

afaict the __pm_notifier_call_chain() thing is broken in two ways:

 - there can be a change to the notifier list between the PREPARE and
   POST iteration

 - the error value isn't put through notifier_to_errno().
