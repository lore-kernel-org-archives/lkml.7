Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8AC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868552087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gandi.net header.i=@gandi.net header.b="VmzJQ+5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfKFCWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:22:45 -0500
Received: from mail12.gandi.net ([217.70.182.73]:36683 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730562AbfKFCWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:22:45 -0500
Received: from khany.gandi.net (unknown [IPv6:2001:470:f3c7:4:4e47:6b16:8d51:b670])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id 889CF160548;
        Wed,  6 Nov 2019 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gandi.net; s=20190808;
        t=1573006962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NyNsVExiET/B0p0O+Ccmm1UHgNhyv2yUtlitAUYuRAQ=;
        b=VmzJQ+5iUrdHlevo7nUuQChnyVYJIlNkU7I+Yw0yS+8LHy/vvJWfOToiHRi/yq7XKfjFLo
        D7KHD4s+bEmg37zhDUnak08bIrzyZu8UVDZvtrfoh4oMMoaWWJPXr/X60ThX0jYKQGcjs0
        VZtt/DLCjV0NnKlPJlfUiWU+bin+OeJJOv9ijnZKE5tpXczxW/6cNjD/fiaJYuv4tfTVYj
        o+hq7jaUY0nN5ig12y9fw3TSjPUtXvf32zgqhwUZqBi6h5wXBpZ6/+MWqgrY4CYGi2IUvH
        cTaBDNi1QNqHeZsWPRwStwd+ZBwI6J5wJ76txzSZ57aGXMWwSM/R8Y/ksQ2kOw==
Received: by khany.gandi.net (Postfix, from userid 1000)
        id 822C6DC009B; Wed,  6 Nov 2019 02:22:16 +0000 (GMT)
Date:   Wed, 6 Nov 2019 02:22:16 +0000
From:   Arthur Gautier <baloo@gandi.net>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20191106022216.emntu2aiapsbyyeh@khany>
References: <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
 <20190926095825.zkdpya55yjusvv4g@khany>
 <20190926140939.GD18383@zn.tnic>
 <20191010164951.kr2epy5lyywgngt6@khany>
 <20191105141112.GB28418@zn.tnic>
 <20191105160530.vdaii44gckfo45rw@khany>
 <CALCETrXVuPWwMj9MByvdbRuerboweajaY3zT4eUaJQk4PXqnnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXVuPWwMj9MByvdbRuerboweajaY3zT4eUaJQk4PXqnnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:21:06PM -0800, Andy Lutomirski wrote:
> On Tue, Nov 5, 2019 at 8:05 AM Arthur Gautier <baloo@gandi.net> wrote:
> >
> > On Tue, Nov 05, 2019 at 03:11:12PM +0100, Borislav Petkov wrote:
> > > On Thu, Oct 10, 2019 at 04:49:51PM +0000, Arthur Gautier wrote:
> > > > I did not receive neither the patch Andy provided, nor the comments made
> > > > on it. But I'd be happy to help and/or take over to fix those if someone could
> > > > send me both.
> > >
> > > Yes, please do, it seems Andy's busy. You can find the whole thread here:
> > >
> > > https://lore.kernel.org/lkml/20190215235901.23541-1-baloo@gandi.net/
> > >
> > > and you can download it in mbox format.
> > >
> > > Care to take Andy's patch, work in the comments I made to it, test it,
> > > write a commit message, i.e., productize it?
> > >
> > > So that we get this thing moving...
> > >
> > > Thx.
> > >
> >
> > Hello Boris,
> >
> > Thank you! But I believe this is the patch I sent, I know Andy sent a
> > patchset with two patches, I believe privately (not copied to a public
> > ML) to some of the recepients here. I got a copy of the second patch
> > but not the first one.
> >
> > I believe from discussions here, that comments have been made on those
> > patchset and because I was not Cc-ed on those patches, I do not have
> > neither the full patchset nor the comments.
> >
> > I cannot take over the work, nor finish the patchset.
> >
> > Would anyone have a copy of the thread and could send them my way?
> >
> 
> I forwarded it to you.
> 
> Here are the patches in git:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=task_size
> 
> it's "unaligned", "fix test sparse warning", optionally
> "strncpy_from_user: Zero any extra output bytes that get written",
> "uaccess: Add a selftest for strncpy_from_user()", and
> "strncpy_from_user: Don't overrun the input buffer onto the next page"
> 
> The basic summary is that Linus didn't like calling it bug fix, but it
> might be acceptable as an improvement.  I also thought that the
> KERNEL_DS oops was changed so it didn't trigger here.

Thank you so much!

-- 
\o/ Arthur
 G  Gandi.net
