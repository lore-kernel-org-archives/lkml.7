Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F322073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="CSt6XAY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLLAM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:12:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37636 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfLLAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:12:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so692830qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpkQHGI2xpytoMExaxEosFs2mgf6joP/Hf11Z973OOo=;
        b=CSt6XAY8CElDN73sZdchWCJTiVYvx0gczwNtK7YUuSVX/lG5mchWFQNQbomhcw58G2
         d92/8npPNpQ73goL6dPfm215af8SsA90ngfSDwgtOY1LnOaqE44SOOIrUTGK85AoA8E/
         aypxy00MsBhiVXUyn1al9RZIE3GrLCeLZjLI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpkQHGI2xpytoMExaxEosFs2mgf6joP/Hf11Z973OOo=;
        b=Z/oKPeSAKhrtBCBFiwwHhQa4lP4yCe+oIdVh8Izdjn9LXPTZn1oHXuj10a6Jp04ukS
         gq2WTKPuHoq5J9UebUlXta7aFU5OqqYn+Huw/O/lVZvq6v9JzdjE8zIyC3Su1f0dop5Q
         tCjcy4nWIZUetRbkq48zvmH5uts6+1sOmKe6+sXlb8d7wK9GknPMZbvhYHhHEDvHwL8d
         wSq48Aa7PRZHIGMeGGlF8ht2Vz2JQ/73DDwrG02TlH/ruyzkM8ojNtslob6gpql5SQ7y
         1fi2yR+L86ZgEO3ocs2PF3ALoucfYhwbDfg6saJ/5sXvUOLOFHJFgK2Mb4jCZz6Z4HQJ
         iBdw==
X-Gm-Message-State: APjAAAU5uD8rB3k0J0AaFRqo3si8W86PZdhrl8GsPXuPyAKCZIpAMPAH
        2IKn+6Q6uH3IaOCjaObsL7Hah+wztYXOmkHZX+0wsGgt
X-Google-Smtp-Source: APXvYqx9tpMnePqfUyI/wqyrtIckfCZNviBzFD6lqfFJher3fMfJBT1e7NmLJtfELd5HAaHlEF3LR3ykCznnk4gFFTs=
X-Received: by 2002:ac8:3467:: with SMTP id v36mr5149667qtb.255.1576109575020;
 Wed, 11 Dec 2019 16:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com> <20191211192742.95699-8-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-8-brendanhiggins@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 12 Dec 2019 00:12:43 +0000
Message-ID: <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com, Andrew Jeffery <andrew@aj.id.au>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        davidgow@google.com, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 19:28, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
>
> ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
> drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'
>
> Fix the build error by adding the unspecified dependency.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
order to build some ARM drivers under UM. Do you have plans to fix
that too?

Do you want to get this in a fix for 5.5?

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
>  drivers/fsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 92ce6d85802cc..4cc0e630ab79b 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -55,6 +55,7 @@ config FSI_MASTER_AST_CF
>
>  config FSI_MASTER_ASPEED
>         tristate "FSI ASPEED master"
> +       depends on HAS_IOMEM
>         help
>          This option enables a FSI master that is present behind an OPB bridge
>          in the AST2600.
> --
> 2.24.0.525.g8f36a354ae-goog
>
