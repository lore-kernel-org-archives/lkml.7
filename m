Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7904C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D20206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="llZt1Kn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plN8q35K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfECBk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:40:59 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47551 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfECBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:40:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3DF8314AEE;
        Thu,  2 May 2019 21:40:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2019 21:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lCcAU6v9USd6O6HdXYYD0bpWXJQ
        yvhP17fafAT6vWFg=; b=llZt1Kn0pG8HKFKAI6d1NqzJGq24SlGJ65lr50ds3GR
        WgNq3mzcnBhb+1U01cuVhrsB36RtrCjYzYzlX7mYl+yAFp3TMgp7E55ZgA0Gici2
        lmYauM1iOH7b7fsT9Rugz8kpo8PF7eLiX0lY4T+m9v0S/Eg9zrHFd2DZU07DdFiB
        +l+XCUC0R0YEtt1ErbcQgzvi297Erj6LTwiIn25E1GHHl/9w9DuGNFvMg3H8073t
        bTGNeff/lFluc6nW2E8EC9P8o81Dg2cc8X+H0i0wfhGntVbYGXLi7hXsnyojqeLR
        +07YxTj+79lNHTn3TEB/cJGazPNp8TozPUs8rc94riQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lCcAU6
        v9USd6O6HdXYYD0bpWXJQyvhP17fafAT6vWFg=; b=plN8q35Kpda21thj9QoPxQ
        IoA5NRiWaJ434/oOSFeEnCNie7ogazP8vDDGCpOJe0PMoVvn9D50dal7553V25+N
        L3O8CO///B3dN1eb3LN/lKNHaicCuF06fnC29yZFJS7KUUyVT2hIkfT0NcEtzBqP
        mdMW9j9tCLePN0+YLQjabo6/kMQY59o3DWP6lBArQIfyjIg25kSQasqMaJiy+QKW
        sggG0c+o4mYihzHsYaaKfxmZmxP9HJboyYyjZuSApCItErJRUw0ZKfE/Y1G0S/X+
        AnFQ//tJmwMt6oBkj0hNIW1BTrXt+jRjBbJ9GyXwU4WN8c66C1nQnnS0XVhi4p8g
        ==
X-ME-Sender: <xms:KJzLXGleEhRc00X81IsFGER0mVwlEqPHkioZSzBlkgG7poJSz-W8Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjedtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeg
    gedrvddtgedrvdefheenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrd
    gttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:KJzLXGjW35US08xGSTMjk805EitBMvAmZ808H3vUzOwjK9nkMmhmcA>
    <xmx:KJzLXElPVbYU7F6DB6KH4xPElHmOS_FsWnUb6vkirFPAOVjaUswaZw>
    <xmx:KJzLXHFQPHpJbYw39B72-oCC0eIkTr6o3lH05dk_dIrRxErWArAaig>
    <xmx:KZzLXL9DRBVouhsX65f-C_8ZbrxmEjlPYyX3RdJZeI3PHcuak3q1lg>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34C87E4625;
        Thu,  2 May 2019 21:40:54 -0400 (EDT)
Date:   Fri, 3 May 2019 11:40:15 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] kobject: Fix kernel-doc comment first line
Message-ID: <20190503014015.GC7416@eros.localdomain>
References: <20190502023142.20139-1-tobin@kernel.org>
 <20190502023142.20139-4-tobin@kernel.org>
 <20190502073823.GQ26546@localhost>
 <20190502082539.GB18363@eros.localdomain>
 <20190502083922.GR26546@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502083922.GR26546@localhost>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:39:22AM +0200, Johan Hovold wrote:
> On Thu, May 02, 2019 at 06:25:39PM +1000, Tobin C. Harding wrote: > Adding Jon to CC
> > 
> > On Thu, May 02, 2019 at 09:38:23AM +0200, Johan Hovold wrote:
> > > On Thu, May 02, 2019 at 12:31:40PM +1000, Tobin C. Harding wrote:
> > > > kernel-doc comments have a prescribed format.  This includes parenthesis
> > > > on the function name.  To be _particularly_ correct we should also
> > > > capitalise the brief description and terminate it with a period.
> > > 
> > > Why do think capitalisation and full stop is required for the function
> > > description?
> > > 
> > > Sure, the example in the current doc happen to use that, but I'm not
> > > sure that's intended as a prescription.
> > > 
> > > The old kernel-doc nano-HOWTO specifically did not use this:
> > > 
> > > 	https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> > > 
> > 
> > Oh?  I was basing this on Documentation/doc-guide/kernel-doc.rst
> > 
> > 	Function documentation
> > 	----------------------
> > 
> > 	The general format of a function and function-like macro kernel-doc comment is::
> > 
> > 	  /**
> > 	   * function_name() - Brief description of function.
> > 	   * @arg1: Describe the first argument.
> > 	   * @arg2: Describe the second argument.
> > 	   *        One can provide multiple line descriptions
> > 	   *        for arguments.
> > 
> > I figured that was the canonical way to do kernel-doc function
> > comments.  I have however refrained from capitalising and adding the
> > period to argument strings to reduce code churn.  I figured if I'm
> > touching the line to add parenthesis then I might as well make it
> > perfect (if such a thing exists).
>
> I think you may have read too much into that example. Many of the
> current function and parameter descriptions aren't even full sentences,
> so sentence case and full stop doesn't really make any sense.
>
> Looks like we discussed this last fall as well:

Ha, this was funny.  By 'we' at first I thought you meant 'we the kernel
community' but you actually meant we as in 'me and you'.  Clearly you
failed to convince me last time :)

> 	https://lkml.kernel.org/r/20180912093116.GC1089@localhost

I am totally aware this is close to code churn and any discussion is
bikeshedding ... for me just because loads of places don't do this it
still looks nicer to my eyes

/**
* sfn() - Super awesome function.

than

/**
*/ sfn() - super awesome function

I most likely will keep doing these changes if I am touching the
kernel-doc comments for other reasons and then drop the changes if the
subsystem maintainer thinks its code churn.

I defiantly won't do theses changes in GNSS, GREYBUS, or USB SERIAL.

Oh, and I'm totally going to CC you know every time I flick one of these
patches, prepare to get spammed :)

Cheers,
Tobin.
