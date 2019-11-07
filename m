Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC8FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5AE2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573116781;
	bh=atNfkvWqHmIDqLBv86TZs4C30jzzuzCcG/ghR09esKA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EW0yoWcrs+GcAxyS4tNpzxKuvuJEIExktVrM6RsPiQq/ySPZIh1pQ4WTXPEUOx4Rt
	 PZyZklEuYLQ08zvNC+PCup2QEErKaWprmIRFDQnE+3e1rz71ukkqyhnoUFul3Kjj0e
	 B6OH/00jz0fs0iuucQa8y4QNIbqEJuZrKbUro3Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfKGIw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:52:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733238AbfKGIw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:52:59 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.217.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223D62077C;
        Thu,  7 Nov 2019 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573116778;
        bh=atNfkvWqHmIDqLBv86TZs4C30jzzuzCcG/ghR09esKA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N7p8iKhXD7qMUIc0Kc48NqghvP37TKKdvsyPGXuC9QLTBsdANK8T1abwIYv4GvbZf
         HALn3YEjWZ/T4Syc1ONWryy8bSOJuL+pwfcY0EagM30R0/BsbnWeuKwSw/PyQ+sC3y
         VG3pBmbXTWwWDLIabQjqa0loryPex93TBVkwUjTs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8E51035227FC; Thu,  7 Nov 2019 00:52:55 -0800 (PST)
Date:   Thu, 7 Nov 2019 00:52:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
Message-ID: <20191107085255.GK20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191106174804.74723-1-edumazet@google.com>
 <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:59:36PM -0800, Eric Dumazet wrote:
> On Wed, Nov 6, 2019 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the timers/core branch of tip:
> > >
> > > Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> > > Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> > > Author:        Eric Dumazet <edumazet@google.com>
> > > AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
> > >
> > > hrtimer: Annotate lockless access to timer->state
> > >
> >
> > I guess we also need to fix timer_pending(), since timer->entry.pprev
> > could change while we read it.
> 
> It is interesting seeing hlist_add_head() has a WRITE_ONCE(h->first, n);,
> but no WRITE_ONCE() for the pprev change.
> 
> The WRITE_ONCE() was added in commit 1c97be677f72b3c338312aecd36d8fff20322f32
> ("list: Use WRITE_ONCE() when adding to lists and hlists")

The theory is that while the ->next pointer is concurrently accessed by
RCU readers, the ->pprev pointer is accessed only by updaters, who need
to supply sufficient synchronization.

But what is this theory missing in practice?

							Thanx, Paul
