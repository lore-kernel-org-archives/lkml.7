Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF1FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E682176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="C/cUhQKq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZKeQSNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLRHFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:05:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53023 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfLRHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:05:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E47222254;
        Wed, 18 Dec 2019 02:05:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 18 Dec 2019 02:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=IXbhvHhEiOcanqsvUj4NZqgbgNp
        bD1LGN3GihPvyCVQ=; b=C/cUhQKq0NO773ahmOBJgfDtxr2P7Y7/r8wG7AwIajc
        XNeOYl6Lmi7cU1PTgZnq8Vo0ACElBq8eZJLnpvXnf5vU302rSjVEUIA2g1k/MJWH
        NoyI2KmHvvGVjs1G5V7vItZ5apwx74rDBN21oXRhY3jf8AH29khp/fBHCNH0SsRr
        ock2uSf4HOjBd+Pixq+Ry/USAJWYXW4RZ1sBq3iWphabnxjmLXK0RWZOMX93pUeP
        RFEz9ckQhtEHE3Ii0Kvw7vHR+22Z/rA/71JEvStpDnzwB1gQUODwOUTpOjf/lYvn
        NL9aOkivVYsRoH4g9jVrHTJOjrEegtD0FYAOfJqwpkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IXbhvH
        hEiOcanqsvUj4NZqgbgNpbD1LGN3GihPvyCVQ=; b=FZKeQSNIppdbLc+D+CO0aY
        Z18JxJg0yhDoPO2AWFD4ZzxeiwKQ30TNEzn/kuEiioRvjbuL3UY7wigXzyrTa6Vb
        Ri/7uuDv8S/kKpcZlJg+KPXllnT9LGu8FLV9GDX8GtCk7G/q3+rrsiw0CSxB9CpX
        9u4UY7qEiSDD5HKz95hto4K+AxMtYppF/MSjV8iJhDT4XwPq1nJK+oO0CniR70r5
        c6qzqBTy1Vt6FrhBd0cstCowL6Ird2gOMQRTsFmJGlEXLbEUYAULmdF12UNO1E35
        hxYxsOELkrY8hDDxJ+tAGLt82W8dfZNECvSe5ZFRpEcJRw71Xo8woDW/DJCGnytw
        ==
X-ME-Sender: <xms:ys_5XWUfim4uPCzEVbtpnkE8HwyJaLtavtAhNvfISNDVUL1O8ycd4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ys_5XTiaWOy1jL0tAqKbiEb7dATiQR0Dj_KRsEVNFxEC0p2MJoozqQ>
    <xmx:ys_5Xav_lNamCXA0WKfxJnfZcasorRYKdnFZ2P4RFhoU5CQiNq9Vzw>
    <xmx:ys_5XbxHSuSQyU_XKY0oNNklt2Tnh6867kEy2lMojza_8cpKB-DpHg>
    <xmx:y8_5XRAB3MI8Jhry_P9VeKT7YhUtbW09h7XTdulEEsoIbK2aqYfhsg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BA8A8005A;
        Wed, 18 Dec 2019 02:05:46 -0500 (EST)
Date:   Wed, 18 Dec 2019 08:05:44 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Engraf <david.engraf@sysgo.com>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <20191218070544.GA1303688@kroah.com>
References: <20191218114942.59cc0446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218114942.59cc0446@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:49:42AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   drivers/tty/serial/atmel_serial.c
> 
> between commit:
> 
>   cb47b9f8630a ("tty/serial: atmel: fix out of range clock divider handling")
> 
> from the tty.current tree and commit:
> 
>   751d0017334d ("tty/serial: atmel: fix out of range clock divider handling")
> 
> from the tty tree.
> 
> These are 2 version of the same change, I guess.
> 
> I fixed it up (I just used the tty tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

Oops, thanks for noticing that, I'll go revert th eone in the tty-next
branch as that should not be there, the one in tty-linus is correct.

thanks,

greg k-h
