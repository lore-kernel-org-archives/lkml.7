Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176AC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsXQZLPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634016AbfIYIJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:09:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438038AbfIYIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZTp1Ng9H3hL5ZJ1CdTCjTLI6S/AduCHTkq4VvYkPq2Q=; b=dsXQZLPBCIPHbyIxLSnsGgoc6
        Joh4RgfQN18BdjbeCImvKbgyNcpzQCEdvDg7MPkXymomvoLi6xZjFWWPfuvbph+fzzPPODVeLwYai
        OUwL8vLN4UvQ1IbcfsiQmYDwokIbQdLBOmAk7cBAOsom7ij4W66XoEmf9kGvONNEqomumfsCASLP3
        ok9aoHF+pRe1PqiN51GYk6A2RMDWLcwZFHFGiRmFk8jUFl7U99uBBHbP8BQ5Fhsj+BPtinWWz68HX
        r4xeU6nb/vFBPoooUA4Jp12Q1b7PzNSXhJKKASNYnoocSTIvs8BXZOAxfDvwxbXVc/sf5tf5emZDK
        8VMizj33g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD2Kl-0001WT-PM; Wed, 25 Sep 2019 08:07:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25DF2305E44;
        Wed, 25 Sep 2019 10:06:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032C5202C9D4B; Wed, 25 Sep 2019 10:07:32 +0200 (CEST)
Date:   Wed, 25 Sep 2019 10:07:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH for 5.4 0/7] Membarrier fixes and cleanups
Message-ID: <20190925080732.GC4536@hirez.programming.kicks-ass.net>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
 <20190923090636.GH2349@hirez.programming.kicks-ass.net>
 <485879119.4072.1569250532294.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485879119.4072.1569250532294.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:55:32AM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 23, 2019, at 5:06 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Thu, Sep 19, 2019 at 01:36:58PM -0400, Mathieu Desnoyers wrote:
> >> Hi,
> >> 
> >> Those series of fixes and cleanups are initially motivated by the report
> >> of race in membarrier, which can load p->mm->membarrier_state after mm
> >> has been freed (use-after-free).
> >> 
> > 
> > The lot looks good to me; what do you want done with them (them being
> > RFC and all) ?
> 
> I can either re-send them without the RFC tag, or you can pick them directly
> through the scheduler tree.

I've picked them up (and fixed them up, they didn't apply to tip) and
merge them with Eric's task_rcu_dereference() patches.

I'll push it out in a bit.
