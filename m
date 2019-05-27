Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9520665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lastninja.net header.i=@lastninja.net header.b="GWpex8vM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IpBQ0tsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfE0Pf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:35:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54221 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfE0Pfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:35:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E2D2C21B4C;
        Mon, 27 May 2019 11:35:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 May 2019 11:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lastninja.net;
         h=date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=9Jn1nm1uX7H3z/48KwvctY3WW1t
        ow+pLr7KMwn5fHww=; b=GWpex8vMUPLn8pp/7J5msTMw/Oi+GgrAjGwkQy7oNBZ
        H0N2kF+xFhIcEnER/woaRMKmx1JdJsMlDyGTKRSG9a4j9dVVaxciqVcJL55Yj9A6
        40Nobxh30EjXJhq31bseFa2hUfb764ovETSiH/TkVNeFCdQZlQIo9A2JvaqOEijS
        Bsgu4Lm8E2K2yTCOFMc2yRtAJPZ/f8tr4sHnw7J7Nf+Krh14xhZoHTflvmDBC8GG
        1SmI+QPzK89HLjI9aV7gKvnpalEutw8e4T4PZZLVKPCoO7eEQpvXCg9IDpUdQZ2e
        nsGZBkVfUh1wMDBQiCpzQkHDM/Uze2FnqefNHh7VUig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9Jn1nm
        1uX7H3z/48KwvctY3WW1tow+pLr7KMwn5fHww=; b=IpBQ0tsNVjfO74sOhs3B7a
        Xnax+f86QpKaiU9mX97V/mqfpiYSQeawqg+WY38VLWEVk+PeT+wv3RXDALecdWzN
        jUc7g+eZUX6cxCaK0J5QOpvB+6lXCzR94rIZOpa0Pkvj1N0MN3YaRVssFxiFY/eX
        DCfcj/o9eOIVWcweZf9cvXPb55XHw6xOwPBUqKhKBO6acyYbrv9rtjEB2tGLonWp
        1Mwlb0Pwod5igymgsoY05UiV+N1zOsvgvot8gh/WfJhLpGFVwr779TMqoY99APAJ
        JXQPPBXLjvlJ+m5kfyjTi61BEwwecpFAiMIw2j4AsCFaXdswNSzQ3+PZGVizZpWA
        ==
X-ME-Sender: <xms:2QPsXOQ78a5gpo0IIeAI0oT1PfqVcu8ssyGlqmOnwdeH61mUdIZr_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomheppfgrvhgv
    vghnucfprghthhgrnhcuoehnrghvvggvnheslhgrshhtnhhinhhjrgdrnhgvtheqnecukf
    hppedutdegrddugeelrdeirdduleenucfrrghrrghmpehmrghilhhfrhhomhepnhgrvhgv
    vghnsehlrghsthhnihhnjhgrrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:2QPsXIBN2sfQdknnyE1_WbDoPn6QGH5T0QyGwBjsGN9bg5tyar1lbg>
    <xmx:2QPsXG3sPm0MNAtI2oNW6Gwv03l5CDyrolwsYjpCCUslOADxL9BR0A>
    <xmx:2QPsXOWhr5Wk065Tv7jukfVjTx7PNgbls8FJOqBtrixLRaQERmvbXg>
    <xmx:2gPsXNhqxgHGFAtZ9X_gsv07Fzy9FsiHZB_vocKqCYPNOjsGLCrGyA>
Received: from armakuni.lastninja.net (wbml.net [104.149.6.19])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28EFF380085;
        Mon, 27 May 2019 11:35:53 -0400 (EDT)
Date:   Tue, 28 May 2019 01:35:51 +1000
From:   Naveen Nathan <naveen@lastninja.net>
To:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kevin Easton <kevin@guarana.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: urandom reads block when CRNG is not initialized.
Message-ID: <20190527153549.GA17775@armakuni.lastninja.net>
References: <20190527122627.GA15618@u>
 <20190527140643.GB8585@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527140643.GB8585@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:06:43AM -0400, Theodore Ts'o wrote:
>> [...] 
>
> This is guaranteed to cause the system to fail for systems using
> systemd.  (Unless you are running an x86 with random.trust_cpu=1 ---
> in which case, this patch/config is pointless.)  And many embedded
> systems *do* use systemd.  I know lots of people like to wish that
> systemd doesn't exist, but we need to face reality.

Hence a compile-time option; systemd systems need not use it yet.
I would argue systemd needs to fix their randomness API (it's a sad
joke), and use secure randomness only where required. For example,
it is said that systemd relies on randomness to generate unique UUIDs
where a UUIDv4 would suffice. I'm happy to add a disclaimer in the
kernel config that this will break systemd.

> *Seriously,* if this is something the system builder should be using,
> they should be fixing userspace.  And if they care enough that they
> would want to enable this patch, they could just scan dmesg looking
> for the warnings from the kernel.

And I think this is the more interesting case, system builders should
ideally fix userspace and rely on getrandom (which is no different to
this compile time option). But the reality is the boot entropy hole
problem has been the source of many insecure cryptographic keys, and
this provides a simple assurance that it can no longer be the cause
of these issues (supposing good entropy is gathered).

- Naveen
