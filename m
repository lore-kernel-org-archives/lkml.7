Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F2D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Pb+5sFbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WE6t/rAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCHUQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:16:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48883 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbfCHUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:16:28 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E5E922071;
        Fri,  8 Mar 2019 15:16:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Mar 2019 15:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=IgaFJl8jU8bx2cIG/FetGchU65g
        iNPkQd+oj5kfyY4c=; b=Pb+5sFbn5+SrnU3LI9KJM8XGZlusjXzUkCHjgjKV15c
        M/4F+CQrMdnKQYoW8YyoGs9ycXXRAqrnbERyNSL3RJHp+fnhT/ba8HJL2DHuLcpw
        evB+34d1sc+XTyZL4pbksfgjykXHWQF7Id4shXT8vDW6NAtJNcxPk6wRUOCV+zKe
        3BGI0YPqyPeUpj9yKO8QpDouSMxCYKOScnSe9s0eMD+RfT37sfF+csg0O3jsVh9D
        eF5niqaI5YsAqjRPsRIMxiJk+dRBvMXQ1zeywrSHKURw6620iYzNHoQNcCEhLAOk
        mg7k2SDeuMphYrpcA+WDsv/uZWkhP+YYLAMLtz7pDXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IgaFJl
        8jU8bx2cIG/FetGchU65giNPkQd+oj5kfyY4c=; b=WE6t/rAfZv38qdO4goL20n
        pqQRiwebphe2Q9kUesqLA8gVxs8+cWG4QqBHJlvNXjVMtOqpDJFB1pvsUz8MyHaY
        C4YtWg1Sdtm0Ptif+Bq0f4Gl/qbcsQSo1njH7y63sP7WVvBXS7NiL6S1DSzfIQgf
        8MdVqnIxxB2M2nAfwBvBVwo7xPyp0Q/yTWtUSzRFSYk7c0L8JoeXj5AVkrWGhubk
        Nd6gfw1xWG0ZJLc2MkeKlPXeirifsAy3cq81NNErOyUK9EQiDjeGPgWNC26r7WY5
        Vzi1o6b5NZ/hpdz0NiH0UJG0Wt/ZqG2LU1zd9Eg0U+5aS8Xxyxr4pCjahFKV401w
        ==
X-ME-Sender: <xms:ms2CXHp872vsFjfiJeL0IrOV_MH3UnJ1w6e4ynA0fIn-G4W4CgWlCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgedtgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecuffhomhgrihhnpehsphhhihhngidqughotgdrohhrghenucfkphep
    uddvgedrudeiledrudelrddukedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesth
    hosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ms2CXKAko7B6zy2PbUgea6Q2R8UwXriBix_MZ-1MUunNg507msaEkw>
    <xmx:ms2CXOedFe2AXMIuuKp5Uin0nX34QHsVKATDlf1_MlGrOVYTungjZQ>
    <xmx:ms2CXPfO5FhxWwi7RJ2JGF-TR1DDkZYzFxDPgu-dnwHOLdR7QSyC7A>
    <xmx:m82CXGGbrxzhAfK32wQdT7aNFw_JBWUHNWS4p-xpB7mCgR0rW_Q3vw>
Received: from localhost (124-169-19-180.dyn.iinet.net.au [124.169.19.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C94310312;
        Fri,  8 Mar 2019 15:16:25 -0500 (EST)
Date:   Sat, 9 Mar 2019 07:16:06 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] docs: Fix various build warnings/errors
Message-ID: <20190308201606.GE25102@eros.localdomain>
References: <20190307211153.28400-1-tobin@kernel.org>
 <2b5f55e5-79d6-2538-5054-b34e4b93e721@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5f55e5-79d6-2538-5054-b34e4b93e721@darmarit.de>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:40:03AM +0100, Markus Heiser wrote:
> 
> Am 07.03.19 um 22:11 schrieb Tobin C. Harding:
> > Hi,
> > 
> > I had a few hours to spare so I thought I'd clear some Sphinx build
> > warnings/errors.  There isn't anything too controversial here.  The only
> > interesting thing I hit was in patch 7 (docs: Remove unknown 'hint'
> > directive), I couldn't work out if this was a serious directive, a joke,
> > or a typo.
> 
> Hi Tobin,
> 
> the problem was a missing empty line (see my comment on this patch).
> 
> The reST primer from sphinx-doc is always a good reference for the daily work
> 
>   http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#directives

Thanks Marcus, that's actually how I came to the conclusion that they
should by asterisks.

	http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks

Anyways, as usual LKML sorted me out :)

thanks,
Tobin.
