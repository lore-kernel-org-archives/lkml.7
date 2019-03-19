Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A04C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3F2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="EIs/rzWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fftpdjCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfCSXm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:42:59 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35403 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfCSXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:42:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C58F21FDA;
        Tue, 19 Mar 2019 19:42:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Mar 2019 19:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=qqJ6zqZmUagpeXC3C8lhNrNZsRP
        XOhhM2nwEO+EJZF4=; b=EIs/rzWjPwF+u7x3P8q4V9Gk8LZPc3kCmQFKdDWf7+n
        cdTpAB+XTZqgZeuVcmxTb1elW9xwSuI/mropTJCDVt/IAUWBL3Y00NX5u4j36OBD
        3oWIQZyq6e+/X3EMkwpqfU7x4G00FwFyRY6EEudiOWBXJQxiQV7fLWj3yEFCCfgm
        oMxEacJWPQuHoWmGyXxeFJTtQI+8X1pM/u9eoXHEdfDb2YRWgoR3Ye65W5MIPnue
        a9vzXtQc713zlhmJywdsXDTyM+lnIMNTXHOUm0bFoNaKW3VJSg3pLPAtfKHz68Qi
        9FPL3jgGxIex12ld9qRnVraKbhX08iKyGk0woXC8fgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qqJ6zq
        ZmUagpeXC3C8lhNrNZsRPXOhhM2nwEO+EJZF4=; b=fftpdjChmY44lpCyg2Fytw
        erCjo8Ij+iJwltDgi9dshsnqTioklEk6BqmwssCxVbmaEAhOYFi2508esMMcVTxh
        TC3bU0oS+yKIDNwu3b10PanKDhG2T5aCriVIFCa891irE2yEKOAvqgIRApVByzp+
        sIJOigF314I+kczt3QUsgqQNI/pLZf0ZE801dNQV1D7Db8wgeS2pGR433f7igA6t
        vpmqow3vCKV0xQ+2NrMjcCOpWLZbZ9Rr19WAI/vWIeDiRy8yRWtb3FsUNtev/AkR
        0qMk+ehf2eijeRlZY45vVKwZXuqZTCcDlObjOvyC21CbDI6e0Az0IVM3sL6Vjo1A
        ==
X-ME-Sender: <xms:gH6RXAXPAvI4enih9_AzvMWJtmdmsNao7aG0E67doNXK-QUZE1GLfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrieehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudejuddrfedurdduhedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:gH6RXPjB_E4igQ48DMWZiLu5SzLE1nffm6uBa7F4Zcxy8oYNnlbrRA>
    <xmx:gH6RXDbdi6ZUo43bfhusYLjk9l1fcwF1HH0LR5HZUrrDdeUkr5zLTw>
    <xmx:gH6RXEq44VLULdboAz3RiUCYpDKDI05M2_3HgNi4iM49ZViBQYOhUw>
    <xmx:gn6RXFK1V6SOj8gmJKR1XXuTC8UJQBUUVfrre-Lr1H_0eZWTzd4O8g>
Received: from localhost (124-171-31-151.dyn.iinet.net.au [124.171.31.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D715E4014;
        Tue, 19 Mar 2019 19:42:54 -0400 (EDT)
Date:   Wed, 20 Mar 2019 10:42:00 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/13] docs: filesystems: vfs: Add code-block and
 txt->RST
Message-ID: <20190319234200.GA13178@eros.localdomain>
References: <20190318231437.1666-1-tobin@kernel.org>
 <20190318231437.1666-10-tobin@kernel.org>
 <20190319013526.GA30001@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319013526.GA30001@eros.localdomain>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:35:26PM +1100, Tobin C. Harding wrote:
> On Tue, Mar 19, 2019 at 10:14:33AM +1100, Tobin C. Harding wrote:
> > Use code-block for C source code.  With this in place we can rename the
> > .txt file to  .rst.  This introduces a few warnings that will be fixed
> > in proceeding patches.
> > 
> > Add '.. code-block:: c' to C source code snippets.  Rename the file to
> > use rst file suffix.
> 
> I just realised that a better way to document these structs is to do so
> above the actual struct definition in the source file then include those
> docs in the documentation file.

Please either drop this set or only consider patches 1-8 for merge.  I
haven't worked out _exactly_ how to move the docs from
Documentation/filesystems/vfs to the source code files but I've played
with it enough now to feel it is possible and it is definitely better.
Just have to massage Sphinx into agreeing with me.

I thought the whole reason we have docstring comments is because we all
agreed that docs close to code hove more chance of staying relevant.
vfs.txt proves that nicely (docs in it from 2.6 for structs that are
actively used and developed).

Sorry for the noise, one day I'll work these things out _before_ sending
the patches :)

thanks,
Tobin.
