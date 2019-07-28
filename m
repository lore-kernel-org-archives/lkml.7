Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F93C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91CA20659
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EOhcF1sp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIeZYY0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfG1J2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:28:52 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57105 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfG1J2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:28:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 933E121650;
        Sun, 28 Jul 2019 05:28:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 28 Jul 2019 05:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=QfkhH3vPBvUSxmLYadZ+3EETQiq
        ZEjt4+Idx1nnqMoE=; b=EOhcF1sp/kxtx3xHxLgAgjSyRJGSX9jT2iCau/Cv4A+
        YloDZzyR0q8zz8wnDUtwtKGKAJWGXvTh1tbJsAE9iSH8ukpXGsQfzhEXGfXKaew6
        vJ4Daj1vD0/xwx2ibGaYnDxbjaZgI9N/8jnFeJlm8SACepKdFJMC/kBtUoQpP75a
        xve/m8NA999+cr4XOnfzAeBvYfGJn8KhgTZxeRm+1p614cMck8rfaP1PToBAfu18
        ONmL049dd+nRj2PSm7GVTLbOavDiOxRb/1fzTRWCs035FdRqT2/2KR4Mau0n1q2a
        VFsUie39m8eUJmfWHMBSgTJyaYViURNnQLbFoRg8rjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QfkhH3
        vPBvUSxmLYadZ+3EETQiqZEjt4+Idx1nnqMoE=; b=bIeZYY0jdhkWzPZ3jFeiry
        UgJhuECySObNxwCDuQuBX8ese5BKTsY6YA9nhMmOG7DJtgjXC3xKZOJQX57xZZ/z
        7um0dy67COMWlZFYSmeXVTnbLronv81CT1DacVa3aL/RUT9l2ivt0CS6zaXjnsnd
        n6ZtlcCGU/ahmGxQw4lncZ4u2VIIYNHktqxULtTlFflSYoDLU/hZtEy1hUJgCSO1
        OoxcyM+50cyBDrKPywTMaliVZu7sumsCq9bI76mjVHhVrtloLtYh6gNqeFupoebD
        v4TIAFBl8qT7fKBbEi+Ppb9xnq5tkmtJPsXvVIlGjiUy2NV/PNMRbNM501vm1Kyg
        ==
X-ME-Sender: <xms:0mo9XRBYFcTYpzwXZWAh-Z325jTWqrIlvyDiZpO-1zGRNpqAw2Zphw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:02o9XdFzeqyXNBRis9pGm6tShDBLifs8Oyw9ZGFFbv_OAfGSm--Ijw>
    <xmx:02o9XVkOP0Ruz7rg1g_iw1hjSp6hYfCeq_faJsC4cBpUHtAgpoQDNQ>
    <xmx:02o9XWru66HQzve3a0gC0uwd7zAC-OlI5tk3wH62NjFw46jyQOTX4w>
    <xmx:02o9XWF6Sjpi3_QERq5T9OkW8KU-fku8NMn7YJQ7PcVSnqsLNPgotg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A095A8005B;
        Sun, 28 Jul 2019 05:28:50 -0400 (EDT)
Date:   Sun, 28 Jul 2019 11:28:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the usb tree
Message-ID: <20190728092849.GB31933@kroah.com>
References: <20190727151032.4eaf3032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727151032.4eaf3032@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 03:10:32PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   6269e4c76eac ("usb: host: xhci-hub: fix extra endianness conversion")
> 
> Fixes tag
> 
>   Fixes: 395f540 "xhci: support new USB 3.1 hub request to get extended port status"
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Ugh, thanks for the report, I'll try to catch these next time before
they hit my tree.

greg k-h
