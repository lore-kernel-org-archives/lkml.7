Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A796C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0F20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YoBz88fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCIDPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:15:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCIDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bAHUfleo3bR96OQM3eEUv1/TgtnFNmFFsvQHw36WTdI=; b=YoBz88fu8G6HmY9QLHusRoj07
        +GBFtm67qvacZf8AmLNWpo2tNZBlZ5yGBz3xBBMyg64pxVSfM45w/JrY0gGBdYb+RFah9/+QjU85a
        +REpGctF3DX1mCQpzwsGpIWifTF5ATNdj2ynY/0Xf5l0aVbTA93mk7Wkz3RG1ZsCjxcvjROZkmqde
        OqK8kaWlIYSNB4SHMbplPzckpNtSXkw3q0zrOBaDMnbiwohlyZLgXjOoNGfCsKl9nwrlZNVwNjgNP
        1evS7YInf1o88uEjzR5mnG6IbuKSugmET5BUys7GrUBvP03RTLe8/9rvM1oMQMceph/vnJCBeN+S0
        sZKoKM5jQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2SSU-0001lb-9t; Sat, 09 Mar 2019 03:15:34 +0000
Subject: Re: [PATCH 3/4] Add header file,Kconfig and Makefile
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20190308123547.20578-1-saumah@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c23c156e-0493-96e2-f4eb-0171e8c8fc58@infradead.org>
Date:   Fri, 8 Mar 2019 19:15:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308123547.20578-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 4:35 AM, Morris Ku wrote:
> This patch add header file, Kconfig and Makefile. 
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---

> diff --git a/char/snx/Kconfig b/char/snx/Kconfig
> new file mode 100644
> index 00000000..86f38352
> --- /dev/null
> +++ b/char/snx/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Character device configuration
> +#
> +
> +config SNX
> +	tristate "SUNIX Multi-IO Board Drvier"

	                               Driver

> +	Driver for SUNIX Multi-I/O Board device driver Based on
> +	drivers/char/serial.c, parport_pc.c, ppdev.c and lp.c by Linus
> +	Torvalds, Theodore Ts'o.

kconfig does not like those 3 lines above.  That indicates some lack of
testing.

They could be put under "help", but they really should just be deleted or
moved to some source file if you think that they are needed.

> +	help
> +	   Say Y here if you have a SUNIX Multi-IO card.

Indent with tab + 2 spaces, not 3 spaces.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called snx.


-- 
~Randy
