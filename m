Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24220663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfCEXrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCEXrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:47:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6E120661;
        Tue,  5 Mar 2019 23:47:35 +0000 (UTC)
Date:   Tue, 5 Mar 2019 18:47:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, Baohong Liu <baohong.liu@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] tracing: kdb: Fix ftdump to not sleep
Message-ID: <20190305184734.113a0fdc@gandalf.local.home>
In-Reply-To: <20190305233150.159633-1-dianders@chromium.org>
References: <20190305233150.159633-1-dianders@chromium.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Mar 2019 15:31:49 -0800
Douglas Anderson <dianders@chromium.org> wrote:

> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 5b9ae62272bb..0c8ab8bf4cfb 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -127,6 +127,8 @@ struct ring_buffer_event *
>  ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
>  		    unsigned long *lost_events);
>  
> +struct ring_buffer_iter *
> +_ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags);
>  struct ring_buffer_iter *
>  ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu);
>  void ring_buffer_read_prepare_sync(void);
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 06e864a334bb..fd60007aa7a1 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4201,6 +4201,29 @@ ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_consume);
>  
> +struct ring_buffer_iter *
> +_ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;

I don't care for this duplicate function. ring_buffer_read_prepare() is
only used in a few places, just add flags to it and to its users.

-- Steve
