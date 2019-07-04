Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE5C06514
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC56321882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KMn9S8L2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClMe+idr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGDGaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:30:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52117 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfGDGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:30:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BA1B21B42;
        Thu,  4 Jul 2019 02:30:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 02:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0xBM5NoBD1bjhoPN3xGKepMaOrv
        4VQ/HIMQ6KzdTKTw=; b=KMn9S8L2cfpG8KleREDjmwXQXIVWRgfkfnGDuAGuZub
        zFnUo1OcqQDkVV9BHEvbZpr6s/oxtdHAZHWzerP7JQu3/mOlncIEfZBRMYNz0TDG
        wa3/8VVrr9UuCkAHyUe0dsi4RLAm4d605HL8LFxT2/jerRFHOhAxT2i2iveDtzfK
        lwUYpK+e5RraaquZ1OO7lfwD1F+ryRqL941fP9dqfEsLzS5+Fd8aYAmUP70Yxc3C
        y19YpYo+Ufm3KirxRsrV/Y0zaTrShr5I7QiXir5TtMWvNT4FmkBSuGaILUM6FIVf
        sY/XDp2qvq337/hel1S/w8Yxt3FP3dhvrFfvaBlV8aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0xBM5N
        oBD1bjhoPN3xGKepMaOrv4VQ/HIMQ6KzdTKTw=; b=ClMe+idrMQNBs5nFLfqzxX
        VdlggJVo3DQvfFsJO4TZlBzjml4qKO2fprCPZAfgf0T+Qc3+9UTki0RhFFdlbh3o
        J1zdtf+8z5jF0ioPXysFs+I8yiLEPMdAsCShk4IwGKm33qCXBSZW3pFnY8314z4q
        cyIOoJaSPyXzjYmTE0EewYMETRX2yLcVPEdwz6HGLXedXnm37kcUuxS1BzDRfZxi
        5phWnRI0ibUKX5tlPH69DWwBxQ9av7g5X5VR6QBh5bVtqVF+kpMdv2TpZ/ERv1sq
        x14JArmLXrq9GmVCaG5WrFouf8W6tQShxvZi0Z2juas8FcJ9pbORag0n/NAzk6HQ
        ==
X-ME-Sender: <xms:7pwdXfOZ7691Ji978LjgACpT5aj7M1oy-tgo9G7QMcp63tQflSIUWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7pwdXb1GRzbe0_CbK-dJ91Av4uOfMoFYkUrDPHNLMkrkWtKT_amg-Q>
    <xmx:7pwdXS4p40wbFgcGzeRq4bYf_f2J2Nc9EzA9dE1x2ehELNpbp6cXYg>
    <xmx:7pwdXSMliUGnnrN1TT8Ohsv0-1nZu7buOVCCBaTQOO4GD4Nak02_YQ>
    <xmx:7pwdXW25uEcDnEMr8mpY2FTz7tGOcPBYFCuGxjJ2jUCpyfHGhI6nIQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C83038008A;
        Thu,  4 Jul 2019 02:30:05 -0400 (EDT)
Date:   Thu, 4 Jul 2019 08:30:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190704063004.GA29000@kroah.com>
References: <20190704161730.1e0f6046@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704161730.1e0f6046@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:17:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> fs/ubifs/debug.c: In function 'dbg_debugfs_init_fs':
> fs/ubifs/debug.c:2812:6: warning: unused variable 'err' [-Wunused-variable]
>   int err, n;
>       ^~~
> 
> Introduced by commit
> 
>   702d6a834b49 ("ubifs: no need to check return value of debugfs_create functions")

Argh, 0-day seems to have failed me here :(

Will go fix it up now, thanks.

greg k-h
