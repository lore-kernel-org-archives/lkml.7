Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90CB21741
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="SzwSoUAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXmB7b2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDIXWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:22:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46401 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbfDIXWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:22:10 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BF0825EE9;
        Tue,  9 Apr 2019 19:22:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Apr 2019 19:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vl/fyFA1uDMvpYRDqKzKG8y9NC6
        DobbF4tLswqG+uik=; b=SzwSoUAICMIlFOtpJZnWvYPesegsK6TfR/bFAkRJnXJ
        Wv/jnGgDmahg++3ZP5OmDL4S12aAGyCD7QXkY6Z2PZkdJ5FBuP5dJXqYKT2/6up3
        gik80K/znNjSjV3tFvcSfXw/UUaTKXJ4tx4V1NuepoHLpvKGkWdzm/njT/uSsUQJ
        Th8v/QGIQOKKMG2gSXJMOtMe/htPxcXICXi6WkDUmCpbEaTsQ2+aWGL0APuQ48A1
        nKLXGFiEinKuTtASdZ/VeKKg+MDMw5HueY260Bgeqr2Wrh8jpDcavLA702iJIAN4
        ln7aqgSafvkIVoj7zLRPvRlFGaDKw7QauCHxJKxRXfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vl/fyF
        A1uDMvpYRDqKzKG8y9NC6DobbF4tLswqG+uik=; b=UXmB7b2QSCR3dGUb86WuTY
        Ts6hdHXO3+jM7oIaWurEJsB4apajCOSqFXOZdgUN3FFnANDCQSHrDVM44IS5sHEJ
        1IMCZo6cwUaokzcFuwNb7NCuhf59gRb/FAoaHKfAu3XmnZZ/MJTPYbQkw2EX7sTZ
        aObH2rZ3f82f21hT1n4dE5BzPZUI1D6P0WMIwlNcyMMFIxjkzwmVKkZw2RrGNDF4
        C43mWiZ8qWYUzCkH1YySys49YHE4yKlmQcxEMtvN3QuvKXHVJHnXvUBBYPnPVM/g
        5blTzCanFDG6P9glFwZNU0mZw6VNyasOEBBGKDyF8NqI/oKOxDWmitJkM39ryubg
        ==
X-ME-Sender: <xms:ISmtXCk5tUyyHWD2Z_WVaMO6BSae_GVj8siC_dgNXX1HwIrvGefvrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ISmtXNCJI9dbvIRvikySZaFCKPbBcgUw_eEEHdKwH8XO_FE5-b20Jw>
    <xmx:ISmtXHej32xDEQrvFZSIC05_U_oiDtMq-3N4NPXp0gWmyizxOPk4aw>
    <xmx:ISmtXLqgWsm5wsWOkzi-01vwgbN2EUqbtcfeBjBKt-q-3SMkJgZOaQ>
    <xmx:ISmtXHXKn2rig45t3BeU5gjekiPAIzgySB7BnjMsJeDJX6HiP8METw>
Received: from localhost (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5AD05E407B;
        Tue,  9 Apr 2019 19:22:08 -0400 (EDT)
Date:   Wed, 10 Apr 2019 09:21:36 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] docs: Remove unnecessary reference link title
Message-ID: <20190409232136.GA23698@eros.localdomain>
References: <20190409004359.29668-1-tobin@kernel.org>
 <20190409004359.29668-4-tobin@kernel.org>
 <20190409152030.2ed66e86@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409152030.2ed66e86@lwn.net>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:20:30PM -0600, Jonathan Corbet wrote:
> On Tue,  9 Apr 2019 10:43:58 +1000
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Labels that precede a heading use the heading as the link title.
> > Explicitly adding the link title is redundant and  makes the reference
> > slightly less maintainable.
> > 
> > Remove unnecessary reference link title.
> 
> So I agree with the objective, but...
> 
> > -	As mentioned above in :ref:`VMA policies <vma_policy>` section,
> > +	As mentioned above in :ref:`vma_policy` section,
> 
> ...this one generates a warning that highlights a flaw in the reasoning
> here:
> 
> 	Documentation/admin-guide/mm/numa_memory_policy.rst:144: WARNING:
> 	undefined label: vma-policy (if the link has no caption the label
> 	must precede a section header)
> 
> Said label does not precede a section header, so it can't be used bare in
> this way.

That's weird, I did a clean build before and after applying the set and
diffed the stderr outputs, I wonder how I missed this.

> I'll apply the other three, but this one needs some repairs :)

thanks,
Tobin.
