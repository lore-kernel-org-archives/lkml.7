Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F204C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273BD22DBF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfE2N65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfE2N64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:58:56 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACAB522DA7;
        Wed, 29 May 2019 13:58:54 +0000 (UTC)
Date:   Wed, 29 May 2019 09:58:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190529095852.36865060@oasis.local.home>
In-Reply-To: <20190529134946.GY2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
        <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
        <20190529083357.GF2623@hirez.programming.kicks-ass.net>
        <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
        <20190529102038.GO2623@hirez.programming.kicks-ass.net>
        <20190529083930.5541130e@oasis.local.home>
        <20190529131957.GV2623@hirez.programming.kicks-ass.net>
        <20190529094213.3e344965@oasis.local.home>
        <20190529134946.GY2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 15:49:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> > That's basically what I was suggesting as the solution to this ;-)  
> 
> You were wanting changes to preempt_disable() and task_struct, neither
> of which is required. The above only needs some per-cpu storage in the
> tracer implementation.

Only changes were to the trace preempt_disable() code. Which I still
think needs to be done regardless to differentiate between when we are
tracing preempt disable and when we are not.

And no modification would need to be done to task_struct as we already
have a place to add tracing flags.

-- Steve



