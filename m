Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B94CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004202086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfJWCw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389377AbfJWCw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:52:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0BF2086D;
        Wed, 23 Oct 2019 02:52:55 +0000 (UTC)
Date:   Tue, 22 Oct 2019 22:52:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
Message-ID: <20191022225253.4086195c@oasis.local.home>
In-Reply-To: <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
        <1565805327-579-5-git-send-email-divya.indi@oracle.com>
        <20191015190436.65c8c7a3@gandalf.local.home>
        <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 16:42:02 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Hi Steve,
> 
> Thanks again for taking the time to review and providing feedback. Please find my comments inline.
> 
> On 10/15/19 4:04 PM, Steven Rostedt wrote:
> > Sorry for taking so long to getting to these patches.
> >
> > On Wed, 14 Aug 2019 10:55:26 -0700
> > Divya Indi <divya.indi@oracle.com> wrote:
> >  
> >> For functions returning a trace array Eg: trace_array_create(), we need to
> >> increment the reference counter associated with the trace array to ensure it
> >> does not get freed when in use.
> >>
> >> Once we are done using the trace array, we need to call
> >> trace_array_put() to make sure we are not holding a reference to it
> >> anymore and the instance/trace array can be removed when required.  
> > I think it would be more in line with other parts of the kernel if we
> > don't need to do the trace_array_put() before calling
> > trace_array_destroy().  
> 
> The reason we went with this approach is
> 
> instance_mkdir -          ref_ctr = 0  // Does not return a trace array ptr.
> trace_array_create -      ref_ctr = 1  // Since this returns a trace array ptr.
> trace_array_lookup -      ref_ctr = 1  // Since this returns a trace array ptr.
> 
> if we make trace_array_destroy to expect ref_ctr to be 1, we risk destroying the trace array while in use.
> 
> We could make it -
> 
> instance_mkdir - 	ref_ctr = 1
> trace_array_create -    ref_ctr = 2
> trace_array_lookup -    ref_ctr = 2+  // depending on no of lookups
> 
> but, we'd still need the trace_array_put() (?)
> 
> We can also have one function doing create (if does not exist) or lookup (if exists), but that would require
> some redundant code since instance_mkdir needs to return -EXIST when a trace array already exists.
> 
> Let me know your thoughts on this.
> 

Can't we just move the trace_array_put() in the instance_rmdir()?

static int instance_rmdir(const char *name)
{
	struct trace_array *tr;
	int ret;

	mutex_lock(&event_mutex);
	mutex_lock(&trace_types_lock);

	ret = -ENODEV;
	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
		if (tr->name && strcmp(tr->name, name) == 0) {
			__trace_array_put(tr);
			ret = __remove_instance(tr);
			if (ret)
				tr->ref++;
			break;
		}
	}

	mutex_unlock(&trace_types_lock);
	mutex_unlock(&event_mutex);

	return ret;
}

-- Steve
