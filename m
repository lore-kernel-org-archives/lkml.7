Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBDC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DEB20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569258930;
	bh=x9lbL13cuZaWJMez+HMp4FUH96nj+s+Lw3qbHNOHEnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VK4DLozS1g0bgwmPEvvWIvnoiuzQ3r7dlaUOanIsxEYuCpK4sJnWrJg759SHsZ4AV
	 e+H1wV4t0n4I1hlG6fiq1l+Fr1HcEHbofhSh97A9h8IqtNP9JcxrbFzOPPe27Ea+o5
	 akkQjrFQ/YE1VixI8ZTYSqIkIU4wLcsckujBPMrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437652AbfIWRP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfIWRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:15:28 -0400
Received: from devnote2 (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1039720820;
        Mon, 23 Sep 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569258927;
        bh=x9lbL13cuZaWJMez+HMp4FUH96nj+s+Lw3qbHNOHEnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P+QnFsASgn8lwNQlAk5rMGmmsniroCGiQoFWNNgsN0nig7P/GN3+nFiqAX8N9aOqP
         wgecopCV0R19K3zr0ADCwsW3Gmz9N8IsBlAq2QajHDAMn35+w3D9PL1Wmdpyu1q5MN
         vR5G7JkbmQgMGUDugzq6WPIvGZT9FWMVaYB6fJhg=
Date:   Mon, 23 Sep 2019 10:15:26 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [for-next][PATCH 7/8] tracing/probe: Reject exactly same probe
 event
Message-Id: <20190923101526.a1a9ccde50da83fbdc86aad8@kernel.org>
In-Reply-To: <20190923102035.GA30095@linux.vnet.ibm.com>
References: <20190919232313.198902049@goodmis.org>
        <20190919232400.470062819@goodmis.org>
        <20190923102035.GA30095@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 16:12:53 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Hey Masami, Steven
> 
> >  
> > +static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
> > +					 struct trace_kprobe *comp)
> > +{
> > +	struct trace_probe_event *tpe = orig->tp.event;
> > +	struct trace_probe *pos;
> > +	int i;
> > +
> > +	list_for_each_entry(pos, &tpe->probes, list) {
> > +		orig = container_of(pos, struct trace_kprobe, tp);
> > +		if (strcmp(trace_kprobe_symbol(orig),
> > +			   trace_kprobe_symbol(comp)) ||
> > +		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> > +			continue;
> > +
> > +		/*
> > +		 * trace_probe_compare_arg_type() ensured that nr_args and
> > +		 * each argument name and type are same. Let's compare comm.
> > +		 */
> > +		for (i = 0; i < orig->tp.nr_args; i++) {
> > +			if (strcmp(orig->tp.args[i].comm,
> > +				   comp->tp.args[i].comm))
> > +				continue;
> 
> In a nested loop, *continue* is going to continue iterating through the
> inner loop. In which case, continue is doing nothing here. I thought we
> should have used a goto instead. No?  To me, continue as a last statement of
> a for loop always looks weird.

Oops, thanks for pointing it out!

> 
> > +		}
> > +
> > +		return true;
> > +	}
> 
> I think we need something like this:
> 
> 	list_for_each_entry(pos, &tpe->probes, list) {
> 		orig = container_of(pos, struct trace_kprobe, tp);
> 		if (strcmp(trace_kprobe_symbol(orig),
> 			   trace_kprobe_symbol(comp)) ||
> 		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> 			continue;
> 
> 		/*
> 		 * trace_probe_compare_arg_type() ensured that nr_args and
> 		 * each argument name and type are same. Let's compare comm.
> 		 */
> 		for (i = 0; i < orig->tp.nr_args; i++) {
> 			if (strcmp(orig->tp.args[i].comm,
> 				   comp->tp.args[i].comm))
> 				goto outer_loop;
> 
> 		}
> 
> 		return true;
> outer_loop:
> 	}

Correct, that's what I intended.
Could you make a fix patch on top of it? (or do I?)

Thank you,

> 
> 
> > +
> > +	return false;
> > +}
> > +
> >  
> 
> ......
> 
> > +static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
> > +					 struct trace_uprobe *comp)
> > +{
> > +	struct trace_probe_event *tpe = orig->tp.event;
> > +	struct trace_probe *pos;
> > +	struct inode *comp_inode = d_real_inode(comp->path.dentry);
> > +	int i;
> > +
> > +	list_for_each_entry(pos, &tpe->probes, list) {
> > +		orig = container_of(pos, struct trace_uprobe, tp);
> > +		if (comp_inode != d_real_inode(orig->path.dentry) ||
> > +		    comp->offset != orig->offset)
> > +			continue;
> > +
> > +		/*
> > +		 * trace_probe_compare_arg_type() ensured that nr_args and
> > +		 * each argument name and type are same. Let's compare comm.
> > +		 */
> > +		for (i = 0; i < orig->tp.nr_args; i++) {
> > +			if (strcmp(orig->tp.args[i].comm,
> > +				   comp->tp.args[i].comm))
> > +				continue;
> 
> Same as above.
> 
> > +		}
> > +
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> 
> -- 
> Thanks and Regards
> Srikar Dronamraju
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
