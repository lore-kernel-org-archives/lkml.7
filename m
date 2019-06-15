Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A563C31E52
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3821473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lKjs1Gtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="daieaTmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFOQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 12:03:41 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59985 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbfFOQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 12:03:41 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 888B2441;
        Sat, 15 Jun 2019 12:03:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 15 Jun 2019 12:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8olIom63vxAS+jwTAm4tSm0wYTP
        FOzn8bOVI2/mtyjk=; b=lKjs1Gtx6X5tbZwvbYJsMOIgri85HKyLRPUVh6FpIP3
        iuUXjbXbYeO7/oBpA4A96iGCnAPfihOs63+p3VU5pg7raURQrbT642UTDEdE+RZ0
        vPFEsIYjwag1t5YKYWce9DxbnYdVZH8YVnhjzxNEKdbe7to6EqlWRNtKK/Txnp4G
        tShgXKKEzGQLfqn7PIUtIHdUMe1AhkANX21ra7xNJvbvmyiWkiviyXU45M/R6Sd7
        cVLbpxz2kRwR9hrb67XrEHdheAb8pD+66RjM5xOmZiXfFSNH5XW7JOhFvI0OB/Pr
        ViLUXosg99vR9SyS0c+6LhHvxyFHcUAadOTEyilQVhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8olIom
        63vxAS+jwTAm4tSm0wYTPFOzn8bOVI2/mtyjk=; b=daieaTmvJoxaqKOyPcTdUE
        C4qUtkBKlpG/VMm6YBTJmCEdK24MIpf219hWNh3yv6xzfgtDkgEvk+4Vw6aEW/4b
        eyPzACcXMZi8rfkVC4jhr051H6oOD4gP4hPS2I5XbM7fcCSrL+W9c3ZxWMPZE1NE
        PIfdlaG4SG4v62UlTCG20oyljm8I5aOET+bafiTAcjJHnf5rTSzUDB+796jeW3gf
        PmDhUFEu3WsUl5PFxhsgu+PlCnsR0i25cvpMI0mXAHdoV7z41bkEWo5ZmKIVISdg
        3AVepbp66Z9WtVkJVpaO7Mmo/MtRNzwylTfDn7qKnO3Pi3DyUP4muFjtqCKEnw/w
        ==
X-ME-Sender: <xms:2hYFXUTlS9bc8WOSM7fcr1depuWofqqRCrTHBy66hj0m6hXYGLkggw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeifedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:2hYFXZAi1YKe3r0VPnBmqk0-KnA88lED2E3AiB3G9fzrXMC7LJRulA>
    <xmx:2hYFXRXc7Brpz2V-K2eSy4zFppLGQdgmwTdZUL5qoObpmW4-fo3SBw>
    <xmx:2hYFXRIbUmof4Xp-d3aDdxZALQSEzqIX03wCgy1dYBLnpVxBlZHWcQ>
    <xmx:2xYFXT6yBG5CcQOOxjDqGacjA_CC0lIxkhy1JS51yLodSn1xran9Jg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 087E380063;
        Sat, 15 Jun 2019 12:03:37 -0400 (EDT)
Date:   Sat, 15 Jun 2019 18:03:36 +0200
From:   Greg KH <greg@kroah.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] media: v4l2-ioctl: clear fields in s_parm
Message-ID: <20190615160336.GA15018@kroah.com>
References: <20190529113247.21188-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529113247.21188-1-naresh.kamboju@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:32:47PM +0100, Naresh Kamboju wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
> 
> commit 8a7c5594c02022ca5fa7fb603e11b3e1feb76ed5 upstream.
> 
> Zero the reserved capture/output array.
> 
> Zero the extendedmode (it is never used in drivers).
> 
> Clear all flags in capture/outputmode except for V4L2_MODE_HIGHQUALITY,
> as that is the only valid flag.
> 
> Cc: <stable@vger.kernel.org> # v4.9 v4.14
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
