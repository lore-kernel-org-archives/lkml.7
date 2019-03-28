Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B83A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qMAjvcB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5q8ytnes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfC1Q2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:04 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50331 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbfC1Q2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:02 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 12:28:01 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 29DF1618C;
        Thu, 28 Mar 2019 12:22:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Mar 2019 12:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jzEin1H05Jj1Q+XEKrBLDcp75FH
        Nt7kl/g/Z8NRtlTo=; b=qMAjvcB/11XZKHim/QoGWAngBy+gT2QkIr0InpOq6Bc
        l77BcU3VoNe6iLTEK68DV4wHfEw/DPBX6U9TSJy6ICGQFwnkgxYsyjvK4hUjzT9J
        e1IQwVTUuV5wd2N6yUz0bE3A0ZOGIcZxqbKEwjWG8ah7AjI50bz5jdtf5KPi3Tm0
        xOICWQLp5RtY17f6mvpGbCfems4wX70jPIOoiLe+2CbqQTLDYdcUSwIwzrnqRAFR
        uTqUKLJC1+Swk4y4ZhVVmw4f0uiDxVf2nZMqplPnSLgjewkheFCsZKi4Yve0n8Ed
        qh1wsHdGBYcxxy12zha7iWTFTNvKvfkreYV15PNXOZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jzEin1
        H05Jj1Q+XEKrBLDcp75FHNt7kl/g/Z8NRtlTo=; b=5q8ytnesnlGlAR9GjsPJZK
        qa9JM03NJNAqTzge71Sw9yNblJ5NmeqOJ6Whxpn4OBZ7BWIV5c63Fuh5ymkZubpD
        TgGFJ/TDdRB9080jST7ChAD0jxGfX/CEBuH3WARQFuezk1/hTXKndTdR8+ARY5RH
        L3nT/vK73eCsJvKlXRjF1v69S60GSrzprqNudAITGgwpCbFZiLRAbmimDeZfHErT
        KKSgyeQ6fi4aDyQqmaFayN1btH2vJErlAXcgbcC5mtRraezMY6w8Z0CSBnAKKmcj
        9jCDZ/UooY4JKvvFltbgVYa+JieVpxHqAxW6kq1RCTaU32BGVnKofaoyq6O4YrSQ
        ==
X-ME-Sender: <xms:zPScXJF4Rx8ve2E0mjv2g-qNe1IcmYKGEaHoDJCjDSwkDBZMMh0cOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkeeggdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:zPScXOBw9KE9NZIUOhc0pRq5TsPVkhYFq_uxi1a0tuIcLvNJCH4EuA>
    <xmx:zPScXF-V1zNqexVptbMcxCjZdsUUpTPLN85Mk_nwfQ638EzZpqHdcA>
    <xmx:zPScXBiv4vYkWNEPFbEuRjAAzdhqVelW1FDg2OS-I7i4Wdag8LhMMQ>
    <xmx:zPScXCW6cr3PEzfGGbhELYAtT-bxsWjO-6gYR9WsUL79uAJR0z7I9A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC0A2100E5;
        Thu, 28 Mar 2019 12:22:35 -0400 (EDT)
Date:   Thu, 28 Mar 2019 17:22:33 +0100
From:   Greg KH <greg@kroah.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-kernel@vger.kernel.org, zbr@ioremap.net, manio@skyboo.net
Subject: Re: [PATCH v3] w1: ds2408: reset on output_write retry with readback
Message-ID: <20190328162233.GB2173@kroah.com>
References: <20190328122244.32126-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328122244.32126-1-jeff.dagenais@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:22:44AM -0400, Jean-Francois Dagenais wrote:
> When we have success in 'Channel Access Write' but reading back latch
> states fails, a write is retried without doing a proper slave reset.
> This leads to protocol errors as the slave treats the next 'Channel
> Access Write' as the continuation of previous command.
> 
> This commit is fixing this by making sure if the retry loop re-runs, a
> reset is performed, whatever the failure (CONFIRM_BYTE or the read
> back).
> 
> The loop was quite due for a cleanup and this change mandated it. By
> isolating the CONFIG_W1_SLAVE_DS2408_READBACK case into it's own
> function, we vastly reduce the visual and branching(runtime and
> compile-time) noise.
> 
> Reported-by: Mariusz Bialonczyk <manio@skyboo.net>
> Tested-by: Mariusz Bialonczyk <manio@skyboo.net>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2408.c | 76 ++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 37 deletions(-)

What changed from previous versions?  That information always goes below
the --- line.

v4 please.

thanks,

greg k-h
