Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103420674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKVLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:33:01 -0500
Received: from foss.arm.com ([217.140.110.172]:46102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKVLdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:33:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 508F8328;
        Fri, 22 Nov 2019 03:33:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85CE73F703;
        Fri, 22 Nov 2019 03:32:59 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:32:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@suse.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: KASAN_INLINE && patchable-function-entry
Message-ID: <20191122113257.GB15749@lakrids.cambridge.arm.com>
References: <20191121183630.GA3668@lakrids.cambridge.arm.com>
 <20191121142737.69978ef9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121142737.69978ef9@oasis.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:27:37PM -0500, Steven Rostedt wrote:
> On Thu, 21 Nov 2019 18:36:32 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > As a heads-up to the ftrace folk, I think it's possible to work around
> > this specific issue in the kernel by allowing the arch code to filter
> > out call sites at init time (probably in ftrace_init_nop()), but I
> > haven't put that together yet.
> 
> If you need to make some code invisible to ftrace at init time, it can
> be possible by setting the dyn_ftrace rec flag to DISABLED, but this
> can be cleared, which we would need a way to keep it from being
> cleared, which shouldn't be too hard.
> 
> Is that what you would be looking for?

That sounds about right, assuming that would also prevent those from
showing up in available_filter_functions, etc.

Another option would be to have arm64's ftrace_adjust_addr() detect this
case and return NULL, given we don't need to perform any call site
initialization for the redundant NOPs. I'm just not sure if we have all
the necessary information at that point, though.

Thanks,
Mark.
