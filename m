Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD35A20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="IssgnUNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjtWI6uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDCGBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:01:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34027 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfDCGBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:01:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DD0520D8D;
        Wed,  3 Apr 2019 02:01:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 03 Apr 2019 02:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=3kuereDgX3uXPv3easIr1d1LfpE5kaJ
        mP5rSzNOWpp8=; b=IssgnUNygebNsmz7eoD82zi0nhXDuRTfy346XGDOua9x7XR
        ZCADWU8cQnhvImCzPJXvuaL9omZgG5KidUQ7wqiVyuyieJOXwbAAJMpUDon8os7i
        Vq85Ex28pTqdTh4NFsYq0yP9i3ofBdSzON0ug39l4onVt29EBXUlGamEKhPVNjDO
        RfHOicwDC1iQlkRVEurXNeYyPfudaUpQ8nznHm+NS+mMM2/3WqcMBKdgLPBxRzcu
        upR02T4CpCEVyf673K5JSwW0j6QQnmX8gsIgW+yGCRdNBry5rQuj9RMR1zw9sONr
        8Wja//3v35HwBEGFOOJJks1H+NHMIpOvwZShRrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3kuere
        DgX3uXPv3easIr1d1LfpE5kaJmP5rSzNOWpp8=; b=fjtWI6uUN+/5uCXP1TuX7b
        FKdvjfJWFvF1ZKhGyNn9/GJBoPmWKilOiu06m6/h5ktObY3fMV0NEYPV1FO/HzgN
        JHhcDQHUWbVUH4uD5sFmIsA/YeDn4XkfGRcVWMbbg3l+uvPnVuB9FqRSuZEFYxAF
        host7tFI9+/k5NwoYtsjwE607sOMvC5Kt3S57pW1nTj/eHphL2eeKc7gYvc6tYuL
        81QDKIzbXskfeeZ7Ke0bucJXs/7UKIlw2tgZNrIQFj+Lcjnbw3ufCjBZK1vsY1d5
        QIIpaFgLOvMqKmSW/d6SbApssDSYZu7lig0vbJ8GL1Y85a+Cad+3JSoBValg45+g
        ==
X-ME-Sender: <xms:JEykXAIW4Q6ogfNU9QJ-1g2rEP6dAzzmaU8fVHwUTGLXEoyx3davNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdelleculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreej
    necuhfhrohhmpedftehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrd
    hiugdrrghuqeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JEykXHF6wLmMQ1MrfWNoBABhwjiJKSrXpEvtn9fttoTiHMFEqb7U9w>
    <xmx:JEykXF3E6KRWv3BCTfLGKQ8FUhvU9P1KXR3BgxazJyOsmofzugvYOQ>
    <xmx:JEykXBy4W7h8k8sL05IHHeI0-e2S1O2B85WVAO8Gk9euNz-pQdGx1A>
    <xmx:JkykXE-vTu_TYtC08xQXEMHIIBnmGPAltvkBJD-XJZ4-zh0sOAhB3Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B05C67C1B9; Wed,  3 Apr 2019 02:01:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
In-Reply-To: <1554229504-5661-3-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-3-git-send-email-eajames@linux.ibm.com>
Date:   Wed, 03 Apr 2019 02:01:08 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        linux-clk@vger.kernel.org, "Stephen Boyd" <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        "Rob Herring" <robh+dt@kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_2/5]_media:_platform:_Aspeed:_Make_reserved_memory_?=
 =?UTF-8?Q?optional?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Apr 2019, at 04:55, Eddie James wrote:
> Reserved memory doesn't need to be required; system memory would work
> fine.

I had to do a bit of legwork to understand what you were doing here. My
understanding is that we allocate out of the default CMA region if the
memory-region property isn't specified. Is that what you're expecting?
Could be helpful to be a little less terse in the commit message.

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/media/platform/aspeed-video.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c 
> b/drivers/media/platform/aspeed-video.c
> index 55c55a6..8144fe3 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1608,11 +1608,7 @@ static int aspeed_video_init(struct aspeed_video 
> *video)
>  		return PTR_ERR(video->vclk);
>  	}
>  
> -	rc = of_reserved_mem_device_init(dev);
> -	if (rc) {
> -		dev_err(dev, "Unable to reserve memory\n");
> -		return rc;
> -	}
> +	of_reserved_mem_device_init(dev);

You're ignoring *all* errors here with the expectation that the cause is the
missing memory-region property. However, other errors can propagate
out of of_reserved_mem_device_init() - e.g. ENOMEM. Rather than remove
error checking, I think you should explicitly test for ENODEV, which is what is
returned if the memory-region property is absent.

Cheers,

Andrew

>  
>  	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (rc) {
> -- 
> 1.8.3.1
> 
>
