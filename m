Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6028C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D11624679
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="K+KEMlZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKV/5TAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfLNMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 07:19:36 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45151 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbfLNMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 07:19:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3BD4174D;
        Sat, 14 Dec 2019 07:19:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 14 Dec 2019 07:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TpQIsNWUD1aN8iX9f7m5nX9Qcoa
        8CADrqKR5uk7hcMk=; b=K+KEMlZ+FKtWC+0zhCYdiD4sAysq2VuSA4TlqEwMAMJ
        ze+vkuA0o80WcLYuZsagwXdriSbI4Wl9KfmDMhq+IW599m/huCfGG8z+9KjQcZMN
        Q/uuFrnLKYO3nWJlbVi7SGPzDVocrmYQGNc3nuelzDhVT9KtZ+vJf9gII0xh+cNK
        REy5w4MjA8HSSOk1BGv+6zA0ard/+JUBExCUBlgYyc/HeC+7gW33V8w+bgPE9sof
        3021MU3/j2DwjL6+rQ7VmjaXzjd5i58UbbAD+eaS6b4KN2O5gCs+aoE3Uozs5cHJ
        pZdeazSQcfXKR41YDksHdNWRzrSM/v1/00Xei/gpVtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TpQIsN
        WUD1aN8iX9f7m5nX9Qcoa8CADrqKR5uk7hcMk=; b=iKV/5TApzSPhkSY3PaIfw7
        WRnQhYx8isfVTkKThAO2bGm4rIGfRQfkfozKirRdkAqE7O1VuO2uQwu9hNXI6UGn
        1jUgJupOzdak32+DPOEim8fUxdJCKRuSf9cq+LbgRWhhkEJFVmCGxwW3KAjp1/ja
        1HVCuN4za1Zuok6qwKp5hc1y2LyjIPjp4AYVots2TTyFpmdHrjt+bjPODPABtvry
        KrYSX9HISA8MVHrgiVOMbLHsJfpaURlxQbmGwzE+2g0d0pPapQiMy9TZETJhhNsn
        83neR7l/l4MvtIxN9X2DYCWLdziTqonrzsKwpJubmdmdtOvSd478umcY5q9KyJsA
        ==
X-ME-Sender: <xms:VdP0XZ61zgg78ON7KbM2z_ZAwEIen7qGRDotKhWOfIS78kzlhKeKZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VdP0XZPeOZX1bXwwt4EsqMSzhkEUDl-oF0I93HpxJ3CkmiRkAh0XuQ>
    <xmx:VdP0XfP9yl1ilFmKtDUmWqWijNJ-nucar7nvkTbP8dBZ7Tx1xFXT6A>
    <xmx:VdP0XcXeKS9TTFzp6_m9X-lsrCXaYMrVh2oVYMa-1tx7c5XEmsIB1g>
    <xmx:VdP0XTCJiGRhXXxPfKlI39fhyIXpSqPZY6ej_T18K-aXr-lHlhq-sA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D75180061;
        Sat, 14 Dec 2019 07:19:32 -0500 (EST)
Date:   Sat, 14 Dec 2019 13:19:30 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20191214121930.GA3338917@kroah.com>
References: <20191213120534.6e04aa02@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213120534.6e04aa02@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:05:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/isdn/gigaset/usb-gigaset.c
> 
> between commits:
> 
>   53f35a39c386 ("staging: gigaset: fix general protection fault on probe")
>   84f60ca7b326 ("staging: gigaset: fix illegal free on probe errors")
>   ed9ed5a89acb ("staging: gigaset: add endpoint-type sanity check")
> 
> from the staging.current tree and commit:
> 
>   f10870b05d5e ("staging: remove isdn capi drivers")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, I knew this would happen :)

greg k-h
