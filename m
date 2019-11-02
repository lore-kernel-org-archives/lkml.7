Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E05CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E438120679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rA/Y8Egr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWquDFZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfKBKj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:39:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51919 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfKBKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:39:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 35B5A21910;
        Sat,  2 Nov 2019 06:39:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 02 Nov 2019 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2Yh2DDRNrKspKq1cM/EQkeKYgy9
        gXyiI2m+Xo++q9KY=; b=rA/Y8EgrtEOTSmhhpiM52u7GSYHst8IXX6Upli2jWcu
        Pz1K3t24B10cA435toAAnOvTivN5rI9n7PLDRPjpfT4jvOIebHdt+TFRX/3XGSLB
        xl4Pz7msWkbLEVIOdOo37gxpFZ5B5isNI5I9/eAk7UoziJpUqGJofKpnJID0IGUY
        olVKoUOPyj0c5TOQFOBTkEhO8huGgl9VmePl++LfYBqSevCiFseh3bkiYnH2TW2C
        ePRvK04mW+G77rpOtFbbSlkWzdxMJLHUwM8/QDkp67IrOefKSzOGo5HVJR+JJf3n
        xC3lobBnq5suCfH8otBVpERzkhoE76lXowsQgUB7+5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2Yh2DD
        RNrKspKq1cM/EQkeKYgy9gXyiI2m+Xo++q9KY=; b=BWquDFZeMXY0xHTRBaOh6m
        slozo5PqETx7d8DwymApcKKwbHPx2LbrNWYUTKLTvQ/2n02Ax086fzzu3RITIhqA
        uAj9xDBpzoa2kNVU1gMRlqZ0VHhdR0scx+LhvwgTtuQXdbSb3q2Y8taSGFM3kTIu
        3nsj83oI1I8UlQkAj6QS7imFeZIOfLIQZO7W5ZeA8KJehMoTLRR5PQ1xVmrxNrwm
        g+9qEs4H5fRLw8rtR/kzQvIPYUL80b2J2+P5/2zUMi0WY96Z3rV/HdvM+2UWxK+K
        qceEQJypxhUIO6s4i+NjPvFq6eePEPGrs7t39W6K6UBYTbcecDk9VL9u4WIITpHg
        ==
X-ME-Sender: <xms:3ly9XTET8HPq_J0xq0hftMzvC2pBcySZzPu0K8H3tAAk1GaNc8bqcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:31y9XUfUl_eFMvt0IcBmZJ5sa0xY1IcUyZjv-RVfF_ilDU3g8iux7A>
    <xmx:31y9XSLrFWGxtP34aokt5ZqZzYLXhby1Ckbpk4avZczzs2bb_y9Yhg>
    <xmx:31y9XbpFzwkvQ6hb-Nuv5dJkMYqI_EL6z__MpzI_I738qz1lYCq1kQ>
    <xmx:31y9XfmlinZdVFREhvzc3sXHqIp2gIyZ1fxITsONiBG9Ke2VYi2HgQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC73A306005F;
        Sat,  2 Nov 2019 06:39:26 -0400 (EDT)
Date:   Sat, 2 Nov 2019 11:39:25 +0100
From:   Greg KH <greg@kroah.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, jerome.pouiller@silabs.com,
        gregkh@linuxfoundation.com, Boqun.Feng@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: fix warning of using plain integer
Message-ID: <20191102103925.GA170933@kroah.com>
References: <20191102001457.23369-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102001457.23369-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:14:57AM +0000, Jules Irenge wrote:
> Fix warning of using plain integer as NULL pointer.
> Issue reported by sparse tool.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/wfx/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
> index ef3ee55cf621..5d29bce65f71 100644
> --- a/drivers/staging/wfx/queue.c
> +++ b/drivers/staging/wfx/queue.c
> @@ -565,7 +565,7 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev)
>  		}
>  
>  		if (ret)
> -			return 0;
> +			return NULL;
>  
>  		queue_num = queue - wdev->tx_queue;
>  
> -- 
> 2.21.0
> 

Please send this as part of a patch series, with your other changes to
this driver.

thanks,

greg k-h
