Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E68C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="is4/9pgh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ta22z7RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfFTF5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:57:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56053 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfFTF5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:57:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B6212249A;
        Thu, 20 Jun 2019 01:57:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jun 2019 01:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=mfAr9uMdunoQvxL5y+8TcMkrYaL
        5Rs/TXMM5I4YUAg8=; b=is4/9pghbtMyQHLl3Gcygop7Msu9w6aGtM+835GHweX
        01HeHGBO4Q7VrSCPKMc6lvUAI/aLiPNbWBZ6P5e2GpqoNu1MEvW2Xs2oIWTVsnQ8
        i373AGD5kfXrYVRDboQQZEwA47bXRI3RxDfbvWhmN6uZcSBxyuVu+tcu9l/EJ0Hx
        74WV0OwyDz+61gbwiQP5+3HJr8nOmU4LmaMtEd8rvl45QvoG+VaeuDYgD9DGhJgC
        N+Ht6GZEXBB5pZvyY++bgwRgF8p6f8ws5K6gVDLOJRQOErgCBLGkaQvkK/HgE93L
        06xEfdqQdJyR0pg8RRy4Z22v9Kquc6d+F3duASOAEFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mfAr9u
        MdunoQvxL5y+8TcMkrYaL5Rs/TXMM5I4YUAg8=; b=Ta22z7RO7wGgm3DbeTAWZL
        NTGPfe0sg7SWlNWkDWJUfM/+1RLxfpA39a4pbDHtrKex4uWeazesfroULf1U8hl+
        BQkiRwwi598N5NhBGtlblDhi0QSO+otQ2B0kPHJZ/xV4aVnFFL3icx/QiZxjs/nd
        lNBKxSBwg+IsCDINIruFfMkWSvActO8J2xZ6CBrnZNY80FiED1WcDdDSQETVxB/9
        +GQq+O18UQx6gxUD4EukBRkp5V6/8BW28Xnshuf7q/j3GsJtebsSNzYif7UVMER3
        w0zAI6r1YzgQHlGEytvuRLSNbjEgB9qrjXcHwquKPwMFeeJ7DhOa6+w3Nvxu5gCA
        ==
X-ME-Sender: <xms:SyALXbiCHkThrBpFzPD9uNyiua34NlH9s5U1td7_L-L13rKOzXhCzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdefgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:SyALXcTtMx139kWfhflfongOjy-ZW8MaQ5gI0jBmrjvnJ_1Q7Q1MHw>
    <xmx:SyALXWFBFQGvfVTle3FigZ1xEfiWKiaRvkXyFB9P0THiuolb9Na7oQ>
    <xmx:SyALXckFNQF5EAI2hCIrdGv9KC17bFZMPHSYFfeFo-f90HKKyWaE3Q>
    <xmx:TCALXZL2OVaEvrZHHFjKiXi7fG6YlAV3HRNeHFa01X9DXFrL-F1AJQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD45C80064;
        Thu, 20 Jun 2019 01:57:30 -0400 (EDT)
Date:   Thu, 20 Jun 2019 07:57:28 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 char-misc.current tree
Message-ID: <20190620055728.GA17149@kroah.com>
References: <20190620111128.7599af5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620111128.7599af5a@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:11:28AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/fb/fbcon.rst
> 
> between commit:
> 
>   fce677d7e8f0 ("docs: fb: Add TER16x32 to the available font names")
> 
> from the char-misc.current tree and commit:
> 
>   ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
> 
> from the jc_docs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/fb/fbcon.rst
> index 5a865437b33f,cfb9f7c38f18..000000000000
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@@ -77,12 -80,12 +80,12 @@@ C. Boot option
>   
>   1. fbcon=font:<name>
>   
> -         Select the initial font to use. The value 'name' can be any of the
> -         compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> -         PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
> + 	Select the initial font to use. The value 'name' can be any of the
> + 	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
>  -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
> ++	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>   
>   	Note, not all drivers can handle font with widths not divisible by 8,
> -         such as vga16fb.
> + 	such as vga16fb.
>   
>   2. fbcon=scrollback:<value>[k]
>   

Fix looks good to me, thanks!

greg k-h

