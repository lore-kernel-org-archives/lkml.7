Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC9C06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF96F218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PXB/uJSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGii2rJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfGDIV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:21:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54805 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbfGDIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:21:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DE2E21B6A;
        Thu,  4 Jul 2019 04:21:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 04:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=YzIEmiky+aIfcR8HU5MmgoQm+T8
        82Wu+zyuXCmi7/e4=; b=PXB/uJSBmDiMg2ZFa979H40MKGVmkp4kyFQsAbMWDif
        NN60TL2Je8ikKvb16i5q0UeWWfbY5l2WzgcZogx0+giPVuYFbZHuVxg6m0Cuzn8q
        ONsZfSp0XO6tA5FVVMZM7rRlzNARG8Drm0mDYtPpxPDXkO/32/d1AfKhqS4mIyiv
        azVVurMyueWBXmEM1Noq9+S/cvCJaiAot8CspY0DmiHa3QwfuPlGje7XWie5KSJY
        xBBHLalzd1PKtS08jDjh3t2GK+M2wqHUYkIKwvhb3LwDWVvoQW9UvpixWPx4X3/o
        NRlYwl7GdYXwxyJOf+8mjNDAhXYzTC01AiHiGgbpnkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YzIEmi
        ky+aIfcR8HU5MmgoQm+T882Wu+zyuXCmi7/e4=; b=IGii2rJrsI5fxn7qOE72/7
        P8kb1v7287kuA0dhQHMKh8IBrF4lBPPHnG9CdjeY0fA84qhhLmMqh2hZfpxPFO/k
        /1rb2kSOLS89VXq/6a53TFC0sYz2zCVea2LAUy3kS2NYkIGtPBowbdkBZ2HWXevh
        3gdeSig7qPBUI56D4rH9S/2OyBR4QKhtnuG4BIGyQZKG0puKLQeCCnlzfUIt+EpP
        BmRNe9+NvSwY4i4JFlmGd3g+Jd6BfPKJsOwPLyzwREftLyNAyPrZt8NyVU/Y7Xbi
        wiB/cozmfIvGEn8dbTvQGrHOTe119boYrxpA/EWC+/jjAaea2CCBbdlckuFXrUkw
        ==
X-ME-Sender: <xms:AbcdXWfQNJ7khS3PMETEh5ZJwDWnWJZYZDpspwc-OubmQZee2b2n2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:AbcdXXaLiAOhnpxikECvyJR9lA9qivL85fXkb977Cf9IDRKQA541yQ>
    <xmx:AbcdXb5blrsiaHGqX2rpOI2S4_rPWBQHv55sGwuXkBA9QAGODQ-hdg>
    <xmx:AbcdXcotHGf3Y0rN_E2Jj1kZjQnZUezj2Rovsg0FQZTH6PpFuWqhdw>
    <xmx:ArcdXc4sLEbfndscgl54YYmpYpguWjCI5LXUv2OhwH-bVyv4AoT33A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C781380085;
        Thu,  4 Jul 2019 04:21:21 -0400 (EDT)
Date:   Thu, 4 Jul 2019 10:21:19 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190704082119.GF6438@kroah.com>
References: <20190704162435.17f405b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704162435.17f405b0@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:24:35PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> fs/orangefs/orangefs-debugfs.c: In function 'orangefs_debugfs_init':
> fs/orangefs/orangefs-debugfs.c:193:1: warning: label 'out' defined but not used [-Wunused-label]
>  out:
>  ^~~
> fs/orangefs/orangefs-debugfs.c: In function 'orangefs_kernel_debug_init':
> fs/orangefs/orangefs-debugfs.c:204:17: warning: unused variable 'ret' [-Wunused-variable]
>   struct dentry *ret;
>                  ^~~
> 
> Introduced by commit
> 
>   f095adba36bb ("orangefs: no need to check return value of debugfs_create functions")

Ugh, sorry about that, will fix it up as well...

