Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EAB217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="vTv86x89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAeVhB+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfDJIQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:16:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45025 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbfDJIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:16:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C3C1D14D2E;
        Wed, 10 Apr 2019 04:16:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Apr 2019 04:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=m/uVHFT1jhHjwl1wvSmrccMP41E
        GDLxAQtR3VjpelW4=; b=vTv86x891gs2zeQ0anLIdh4jLJdItCLHC1bgyKJpLQp
        ueh4sVyQQ2jtNvo/eVjk94ChD/ZBcaiKZsM1hxlnWDXRZfkHXA1Mp6Ju2XulA3ne
        ljIrjTtYu4/EGl3LdEuEaGv7O8fMdxH/tuVCZhBiY9hwiVDKsZx8MG9eQn9onC7b
        wHfhXhOGNgOEJpZcoO3Cf97G/Aq2y8ZVYLrW6JM/1S9SnVG+CJup/w4O+9CWlRzZ
        EdOZWu/uXOmyw7ewfpl/9eqhaUTKu1DflnbdmPCn5w1aZgOzC+N++2Fh0Psa9HYK
        6W6th5LMUpOpz9KPa6RpVOk9sp6llI8V+/Jjcx3juDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=m/uVHF
        T1jhHjwl1wvSmrccMP41EGDLxAQtR3VjpelW4=; b=JAeVhB+RKxo8VoPuYMZRnW
        RNw4G56faDioJGzB8f3p5qK1ktZ3FlJQrS9IivEQdBV5CpoekLVR1PJmlXyRLr2y
        rW3iIc36+1l7LdmiSdp7WoI4oH6wIR7XAUzsFpSk0A91OjuKiB8rLXBUhF1rvXcM
        VCQsTnCPI1JVgR7dOpb1V4x+3+H7wFl3+xIbDAMc/LVse+1iyBpQv3vew8GRS1ZP
        Z3AwQbrTX6sDUJhX1zSSSP1FmtXNvmC+NvCGLVq6FkMU/CAcjAP5WMPS38ZONYmA
        oVK2MtyDWSDWmEnLKy160OKFVR3tuRX5j5CKowEYj1TZllSARVIjdE21W7FbhUJQ
        ==
X-ME-Sender: <xms:d6atXON43mYmyfinx8E3M1GfCH8J9ndOCkiOy5a7T67NI3LRxTDHzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdegrddu
    jedurdduledrudelgeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrd
    gttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:d6atXBENj7Kztz9HxoAFCfV4BhEOGaPkjHPtD9nc3yyJigy9IxGY4w>
    <xmx:d6atXCSVlp-e5sEUFdE8SLndAtySbZIw6maP-T0gaD0UjWT9318sNg>
    <xmx:d6atXJR0LbXjKnimvSSiWK71bTJ_nzcFTz7YnwdC2pZgChOYddRFVA>
    <xmx:eaatXFQI54cMgvE9WEp3tiwqaVEzSoVlT5cIixgnTBMNH0xPnE2Z5g>
Received: from localhost (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB0EA10394;
        Wed, 10 Apr 2019 04:16:54 -0400 (EDT)
Date:   Wed, 10 Apr 2019 18:16:18 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
Message-ID: <20190410081618.GA25494@eros.localdomain>
References: <20190410024714.26607-1-tobin@kernel.org>
 <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:02:36AM +0200, Vlastimil Babka wrote:
> On 4/10/19 4:47 AM, Tobin C. Harding wrote:
> > Recently a 2 year old bug was found in the SLAB allocator that crashes
> > the kernel.  This seems to imply that not that many people are using the
> > SLAB allocator.
> 
> AFAIK that bug required CONFIG_DEBUG_SLAB_LEAK, not just SLAB. That
> seems to imply not that many people are using SLAB when debugging and
> yeah, SLUB has better debugging support. But I wouldn't dare to make the
> broader implication :)

Point noted.

> > Currently we have 3 slab allocators.  Two is company three is a crowd -
> > let's get rid of one. 
> > 
> >  - The SLUB allocator has been the default since 2.6.23
> 
> Yeah, with a sophisticated reasoning :)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd820807680d2ccc4ef3448387fcdbf152c73
> 
> >  - The SLOB allocator is kinda sexy.  Its only 664 LOC, the general
> >    design is outlined in KnR, and there is an optimisation taken from
> >    Knuth - say no more.
> > 
> > If you are using the SLAB allocator please speak now or forever hold your peace ...
> 
> FWIW, our enterprise kernel use it (latest is 4.12 based), and openSUSE
> kernels as well (with openSUSE Tumbleweed that includes latest
> kernel.org stables). AFAIK we don't enable SLAB_DEBUG even in general
> debug kernel flavours as it's just too slow.

Ok, so that probably already kills this.  Thanks for the response.  No
flaming, no swearing, man! and they said LKML was a harsh environment ...

> IIRC last time Mel evaluated switching to SLUB, it wasn't a clear
> winner, but I'll just CC him for details :)

Probably don't need to take up too much of Mel's time, if we have one
user in production we have to keep it, right.

Thanks for your time Vlastimil.


	Tobin
