Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA3B20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Rp1IdbRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfD2Mgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:36:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34706 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfD2Mgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:36:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so11675726qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsdtygGHwHLDiP7U7Nb22tfplZQ4QZkZbhbFoqCY5j8=;
        b=Rp1IdbRAg44yBruvqm0KtYJGRO62vJxcikXVloHeZ4JXGHD+WrE0ueSYlgEkbbgMhk
         pYs5bP8BEV5lMPCWfOJ+hUQdY8hPHghG9f0qwlLPSYpnzCLsU3q3jiYaUcV9waCOCbKS
         I5RmTzEKKqEoDUZHojdqSJyyLg9gMcrJ+G568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsdtygGHwHLDiP7U7Nb22tfplZQ4QZkZbhbFoqCY5j8=;
        b=ewTf+6zY+wI9D4dL7piAPcr4NCbXHw+F9W8RlmXj2woqDkJ85peReFj32KaL1n85Bp
         xftHo05AsPYGdr65v4wyzt4AWsxD3h0aaUSYg/Wxu25Hynz0c9ua/LwsnH3Isn78gMsM
         Y+F6stUwjmMiENDTbrRBeKeC7fdGfBZC4gpKDcwd/+B6DeO4Nu5uyA/RuTEbi4Da3fXn
         c99XiVANbCN0z1hinItsPcv+AqRK2Ww6LVR0ms022nysxs2O5BvJTTliryRsvl9q5E1r
         jUY9Y9FYRT91N/bxy+kkxH9FSvKLhn1ixYqSWtsFSTbJtZDL4V26ZZmJ6OJBV38yLRYp
         MOEg==
X-Gm-Message-State: APjAAAUkdpV6tQsVFam2OzNBHuI79pqgN0ZO0bVBxX162dMNArsPm4Zm
        NmLxFKo3QZX+sGgWJ90cLonPSA==
X-Google-Smtp-Source: APXvYqxqExPcFEbYH/RX70P/kra/zXk+oYoeBb59MXfrLZnCdjCRTBkpWfMBR7lwIl8npLKgQqDGjw==
X-Received: by 2002:ac8:2728:: with SMTP id g37mr25376314qtg.264.1556541409092;
        Mon, 29 Apr 2019 05:36:49 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id d55sm3249211qtb.59.2019.04.29.05.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 05:36:48 -0700 (PDT)
Date:   Mon, 29 Apr 2019 08:36:42 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 16/17] sched: Wake up sibling if it has something
 to run
Message-ID: <20190429123642.GA16059@sinkpad>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <a0132b8ffb5b37a5f8e242a5ac9e3a0a5ecc5f8e.1556025155.git.vpillai@digitalocean.com>
 <20190426150337.GC2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426150337.GC2623@hirez.programming.kicks-ass.net>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Apr-2019 05:03:37 PM, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 04:18:21PM +0000, Vineeth Remanan Pillai wrote:
> 
> (you lost From: Julien)
> 
> > During core scheduling, it can happen that the current rq selects a
> > non-tagged process while the sibling might be idling even though it
> > had something to run (because the sibling selected idle to match the
> > tagged process in previous tag matching iteration). We need to wake up
> > the sibling if such a situation arise.
> > 
> > Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> > Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > ---
> >  kernel/sched/core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e8f5ec641d0a..0e3c51a1b54a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3775,6 +3775,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  			 */
> >  			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
> >  				next = p;
> > +				rq->core_pick = NULL;
> > + 
> > +				/*
> > +				 * If the sibling is idling, we might want to wake it
> > +				 * so that it can check for any runnable tasks that did
> > +				 * not get a chance to run due to previous task matching.
> > +				 */
> > +				for_each_cpu(j, smt_mask) {
> > +					struct rq *rq_j = cpu_rq(j);
> > +					rq_j->core_pick = NULL;
> > +					if (j != cpu &&
> > +					    is_idle_task(rq_j->curr) && rq_j->nr_running) {
> > +						resched_curr(rq_j);
> > +					}
> > +				}
> >  				goto done;
> >  			}
> 
> Anyway, as written here:
> 
>   https://lkml.kernel.org/r/20190410150116.GI2490@worktop.programming.kicks-ass.net
> 
> I think this isn't quite right. Does the below patch (which actually
> removes lines) also work?
> 
> As written before; the intent was to not allow that optimization if the
> last pick had a cookie; thereby doing a (last) core wide selection when
> we go to a 0-cookie, and this then includes kicking forced-idle cores.

It works and the performance is similar to our previous solution :-)

Thanks,

Julien
