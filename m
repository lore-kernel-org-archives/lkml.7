Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AC520881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="leYrYXLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMzWaB3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfD1BUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:20:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46967 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfD1BUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:20:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D442021E92;
        Sat, 27 Apr 2019 21:20:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 27 Apr 2019 21:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=CaIRzs2uedsPMNBCe341n5M6L2A
        osQXLoInsrDXBVN4=; b=leYrYXLvCvxxjXsEvTYcOtAvGf7PeY3CZe1AJ+JrpFQ
        OFfkfXhhnV8noqrqdXLhh8KV2223K8dsBYuoXSuiY228TGVdD/cXQqCXQ1dhSrkr
        HlgC+Tt8hL/lpVUjv7OeKXYoTGuVrQZs6K2M9hoFoqIQ4tpwCkCvaOXzmDTO33Ec
        P/h1ndkjJFcCqBuq5i8oGmNM+qZLZkeVJeZ7iFOdnbVqpGHZ4GgN1E5G1LDpy1z2
        Tcdtf8zu6FkgC82U2KxjSkdqcJXRU0SE2GGIiQer3z6ZfYa0Ac9py1l+/cjDRc9p
        82VoujDQVoL80c7PC4mhx2a8jOtAK5R0zWtXRr5jAKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CaIRzs
        2uedsPMNBCe341n5M6L2AosQXLoInsrDXBVN4=; b=MMzWaB3qAZI80xtwqm6oID
        SiJ89dl+AcNVPWCCrzKah9PSyS5qz4kVfBJgBUJk+YVBTljL+ic204PTBMFefbh1
        3t4Uk0pRpyjrRxxkjwTDP0/3lZb48FWOxh/W15sChh2TLL/KxlXVXaKMpbXLIGhG
        oklIwBC71+ks4hY9NaRkgku75WNDfmX6jrj58SBfoKQN3v50+g3yDJM1AbWHBd60
        1uccquwEPbePE9YOZdwccy+DUxhtB4TAH+ksN+8mGWXVA8ApjsvqjC5Wmk+HbQ0+
        f3x50yflIPvdb6r/fqjFV3jSy1cisdfBXKqvC3iIR+KzqmebMVji4fQQtZVZL56w
        ==
X-ME-Sender: <xms:4P_EXEaf-FAC5Z1MbnjDj57wZUzhyJxT7MquSgg2NdD3gV7CwhClzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddukedrvdduuddrvddttddrudeileenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:4f_EXKG6KUBojJVkxYQ9ZuybO6rVlvbS94OCJJohOrP5TsGNBtPdsg>
    <xmx:4f_EXHrmXifHcEVV0qq5FCBtDx8h_W7mlf4KQvBcmu4lszxEtjNO-Q>
    <xmx:4f_EXFxg5wRGRWfDNn-MD07N_nASf0C1IakTXyBNqNKv6Yk5qHB4ig>
    <xmx:4v_EXANqdBF1zn53hp4fIKcB1IJoltjLhcvEgyMXXoDoK7pZ-qqBHQ>
Received: from localhost (ppp118-211-200-169.bras1.syd2.internode.on.net [118.211.200.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id B25DAE474A;
        Sat, 27 Apr 2019 21:20:31 -0400 (EDT)
Date:   Sun, 28 Apr 2019 11:19:57 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190428011957.GA18843@eros.localdomain>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427192809.GA8454@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > (Note at bottom on reasons for 'To' list 'Cc' list)
> > 
> > Hi,
> > 
> > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > function requires a call to kobject_put() otherwise we leak memory.
> > 
> > Examples memleaks can be seen in:
> > 
> > 	mm/slub.c
> > 	fs/btrfs/sysfs.c
> > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > 
> >  Question: Do we fix the misuse or fix the API?
> 
> Fix the misuse.

Following on from this.  It seems we often also forget to call
kobject_uevent() after calls to kobject_init_and_add().  Before I make a
goose of myself patching the whole tree is there ever any reason why we
would _not_ want to call kobject_uevent() after successfully calling
kobject_add() (or kobject_init_and_add())?

Cheers,
Tobin.
