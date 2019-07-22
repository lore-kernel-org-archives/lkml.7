Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28F621900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbfGVVX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:23:29 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58346 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbfGVVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:23:29 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpfmH-0006uW-SS from George_Davis@mentor.com ; Mon, 22 Jul 2019 14:23:25 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 22 Jul
 2019 14:23:23 -0700
Date:   Mon, 22 Jul 2019 17:23:22 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: kmem: convert call_site addresses to user
 friendly symbols
Message-ID: <20190722212322.GA10300@mam-gdavis-lt>
References: <1563589361-18337-1-git-send-email-george_davis@mentor.com>
 <20190722094343.1e9a5920@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190722094343.1e9a5920@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve,

On Mon, Jul 22, 2019 at 09:43:43AM -0400, Steven Rostedt wrote:
> 
> Looking at the kbuild report...
> 
> On Fri, 19 Jul 2019 22:22:40 -0400
> "George G. Davis" <george_davis@mentor.com> wrote:
> 
> > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > index eb57e3037deb..ae18e61fa1c0 100644
> > --- a/include/trace/events/kmem.h
> > +++ b/include/trace/events/kmem.h
> > @@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
> >  		__entry->gfp_flags	= gfp_flags;
> >  	),
> >  
> > -	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> > +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> 
> Note, %lx expects an unsigned long, %pS expects a pointer.
> 
> >  		__entry->call_site,
> 
> You need to change the above to: (void *)__entry->call_site,

Oops, I should have paid more attention. Fixed.

Thanks!

> 
> -- Steve
> 
> >  		__entry->ptr,
> >  		__entry->bytes_req,

-- 
Regards,
George
