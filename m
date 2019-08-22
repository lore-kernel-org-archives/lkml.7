Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8D7233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566512469;
	bh=ZK+4viUVMcreAR+kV5XHqpEXMtz6TyLzfEBgLHO7caI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=t/bPVy25upgqndU8AQYyZP+dReVNNOIozYlT3Y7XOjR4q4WRGTaeY5J55qfOTY/FD
	 8qKdN6hRw1hBW/mwj6j/XVk/UOn1NOeCHs8M3LhNPyoWf21STjNmHKDVLthxIR4nP3
	 bQRL7ZYMFv8y53Uqee7Tlpk/f7SeB5yL85KD5odM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393819AbfHVWVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390362AbfHVWVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:21:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FE320578;
        Thu, 22 Aug 2019 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566512467;
        bh=ZK+4viUVMcreAR+kV5XHqpEXMtz6TyLzfEBgLHO7caI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZTRiKivSAnGbuVXi3lr95pqlLec8Z+IfiP0Bllptj/JGK2b8EHoCoXAuAn+OT9Ib
         45iKPDgQdTC3BokxrM+bDrAfYjp43O2+6A7fnwuqJBQxeEeGtnithXRIZhL0e5f7XM
         HyQY5ur/FIYPpS773GIiS3zKK0jwdauQN5sq9rrI=
Date:   Thu, 22 Aug 2019 15:21:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
Subject: Re: [PATCH v3] psi: get poll_work to run when calling poll syscall
 next time
Message-Id: <20190822152107.adc0d4cd374fcc3eb8e148a9@linux-foundation.org>
In-Reply-To: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 11:26:25 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> Only when calling the poll syscall the first time can user
> receive POLLPRI correctly. After that, user always fails to
> acquire the event signal.
> 
> Reproduce case:
> 1. Get the monitor code in Documentation/accounting/psi.txt
> 2. Run it, and wait for the event triggered.
> 3. Kill and restart the process.
> 
> The question is why we can end up with poll_scheduled = 1 but the work
> not running (which would reset it to 0). And the answer is because the
> scheduling side sees group->poll_kworker under RCU protection and then
> schedules it, but here we cancel the work and destroy the worker. The
> cancel needs to pair with resetting the poll_scheduled flag.

Should this be backported into -stable kernels?
