Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB1BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E3D20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="q1dSQv8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbddL7t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfCXXTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:19:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57165 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729069AbfCXXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:19:13 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Mar 2019 19:19:12 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BA353213CA;
        Sun, 24 Mar 2019 19:12:32 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 24 Mar 2019 19:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=+AtqmXDbkawaUXtI5XQZuTYqeFZTunP
        gF8mmNQUJkH8=; b=q1dSQv8qWhtPNFLm1fLDd1TWk345t7MlmBwINPQAt/rIWdq
        F+Utjt+euP0VxVqAOZ4JLwq1EfMmuuJ90eqG26Ml/qqYz1zJ69yRU1oB7NXC4u9b
        gHCIYYSMCz0Xb7E3m2T+MD9cxXeIvO/LR1HTLroOre6s7EV0qFpogNdkQQJvbWyI
        fep0+G4bzWig4UGSDq4vJqIDdJjWE/rXuc+FwqTlWqCVLflmzSG71bEPtw/HF+mT
        lSY0V6zkhH3HbJq7ELa9bUeq6+z9lpiBQJH3rWo6jT6qFPGU6G3YtlOapL5qwqWP
        7islv7a7Dm4w2gyVFTidqJnQCNjKy/XnoMwp08w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+AtqmX
        DbkawaUXtI5XQZuTYqeFZTunPgF8mmNQUJkH8=; b=RbddL7t6omTBaG4Hnrp3Zh
        l8K07N4RFgH+AHU3v7uqx/5Gi/aOkOgAC3Q26EVW4oKwchVPglrJpdwlh534evg8
        EX/vmKEC1TtqApEoJZ89XZR50lN8Oa9cJcSaQev9ogQXDCS8SFvzP/0i3HZz+JHf
        tUiSZ8Thn8Je7JoOrjV4f0Q13VMOxpy7iGXDreU9Wm2dkP4hhkF15006NIGwxa3I
        aLP7E8KKpmUWBx9ZPppGxo+y9r4buGUjGytCJVDrjvHcISFpYVFKTke1Nv+KsfeF
        IYVDhF0PkDnXIKbqxZ7Lj17ZJUvIRyoubBM5ZAIlnnq5FFpda0Y2NdprEoRdbVTQ
        ==
X-ME-Sender: <xms:3w6YXGCJqDd-fk-Zf201hqntID4LV5pQ3xjo1y0x4GCRmySJ43A1UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjeeigddujeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:3w6YXHUjz6ZwAwV-QBUW9sgyoWYjNAjBXIgl3gWjY8RIx-pPn-s0hg>
    <xmx:3w6YXCjNdiOVCyxtq2HLIQAOFaIygGrgiiI5YqPEN4as4CuEODSjNw>
    <xmx:3w6YXHkVyb7xS-e9TUWeDgU3bBD8ZsCLeMUUsrVwDOVDxqKxELlxRA>
    <xmx:4A6YXDjOrCKwoqGS5YqL5yNWcQMRfStA5chBauHd7NWaIhisyg1srg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 473F97C63D; Sun, 24 Mar 2019 19:12:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-976-g376b1f3-fmstable-20190314v3
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <f4d27985-376a-42bb-b781-bdc96c0cef21@www.fastmail.com>
In-Reply-To: <20190324231002.2106-1-kjlu@umn.edu>
References: <20190324231002.2106-1-kjlu@umn.edu>
Date:   Sun, 24 Mar 2019 19:12:06 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Kangjie Lu" <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        "Joel Stanley" <joel@jms.id.au>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: fix a potential NULL pointer dereference
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Mar 2019, at 09:40, Kangjie Lu wrote:
> In case devm_kzalloc, the patch returns ENOMEM to avoid potential
> NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/gpio/gpio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 854bce4fb9e7..217507002dbc 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct 
> platform_device *pdev)
>  
>  	gpio->offset_timer =
>  		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> +	if (!gpio->offset_timer)
> +		return -ENOMEM;
>  
>  	return aspeed_gpio_setup_irqs(gpio, pdev);
>  }
> -- 
> 2.17.1
> 
>
