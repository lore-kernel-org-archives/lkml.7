Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="uKsLrxQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDqDAx/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCFT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:26:14 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39689 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbfCFT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:26:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 33CCD329B;
        Wed,  6 Mar 2019 14:26:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2019 14:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8tyseS6BlKC6YSs8mKSBa5rHiEP
        m1VrnrLM3mvhUqBc=; b=uKsLrxQDORWsgJ3ViTctGRokQKKU/v5XBJX74qrMuCd
        x5/SdgXp8OP2PT/EgcKSoQ56euxBT+qvcj8/nM8p0aTriO90IEca8M5Ac20uXnmq
        JxXLG+fv8aRSRFgDpTev+53QoqFVUMMRUg9Y0QGER4cdCrnvCmEsiyjR3HnXisuD
        ASmupNEormoaLLClBIcrdt2TA7RG85RQGXBbwg0BSDXKIM09lyZHspe65AgUhCzh
        Wdertr4ewkijfbj2xFP/bq+VIvB/O10Xn3hnqq1Re+ngCpkqaaRVP+/C6lRVtEaB
        JCti4r7yOS2hOW2Y8SZXXHrDTq50XSqJy4LwAA5i+UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8tyseS
        6BlKC6YSs8mKSBa5rHiEPm1VrnrLM3mvhUqBc=; b=lDqDAx/IatIjPIScE70p8S
        bscvraPN1xPC/RaG9LeSbd1LRUKH24uoyvvfA1yAg1TBhgnJxZn4u3Dzj6SWKmVm
        AvcjVxfYuSC8Qr3lkwiaZ+BNExTa3zDRjO7OI2/oLObjGy/UwxiPohQZHe55/KV6
        MLv5pE1vfZxNA//7iHNS8a/14QTrNZ1vKIBOV7cXf2nG2XiSecUDhD0DJrPHcul8
        sCSsoqXdwtWdKJVQeoxeYX3UL/KomLYlT1FBDd+drpyowx3ejoy4uFCMJ6gWX6Kn
        1FrIqTgvtA5HRI46JksGm31tBCkPdT4vqp8WuMavM5NiWG2rNb29btcVR5tkToSw
        ==
X-ME-Sender: <xms:0h6AXB7iIPmR8pbuSKUS0TTYqk-pdj6wmLqV4EKTm_NuQr959dzxbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtre
    dttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:0h6AXLMnetck7praTdpKZoCIKjCI17euAl7DNRotKvPuE5NsTi-VDg>
    <xmx:0h6AXLPCsGBRIpNksdD44-FeINbL8po6kHjifxwxVFJ0txfNgO8XUw>
    <xmx:0h6AXL9Xx4nNqYfpueSriTZEwhB8wTStrtTM3H-C9p5Ei43mn7tkuQ>
    <xmx:0h6AXM587hafnwA7pGfn_UDEK0ovD2eDB12uXSzjmhZe7Axcjw1Ccg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3410FE4752;
        Wed,  6 Mar 2019 14:26:10 -0500 (EST)
Date:   Wed, 6 Mar 2019 20:26:08 +0100
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] drivers: uwb: Kconfig: pedantic cleanups
Message-ID: <20190306192608.GB29080@kroah.com>
References: <1551898306-18997-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551898306-18997-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 07:51:46PM +0100, Enrico Weigelt, metux IT consult wrote:
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/uwb/Kconfig | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

I do not take patches without any changelog comments.

thanks,

greg k-h
