Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA9C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20021019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="DOUTb98Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaRo/6qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfELRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:43:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35107 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfELRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:43:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B9A42214E;
        Sun, 12 May 2019 13:43:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 May 2019 13:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=1
        Cfgoh86yXIhO1l3wHSjbNZkoYailjfwdznI6j24knQ=; b=DOUTb98QG6a6HyxD6
        y2VpMKjSpjDU8eJWbZ4IjvNB7RKvx0MuJzptG8e3j990G1W0m78xUC/H+R4Bth0n
        6IYedryREeNcp1JjUwCxbIVn16+6/hXO9fSxSGbhspEtlDvi8tDNMK4GRs3Z5D0R
        0NJc16JnGGqr+S20KLPJ5NYZZM2elFSN/CQOUQJpa1qFtuv2p1lqRH7V7jwzfRSg
        DFYz0fUYC9dr4l1gjoWwo/MwD56G8xrzY2x9juIn0J8/KXeOaY0C8VDA5oZ+RrXw
        e1ttSCVe8vgY95sZv2UTtFHWEWvJUSUmZKPyCjJTuPVchzayNcD5nrYmnFUy83au
        t8REA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1Cfgoh86yXIhO1l3wHSjbNZkoYailjfwdznI6j24k
        nQ=; b=PaRo/6qANqcqzETyFza2PkZklHstdSDrXbV/gPgmJyXAlYLrcdM3AgV5G
        Ry9TAaOQcTI0xQPpx6WpaZqF8DbtggBrtsHIK7FkFBLgjfFTEmxs8qS2/n592kLb
        bZr7dUTPqnqI+U6GMeFDCUTeb+6lK+cRwkWKoIWzYGBZnFFG/wyBoca2ZaQtaTZJ
        ToGQHH0rFQrOVLgJ5q1TmT/kaYoRz74H51DITVHsKavnedp7fS3X0T9C0e6l7qqS
        8dx48DsokfksV0Py0GG1HasOdGGqdusnTr9U04SlxW+Ph1/38jO2fUpPoxl74R6V
        bekaO016p6gn0uQ2Zk3aPwwUYfJdA==
X-ME-Sender: <xms:MFvYXCw827tw7RXqmIdoApjT5Bes2g1WmrMoKbAcRDBl3gIYkVEDbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrledvgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukf
    hppeejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:MFvYXJwt0Ou-mARw5gr1clJiD75ywLKZ3jof3e9ZkOLUEFsIcysGgw>
    <xmx:MFvYXKVKHqzzw7lw9opI2b3Vrgvu3Rh1GZkl-8fm2j45dd2r3B1tkw>
    <xmx:MFvYXGTbmZytg4AtXMJwxfHzT-2SjmBMTZ_u8J0ZydTf0x5E19_zcg>
    <xmx:MFvYXN_OBeve-z4oe-TQwR-tim1FE7xBzyA4H7wYWnEAvkXbFvIjmQ>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A997080060;
        Sun, 12 May 2019 13:43:11 -0400 (EDT)
Subject: Re: [PATCH 0/5] Misc Google coreboot driver fixes/cleanups
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b08e5d6e-7291-7b29-301a-6b0b3bd57a41@sholland.org>
Date:   Sun, 12 May 2019 12:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/19 1:01 PM, Stephen Boyd wrote:
> Here's some minor fixes and cleanups for the Google coreboot drivers
> that I've had lying around in my tree for a little bit. They
> tighten up the code a bit and get rid of some boiler plate.
> 
> Stephen Boyd (5):
>   firmware: google: Add a module_coreboot_driver() macro and use it
>   firmware: google: memconsole: Use devm_memremap()
>   firmware: google: memconsole: Drop __iomem on memremap memory
>   firmware: google: memconsole: Drop global func pointer
>   firmware: google: coreboot: Drop unnecessary headers

With v2 of patch 2:

Reviewed-by: Samuel Holland <samuel@sholland.org>
