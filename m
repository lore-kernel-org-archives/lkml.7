Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21AC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89BD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="BL/5yuWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iv6AjPuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEOUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:49:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57887 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfEOUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:49:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 409052438C;
        Wed, 15 May 2019 16:49:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 May 2019 16:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4DYWIxOWx2bjSXKtJq2DIJnjfb0
        7mluDbIFzNb7XWk8=; b=BL/5yuWiNwjOvU4jFHmI7rLvnAomYbuItkmAV2xzV6U
        +HMTmQX067H0vRmAG/6UgabVOQBTSp+cKOacnbNdRQ/OLgArR0IHAApHf2gOlX8a
        ZYHIV3+/vyZp9UBpDfb/+zsUNivC7uSTiH2CCMVqFskfPG7KoUQCDmg/Z0/hXdVE
        /mEj8xMWkOh12s36Nuhzy7CNCpnW/uIdiO9Zo70cx/mlt4blc0bVeQHfw4KMPq1N
        2Tum8dmoL/oEkqYRZauFuC2wXFkWPj+QnVMlx7ar7+o/uLTwz6BiquzArRHRpFYu
        lsetzqibTGMosxAWaV5F1bsMKybx2kjqFGoTVEfhj3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4DYWIx
        OWx2bjSXKtJq2DIJnjfb07mluDbIFzNb7XWk8=; b=Iv6AjPuOCaeYwZEnLxDmhY
        KIYmpK+gncszduGeAwu1YCDrj5lmJm2HEzAy2gZiBgqwSi2j8eD1RmZWrFoB9xUf
        ZKdauatKTGYGH2Njb9+MEnZK0ZnnOgiRmwjpDZCoTwue4BVWGtJK/6RN/P63unr5
        YgFbdXUosJIIiB7m4/fZMw18yBD7USuRybZrWao6ut/VE01y3yVzuKsREW4w0yiW
        Wd1PPIn9GtsShnBNeZxIYbnF5WmCDSzAlvgTBAoP9FGaG+z16jfvg7dnSxF2Pq9q
        K0kbf4w894WBo+2Mql0nsZDqy/tV1DBhJuCG+pWgSl+S4YRccGDR+qLDC/nZcDuQ
        ==
X-ME-Sender: <xms:THvcXLe9PfILHqiCvzZt3-SM8HPaiIYnPOPz2NB9gVQ6io3tGs_LCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddvkedrvdefheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:THvcXEGulgIGb_Wi16_-rjZpWV8pCjdQtGnJvLYb3jaZGrFftghRFw>
    <xmx:THvcXNjKywDKaM1In-4PLN7b9wCSB8aiGrso3IzP7D50ctOH6wDVTw>
    <xmx:THvcXMd8klvLzix2Wryq9_cHRDKjAQPfJ4Hht6S3UAOXgVfk0DTJBg>
    <xmx:TXvcXFNSp8PeNgVr5hvUbk3YEGetmuvUXqgicIlrqngdz-xSxkHW8g>
Received: from localhost (ppp121-44-228-235.bras2.syd2.internode.on.net [121.44.228.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2133210378;
        Wed, 15 May 2019 16:49:15 -0400 (EDT)
Date:   Thu, 16 May 2019 06:48:40 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3.18 78/86] bridge: Fix error path for
 kobject_init_and_add()
Message-ID: <20190515204840.GE11749@eros.localdomain>
References: <20190515090642.339346723@linuxfoundation.org>
 <20190515090655.622147146@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515090655.622147146@linuxfoundation.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 12:55:55PM +0200, Greg Kroah-Hartman wrote:
> From: "Tobin C. Harding" <tobin@kernel.org>
> 
> [ Upstream commit bdfad5aec1392b93495b77b864d58d7f101dc1c1 ]

Greg you are not going to back port all of these kobject fixes are you?
There is going to be a _lot_ of them.  I'm not super comfortable
generating all this work for you.  And besides that, I keep making
mistakes (reference to last nights find of double free in powerpc that
you reviewed already), then we have to back port those too.

For the record I've been going through all uses of kobject and splitting
them into categories

 1. Broken
 2. Too complex to immediately tell
 3. Done correctly

I'm not getting many in category #3, let's hope that some in #1 and #2 are
my misunderstanding and that many in #2 should be in #3.  I'm having fun
fixing them but I shudder at making life hard for other people.

Cheers,
Tobin.
