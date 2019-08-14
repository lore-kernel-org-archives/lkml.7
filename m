Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE9C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A10206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfHNNjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:39:16 -0400
Received: from foss.arm.com ([217.140.110.172]:54884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfHNNjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:39:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 711A428;
        Wed, 14 Aug 2019 06:39:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA2B3F706;
        Wed, 14 Aug 2019 06:39:12 -0700 (PDT)
Date:   Wed, 14 Aug 2019 14:39:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 8/9] x86/fpu: correctly check for kthreads
Message-ID: <20190814133910.GC51963@lakrids.cambridge.arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-9-mark.rutland@arm.com>
 <20190814130708.b4lu3d6enkga5p4h@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814130708.b4lu3d6enkga5p4h@linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:07:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-14 11:41:30 [+0100], Mark Rutland wrote:
> > Per commit:
> > 
> >   0cecca9d03c964ab ("x86/fpu: Eager switch PKRU state")
> > 
> > ... switch_fpu_state() is trying to distinguish user threads from
> > kthreads, such that kthreads consistently use init_pkru_value. It does
> > do by looking at current->mm.
> > 
> > In general, a non-NULL current->mm doesn't imply that current is a
> > kthread, as kthreads can install an mm via use_mm(), and so it's
> > preferable to use is_kthread() to determine whether a thread is a
> > kthread.
> 
> I think this was missed in commit.
> 	8d3289f2fa1e0 ("x86/fpu: Don't use current->mm to check for a kthread")

Yup, though if it's a bug it's been a bug since commit:

  0cecca9d03c964ab ("x86/fpu: Eager switch PKRU state")

... which I guess the fixes tag would have to mention.

> 
> A kthread with use_mm() would load here non-existing FPU state.
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Given the above, should I add the fixes tag (for 0cecca9d03c964ab)?

Thanks,
Mark.
