Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84C6206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfHNNHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:07:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfHNNHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:07:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxszc-00053M-Rq; Wed, 14 Aug 2019 15:07:08 +0200
Date:   Wed, 14 Aug 2019 15:07:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 8/9] x86/fpu: correctly check for kthreads
Message-ID: <20190814130708.b4lu3d6enkga5p4h@linutronix.de>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814104131.20190-9-mark.rutland@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 11:41:30 [+0100], Mark Rutland wrote:
> Per commit:
> 
>   0cecca9d03c964ab ("x86/fpu: Eager switch PKRU state")
> 
> ... switch_fpu_state() is trying to distinguish user threads from
> kthreads, such that kthreads consistently use init_pkru_value. It does
> do by looking at current->mm.
> 
> In general, a non-NULL current->mm doesn't imply that current is a
> kthread, as kthreads can install an mm via use_mm(), and so it's
> preferable to use is_kthread() to determine whether a thread is a
> kthread.

I think this was missed in commit.
	8d3289f2fa1e0 ("x86/fpu: Don't use current->mm to check for a kthread")

A kthread with use_mm() would load here non-existing FPU state.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
