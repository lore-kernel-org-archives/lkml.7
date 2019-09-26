Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F302222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URbFQq7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfIZIOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:14:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfIZIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qNXe1DLOYq+LbjBhS7qEU55tuee2E34vS3LvdrTMFfk=; b=URbFQq7Q6H62SX2gi4xc3zxRT
        DvGAdonmQPJkhuQJkcPKu8Tq9ElDbFv5oKaF7BJFHZR9Bf7xvbPicryV+XuarU9l4DB8H9Ty6CY2A
        JDWFR3FvLGCvVUtO6YHwBcx44A36QDbuNNsg3ieot1EXUZps0Z62BVR6PTuaWS4C1jUhZMfj+c2Uw
        MLAM/ZUPwqSjoicTtvqCeps5mhIRAfX4lqJxpiJ6gMlrY7silK63xescQ9lkGwy+z26WkZWkRoh5w
        GVUqzTazYaf+Kk4MIl9T3J/1av+yI4ncyMVCLc/dO4D2KiR8tdMJnXSv1b01XqrVe5WlzjdbFZr+L
        zhbDFdREg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDOua-0003l8-N8; Thu, 26 Sep 2019 08:14:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93D7B302A71;
        Thu, 26 Sep 2019 10:13:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF10520138CCF; Thu, 26 Sep 2019 10:14:00 +0200 (CEST)
Date:   Thu, 26 Sep 2019 10:14:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] sched/vtime: Fix guest/system mis-accounting on task
 switch
Message-ID: <20190926081400.GH4553@hirez.programming.kicks-ass.net>
References: <20190925214242.21873-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925214242.21873-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:42:42PM +0200, Frederic Weisbecker wrote:
> vtime_account_system() assumes that the target task to account cputime
> to is always the current task. This is most often true indeed except on
> task switch where we call:
> 
> 	vtime_common_task_switch(prev)
> 		vtime_account_system(prev)
> 
> Here prev is the scheduling-out task where we account the cputime to. It
> doesn't match current that is already the scheduling-in task at this
> stage of the context switch.
> 
> So we end up checking the wrong task flags to determine if we are
> accounting guest or system time to the previous task.
> 
> As a result the wrong task is used to check if the target is running in
> guest mode. We may then spuriously account or leak either system or
> guest time on task switch.
> 
> Fix this assumption and also turn vtime_guest_enter/exit() to use the
> task passed in parameter as well to avoid future similar issues.
> 
> Fixes: 2a42eb9594a1 ("sched/cputime: Accumulate vtime on top of nsec clocksource")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>

Thanks!
