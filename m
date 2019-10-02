Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12155C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B820659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfJBWuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfJBWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:50:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E394120659;
        Wed,  2 Oct 2019 22:50:44 +0000 (UTC)
Date:   Wed, 2 Oct 2019 18:50:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v7 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20191002185043.298fa820@gandalf.local.home>
In-Reply-To: <fc1de769-a00e-b7cc-50cb-796560d79d89@gmail.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
        <20190920152219.12920-2-viktor.rosendahl@gmail.com>
        <20191002111324.7590bf6d@gandalf.local.home>
        <fc1de769-a00e-b7cc-50cb-796560d79d89@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019 00:04:56 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> > Can fsnotify() be called from irq context? If so, why have the work
> > queue at all? Just do the work from the irq_work handler.
> >   
> 
> fsnotify() might sleep. It calls send_to_group(), which calls 
> inotify_handle_event() through a function pointer.
> 
> inotify_handle_event() calls kmalloc() without the GFP_ATOMIC flag.
> 
> There might be other reasons as well but the above is one that I have 
> seen a warning for, when enabling CONFIG_DEBUG_ATOMIC_SLEEP and trying 
> to call fsnotify() from an atomic context.

Thanks for the context. I wonder if we should add a "might_sleep()" to
fsnotify() then.

-- Steve
