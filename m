Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99131C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F220879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="w/av7o+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCovG6R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDHXmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:42:23 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52987 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbfDHXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:42:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D5EE238DF;
        Mon,  8 Apr 2019 19:42:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2019 19:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hlrG1h5r/gtTe9wlG2O5Vs6sRSa
        HOgL/v3YX7qAdA4k=; b=w/av7o+IwXSGj1V70Q3QWVcKDR60fRQL5+aswcuOwpg
        XaRQmcLlNHYv7bV4dfZ6wogqqK5DFkO9Fw+b5f9uvhEXIojNsCoL7kZBmeH5zozO
        gw2WGf3XScadCUS7tdzh+D8FVVRim5hCxkaDUnWQrSTJDdK/wae/hbQKnAe/U2SO
        6zyiJriT5Jaot3G2toKJWSOLP2NZ9+K0iL3bFNMG0hOFop0StbEWGw4JlOtxzKsN
        8mG7R92+ywMuR6/KNVLBXmg0uJbkSMsaKhHKn4a7CNA+0h7w98HzmqJkh87N2Fm5
        +fN4oAVefabaGT1+WSkkf5mG57fkQPwaPnICiCTHU7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hlrG1h
        5r/gtTe9wlG2O5Vs6sRSaHOgL/v3YX7qAdA4k=; b=OCovG6R/WvyuxOYGYf4fth
        CHKmiPCgH3DrJJL3gbmJL7YUFy1yieQ6yRJhk4PxZwfompZZpbgDrx0PbbHCWle2
        Ew4LjCxF36vqm3pChXQ7v/euATtfwa1CRGEJl3+Puy/7l78LTibLvHHz+VTrDY5C
        VWx0jK/LCAHAq/B9RVCJJTAtohj0W4mJiSIW/PeUiH0uE/KLRzQkDR2fcOAk89o1
        yzFJia4z19S9cS8lNTAkMAqYB1Bk1WlNp5zssKPrKT+ZAzBUlB0Wn4UTYFaVx70t
        Dv7JVPMRd3VQoIUB6/uEzGUcWQFjJR9Zsd/PuFNOWfOO0zWFxg0WFCSdvDbZOjZQ
        ==
X-ME-Sender: <xms:WtyrXCi-7pr352NwUPXvPhz81KLfeds4l6FtgBSt2y11JQ4pbwa43w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvudejrdehtdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WtyrXEQDue7xOJC7j_VbLlqiYyBf4CMyM0lkPWTONxMqllMDk3bYEQ>
    <xmx:WtyrXCiALVvUHvtN51wuLdpCzvKPE-C2SbbdlN6rqOng0ba6nb3fwA>
    <xmx:WtyrXBeS1NrAAXUCsI5xO5zzX73n1AMQ-1YIB75jXNnHK46W8-MGxg>
    <xmx:W9yrXNhyDygMXLcwcnmTtvx4AJ1CKQwwJ2WDIeo_kilRy-A5iA_rHQ>
Received: from localhost (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 552E310394;
        Mon,  8 Apr 2019 19:42:17 -0400 (EDT)
Date:   Tue, 9 Apr 2019 09:41:47 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
Message-ID: <20190408234147.GA14359@eros.localdomain>
References: <20190406225901.35465-1-cai@lca.pw>
 <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 07:35:34PM -1000, Linus Torvalds wrote:
> On Sat, Apr 6, 2019 at 12:59 PM Qian Cai <cai@lca.pw> wrote:
> >
> > The commit 510ded33e075 ("slab: implement slab_root_caches list")
> > changes the name of the list node within "struct kmem_cache" from
> > "list" to "root_caches_node", but leaks_show() still use the "list"
> > which causes a crash when reading /proc/slab_allocators.
> 
> The patch does seem to be correct, and I have applied it.
> 
> However, it does strike me that apparently this wasn't caught for two
> years. Which makes me wonder whether we should (once again) discuss
> just removing SLAB entirely, or at least removing the
> /proc/slab_allocators file. Apparently it has never been used in the
> last two years. At some point a "this can't have worked if  anybody
> ever tried to use it" situation means that the code should likely be
> excised.

The bug doesn't trigger on every read of /proc/slab_allocators (as noted
later in this thread by Qian).  I tried to repro it with a bunch of
different configs and often `cat /proc/slab_allocators` just returns
empty.

I've got a patchset ready to go sitting in my tree that removes SLAB, I
could just send it to start the conversation :)


	Tobin
