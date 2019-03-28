Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23E42173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553750867;
	bh=sTepjNv+lCttaCr4VU9DFErARrxIXKIrE1XAT2yCnT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TIngBnV4j1sRjiJKoR+4pmN8vQnLhhAVa/QojQ4wU8FE2+cTQp6297clO2PpFi4Zt
	 9qLFRE27UOdcpaaNG0Vc+Vpapis8XJ0scNkedyy2EdrIVKeFskM8J1r1MFn429MVEe
	 XDbSRxwdGWz9HqnFpjmMTSK5FLzy4zFF/c/qA4A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfC1F1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfC1F1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:27:46 -0400
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF92E20811;
        Thu, 28 Mar 2019 05:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553750865;
        bh=sTepjNv+lCttaCr4VU9DFErARrxIXKIrE1XAT2yCnT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghQSSAHd696QGn+wXbUqndwaG1Dif8y9b+peZpRV5cVeKwvi4YBB1vQJsf1UgZi41
         r7OYZYMqs7xwGxxyGhxp04tZw+7ZwLura3Ol9unj7rbFtODnaWiorTJYnLxq41wSoB
         Tc8QfhCugiPR1FP5ITLNenpuTAdcDCTiTEaGx60s=
Date:   Thu, 28 Mar 2019 06:27:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20190328052741.GA29635@lenoir>
References: <000000000000639f6a0584d11b82@google.com>
 <20190327132805.GG32571@zn.tnic>
 <CACT4Y+bHd938t-w++LBO-yHMWP1cXpn+U=AVL+8mMfTBYk86=g@mail.gmail.com>
 <20190327151725.GH32571@zn.tnic>
 <20190327174841.GI32571@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327174841.GI32571@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:48:41PM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 04:17:25PM +0100, Borislav Petkov wrote:
> Ok, after adding some debug output, it looks like this (newlines mine):
> 
> [  200.921625][ T8029]    repro-8029    0d..4 200923254us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
> 
> [  200.922507][ T8029]    repro-8029    0d..4 200923257us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
> [  200.923397][ T8029]    repro-8029    0d..4 200923259us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40
> 
> [  200.924294][ T8029]    repro-8029    0d..4 200923262us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
> [  200.925175][ T8029]    repro-8029    0d..4 200923264us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40
> [  200.926054][ T8029]    repro-8029    0d..4 200923266us : arch_install_hw_breakpoint: i: 2, slot: ffff8880602004c0
> 
> [  200.926933][ T8029]    repro-8029    0d..4 200923270us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
> [  200.927816][ T8029]    repro-8029    0d..4 200923271us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40
> [  200.928695][ T8029]    repro-8029    0d..4 200923273us : arch_install_hw_breakpoint: i: 2, slot: ffff8880602004c0
> [  200.929573][ T8029]    repro-8029    0d..4 200923275us : arch_install_hw_breakpoint: i: 3, slot: ffff88806991ed00
> 
> which basically shows how this thread adds 4 breakpoints and hits the
> warn on on the 5th.
> 
> Now, that code I've seen only once or twice so I don't have a very smart
> guess but it looks to me like arch_install_hw_breakpoint() or something
> scheduling the events above that, should check HBP_NUM and not schedule
> more than 4 hw breakpoints. Or..?
> 
> Frederic, I know you know this code... :-)

Ok, I finally managed to reproduce. The issue is unlikely to come from the
architecture. Perf shouldn't commit more breakpoints than possible so it's
probably perf events scheduling or hw breakpoint core constraints that are
broken. I'm investigating...

Thanks.
