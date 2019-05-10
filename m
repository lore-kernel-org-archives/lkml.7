Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0779CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AE220881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="dkS98jW/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boFvQMsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfEJUpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 16:45:51 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbfEJUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:45:50 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FF7821FE0;
        Fri, 10 May 2019 16:45:47 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute5.internal (MEProxy); Fri, 10 May 2019 16:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=vwhOJce3ZkxXuJH0oJfw/OIAX76yCZA
        aJr+TAGwuShQ=; b=dkS98jW/JNiik0LeBJy03Ed1tMILgeWRVbWjhUUM502Qlyv
        aXUgCG1MshcYlNzziwgHfMsf9WUvp3XAENPxfWbswRQe5ybYMVLrvlkew7zTWjCY
        1S1ZdUw6arMeQJ9HRo2GXPqJvCDLdiJwB0Lqt+3PP//z8YXy8ZJ81+fMYTmBgSnT
        NkuXYkgpD1sArHftABA6ydlIu8O+nhcn69GqU0ZSC21k25coQYZuXI5IdfVPDrVO
        IUEIMRxc3FVzjYP4moiHNRZ1ZbRGOAWqY49Qh6fkQYiRd6UmDIpXrTkEX8SQlzxr
        +XrZul/FBf1WsXey8JDfG+JJzUu6S/IcMBlIUiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vwhOJc
        e3ZkxXuJH0oJfw/OIAX76yCZAaJr+TAGwuShQ=; b=boFvQMsuqRyKb0tSk0cher
        wO0iQ5WsJNB51LCSbSoPyG18BXJtUuwGSf7fei1FM5GMO/6IA3KrYFGFiIS2IAQV
        I/73a3Q/CDSWWsxWbLvgUmataZAncUZsof2vJRD+mvOVf0g/Sg4y6t+YVKXy2rEj
        Ja7qHpCH5Qn+UOoGx6cs0LIQMkV97UQ2PDlLwBucDms3bDVf0M37cKAIxqDDYQdG
        zrHFLZ8HAfU3dekS2hN5UhRN/6SNwg8ccJXrqeYkcX1V6DjdUy43UDI/mp/023As
        AR4lmFrIyRZ+XK7ae9WSDWpO3/5p3Qps8vvSzft/F8mDC9dz1+T4wsdjzkuvepzA
        ==
X-ME-Sender: <xms:-uLVXPcrYOLSWMokSRsVZfHid3JjHXpoT7aSjKd-3rFXkphqq6INpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:-uLVXKGVd4YgR3g4Pe_T50A7Nd91RQgUeeK0lHZ7g1GzqLfIv7tZLg>
    <xmx:-uLVXGFs8ZfDpILRjitXWhQOD06igzn4oJKURYmso7QarGWSAWcePw>
    <xmx:-uLVXDAbOa1EyUdR1PSdyYxOPKnUYzRa_s-Lk7ybVgp02azvivSuEg>
    <xmx:--LVXNujsEtxLTa9jG0JaVPzBsOOvo-PVdW22zWSrOp0C7_5VlcdHA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BE8ADEC25; Fri, 10 May 2019 16:45:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <f48e76f7-6b95-4cf0-82af-424119bb2eb4@www.fastmail.com>
In-Reply-To: <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
References: <20190510001747.8767-1-tobin@kernel.org>
 <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
Date:   Fri, 10 May 2019 16:45:45 -0400
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Thomas Hellstrom" <thellstrom@vmware.com>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 10, 2019, at 20:51, Thomas Hellstrom wrote:
> On Fri, 2019-05-10 at 10:17 +1000, Tobin C. Harding wrote:
> > kref.txt is already written using correct ReStructuredText
> > format.  This
> > can be verified as follows
> > 
> > 	make cleandocs
> > 	make htmldocs 2> pre.stderr
> > 	mv Documentation/kref.txt Documentation/core-api/kref.rst
> > 	// Add 'kref' to core-api/index.rst
> > 	make cleandocs
> > 	make htmldocs 2> post.stderr
> > 	diff pre.stderr post.stderr
> > 
> > While doing the file move, fix the column width to be 72 characters
> > wide
> > as it is throughout the document.  This is whitespace only.  kref.txt
> > is
> > so cleanly written its a shame to have these few extra wide
> > paragraphs.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > 
> > I'm always hesitant to do docs patches that seem obvious - is there
> > some reason that this was not done previously?
> 
> Speaking for the two kref.txt paragraphs, the width being too large is
> simply an oversight from my side. I wasn't aware of the restriction.

I'm a stickler for the rules, often to peoples dismay :) AFAIK they say 80 characters for code and 72 for documentation is optimal.  I'm yet to understand why 72 was chosen.  Maybe because its the same length as the git commit long message but that doesn't explain where _that_ came from.  I read once that they used 72 characters on punch cards at times because the other 8 characters got mangled for some reason.  Anyways, its kinda anal and I only change it if it looks like doing so is not going to annoy people _too_ much or, like in this instance, if the file is super clean except for a small portion.  The rest of this file seems to use 72 so I thought it was worth the change.

I'm open to being told otherwise.

Hope this is interesting for you,
Tobin.
