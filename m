Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2771C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE67B2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="MCI5iyqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wtQsRlEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEBDiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 23:38:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34129 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbfEBDiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 23:38:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B19E23331;
        Wed,  1 May 2019 23:38:14 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 01 May 2019 23:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=/n72BNTxkHX6NBIhd/p5zL3KWP3/PyG
        ZP2hQM7vw20g=; b=MCI5iyqkxaOgf7gRkwsEyLdoVFv0ejIzogXrM5ekkDV/z8h
        FxMwd5TgN4J37kmrcQ60tZK9eoaGbMgFkCVsmEWjL007YQ+PeWrvZA0nctQI5EyI
        ii+jCwyBSCFCMjAFvUYK4uPGhEpDe6dVcWVDWy0ZW9eYoHh0JSiPJbbO0Bj3/OGh
        +tBxenwgWEpjpFQaLDZjsP6rVRlVzQYbRg5KJW9La+NszgHM2lvJ9OLLglRCHO69
        mhSWBvycruQdEGdsR6ikmoy9uZwj/nPDe4E81Idqm3eZEJJL/+ReTC1QV7sI+6Gt
        kq27oXv17kGtaW5tKfNmERE2Y+FDEOhhQjeSp4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/n72BN
        TxkHX6NBIhd/p5zL3KWP3/PyGZP2hQM7vw20g=; b=wtQsRlEWn9LGA3wllkwogB
        +9IPhc8LV+jYBhTFcDSteo4siYvFgakXicppdkTH7RKXJwuJAq7ZuRatJgoXwk1f
        5A21MywhFDBjRgMpVG+SbT8QoNMYn2KKRaX9yBrrBjAcim3kqznimK8+aOOqd08Z
        IS9TjSjb5VsxPSGGM8Z6cjk55QRoeqsvPa+0cj/4tnFgv9YgV89ioDV6n8kI6IML
        jC8JsKQtUf2btrtgAdzJfqGYShNUakvVTPkRZjonUrU/f1aA90ruNc0vrV0KCeVk
        Z4VbWHCkRZZFBDiwGRliE0P1YbKdQ8hGHaPUIsYQC+wG9eGHF79lmOwasOb9fqBw
        ==
X-ME-Sender: <xms:JGbKXJeVDYPhK2I_6dtDBKZ_-uHfi6kKdOH0dySElkcytqfmmcJPng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieekgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:JWbKXM-jrg1l0Jasczh8con4d15w5bcHnH6pN8BbKKyBXChpRk40UA>
    <xmx:JWbKXAkIXxtOu7ThHOUEue5AM-etYDn2uoI-uCg_ivhBw0gLtHPVeQ>
    <xmx:JWbKXNhoDkiZEUf7UaQ4ZBAd5wjOE0HRHjyESWCdorZjmr5E893Hmw>
    <xmx:JWbKXEugwosNKIJ6WZT66--1DRz-JP8KllqUjyAmXtB9Np4nUB0cCA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CD7177C6D9; Wed,  1 May 2019 23:38:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <ad47a332-125b-49c6-bf06-2b414ad446be@www.fastmail.com>
In-Reply-To: <20190426165655.218228-1-venture@google.com>
References: <20190426165655.218228-1-venture@google.com>
Date:   Wed, 01 May 2019 23:38:12 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Patrick Venture" <venture@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] misc: aspeed-p2a-ctrl: fix mixed declarations
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Apr 2019, at 02:27, Patrick Venture wrote:
> Fix up mixed declarations and code in aspeed_p2a_mmap.
> 
> Tested: Verified the build had the error and that this patch resolved it
> and there were no other warnings or build errors associated with
> compilation of this driver.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Patrick Venture <venture@google.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/misc/aspeed-p2a-ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/aspeed-p2a-ctrl.c 
> b/drivers/misc/aspeed-p2a-ctrl.c
> index 9736821972ef..b60fbeaffcbd 100644
> --- a/drivers/misc/aspeed-p2a-ctrl.c
> +++ b/drivers/misc/aspeed-p2a-ctrl.c
> @@ -100,6 +100,7 @@ static void aspeed_p2a_disable_bridge(struct 
> aspeed_p2a_ctrl *p2a_ctrl)
>  static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct 
> *vma)
>  {
>  	unsigned long vsize;
> +	pgprot_t prot;
>  	struct aspeed_p2a_user *priv = file->private_data;
>  	struct aspeed_p2a_ctrl *ctrl = priv->parent;
>  
> @@ -107,7 +108,7 @@ static int aspeed_p2a_mmap(struct file *file, 
> struct vm_area_struct *vma)
>  		return -EINVAL;
>  
>  	vsize = vma->vm_end - vma->vm_start;
> -	pgprot_t prot = vma->vm_page_prot;
> +	prot = vma->vm_page_prot;
>  
>  	if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
>  		return -EINVAL;
> -- 
> 2.21.0.593.g511ec345e18-goog
> 
>
