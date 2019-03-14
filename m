Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="fFNsm8gj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q14FmF+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCNDYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:24:48 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57509 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbfCNDYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:24:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 609AD3739;
        Wed, 13 Mar 2019 23:24:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Mar 2019 23:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=QD/L4U5YxRm2Guw00dch8PmlTQ/
        omLCRelsZiBSPVsY=; b=fFNsm8gjbOopziwP/as9hJ3WnJSe6neNNC0/pLoTrln
        5egdSuSKvOOgq5hW03NC9btqGVfvcJFp0GJwHwgHPPSWwNy5VYnG82I137mqhwkU
        ApaZHxuGXwWMR3o0RKCORoLe+vYesHhEYfRVl9YoEnsmce6yfAAUUtuWBefV/D8K
        c7VzhJz9IB6iKNRzUwJ8VRvdI5R9iQilt9ML3P7tkgs5YOgaVvHRT0bVHaHKgKT3
        Ym8Wi0XkDZSDdYb+Nzd627/Rgpglego+/4ia25zEEdJbdF4FmD5N1Umc5gM8hamh
        Xxh5qYKHzh/7Fq2bvL4Rom+RSKeYFbGMMRq+eKh/SjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QD/L4U
        5YxRm2Guw00dch8PmlTQ/omLCRelsZiBSPVsY=; b=Q14FmF+xo3wVrkrc8Azank
        0VTTApneGjeGoytQPhAQlW2gXnOwJ4qGRHpPNZTQrGzgLvBM4HVy276HCQHN505+
        QgrnR8NP3WjXiW9EftW2PjGbSRoE7OqfR6YfZJhnq+ghVvoHzHJgMFFLD6cFuLtx
        JYAljqI9gX5A76iPSHcG0ns0peC5Z3nMPLP+HCwYHodzzJVDPsB9tdtNKwwz4dAb
        AF43tS4H77Vmd9JZZpP/ild5SSBimDWhI1AbZONj/IFKZUnWyN4ZxNMNEG6MoBD6
        qJ57xEYnANEr5Xr7lFJBENDsKihLD/6UHG10WE/CQYR4yWo4H+ze2xTp61FVxaGQ
        ==
X-ME-Sender: <xms:d8mJXCBJs40Wf9tZwsWTj6N7UnQGNbVquJ206Ex30GBgfr8h8or0Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:d8mJXAzYrTOZT0XFO4AzJ9gXW3byODdFP73B8AlIfLpkfUiMx0FC2Q>
    <xmx:d8mJXAmy2oW8cIw4AWAQnZaEVBobqavKAkwd__apBoRMbno81KP5qA>
    <xmx:d8mJXFHtXHcc8h_DSJBz4cIvJdnq8iPsPPpfIye_npg5BKalkEqEQQ>
    <xmx:e8mJXKJrNFYDc7_iP2hLY8xMYLPq1hzXCvcOS-MYYq31qNC4--iqIQ>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31C52E4210;
        Wed, 13 Mar 2019 23:24:37 -0400 (EDT)
Date:   Thu, 14 Mar 2019 14:24:16 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] slob: Use slab_list instead of lru
Message-ID: <20190314032416.GA25492@eros.localdomain>
References: <20190313052030.13392-1-tobin@kernel.org>
 <20190313052030.13392-5-tobin@kernel.org>
 <0100016978719138-5260db28-77f5-4abb-8110-2732aa709c5e-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016978719138-5260db28-77f5-4abb-8110-2732aa709c5e-000000@email.amazonses.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:05:02PM +0000, Christopher Lameter wrote:
> On Wed, 13 Mar 2019, Tobin C. Harding wrote:
> 
> > @@ -297,7 +297,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
> >  			continue;
> >
> >  		/* Attempt to alloc */
> > -		prev = sp->lru.prev;
> > +		prev = sp->slab_list.prev;
> >  		b = slob_page_alloc(sp, size, align);
> >  		if (!b)
> >  			continue;
> 
> Hmmm... Is there a way to use a macro or so to avoid referencing the field
> within the slab_list?

Thanks for the review.  Next version includes a fix for this.

	Tobin.
	
