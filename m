Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841C12073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfLLShj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:37:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52382 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbfLLShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:37:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifTKr-0001ft-Pm; Thu, 12 Dec 2019 18:37:13 +0000
Date:   Thu, 12 Dec 2019 18:37:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] use do_mount() instead of ksys_mount()
Message-ID: <20191212183713.GI4203@ZenIV.linux.org.uk>
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <CAHk-=wgQRXLjXC5YxJd1VHoGpMB6wg=2XaLj1FgH=H+bP8=fDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQRXLjXC5YxJd1VHoGpMB6wg=2XaLj1FgH=H+bP8=fDQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:11:10AM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 5:59 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > This small series replaces all in-kernel calls to the
> > userspace-focused wrapper ksys_mount() with calls to
> > the kernel-centric do_mount().
> 
> If you fix the pointless cast I pointed out, and put it in a git
> branch, I'll pull it.
> 
> In fact, just do both series in the same branch, they do conceptually
> the same thing, after all.

IMO it's not a good idea.  Exposing the guts of fs/namespace.c to
what's essentially a userland code that happens to run in kernel thread
is asking for trouble - we'd been there and it had been hell to untangle.
