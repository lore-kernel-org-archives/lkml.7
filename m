Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD846C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9220020652
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436816AbfFLIMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730479AbfFLIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:12:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8BF6AF03;
        Wed, 12 Jun 2019 08:12:43 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:12:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, joe.lawrence@redhat.com,
        kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/3] stacktrace: Remove weak version of
 save_stack_trace_tsk_reliable()
Message-ID: <20190612081243.4pnj4bqpy4xto6nf@pathway.suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
 <20190611141320.25359-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611141320.25359-2-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-06-11 16:13:18, Miroslav Benes wrote:
> Recent rework of stack trace infrastructure introduced a new set of
> helpers for common stack trace operations (commit e9b98e162aa5
> ("stacktrace: Provide helpers for common stack trace operations") and
> related). As a result, save_stack_trace_tsk_reliable() is not directly
> called anywhere. Livepatch, currently the only user of the reliable
> stack trace feature, now calls stack_trace_save_tsk_reliable().
> 
> When CONFIG_HAVE_RELIABLE_STACKTRACE is set and depending on
> CONFIG_ARCH_STACKWALK, stack_trace_save_tsk_reliable() calls either
> arch_stack_walk_reliable() or mentioned save_stack_trace_tsk_reliable().
> x86_64 defines the former, ppc64le the latter. All other architectures
> do not have HAVE_RELIABLE_STACKTRACE and include/linux/stacktrace.h
> defines -ENOSYS returning version for them.
> 
> In short, stack_trace_save_tsk_reliable() returning -ENOSYS defined in
> include/linux/stacktrace.h serves the same purpose as the old weak
> version of save_stack_trace_tsk_reliable() which is therefore no longer
> needed.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
