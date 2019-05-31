Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B449C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE38265C0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur3sH+oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfEaI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:27:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaI1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F8NoI3W73DO0SCEdwnQavtdIVV42FzonTKlzSvHEtGs=; b=Ur3sH+oFD8zknDu0FjLQ9xW9C
        Cfc6ClXXQ+d/xmjRNsCynnL5OkLL7Yjvm1MxZsplISWfPwuoaNsJPV7tU8P7H1h7/gmAltCwLFEVG
        0wVwN3Aw0IPrhB639kNEpkn9ri3ytGh+84ImmBMUsEO4VQ6DeBpmUs4Lvek3PvipszzKyu6EdRz4e
        g0oOBLFzxb9l4ZSNYtrFi5duy4QtcnWSt0F02hhn6ZOw3u8PcQ5twQEbE22UCLVK1wXaJueQjbJjd
        kSREAFdl5Alge3uvXj01Vmc02qiVn+j59ok2qOzfETmZkZsFnRkoRsQikEoMA13zg21wdzzpdaaqG
        wK3+8emTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWcst-000071-1C; Fri, 31 May 2019 08:27:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7EE4201B8CFE; Fri, 31 May 2019 10:27:28 +0200 (CEST)
Date:   Fri, 31 May 2019 10:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     l00383200 <liucheng32@huawei.com>, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stacktrace in ARM32 architecture has jumped the first 2
 layers, which may ignore the display of save_stack_trace_tsk.
Message-ID: <20190531082728.GK2623@hirez.programming.kicks-ass.net>
References: <1559228799-84473-1-git-send-email-liucheng32@huawei.com>
 <20190530162219.dtooagpeyczfaazb@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530162219.dtooagpeyczfaazb@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:22:19PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, May 30, 2019 at 11:06:39PM +0800, l00383200 wrote:
> > Without optimization, both save_stack_trace_tsk and __save_stack_trace
> > will have stacktrace information in ARM32.
> > 
> > In this situation, "data.skip += 2" operation will skip the first two layers,
> > which may make the stacktrace strange and different from other architectures.
> > 
> > A simple example is as follows:
> > In ARM32 architecture:
> > [<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
> > [<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
> > [<ffffff800838aca8>] seq_read+0x130/0x420
> > [<ffffff8008365c54>] __vfs_read+0x60/0x11c
> > [<ffffff80083665dc>] vfs_read+0x8c/0x140
> > [<ffffff800836717c>] SyS_read+0x6c/0xcc
> > [<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > 
> > In some other architectures(ARM64):
> > [<ffffff8008209be0>] save_stack_trace_tsk+0x0/0xf0
> > [<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
> > [<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
> > [<ffffff800838aca8>] seq_read+0x130/0x420
> > [<ffffff8008365c54>] __vfs_read+0x60/0x11c
> > [<ffffff80083665dc>] vfs_read+0x8c/0x140
> > [<ffffff800836717c>] SyS_read+0x6c/0xcc
> > [<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > 
> > Therefore, we'd better just jump only one layer to ensure accuracy and consistency.
> 
> Why do we want to log the function we called to save the stack trace
> _in_ the stack trace?  What useful purpose does it serve?
> 
> I've always taken the attitude that if we want a stack trace from a
> certain point in the function, then that's the point that the stack
> trace should start.  It's entirely sensible.

Agreed, also the .skip interface sucks and is slated for replacement
(whenever we get around to it).
