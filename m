Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22CCC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0582133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="Pjjwt9K6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0TaaIeG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfFYQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:46:16 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48577 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfFYQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:46:16 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 12:46:15 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 452053376;
        Tue, 25 Jun 2019 12:37:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 25 Jun 2019 12:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=mesmtp;
         bh=gSyJjIHjthT3a2SYIYJNLmRY+/ZGTrj+u+zCYKrjbOY=; b=Pjjwt9K6MhBJ
        zIuUap8jIrsLK5wc0QVha0hXjF6ATPFKsLe/UK4gCKkpu4gJa3sb4sXewoHVwKYb
        qYuzqpS43/PE7nIII03rzTXWvSujg6zxliCmmKQIbwPfy0D5ux99JMv+xyEA+DCg
        zoVbLxyQQ30U8rAInLhkmHQuiAVpSWI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=gSyJjIHjthT3a2SYIYJNLmRY+/ZGTrj+u+zCYKrjb
        OY=; b=0TaaIeG19hAjd3vPGddqd1WWw0wICU2LXquWcQhbdWOy/xTgmGnz8z9bH
        wtXuiGUFghRvJ3lHfhKtQ7NSotX4m2sK+9LH50u9Bc7ZpU9oSxc2B9QUqDgZsonX
        CNqhrnosdixhRCa2nYx3XLcKvE4MHPMes5pM6qL+sMeQ0/Nr6XjM8+A1BtPGowHN
        MLJ+6vcUUJydtyWkkHRdzAPvDBVhxGgRg2xvAHrZpI5RhKMRA9t7xm6IQGvYHVSA
        MwX0Pw6dzLvQSuo8lRVBR8Oba4CgR5VtgvQtweSJk9yQenSaqXXbuUyHZWZ0QfxL
        S+59hWB7sWSizPQIcZbrc/isLk+Lw==
X-ME-Sender: <xms:xk0SXXqoRo6-9c96z-V0VMIQ6RtwXK_Ym2YZ_RumZj1EaVMGTgiWTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeggddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjghofgesthekredttderjeenucfhrhhomhepofgr
    rhhkucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmqeenuc
    fkphepieekrddvrdekjedrleehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggv
    rhesrghnihhmrghltghrvggvkhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xk0SXdP-_PEWJQ-GUifoOwZaTe-qXfgM7G7CB3tp4tBAMJSOsKyDOw>
    <xmx:xk0SXUOuKAjwZH2g5YDwcEKThKcJfID8Ufz3v0Y1DEYWMmqADeLI6w>
    <xmx:xk0SXf1X98dcDEpn0tsLimeZC0jV4RBuOmwZjA3R3q8vsRcEN2-yzw>
    <xmx:yE0SXUxtVKcHhRzMz8c54pIyl_w4XGLXQyskSEBczUBmZpyw1IX1_A>
Received: from blue.animalcreek.com (ip68-2-87-95.ph.ph.cox.net [68.2.87.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9A74380079;
        Tue, 25 Jun 2019 12:37:26 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id D4B5AA22265; Tue, 25 Jun 2019 09:37:22 -0700 (MST)
Date:   Tue, 25 Jun 2019 09:37:22 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Dale Farnsworth <dale@farnsworth.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: DMA coherency in drivers/tty/serial/mpsc.c
Message-ID: <20190625163722.GA18626@animalcreek.com>
References: <20190625122641.GA4421@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625122641.GA4421@lst.de>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:26:41PM +0200, Christoph Hellwig wrote:
> Hi Paul, Dale and Mark (I hope this reaches the right Mark),

Hi Christoph.  Yes, you did reach the right Mark.  :)

> I've started auditing all users of DMA_ATTR_NON_CONSISTENT ot prepare
> for major API improvements in that area.
> 
> One of the odd users is the mpsc ѕerial driver, which allocates DMA
> memory with the above flag, and then actually properly calls
> dma_cache_sync.  So far, so good.  But it turns out it also has
> "#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)"
> ifdef blocks next to the dma_cache_sync calls that perform cache
> maintainance for platforms that according to the ifdef claim to
> be cache coherent.  According to the Kconfig the driver can
> only build if the MV64X60 symbol is set, which is a ppc embedded 6xx
> SOC, which appears to be configurable as either cache coherent, or
> not.  But according to the code in the driver at least this device
> always is not cache coherent.
> 
> It seems like we need to always mark that platform as potentially
> not coherent, and then use the per-device flag to mark all device
> except for this one as coherent.  Or did I miss anything?  Maybe
> all this is actually dead code and can go away?

Yeah, the mpsc driver had lots of ugly cache related hacks because of
cache coherency bugs in the early version of the MV64x60 bridge chips
that it was embedded in.  That chip is pretty much dead now and I've
removed core support for it from the powerpc tree.  Removing the mpsc
driver is on my todo list but I've been busy and lazy.  So, to sum it
up, don't spend any more time worrying about it as it should be removed.

I'll post a patch to do that tonight and I'm sorry for any time you've
spent looking at it so far.

Mark
--
