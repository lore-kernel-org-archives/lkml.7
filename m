Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1637C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92274218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="UoKXTf63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzUkP6Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGDPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:55:50 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47323 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfGDPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:55:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9087918E2;
        Thu,  4 Jul 2019 11:55:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jul 2019 11:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=mesmtp; bh=mPnkcAZw82aZVs9Z9rG4+ggB
        DTzCBZWCGqYWdqaNVKo=; b=UoKXTf63vhblNFTYDD5ovIuLnfoPRIkcdpE3lDTX
        pp6uCs71cXKAbTBfaDi2DPqUrONtik3P0RQGNyx+i6k/alDjwtc3mWkBfObiRhfP
        wywdn4VSdZRg97zey6ECbueW+PTxpFTMVVptQiawFpUqe71zwstTuWP8iRNLhdiA
        Azg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mPnkcA
        Zw82aZVs9Z9rG4+ggBDTzCBZWCGqYWdqaNVKo=; b=dzUkP6Om+KPVTzCTzYlfku
        M7nWyC/cKVzyjsFPHkrAkHb76daPECLWsKjlgBcUiiCrWN4IpzK5VDSLV2E7rXxw
        tCQqoLkTeMxH2fvKcWE0aDtY7OlJ4Dd5CVuY7Om+YbvRd2842eSQdntgNA8XwmBk
        l+WQj4QM2/4YGZqp9jaYbCzGpAKhS2TN6Vo2j83QgdQziuPY+nVfZ2Bn+zje8c/d
        aqZMPfO3hLC6/koOm0mjgJpBAo61rLVoZhQ4mYYxCzq5+u4l2chGe82Vr8/fetoe
        nv3IPtOZvGYP5zbiLC5ZSSTJG8IXJxnPUyVcNzKM0DGawGmrRdWE2er5U+SxuiQg
        ==
X-ME-Sender: <xms:gSEeXeSJZ13ZJDRYm6sQZAmbjTgoTtqJTRKVt5mo6hOYiNK66RhmlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujghofgesthdtredttdervdenucfhrhhomhepofgrrhhk
    ucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmqeenucfkph
    epieekrddvrdekjedrleehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggvrhes
    rghnihhmrghltghrvggvkhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gSEeXYCDTULzTwvjWIlqxBWrN2IdBStYQ-OePsOXybw_vFKaNM4x8Q>
    <xmx:gSEeXW3q0NqpSkm9RprpJqyoSOOrVIsEJeAlPTgtZjvzlUrWaRJUQw>
    <xmx:gSEeXeXHDI-EbjNhcop2oajjHqtaPOKdY4s2m9TcbOPA57ojRzoUJw>
    <xmx:giEeXe7g1ZXBuiE6DWNZzHP8LMlFf7jRSL0UpaHDETllnufFqKrrXQ>
Received: from blue.animalcreek.com (ip68-2-87-95.ph.ph.cox.net [68.2.87.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D81D380088;
        Thu,  4 Jul 2019 11:55:45 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 56FC1A22246; Thu,  4 Jul 2019 08:55:42 -0700 (MST)
Date:   Thu, 4 Jul 2019 08:55:42 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: remove redundant assignment to
 variable is_empty
Message-ID: <20190704155542.GA28490@animalcreek.com>
References: <20190704133031.28809-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704133031.28809-1-colin.king@canonical.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 02:30:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable is_empty is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/greybus/audio_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index c2a4af4c1d06..9b19ea9d3fa1 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
>  void gb_audio_manager_remove_all(void)
>  {
>  	struct gb_audio_manager_module *module, *next;
> -	int is_empty = 1;
> +	int is_empty;
>  
>  	down_write(&modules_rwsem);

Reviewed-by: Mark Greer <mgreer@animalcreek.com>
