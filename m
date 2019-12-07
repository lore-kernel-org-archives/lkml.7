Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF8C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1332082E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="g7rkzGd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWBOFl9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLGLWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 06:22:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51015 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfLGLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:22:18 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A7ED22774;
        Sat,  7 Dec 2019 06:22:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 07 Dec 2019 06:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6albwC4s9Bq4fRNcrY4NJXtd+Ak
        t1Cjqb8IYCWggpPI=; b=g7rkzGd+uvijOH10GeQDc6EvJrOQZL8GiCSRf9BuuhG
        tpNlofNtQM1c5toBrfrD5VL4XY5PBNFqUsmRMTBW3sBEu0+VopzkiGjtQKXuFYSc
        TeHOTYBkqam/G8BlqgLC6Fq3lN02OaTkYzUnlK954o9GF/GyBjCNHKPmPNfguaFi
        kvTaQbu80wuKBXVp5BW+jwoMY85mOCN7qgtZhK4OYUYEcBXAVKEARh9e9ikYerE7
        FoDC3yxuGB23PZljYTcheOUQpoFRG9ZtXTwMfFXfueQYPM2ERhvaczVfalv+Cn86
        HPiOEeCpcYhraI3D1F/EG7sOSog0HNOY7I0Ito0ZPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6albwC
        4s9Bq4fRNcrY4NJXtd+Akt1Cjqb8IYCWggpPI=; b=MWBOFl9nqgEWAAvr9FUR9i
        GdlewfG+wwSnqY7gRrs3jwy9b1XnXMnoGOaRfjSosLixCk0654nf2DuoIpguqEuE
        3Bn/pBCPuV2WV7uP1CMTPfspAsaeEbgvFTw9YzrYweg5ChBOBVysy+f6iJV7g6Uo
        U2tmWmcvIRa+HOUdCd2murJE9hu/xhC0NslcCZdbZ0ZPUqlEvNoskKBBB0opE33W
        HYxkP3UDzN8oo1eBhYkLhvAM/gOr4H9pZhur1iQZIVRfmYO39jFFumAPe+ZgXisO
        WAeqcnOlR+k9M3NxvotGgRuZxGGYYOwloHvTRLP6GuFb98jCosMLKHV4ZNqPxjVw
        ==
X-ME-Sender: <xms:aIvrXRLQqM5gZMTWiLMhKRFxNBR2HYRrs9JAQiTlkKBeTviuvlhd-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:aIvrXZCWTQyrDpodGo70_06vbD2z-FdWJaD6UWvkras_76Mzs8iQrw>
    <xmx:aIvrXWuW2W42kIjeQWvd5P7TUdZBe26wKWjK2hhA49jmoXgM6sX2Cw>
    <xmx:aIvrXXSYnuHi3kdzdE7WdSWEjt33W0sPl3Et0h051VBWeicIz715MA>
    <xmx:aYvrXUa5Kt95GQVcDJBgdKPMMZQJMD04uk14Q8fXyA3f7U19Zr4wJA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9EA930603A8;
        Sat,  7 Dec 2019 06:22:16 -0500 (EST)
Date:   Sat, 7 Dec 2019 12:22:14 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     swise@opengridcomputing.com, stable-commits@vger.kernel.org
Subject: Re: Patch "iw_cxgb4: only reconnect with MPAv1 if the peer aborts"
 has been added to the 4.4-stable tree
Message-ID: <20191207112214.GA280629@kroah.com>
References: <20191206212436.2628724670@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206212436.2628724670@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:24:35PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     iw_cxgb4: only reconnect with MPAv1 if the peer aborts
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      iw_cxgb4-only-reconnect-with-mpav1-if-the-peer-abort.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0259a468e2383fc41f8bf84b9a7548727874c03c
> Author: Steve Wise <swise@opengridcomputing.com>
> Date:   Sat Nov 10 05:27:39 2018 -0800
> 
>     iw_cxgb4: only reconnect with MPAv1 if the peer aborts
>     
>     [ Upstream commit 9828ca654b52848e7eb7dcc9b0994ff130dd4546 ]
>     
>     Only retry connection setup with MPAv1 if the peer actually aborted the
>     connection upon receiving the MPAv2 start message.  This avoids retrying
>     with MPAv1 in the case where the connection was aborted due to retransmit
>     timeouts.
>     
>     Fixes: d2fe99e86bb2 ("RDMA/cxgb4: Add support for MPAv2 Enhanced RDMA Negotiation")
>     Signed-off-by: Steve Wise <swise@opengridcomputing.com>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 54fd4d81a3f1f..0d13d369fea91 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2691,7 +2691,8 @@ static int peer_abort(struct c4iw_dev *dev, struct sk_buff *skb)
>  		break;
>  	case MPA_REQ_SENT:
>  		(void)stop_ep_timer(ep);
> -		if (mpa_rev == 1 || (mpa_rev == 2 && ep->tried_with_mpa_v1))
> +		if (status != CPL_ERR_CONN_RESET || mpa_rev == 1 ||
> +		    (mpa_rev == 2 && ep->tried_with_mpa_v1))
>  			connect_reply_upcall(ep, -ECONNRESET);
>  		else {
>  			/*

This breaks the build here and in 4.9.y and 4.14.y so I'm dropping it
from all of these queues :(

greg k-h
