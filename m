Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D8C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A1A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ettHd6os";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAw+WC/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3IOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:14:16 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39317 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfD3IOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:14:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C052C71E;
        Tue, 30 Apr 2019 04:14:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2019 04:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QaMnlBFGPZs+DEMS0nyUumPQ3/f
        Otf0Ip12DCFXxfKM=; b=ettHd6osx2iW0UtF6UIP15gDoVrZSwKKvXyyWManic5
        c4fbeX/H5u96nd1CPeTvHaK7wqIFAzEVX9/n0JbmduAvEC8yp5v5wd2c9bS4eaBi
        yG8gXiTI7ZqZxOkF52dkRP/EjBD6MmUZ25FBaBUcLXxLAwOxCZ8UjFuhKQvNsmp6
        K+hmDKtxkzZmLHDbL9Ez6KzB/mp8nXdqOsHR4AF9yHS5Od+aXKLsQCx6UxI45jck
        DVxpNpjSR/rj795NgUCeXpJsYRMlYjF2/Q3Xrr1kzw83RvTA4eaVOomVHy12xl/c
        43h2/3O0PjxqB4dluDKnin8mPT/dWgdzVYzMjxcuDQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QaMnlB
        FGPZs+DEMS0nyUumPQ3/fOtf0Ip12DCFXxfKM=; b=hAw+WC/2lxijMbOmK0FzBz
        9zU4JGzeYtYiUbrEpBsOuUXx77j2x8vPv6GpC0EnBizC1LvwGRI78/0iWkW0CaQW
        0Z0hWvtAE3LXxL0l+SyoI/bRR6Uoocym42wmRCMe0hxak/I23AModNPr1aBQfK+R
        RVxeUhm4PBnkuMLe5QK3+OmJiNM7cHiSIuvW8kqgX/yhF1f50AKUy69p1dBdJKJQ
        6ShMj9zems5cwR52oJxvvJzDKxg0M9grpksiyR6g3HRablgHIv+3UR/FlW2fs31Z
        lykGPomgVueI0EamLgp8r6GnJ52LJ+Q+ZqDE6ArGfkUk0c0cD/p9lqD6sSimOZFw
        ==
X-ME-Sender: <xms:0wPIXDRZ49IfAdk99l-irItgHMakpbd3T1b-2qg0ujtK8U1PXLXG9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:0wPIXHvR4nC5ai6CDHmXQJrfkFr3kX8ANvoImXYwxiIRaxPWGjxMRQ>
    <xmx:0wPIXBAI9PxnJaCj0eEZmp6jDyQ2L_G5Ky4qxOBMw_03bHwBkVlYrQ>
    <xmx:0wPIXB1z397X-cmBS4dtg4bIP_8g_IiOYEc5bn3YJMZUAZRgkSzgJA>
    <xmx:1gPIXNF5dDQuAaGY28NzFR9jjaGCQOlybbvnl0RgvXbvl_JqTZ18Fw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5A6EE454A;
        Tue, 30 Apr 2019 04:14:10 -0400 (EDT)
Date:   Tue, 30 Apr 2019 10:14:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Venture <venture@google.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the arm-soc
 tree
Message-ID: <20190430081408.GB8245@kroah.com>
References: <20190430174051.038c77c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430174051.038c77c8@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:40:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got conflicts in:
> 
>   drivers/misc/Kconfig
>   drivers/misc/Makefile
> 
> between commit:
> 
>   524feb799408 ("soc: add aspeed folder and misc drivers")
> 
> from the arm-soc tree and commit:
> 
>   01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")
> 
> from the char-misc tree.
> 
> I fixed it up (see below - though the additions probably want to be
> moved as in the arm-soc commit)

People are still arguing about this, so let's leave this as-is for now
:)

Thanks for the merge resolution,

greg k-h
