Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF2C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC262183F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557448917;
	bh=EqsJaW5/Bzf8oCcbFLU8Gud/uLDl1k8nju9cFcmd4TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QSBI4MOIMIccuZFUbVeFrag0DJXvrvhw4y/5ChkZ+15fXTvUfdKAWfknf79mD4L7G
	 PD4UV1eva3WHQyf0xir2ozPn9m7dkUrCUHQyGBdTCU+3yVbgaKgfQuzhSBvq8wIajW
	 idfH9I95zS50+j/6Giy5HHkvrzslmtUv54WavVMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEJAlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:41:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48001 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbfEJAlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:41:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DBEE0244D4;
        Thu,  9 May 2019 20:41:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 May 2019 20:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eSuSuN
        WKvuPEDUPjbixf2FvUCsLfGC4yeDD4rUAOVfY=; b=nTKo8Y+C8t4v3/B0TVP69m
        ccd+25zeVPVFUoY4V0qBoUGUX0i5vqpKfGK/pvpNWnvcHUTeUi0+Pdpo3gvKor1d
        az8yY5nD8ZJ3cRJhCLfpBywApTuiYVx/KU0umH+Kxs4BppXPGTT30rZZ3mU3RLOX
        vZYidikiMb2TOdyACEiKsfUrPmZjKiG3OmnA+soNVd6w6/dBWOXANaJ8ANZ1ddoe
        2J5C6SFcdqmxi7mmh7+XV0ARRtwv0hwRIgITXtEe2w2nq8eT+b+Ofy3fVqQMbex0
        CS9nfCybu5eOt1cXST/794lft7Lmwl3hvtCgkqmTXAwSCbaYQ15gpGGHp2m7PJyw
        ==
X-ME-Sender: <xms:zMjUXNjUsGsZF5k6Y9opmAEj3XkuP1O8t2pH2ms6OCDakt9md0NAFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehtohgsih
    hnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvdegrddujedurddvuddrhedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedt
X-ME-Proxy: <xmx:zMjUXLB1G5jzUpXX_1wx0JhoZOG5hXWRvUtB1hkI6awged12RSKVjg>
    <xmx:zMjUXGxPikSVMiIzWj3fJq-xnqtbURk0G5xsLqCqqLz1Fk4eFEguEA>
    <xmx:zMjUXJMoG3ZInwUicjbBHfo-pW83tauKieyX1P5kx37goJgq2aI_QQ>
    <xmx:zMjUXCVsv5qsP8rIqsBnX-QfgENdc5e_9wKLjhM1f79-KUlIrWUKdQ>
Received: from localhost (124-171-21-52.dyn.iinet.net.au [124.171.21.52])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0A33103D0;
        Thu,  9 May 2019 20:41:47 -0400 (EDT)
Date:   Fri, 10 May 2019 10:41:04 +1000
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Message-ID: <20190510004104.GA12809@eros.localdomain>
References: <20190510001747.8767-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510001747.8767-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:17:47AM +1000, Tobin C. Harding wrote:
> kref.txt is already written using correct ReStructuredText format.  This
> can be verified as follows
> 
> 	make cleandocs
> 	make htmldocs 2> pre.stderr
> 	mv Documentation/kref.txt Documentation/core-api/kref.rst
> 	// Add 'kref' to core-api/index.rst
> 	make cleandocs
> 	make htmldocs 2> post.stderr
> 	diff pre.stderr post.stderr
> 
> While doing the file move, fix the column width to be 72 characters wide
> as it is throughout the document.  This is whitespace only.  kref.txt is
> so cleanly written its a shame to have these few extra wide paragraphs.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> I'm always hesitant to do docs patches that seem obvious - is there
> some reason that this was not done previously?
> 
> I did this one in preparation for converting kobject.txt, my intent is
> to put kboject.rst in core-api/ also?

Oh, I should have started on kobject.rst before sending this.  It builds
without errors also.  The 'conversion' is no more than renaming the
file.

If this patch is acceptable I can re-spin it as part of a series that
does kobject as well so you don't get merge conflicts in core-api/index

thanks,
Tobin.
