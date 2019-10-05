Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A5ECE58B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E72222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570292171;
	bh=eqnryWtzabgZzM7uNXAO12dttpuheq0j+RkDpfvQTto=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1Mpe0uPLFwXb5j0EvptA6/x803UVd18tU9hL1fqZewSi3A/31DbaCYxfVX/t8E7sX
	 SICg0U04t98C8sfC4k7mdglwynojr+edq8/NpIHZHvvb8+sUKzjy7KAZLWYBjtqz+X
	 BL1ZxTImDDoWhCi9IWxKXAoI98Jqle8+4Y0vbHYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfJEQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfJEQQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:16:10 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A754120862;
        Sat,  5 Oct 2019 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570292169;
        bh=eqnryWtzabgZzM7uNXAO12dttpuheq0j+RkDpfvQTto=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QjucN5lc/gzfxGIgPsljQW0GS6FHdu1CwpKXYK7mTFlpz/AfwWyzp6UklxFWg+5Vk
         Xc8Z5D9joQ9RinxnLFFi7Ka8Wx67MCKOXmgTZj51GWKXZoxCobrVSZJx++J2KOr3H2
         FCMH2XaJaFOTg049hKtoBFuon7x665OQve2NGngc=
Date:   Sat, 5 Oct 2019 09:16:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH tip/core/rcu 9/9] rcu: Suppress levelspread uninitialized
 messages
Message-ID: <20191005161608.GH2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
 <20191003014728.13496-9-paulmck@kernel.org>
 <CAMuHMdW5+RSp6iycmyPnYPv+xHr5tNY7U3w-BVrWqz4BR2Dd7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5+RSp6iycmyPnYPv+xHr5tNY7U3w-BVrWqz4BR2Dd7w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:53:03AM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, Oct 3, 2019 at 3:49 AM <paulmck@kernel.org> wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > New tools bring new warnings, and with v5.3 comes:
> 
> According to the kisskb build logs, it happens with gcc 4.6.3 only ;-)
> 
> > kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
> >
> > This commit suppresses this warning by initializing the full array
> > to INT_MIN, which will result in failures should any out-of-bounds
> > references appear.
> >
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks for your patch!
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> (for the initialization loop, not for the actual INT_MIN value)

Applied, thank you!

> Unfortunately I don't have a gcc-4.6.3 Linux cross-compiler anymore.
> I tried with msp430-gcc-4.6.3 and some hackery to get it to compile,
> but that didn't let me reproduce the warning.

OK, please let me know when gcc-4.6.3 is old enough that this patch
should be reverted.  Or just submit the revert at that point, as the
case may be.  ;-)

							Thanx, Paul
