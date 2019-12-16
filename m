Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0202053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="eb4AVJUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MeXLoRyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfLPNGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:06:38 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42399 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbfLPNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:06:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A9FB0705;
        Mon, 16 Dec 2019 08:06:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Dec 2019 08:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SSBA7Ov7ZJvUelq0IS5gSJti76n
        EVtN812W5WLYVrgI=; b=eb4AVJUDZgm9Wdq7m42bZJ9k/w17EplO0Luz/EfvMAJ
        a4/vNM9N9nS9nG95uZMtF5/PZTURH3YlqSMnjDapMuqKwSOyOD9MlQq4P8HxtzQd
        aIE0HbOa0xUph/Z5Ps+uMnwlJX14YNSfD8YgbpTJ04jrGxNTJkpupGil/fZTTLlu
        QRStvspT6IPEyoLGmY+9WBSvExVWVql6iZo+7l3xBx8Zfq9kRRLw/mSpD8WhDGd9
        5glIuoOyoBXr8XFdz1cYxKL4kvLTlskewbXw2Yr2Gl+JCx0ezi7L/4Dx1KBSc3Ur
        U6YuZiPWoPix35fAGw9zZqEEQ9/UX3qxV2Pp+iMYtRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SSBA7O
        v7ZJvUelq0IS5gSJti76nEVtN812W5WLYVrgI=; b=MeXLoRyLzySTaJ3ie7qDZi
        iHWqHXLDDkOdP5OKnVtZQcjDSi4Hc80HA/6DkruvW6LigX7fHUbAx7O0xh1fhRd8
        GKVUQCdhJSDRrUiiwN5zqn6XpjRrSxKidPn60tnLWlmmmpzaPVvAo1SxNZadr/Vc
        ux9piRkUd7rV/fJV8hVQznie0PRblKBOYAdEk5UaJ41ixCGIigVPteS1RM1SFhe8
        xfbEUsBH8r5i/WdF6NnGBt6zi6w39hXPUr7iwYejzFNlML/qysFMfTBBzdrBRhEl
        /S7HlBumlxYmWu6jbk9Zo90tifKrVu08qC87Z+lzTKxkE9BertpvTnqbvZ1kIElQ
        ==
X-ME-Sender: <xms:W4H3XbMLuF8lwWWfnnlVJa9wBa7D9hQ399mhA5ygQUCK_B2CZoZrOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddthedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:W4H3XUdVTj5UFtShc8iWGuC1MA3sG-buIL1tXHjIjx1Nc4A7OF3AKQ>
    <xmx:W4H3XVxYirWCIB4bmwiRUYAjhleWJBMa-IG-I5O7e1m-yJXcSYg-lA>
    <xmx:W4H3XZ3albaEG1jUTZ5-ZbBmasmsSASn6QKOwnKVf2OUV5V_gQvpUw>
    <xmx:XIH3XftN7ey_9aKvgs-_kUAYzzjkfZ2cljj6vOF39mMOx_cPCBkcrQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DFAB3060130;
        Mon, 16 Dec 2019 08:06:35 -0500 (EST)
Date:   Mon, 16 Dec 2019 14:06:34 +0100
From:   Greg KH <greg@kroah.com>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, stable@vger.kernel.org,
        linux@roeck-us.net
Subject: Re: [PATCH v5 2/4] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191216130634.GA1563846@kroah.com>
References: <20191016210629.1005086-3-ztuowen@gmail.com>
 <20191017143144.9985421848@mail.kernel.org>
 <b113dd8da86934acc90859dc592e0234fa88cfdc.camel@gmail.com>
 <20191018164738.GY31224@sasha-vm>
 <7eb0ed7d51b53f7d720a78d9b959c462adb850d4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb0ed7d51b53f7d720a78d9b959c462adb850d4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 08:51:30AM -0700, Tuowen Zhao wrote:
> Hi Sasha,
> 
> Sorry to bother. Can I ask for patches in this series to NOT be applied
> to stable?
> 
> They causes build failure on Hexagon.
> 
> Relevant patches include
> 
> sparc64: implement ioremap_uc
> lib: devres: add a helper function for ioremap_uc
> mfd: intel-lpss: Use devm_ioremap_uc for MMIO

Oops, almost added that last one.  Will go drop them all now from my
queue, thanks!

greg k-h
