Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E533520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554690231;
	bh=lrCw0iUUmcs2Ad2V6P14jHAscsgzliMMc40BRmRKkcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mRQJJbmgzfajR+FudhLaTO06Lew/fxCrlTyevz2YkUHeUzuslu87RK7FpeR0MfMBo
	 bhxel0QA4yO5S6KNcWYHwfymcSTC9p8Z4yY5DmpglJ/j8S3etdaL6OFPaGBjpmH4uG
	 3i2QYa7quIIjnT2XYhwPZ57Vg9hgdf7U9df35U6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDHCXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfDHCXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:23:48 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88AF208E3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 02:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554690228;
        bh=lrCw0iUUmcs2Ad2V6P14jHAscsgzliMMc40BRmRKkcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1v0QDghtyT39gjJhJHL0Xj+SDtwpSWO5S5XDa6Bqz2ck825+z92XJfmaYfXsC7C8n
         4mI6jzHOsDlzh9+CPKPjtH8pWwoHilvnn4faVo7Mr/OQWjXP35uQrrSff60VyyExyu
         Oe38qKSH3PKPbFk5q4qES4rfpzhFdyy0IT+LqcD4=
Received: by mail-wm1-f45.google.com with SMTP id a184so12425420wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 19:23:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWlOSgYSJ45xJjzzsfrGnmAiGPR9nOO5Xmc6ILV62ELIRJF36Bj
        quMUK1sVpl9GXwKjqql+JH/mWHCq79mE2Fk5OhDhNA==
X-Google-Smtp-Source: APXvYqxXZOaSXTJWewKrKlJZ4enftV1rq7D2Q/p5HVpsgENvDvTI1s+BpiJ+UtbRfbFCTzPW3YNICFcRidwp+HEpO78=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr16352574wmh.9.1554690226392;
 Sun, 07 Apr 2019 19:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de>
 <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com> <alpine.DEB.2.21.1904080043390.1840@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904080043390.1840@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 7 Apr 2019 19:23:34 -0700
X-Gmail-Original-Message-ID: <CALCETrXyfEu5MHCDp+OiRdHcYQ1tMNhTMSxcAhWkOx_8r2rxsA@mail.gmail.com>
Message-ID: <CALCETrXyfEu5MHCDp+OiRdHcYQ1tMNhTMSxcAhWkOx_8r2rxsA@mail.gmail.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 6 Apr 2019, Andy Lutomirski wrote:
> > On Fri, Apr 5, 2019 at 8:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > From: Andy Lutomirski <luto@kernel.org>
> > >
> > > The IRQ stack lives in percpu space, so an IRQ handler that overflows it
> > > will overwrite other data structures.
> > >
> > > Use vmap() to remap the IRQ stack so that it will have the usual guard
> > > pages that vmap/vmalloc allocations have. With this the kernel will panic
> > > immediately on an IRQ stack overflow.
> >
> > The 0day bot noticed that this dies with DEBUG_PAGEALLOC on.  This is
> > because the store_stackinfo() function is utter garbage and this patch
> > correctly detects just how broken it is.  The attached patch "fixes"
> > it.  (It also contains a reliability improvement that should probably
> > get folded in, but is otherwise unrelated.)
> >
> > A real fix would remove the generic kstack_end() function entirely
> > along with __HAVE_ARCH_KSTACK_END and would optionally replace
> > store_stackinfo() with something useful.  Josh, do we have a generic
> > API to do a little stack walk like this?  Otherwise, I don't think it
> > would be the end of the world to just remove the offending code.
>
> Actually we have: save_stack_trace()
>

Like I did here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=WIP.x86/stackguards

(Link is bad right now but will hopefully be okay when you read it.
I'm still fiddling with the other patches in there -- I'd like to kill
kstack_end() entirely.
