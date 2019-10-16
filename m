Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94673ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751372084B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfJPBRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfJPBRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:17:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515792084B;
        Wed, 16 Oct 2019 01:17:43 +0000 (UTC)
Date:   Tue, 15 Oct 2019 21:17:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20191015211741.3ff2f3a1@gandalf.local.home>
In-Reply-To: <20191016004120.GD89937@google.com>
References: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
        <20191015111910.4496-2-viktor.rosendahl@gmail.com>
        <20191016004120.GD89937@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 20:41:20 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > +static const struct file_operations tracing_max_lat_fops;
> > +
> > +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> > +	defined(CONFIG_FSNOTIFY)  
> 
> Something bothers me. If you dropped support for HWLAT_TRACER as you
> mentioned in the cover letter, then why does this #if look for the CONFIG
> option?
> 
> (and similar comment on the rest of the patch..)

Also, if you have a complex if statement like this, it is better to
create a new define to set it in a header file:

#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
	defined(CONFIG_FSNOTIFY)
# define HAVE_TRACER_FSNOTIFY
#endif

And then just use that:

#ifdef HAVE_TRACER_FSNOTIFY
...
#endif

It keeps things a bit more manageable.

-- Steve
