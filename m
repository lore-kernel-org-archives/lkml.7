Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBFB24D18
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559292450;
	bh=IIaVN1Sed6YeNQgaJd2OLBZP8P14wg5t9mFGKrpWqq8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=VgCXKNZZLtHGW7tNjivbL+U0ajD0ItHBTwBJ3CO+0UoUo8ctRZFr51yVpRFs+GfDd
	 dz2SbuqNBpC2le2G5BvxYw1nNs/6ERaPoxK26J+4yJhg/HtPIyFzh7PhCe3IUKjy6w
	 hSCRnrMVN52feVwlx/GFzekSpRRoX7kXjr2jHGkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEaIr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:47:27 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253B3206C1;
        Fri, 31 May 2019 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559292446;
        bh=IIaVN1Sed6YeNQgaJd2OLBZP8P14wg5t9mFGKrpWqq8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LsBosZBqtOKJ1OYqUUke6mXwXRYOqUy+Ul4wPQoIxfeBsqxdbhJSrGVlsiZCug0Pn
         g/6ripfj3sQG/05kWEYiCt9ROMJn5gBz3IF8W8DVi8nHHRlDZlyyQyAej+4eD4ERvw
         gHXuqLhP+2PG+VWeAkvawjMIhmw+59QfGqQq7lF8=
Date:   Fri, 31 May 2019 10:47:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190531051456.fzkvn62qlkf6wqra@treble>
Message-ID: <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm> <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com> <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com> <20190530233804.syv4brpe3ndslyvo@treble> <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, Josh Poimboeuf wrote:

> > I disagree with that from the backwards compatibility point of view.
> > 
> > I personally am quite frequently using differnet combinations of 
> > resumer/resumee kernels, and I've never been biten by it so far. I'd guess 
> > I am not the only one.
> > Fixmap sort of breaks that invariant.
> 
> Right now there is no backwards compatibility because nosmt resume is
> already broken.

Yeah, well, but that's "only" for nosmt kernels at least.

> For "future" backwards compatibility we could just define a hard-coded 
> reserved fixmap page address, adjacent to the vsyscall reserved address.
> 
> Something like this (not yet tested)?  Maybe we could also remove the
> resume_play_dead() hack?

Does it also solve cpuidle case? I have no overview what all the cpuidle 
drivers might be potentially doing in their ->enter_dead() callbacks. 
Rafael?

Thanks,

-- 
Jiri Kosina
SUSE Labs

