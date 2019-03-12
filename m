Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D873221734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="tHxvFSp+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOv1MgBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfCLDxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:53:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36899 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbfCLDxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:53:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A875322158;
        Mon, 11 Mar 2019 23:53:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 23:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=iIK4K2fa3ctQzOW1hEie5Z6OZpa
        asuw7MQHhKT6+nNg=; b=tHxvFSp+CUHlW4XvKgJVQ6ivgkukQyPY5PrtQ/L0Y1L
        EQS7wopd5mDz0wplgsXe4FQRHuqhOGZ+6cCqxXfvFq2SRJtAfBVNrok7pJbhQ48Z
        1ZISRc6zdVQ78Ld74kV7hXk+cVVVQlaNX+TtOSBKri0Ca/rx5sV512AT2WYWYTdX
        Bk2E6SHq6Nn+JjNLhJzzuxGvyTA1Pecu2HVJkurWAw5kT8Y9mf2xzmkR6hAGL68r
        6rdR7t7ioUB0ZHq0rnYpaMUP7s1hF9c+j4+XVPcLWPuBJKZH5Aru9WA4eBzMRRUw
        V4ArZGc7BV3R3tEU22DaZkjp+Fu2PEcDKzkxh0L77QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iIK4K2
        fa3ctQzOW1hEie5Z6OZpaasuw7MQHhKT6+nNg=; b=MOv1MgBY4r10k5L939lC+2
        BRbRLpO4l8SupEVwV3P8j27HBaN+xbI5pvHe3Y7PsqIjZEcNFtG/n5kEBD6ekFRQ
        PfhPjRMbt2EPb6A7MZnQgVfUQ/4rqmrKF8sXiN2sfR+u7821nb12sOM3b/0aXSRM
        QoTFAbS/qsyOSSBPozzu6CRmtSo2w9+1qz/czIAFC4Skt0LoP8bCaxTDB+mxsu2O
        QVHQqSA9N6MPHPb6FfN9SVmyCgkWJr/CXBbv5U57heWbM4yHYbzs+K5M0rojsIAc
        hBifnaC1gc5oj6e8oaphGAUiAvhWb+RK+B1XFAy5f7jo/0pW5eT4CAtQvmMJ4cBw
        ==
X-ME-Sender: <xms:QC2HXNRxkO9CivC5ngbaRVL4QXVF78_hCXiBIzJcrBEv-aLrWVeiFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QS2HXDHc30-0s-L8snngdeGWnPD6ol9M14zXJXmllYFWtw7tNMOkVQ>
    <xmx:QS2HXFnQT6zjRiPa4jYPflzW4JsQ2Y-N3iY85716OvvlmQtfr1vXZg>
    <xmx:QS2HXG1Lyyup8k9GC4-lrC7GB_0sxYJ84fWbYG5GGrar7Lb-3jRxDw>
    <xmx:Qi2HXHpuPVHym96-PKRAzJGfdFN-_9IKqMkoKAHbdKQJPxNDjEubBw>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74CB1E4752;
        Mon, 11 Mar 2019 23:53:35 -0400 (EDT)
Date:   Tue, 12 Mar 2019 14:53:10 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guro@fb.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Message-ID: <20190312035310.GA29476@eros.localdomain>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
 <20190312010554.GA9362@eros.localdomain>
 <20190312023828.GH19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312023828.GH19508@bombadil.infradead.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 07:38:28PM -0700, Matthew Wilcox wrote:
> On Tue, Mar 12, 2019 at 12:05:54PM +1100, Tobin C. Harding wrote:
> > > slab_list and lru are in the same bits.  Once this patch set is in,
> > > we can remove the enigmatic 'uses lru' comment that I added.
> > 
> > Funny you should say this, I came to me today while daydreaming that I
> > should have removed that comment :)
> > 
> > I'll remove it in v2.
> 
> That's great.  BTW, something else you could do to verify this patch
> set is check that the object file is unchanged before/after the patch.
> I tend to use 'objdump -dr' to before.s and after.s and use 'diff'
> to compare the two.

Oh cool, I didn't know to do that.  I'm not super familiar with the use
of unions having never had need to use one myself so any other union
related tips you think of please share.

thanks,
Tobin.
