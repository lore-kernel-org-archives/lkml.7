Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLBhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:37:45 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:36831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbfKLBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:37:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66AB6180A68C6;
        Tue, 12 Nov 2019 01:37:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck48_6064df2d13208
X-Filterd-Recvd-Size: 2216
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 01:37:42 +0000 (UTC)
Message-ID: <24e38dd1be9e0f6e4520cb81f72e27b88dae4015.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Mon, 11 Nov 2019 17:37:26 -0800
In-Reply-To: <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
         <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
         <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
         <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
         <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 09:12 -0800, Linus Torvalds wrote:
> On Sun, Nov 10, 2019 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> > The !! logical usage is not particularly common in the kernel.
> > There seems to be only a couple/few dozen.
> 
> Your grep pattern is for the explicitly silly "turn a boolean to a
> boolean". That should certainly be rare.
> 
> But I meant it in a more general way - there's a lot of common use of
> "!!" for "turn this expression into a boolean". A trivial grep for
> that (didn't check how correct it was - there might be comments that
> are very excited too) implies that we have a fair amount of this
> pattern:
> 
>     $ git grep '[^!]!![^!]' -- '*.[ch]' | wc -l
>     7007

Likely the majority of those are bit comparison coercions to 0/1 like

	int val = !!(A & B)

> so the '!!' pattern itself isn't rare.

And likely these !! patterns are preferred to (A & B) != 0

I don't care much either way as either form, unlike !!(A == B),
is not redundant.


