Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38AFC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C76D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="kB3M0EF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMLwgH0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEPXUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 19:20:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44273 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfEPXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 19:20:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 69D6C247EE;
        Thu, 16 May 2019 19:20:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2019 19:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=w5gH9IZI3l53KDXLVC+HD0A+klb
        zgt0ehnqv827jsNU=; b=kB3M0EF9ZBdRGARsMVJ4KAscJSJE+wCUzjlrkHIkdY3
        UB89cEqpToxB1+wkbaetNrS40wn6sTZ+zF1tSb9vK6F6sLVWoldVMrfsnDCDdc6b
        8UZEw+wl+WMDCI+uuiDbByguow/tQahBqIg+8wA8cMesyHQafGi6XyLOHFmp1xQf
        k7EO0SMw94gtY8Z1ip+/+waOkSK1tF1X+NLDbYsiAb8GNIeKYgTuIA3I1BRQyyZP
        8u4Pu7Cm0wQ2l8vg5NB92XUyTU+FFrCzfFGTaT1zUhd9HFEFMPJo/ZU+elnM9PRB
        bNG5ZssTtNuCu6CQvcedx/13u8qqG7PDT5rz5WA8lxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=w5gH9I
        ZI3l53KDXLVC+HD0A+klbzgt0ehnqv827jsNU=; b=pMLwgH0M+MAKSzpAuSXr5n
        0b+gj4/4v2YoTPomPlBnblBYK7tiXpRpxA8je7bCLYSJh1H0FFvbonnsUCCHhjYF
        ay+KiNUoE/pJFAFcHaQvxg/VkbeX6uK6f+ZDzL7rNcee5btlKaTnTH9AnVMj0syu
        rKwPBFJCuxih2b+Fw0gxdroQc8N5tcCZkyRADtZIGt5MVzd6x6cNxWgjpIKXyJIL
        coQe4ibHU2VXM+SDDESCvkpKVwatcFP+zeEmegLb9bQjnSRRFhtNpjP5bQZ+jVn5
        hzSF3v0mMJR63dwHoElYzp9FmHD20tq3FQUp5p4m1hXLFonBL5foHLzuFV+MouqQ
        ==
X-ME-Sender: <xms:PfDdXIop5RSQnLhSHi_Bb1hIm-RrsGJhaxPAIu3GFzC6U_jGTUA6rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddvuddrfeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PfDdXD61G88coePhXXkZQLKprPgy1L8UkXAWU5ldHm0nx1QowXJ5Cw>
    <xmx:PfDdXO5-XcUpCY-4XsQF692FCmeYgOElyKDItt2L2lyhTfna9PD7Aw>
    <xmx:PfDdXIHViaTDzj_szUrenb5Bxy6Vf-dKpE8vbcGC4jNCunZXvCJSsA>
    <xmx:PvDdXC_CSZSsRWzOSzQhNfMM1iu25I1RwOK3gh0YBsPZy1SPwFAInQ>
Received: from localhost (ppp121-44-221-3.bras1.syd2.internode.on.net [121.44.221.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id E3D9F103D3;
        Thu, 16 May 2019 19:20:28 -0400 (EDT)
Date:   Fri, 17 May 2019 09:19:49 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [TRIVIA] Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Message-ID: <20190516231949.GA5056@eros.localdomain>
References: <20190510001747.8767-1-tobin@kernel.org>
 <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
 <f48e76f7-6b95-4cf0-82af-424119bb2eb4@www.fastmail.com>
 <20190515105648.61164eab@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515105648.61164eab@lwn.net>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:56:48AM -0600, Jonathan Corbet wrote:
> On Fri, 10 May 2019 16:45:45 -0400
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > I read once that they used 72 characters on punch cards at times because
> > the other 8 characters got mangled for some reason.
> 
> Those of use who worked in Fortran understand these things... columns
> 73-80 were ignored by the compiler.  The normal use was to put line
> numbers in there to help recovery when you dropped your card deck on the
> floor and had to unshuffle things.  A diagonal line drawn across the
> top of deck helped a lot, but it was good to have verification for the
> marginal cases.
> 
> Kids today just don't have any culture at all...:)

I was just going through my editors init file and I see I have default
column width for kernel RST files set to 75.  Did you tell me that some
time Jon, I vaguely remember?

+1 for the trivia

Cheers,
Tobin.
