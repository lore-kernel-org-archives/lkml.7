Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA502C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920B32071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLBUZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:25:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:38875 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfLBUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:25:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 12:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="385024237"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2019 12:25:35 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 97D85300B57; Mon,  2 Dec 2019 12:25:35 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:25:35 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202202535.GO84886@tassilo.jf.intel.com>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <20191202162152.GG2827@hirez.programming.kicks-ass.net>
 <20191202191519.GN84886@tassilo.jf.intel.com>
 <8612523d-f035-b2aa-28f5-e4122ef59901@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8612523d-f035-b2aa-28f5-e4122ef59901@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks reasonable to me.

> //get current number of threads
> read_lock(&tasklist_lock);
> for_each_process_thread(g, p)
> 	num_thread++;
> read_unlock(&tasklist_lock);

I'm sure we have that count somewhere.

> 
> //allocate the space for them
> for (i = 0; i < num_thread; i++)
> 	data[i] = kzalloc(ctx_size, flags);
> i = 0;
> 
> /*
>  * Assign the space to tasks
>  * There may be some new threads created when we allocate space.
>  * new_task will track its number.
>  */
> raw_spin_lock_irqsave(&task_data_events_lock, flags);
> 
> if (atomic_inc_return(&nr_task_data_events) > 1)
> 	goto unlock;
> 
> for_each_process_thread(g, p) {
> 	if (i < num_thread)
> 		p->perf_ctx_data = data[i++];
> 	else
> 		new_task++;
> }
> raw_spin_unlock_irqrestore(&task_data_events_lock, flags);

Is that lock taken in the context switch?

If not could be a normal spinlock, thus be more RT friendly.

-Andi
