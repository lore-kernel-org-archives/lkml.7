Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16275C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E461C208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MZT72ONa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlyXDNvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFUN3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:29:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54261 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfFUN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:29:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C66D922274;
        Fri, 21 Jun 2019 09:29:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 21 Jun 2019 09:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=X4jgCsPTpY0MEyCO3acdNzjmRnr
        VZZybxhhzrkSRkpg=; b=MZT72ONacup78AyY+/OaPqJTP8rVj6568fzz264cyE+
        zL7w8UjHip/us4TT8XrOQKcHVKh/G62D+xAdVwrQKu15BUAeIg48c2KujO0eGkLi
        Ln/fqc9hebl69ljogWKZCIfhNZSoBuRbR1Fp/vayWkCjgfqtsxFqLy+vlxC6devk
        GJ9h9DoAxP9yGR9TQz9Ku1b0dDsU7aRQu2nvBzE1OTp3Tg9DSLu0N24KkmI4XYc7
        7Q6lF5SPppHFbc8CivoQb2sM0K/FTl1Rr5yZFhXoBQugZri4HVV+nSANM7ORvaFx
        vvsU3S+9d/niB+jqDWKbdHupA8U/MnCRKj4Gn9O5I9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X4jgCs
        PTpY0MEyCO3acdNzjmRnrVZZybxhhzrkSRkpg=; b=VlyXDNvPlC0caYrX34HuKQ
        6ueNkeMsGPuxUHtFlE9XeABex7787SRxDGPeKsay7zvRV6OdVTHndHV3qHmIRf0h
        FnJ8ilZXDALymYa9ItSIQolP6YYpiO1XVI8ySUD/gue+3yjvy9RHAYCut80wOfkZ
        0mF6f7U1LkmqP9bwE6nxuR4VrgUkLowjcD9qNxs/W3aExyzJ9NTaEiouXPsB0Tl2
        LrpFLd+H2uSrstGcyTokddaU61FblEHWGNxsGy+gJinek8S9oRouxZdMZ7hkG+m8
        OaAsvbs7CotNKvv59sxHzn/EZOn+nvZpBfja07m37vEE6LDMuzOFCgUzp2kTmEPQ
        ==
X-ME-Sender: <xms:sdsMXQdS8sp-Fop-zkwMXZynm5yMa7xerpDlqAUG-_zvntB4SF-Z4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:sdsMXdVczzU5XQo_4uMPNGo54aOeYYG6kjN3SNMd95yuq8syqySCVQ>
    <xmx:sdsMXW7_l6vHrUwGEx91PhsCZLlxHgbTiaGDpHlj-rRM-JB9VXrGbQ>
    <xmx:sdsMXVxV4nx-WM6v_K8uaxnccIu7fukqOKznHi5tSrnTPrUnPLNqyg>
    <xmx:sdsMXRICYGDyj15hbhbtIbxg4Or3tBvPuRhFllb71Jrfy8_C7XylRg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F3263380074;
        Fri, 21 Jun 2019 09:29:20 -0400 (EDT)
Date:   Fri, 21 Jun 2019 15:29:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: unexpected file in the usb tree
Message-ID: <20190621132910.GA11875@kroah.com>
References: <20190621212423.2b264411@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621212423.2b264411@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:24:23PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Commit
> 
>   ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-api")
> 
> added this unexpected file:
> 
>   Documentation/index.rst.rej

Ugh, that's what I get for having to manually apply a patch :(

I'll go remove it now, thanks for noticing.

greg k-h
