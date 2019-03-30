Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF86218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Sp/W0/Ke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="49eMlc9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfC3HNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:13:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42807 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbfC3HNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:13:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2439A22028;
        Sat, 30 Mar 2019 03:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 30 Mar 2019 03:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JAsN6jrD2sUa5XnDavoOpIyge+S
        UI9rJos1wEEAIbJI=; b=Sp/W0/KevkAoyUP3e33Bvt1TjFPRveT4dgXaoEzelxL
        XV+xnyO7bO2q7Pv6yhy6K1HdMmK1IqMKM2oQqqE471db7qO6dS/qdpP0buXMDSNs
        CsOPnUJf0cLgx+5cLsveM8eVbzLP/zzmEgbVbhOLMta+PeNBAVMBpHke6/gx1x5K
        zIsb2XlSIJeE14it3SiLgnXeD+IoAAoebA+hlNEdUZCiCjC5/nzB1AoovEF6c9I3
        fCG6dd2ohb64KPndUTK/FlTDyMoA2Euh1HtEH/bI/pV+danuOv5cAUp93soUFPYO
        DJJkjXTebRebrgtAPFWk+tYQEVt7agcaDqid10Es+2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JAsN6j
        rD2sUa5XnDavoOpIyge+SUI9rJos1wEEAIbJI=; b=49eMlc9jj2shM7gINmPA22
        DpH6V6sasjIZKBm694AnYjo5FnJQ9mZf8o7dfW4Q7P05CHgiMicLcz88AFABUock
        H57lNxxdbe9HebaE/qtKCQyEJd4dOIDnURQXSA57K55rt+7naJf19dEc3Nuhd/JP
        HR7wA3qgKhy8/VBUnS2slfvXb//AusNysEk/Ua5N4Dm+2QgOMbxML+RfRx8aVOYO
        cNJBx/wFxm7OIK33+8xrIPckun9J2WOfTz5Zsh5PQd6H+ftssg/uCzL0wewDGiyA
        SIa31iJ3L96t+yTQpcX/N4X5G9omQUd+0TYZ0Vp/0xM9PplMeWRwxDIayVufk2ow
        ==
X-ME-Sender: <xms:ABefXHpJUQDnfNaAYykSELBJCvFf7W0gT9MwIron8e4BHqxOEB6pIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkeekgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppedukeekrdeltddrfedtrd
    duheeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ABefXKfy0TG3vXuBaicF6lBaaWhkTcR7SpUlQBimZXJ9c_KylH0tMA>
    <xmx:ABefXFgMLPjVJ0ZcKlACo6UZ6eR7g4lBv3Sy1r7F-H6wfd2FMjSCiA>
    <xmx:ABefXAJWJ4qbLIjRq6mMKdtalxz37qd1o4E9t4bTqU-BYYaGmUg-Tw>
    <xmx:AhefXPFfjCJa2Z6IM377vmKEOc2x95zBWfWoqoF5U3VNT9KZSpcUcQ>
Received: from localhost (unknown [188.90.30.156])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10F22E43A3;
        Sat, 30 Mar 2019 03:13:03 -0400 (EDT)
Date:   Sat, 30 Mar 2019 08:13:01 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: linux-next: Fixes tag needs some work in the tty.current tree
Message-ID: <20190330071301.GB5068@kroah.com>
References: <20190328072734.2093d03c@canb.auug.org.au>
 <20190329194718.GE12004@kroah.com>
 <20190330162529.65805441@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330162529.65805441@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 04:25:29PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Fri, 29 Mar 2019 20:47:18 +0100 Greg KH <greg@kroah.com> wrote:
> >
> > Is there a script somewhere that I can use to run on my tree before I
> > push it out, much like I do now for the signed-off-by checks?
> 
> Attached is what I use ...

Nice, thanks!

Perhaps this should be added to checkpatch someday :)

greg k-h
