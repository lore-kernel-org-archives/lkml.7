Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57646C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032420862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfENQvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENQvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:51:05 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C46220675;
        Tue, 14 May 2019 16:51:05 +0000 (UTC)
Date:   Tue, 14 May 2019 12:51:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3 0/4] Some new features for the latency tracers
Message-ID: <20190514125103.64d778d6@oasis.local.home>
In-Reply-To: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
References: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 23:50:04 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> Hello all,

Hi Viktor,

Note, as the merge window is open and I'm also currently at a
conference, it may be a while before I can take a look at this. If you
don't hear something from me in 10 days, feel free to send me a ping.

-- Steve



> 
> Changes in v3:
> - [PATCH 1/4]: 
>   * I have generalized this to send the fsnotify() notifications for all
>     tracers that use tracing_max_latency.
> 
>   * There are large additions of code to prevent queue_work() from being
>     called while we are in __schedule() or do_idle(). This was a bug also
>     in the previous version but had gone unnoticed. It became very visible
>     when I tried to make it work with the wakeup tracers because they are
>     always invoked from the sched_switch tracepoint.
> 
>   * The fsnotify notification is issued for tracing_max_latency, not trace.
> 
>   * I got rid of the kernel config option. The facility is always compiled
>     when CONFIG_FSNOTIFY is enabled and any of the latency tracers are
>     enabled.
> 
> - [PATCH 2/4]:
>   * No significant changes.
> 
> - [PATCH 3/4]:
>   * The latency-collector help messages have been tuned to the fact that it
>     can be used also with wakeup and hwlat tracers.
> 
>   * I increased the size of the buffer for reading from
>     /sys/kernel/debug/tracing/trace.
> 
>   * Adapted it to monitor tracing_max_latency instead of trace
> 
> - [PATCH 4/4]:
>   * I converted this from a kernel config option to a trace config option
>     that can be changed at runtime.
> 
>
