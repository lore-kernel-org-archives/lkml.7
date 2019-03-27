Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D80205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="wKry3Si5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJPRaMxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbfC0G1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:27:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38523 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732949AbfC0G1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:27:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 612AD22616;
        Wed, 27 Mar 2019 02:27:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2019 02:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=CbvWzpi+9CjGLTTGIZgcHtbiK3b
        6cUV2KwJocRoXwgw=; b=wKry3Si5PVeZeQmyGff463AXTFg4gtfNCj2YJPU+Wjr
        B+QL/RKVieD9v3CpvK8BLnlmwl2zXKXj+xfM8r0+bDPReg7/iLLEfkvOUSftHI76
        grvCjjyajP0Rx41sgnTnmYmUm9n1K1V4mo0B9xelRcZTUg8KvfZ+6qqjJChVGW/B
        2nuGivKAEBg8sFC5hoQu9EdVP/Mry22n0dSv9ysj4O5oQWlravmtePpVQglhPqNt
        cKVMYizDnSJiqDsiXCOV2FQ0gENylZmMYlCpOq+PpiX+1meXQwrsOZSkmJy6IeyC
        1aG+jB4PrGCUfaoXYvUDgHci4t8ig581Or6bGQcOv2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CbvWzp
        i+9CjGLTTGIZgcHtbiK3b6cUV2KwJocRoXwgw=; b=GJPRaMxMn53GCZkldRbGZI
        quL6b+iMOvWcRTz+cQN1vbqcWCkCdPeMEiyid5A+37PGhRgAQJ4MRmj5IMAF+kxG
        J/bGvdtYeekkhoDJF73DbCTqdKEH11WG7Tr4hY8KilIA6HA9s/E9DcjoUrR+3zdm
        j/+kuWe0ez1U9xBUzxAmy76oKMgqs6NcfsNXOjEb54MDj/Z8aqEUCQ0zwBCKn0J/
        lIESaMSbXsg8g8/fHc+TkOjT0dGpLN3jhNeBX3bTUaau+HdVt0hVlBHjwLOOYqU+
        dwnCTi5WhuV07UREp4FKxTouQJU5zPeoBhEfYKV5r4Au9HbFY5hJ4PmTvMranwwg
        ==
X-ME-Sender: <xms:xxebXBSF-XEZV7vuSctM1YzkPaJDkk27SiawG0XnG_n3y1jo0ZGRaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xxebXKVf1YjGkX7TBNE2og9RaxNGUP_7Lsy0Q20XlKhQD2dfsHpYiw>
    <xmx:xxebXK6Yl5ZYHGbfc31-AkMfE-g1UmKfl84yuWvqjmLHYr22dbyhDw>
    <xmx:xxebXIzlkqkxDHKkPft36nSz-DQm-F5jFtNGlwFzjyE7cLz9e8LgSQ>
    <xmx:yBebXP2_XyJ7bKkqGEXGMOPx2sUT6Wt_xLi0GpsNzGPAZSWIjl1Heg>
Received: from localhost (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01717E49DC;
        Wed, 27 Mar 2019 02:27:18 -0400 (EDT)
Date:   Wed, 27 Mar 2019 17:26:52 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Joe Perches <joe@perches.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190327062652.GA26545@eros.localdomain>
References: <20190327051717.23225-1-tobin@kernel.org>
 <ba0732a4dda60e263049f3deec08d90d8bde5064.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba0732a4dda60e263049f3deec08d90d8bde5064.camel@perches.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:24:37PM -0700, Joe Perches wrote:
> On Wed, 2019-03-27 at 16:16 +1100, Tobin C. Harding wrote:
> > Hi Al,
> > 
> > This series converts the VFS file Documentation/filesystems/vfs.txt to
> > reStructuredText format.
> 
> Perhaps add a MAINTAINERS entry too.

Checkpatch suggested that to me, I didn't think it was polite to put
Al's name on it without him first seeing it :)  I can certainly add it
to MAINTAINERS for the next version if you want me to Al.

thanks,
Tobin.
