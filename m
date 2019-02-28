Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A2521850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FWnl7R/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4dZ1l8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfB1HEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:04:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58077 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731129AbfB1HEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:04:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CA7662439C;
        Thu, 28 Feb 2019 02:04:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Feb 2019 02:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=9MUpjmqZtkuL7cteK6jueqB2Ekh
        dqXxd+fiy4MXUKlc=; b=FWnl7R/9pg4L4MGPD5yXHj+bDmLH10S8ITPaguQXQuH
        hNlZlgfqvVq3LvEYGtotJVwhLxQOeU0MJy7SJRSMhARvgE+ECfgCYZ01o28VW47G
        5frjUrnvyGY05NNJBxEZtwi93bSck5v40ikdKwHfa5fGf5vf/f9nbwQUoa4l6s8+
        uduO2pjkokw5UakNxACBYRVlEWbgnDwQorNM8BQB5/GEg4oCten3/3a7RrUMoZ8n
        ceYdVTgnColBjxTte66HN2a4LfY+4c28InDAvnt8/ClxIw4sDVpslMz5hcKeYTIp
        kcjaYsettvIQliWZBHPVVEUmTwV6TA4flho+boZjA0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9MUpjm
        qZtkuL7cteK6jueqB2EkhdqXxd+fiy4MXUKlc=; b=o4dZ1l8e/jJZ8G0okeqe+E
        m2VlWybkxrr1LPI1GmWjtzuK2BmRpHdB2tIoUvc+hx7XNBzUSSReld7XpGAHk5f1
        RhZdW9UNdegU1sbQa1ZcoedOXb4FhjjPTjTV3NRlN9HEmI/AXELDST0sRMqDKYjJ
        uadepYa/JloP71vFNsQG9pNT92G2QRcfV3IhUH57FPf76nc3q9NdAsKFPizXMfyQ
        ymhH7UgU02UkcrXMBzcl4nkBp9WsORdAUX1Tkp8Cch11unCD+BGO6dK4cl9ILe9V
        FsJ6rCE7RlSGvY3XwM65dkwt760jt1immylXKYpbdHY/ZtrOS47LJpU8zTpjnX8g
        ==
X-ME-Sender: <xms:6od3XB5LRiWVYYztjOGSk6jtIRjecLYGsyOUpkfTDN5_8mAK5bop6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvddvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6od3XPA-Na2esGKRhwb0pkFzsaVbRzq6FvoVKD5iZkjkG8lwOUSPKg>
    <xmx:6od3XMk4CT27CqWMBYX-nAmzGVcQ1XPIRPkDiILjczJty8j6cqYITA>
    <xmx:6od3XCkMczwxcFmuRsKs1DKSCXptP6OFFbQICQJr-u5Pp1aenQGqrQ>
    <xmx:64d3XNucC0dLzfQKQU-DCUbs53B6nUSxsOYEXbo139_8m6wf0fcHpQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 580871030F;
        Thu, 28 Feb 2019 02:04:10 -0500 (EST)
Date:   Thu, 28 Feb 2019 08:04:08 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the net-next
 tree
Message-ID: <20190228070408.GA27446@kroah.com>
References: <20190228155201.329a1fad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228155201.329a1fad@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:52:01PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> 
> between commit:
> 
>   570b68c8ddde ("staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET")
> 
> from the net-next tree and commit:
> 
>   11f27765f611 ("staging: fsl-dpaa2: ethsw: Add missing netdevice check")
> 
> from the staging tree.
> 
> I fixed it up (the former is a superset of the latter) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Looks good to me, thanks!

greg k-h
