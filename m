Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14394ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75F221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfJKNLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfJKNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:11:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19097206A1;
        Fri, 11 Oct 2019 13:11:47 +0000 (UTC)
Date:   Fri, 11 Oct 2019 09:11:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191011091145.5d8304cb@gandalf.local.home>
In-Reply-To: <c482a958-e1f5-d39a-21e2-ade5cd41798e@redhat.com>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
        <20191003181045.7fb1a5b3@gandalf.local.home>
        <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
        <20191011070126.GU2328@hirez.programming.kicks-ass.net>
        <c482a958-e1f5-d39a-21e2-ade5cd41798e@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 09:37:10 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> But, yes, we will need [ as an optimization ] to sort the address right before
> inserting them in the batch. Still, having the ftrace_pages ordered seems to be
> a good thing, as in many cases, the ftrace_pages are disjoint sets.

I think it would be fine if we run the batches according to the ftrace
page groups. Which will be guaranteed to be sorted. I try to keep the
groups to a minimum, thus it shouldn't be too many ipi busts.

Although, my new work may actually make more page groups by trying to
cut down on the dyn_ftrace size by using offsets. If a function extends
outside the offset range, a new page group will need to be created.

-- Steve

