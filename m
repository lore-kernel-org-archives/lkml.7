Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4026EC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025592087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="AabTaahW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOGzX0wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDGVpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:45:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44681 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbfDGVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:45:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 921C721E8D;
        Sun,  7 Apr 2019 17:45:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Apr 2019 17:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=eDH9kwHRJ6uwJ2msZgba1sgIWRv
        hoRzbdnTzezrnDJ0=; b=AabTaahWB5ewo1F57b9XaP26J47GTExL91xnBsuOsUz
        aFad//LoX+5mSd7G4eCctfHKac1bkcRVYk33C/7wZ+o8tdkJ7mJuP98BCSsXx2be
        B+8QvmYTDGxwHtT+SuXgU0iXugFrB+Dt92/pMe4XWjBQu49HC5BNHAOQfQRGqTas
        kL5Eam9PSBm/rs5MRr0lQ8V4NFCM54jCG2ie2tjRuNWJSLtjeOooOd0aW+KS3Oj/
        O6W1CpvVmpzSSYzzoXtxWk0lTnyKmbbuxLk0aclGbVwJhIqflZKakyMYXqPakE/Z
        G6X0O4oulxKv91z0ZX/tpN8kR3dvS8vpGimJib4nwjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eDH9kw
        HRJ6uwJ2msZgba1sgIWRvhoRzbdnTzezrnDJ0=; b=GOGzX0wLgMn2JsVcSZrq2t
        OdX0G5/hk9NlRvlWfzS1uNCE8zyZZtoSCDX+Pu4SxxunjtnGi0FPju1pmz1+mcHy
        3dm6mkhtGUrszr9zjtuNUmluzx3ICLOMN1egdoWpnIg7YuQP0ThiLS1je9ZtrZkC
        GyXuNvj6xaJzA/kIdklZ6ZnYq/N02I6E8kJmalF/Tu2Cepv+Vfq5lBxeJ3ADMh0v
        DKUVigUQq6ecaB93pEQjaSNyw7JFonJYpEDtV5COtZ5YPMHjgLw9ii6A6I+/zg8f
        ruQZtCy5SL9IJ8zCWinPpcFBX9YQT90WL9Nre23qJm29oZCgzjqIa+m2HUApezTA
        ==
X-ME-Sender: <xms:e2-qXPs9dNZXAXBXdYmOpFvhoc5oCGqJ2rJo273bcUm-bOV4nrAhWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvgddtvdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhf
    gggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrug
    hinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudeiledrudehvddr
    vddvleenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:e2-qXC6g2sDABeGAnOlqrvn2nBSGshWt39JY0LT1xX_2nZUsxdaEfg>
    <xmx:e2-qXC9NDDd9AwcMabHgwEYvn82cJAPjvE_Y-uG8uuiHV0xV8xUGPQ>
    <xmx:e2-qXFvIH_Yt6lt3R6VnaK-BiermI4ya_zUFzaMIsJneOVj3-VDg8A>
    <xmx:gm-qXC_VFdQkPf6PTN9i_Hu4SMWoE7lb2-MspepHDFKD9NIURmGjKg>
Received: from localhost (124-169-152-229.dyn.iinet.net.au [124.169.152.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1999E4332;
        Sun,  7 Apr 2019 17:45:29 -0400 (EDT)
Date:   Mon, 8 Apr 2019 07:45:00 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/string: Add strscpy_pad() function
Message-ID: <20190407214500.GA22600@eros.localdomain>
References: <20190405015859.32755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:58:53PM +1100, Tobin C. Harding wrote:
> Hi Shua,

Apologies for continually leaving off the 'h' from your name Shuah.


	Tobin
