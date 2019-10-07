Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559842084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570467106;
	bh=rbJXiYsft/c1AQX7jWydtI8lRj1XxLZmEODMfBy6xnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NS8nDZFQS0Xx3R8Mpx1DXOSBsa/0Wvz8zThzqTt2W4Jaf8BQ+MtrAcXAkuGPkotgK
	 7L+RHR48dNLE3E018yOkBV1z1Rzg+VIOhjZNM5aCty1TFNy/tKMKsiV+2eBtfPByC4
	 p8ZJ8NB6VtfOHvkg7Wif2jG3KTzpgae4LAJKEsks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfJGQvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfJGQvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:51:44 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1462070B;
        Mon,  7 Oct 2019 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570467104;
        bh=rbJXiYsft/c1AQX7jWydtI8lRj1XxLZmEODMfBy6xnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUBbN/a9T3gpW7OEfYIdJNqjKk0perCmfvxVYjLXrlWFQ07Ruicqw6//IgTz4kMXB
         RBwZ+BsgxpFFTDE1So5Nls79w6FCJzsq4aBdKXKfYFLmlHEAwqZRlrsNB0y1yU+EKi
         srUXZmf/pXg/hASjzXyUekEOr5270KEftMB57ISc=
Date:   Mon, 7 Oct 2019 18:51:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 0/2] vtime: Remove pair of seqcount on context switch
Message-ID: <20191007165140.GA31013@lenoir>
References: <20191003161745.28464-1-frederic@kernel.org>
 <20191007162031.GA7676@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007162031.GA7676@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:20:31PM +0200, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > Extracted from a larger queue that fixes kcpustat on nohz_full, these
> > two patches have value on their own as they remove two write barriers
> > on nohz_full context switch.
> > 
> > Frederic Weisbecker (2):
> >   vtime: Rename vtime_account_system() to vtime_account_kernel()
> >   vtime: Spare a seqcount lock/unlock cycle on context switch
> > 
> >  arch/ia64/kernel/time.c          |  4 +--
> >  arch/powerpc/kernel/time.c       |  6 ++--
> >  arch/s390/kernel/vtime.c         |  4 +--
> >  include/linux/context_tracking.h |  4 +--
> >  include/linux/vtime.h            | 38 ++++++++++++------------
> >  kernel/sched/cputime.c           | 50 ++++++++++++++++++--------------
> >  6 files changed, 57 insertions(+), 49 deletions(-)
> 
> Which tree is this against? Doesn't apply cleanly to v5.4-rc2 nor v5.3. 
> Does it have any prereqs perhaps?

Indeed, you need to apply this fix first: https://lore.kernel.org/lkml/20190925214242.21873-1-frederic@kernel.org/

"[PATCH] sched/vtime: Fix guest/system mis-accounting on task switch"

Thanks!
