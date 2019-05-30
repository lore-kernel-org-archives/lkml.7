Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B6C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4A725762
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE3Kfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:35:43 -0400
Received: from foss.arm.com ([217.140.101.70]:33934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3Kfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:35:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153F2374;
        Thu, 30 May 2019 03:35:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429CB3F5AF;
        Thu, 30 May 2019 03:35:39 -0700 (PDT)
Date:   Thu, 30 May 2019 11:35:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au, acme@redhat.com, eranian@google.com,
        fweisbec@gmail.com, jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190530103536.GA56046@lakrids.cambridge.arm.com>
References: <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
 <20190529162435.GM31777@lakrids.cambridge.arm.com>
 <20190529163854.GN31777@lakrids.cambridge.arm.com>
 <20190529170313.GE2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529170313.GE2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:03:13PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 05:38:54PM +0100, Mark Rutland wrote:
> > Generally speaking though, if we ever task task_pt_regs() of an idle
> > task we'll get junk, and user_mode() could be true.
> 
> Agreed, but we're not doing that.

Sure.

I just think that might be an argument for having task_pt_regs() return
NULL for kthreads, or having a WARN_ON_ONCE(t->flags & PF_KTHREAD) to
catch missing checks elsewhere.

Thanks,
Mark.
