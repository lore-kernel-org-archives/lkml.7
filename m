Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E9724905
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfFCIHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:07:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:55122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfFCIHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:07:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EDBFB133;
        Mon,  3 Jun 2019 08:07:29 +0000 (UTC)
Date:   Mon, 3 Jun 2019 10:07:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Use static buffer for debugging messages
 under rq lock
Message-ID: <20190603080729.67je4pl4epsjtgtg@pathway.suse.cz>
References: <20190531074147.27616-1-pmladek@suse.com>
 <20190531074147.27616-4-pmladek@suse.com>
 <alpine.LSU.2.21.1905311433230.742@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1905311433230.742@pobox.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-05-31 14:37:52, Miroslav Benes wrote:
> On Fri, 31 May 2019, Petr Mladek wrote:
> 
> > The err_buf array uses 128 bytes of stack space.  Move it off the stack
> > by making it static.  It's safe to use a shared buffer because
> > klp_try_switch_task() is called under klp_mutex.
> > 
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index 1bf362df76e1..5c4f0c1f826e 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -327,7 +327,6 @@ static bool klp_try_switch_task(struct task_struct *task)
> >  		pr_debug("%s", err_buf);
> >  
> >  	return success;
> > -
> >  }
> 
> This could go in separately as it is not connected to the rest of the 
> series.

I have never seen a standalone commit just removing an empty line.
It is usually done when one touches the code around.

If you resist, we could omit this hunk from the patch and leave
the code as is.

Best Regards,
Petr
