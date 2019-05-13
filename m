Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A49C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16C8208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Rq4UUNO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebnL0SxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEMUsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:48:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39977 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfEMUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:48:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BAEC26256;
        Mon, 13 May 2019 16:48:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2019 16:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=KNgp5jlCdpQelzZZ83zf0wjeuD+
        zXHXWamPU2Yqam7w=; b=Rq4UUNO0tjyq4Nenc1iYwQ2c2jtno3yem8hiAa/wWcm
        WayWCqQcSI2E4A7hPegebCFu3ZqcVhSmr1Tg4kINOe9a6L+2BdZgJmHBQ460Toh+
        N70akY1B3KtrOa3lcsLEpesI6CR/n/DAB9O2gcK4dAmUiP712FLS+A14diRyokcu
        ufAkXXONB755dt4CGLa87XELYM5g4UdCM6HaoDP3mrM8fEnBr5clp6DOFDDGQo+b
        xK1pQVdM/RMrt1f1plBS560nFKZD3/cFMsCDbWJ4RA4XcNBiMZVqDyyWucb3/qCn
        DvnVJF0LSxXyJ4wr+NlpBaTFGTahhY7ZXQ0aRmuHsOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KNgp5j
        lCdpQelzZZ83zf0wjeuD+zXHXWamPU2Yqam7w=; b=ebnL0SxVmSbGlN3XSP/uke
        rcnBiwQlvlcjQJmeO/PwbWzj46+cRPr3XT6iYLdd+qTUEMTPavN+zJWxQpKTzp/V
        KGMmCW4iegH78q2ygBSIShbfPqGsW3iyxQWxi6k3WNuCaOggvBg86pQxHzj6jKrf
        1f9coSAOjaB4TQIkqgcapCURs2N7obDNJSratqOQbhzoWrl4Jv4iZ+9QYVx7URi4
        hJ1n6n6buOY+K4ixhgjKxYBNBBB2ttg5iG5EXzKhP1h01dv4mW6qL+MmhnhnyeXk
        WkTwFvT47HJE1qPXEnh0aaOenw62Vz/qQQpiett/tAqnCR5VlvfDJSra3WWXhKiw
        ==
X-ME-Sender: <xms:NtjZXPvpOaZ5qNxPeOf7TiuoA7iQppF5maaRu4bQc4mrcfn7MnQFRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:NtjZXCEpDUJAe7A1QZwyGYmEw1rKhSWjBUaK5SzYmAxvC4fdJKDaVQ>
    <xmx:NtjZXG0OvOFAPuGkeGjD06BTlCnpVZQbUPsPWo_QUus1EWycsXBvdg>
    <xmx:NtjZXEq5lar8DRQKcVlDRqw4i7eHhHPq3IrCDSuKQ_vsxS6uUHbXWw>
    <xmx:NtjZXH8-kWT1QI_tWoWuvd68jOGzsOjz5mlgyPSB5UDBjJydTRg5RA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C752D10378;
        Mon, 13 May 2019 16:48:53 -0400 (EDT)
Date:   Mon, 13 May 2019 22:48:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     andreyknvl@google.com, gustavo@embeddedor.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, suwan.kim027@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: Fix slab-out-of-bounds write in
 usb_get_bos_descriptor
Message-ID: <20190513204851.GA20475@kroah.com>
References: <00000000000061c7cd0588c6933c@google.com>
 <Pine.LNX.4.44L0.1905131313100.1478-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1905131313100.1478-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 01:14:29PM -0400, Alan Stern wrote:
> The syzkaller USB fuzzer found a slab-out-of-bounds write bug in the
> USB core, caused by a failure to check the actual size of a BOS
> descriptor.  This patch adds a check to make sure the descriptor is at
> least as large as it is supposed to be, so that the code doesn't
> inadvertently access memory beyond the end of the allocated region
> when assigning to dev->bos->desc->bNumDeviceCaps later on.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-and-tested-by: syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com
> CC: <stable@vger.kernel.org>
> 
> ---
> 
> 
> [as1898]
> 
> 
>  drivers/usb/core/config.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: usb-devel/drivers/usb/core/config.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/config.c
> +++ usb-devel/drivers/usb/core/config.c
> @@ -932,8 +932,8 @@ int usb_get_bos_descriptor(struct usb_de
>  
>  	/* Get BOS descriptor */
>  	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
> -	if (ret < USB_DT_BOS_SIZE) {
> -		dev_err(ddev, "unable to get BOS descriptor\n");
> +	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
> +		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");

Nice fix, I thought we had found all of these the last time we fuzzed
this area :)

I'll queue this up once 5.2-rc1 is out, thanks.

greg k-h
