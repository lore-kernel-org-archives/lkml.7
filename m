Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388D421929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255371;
	bh=ktE7TBIGIjZIiKUkkj1xT4cKT1mN4Hi12oqEATiFHns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kwd7VJyMrPCPo6Oe4U1Hndm3AFHQeDb/Y0PEAO2IAyhP6iOHIWNRN96RSBXSyw0KG
	 Gz0oDrv95dM/VAzuPdiLfY6jbvFu3DCaUgOgSxm7YhTyk6EF8y+X6IrQ0ZqMakV0T6
	 CqAseTHACtv5w7r9EfGxkd6+WdMyA+BcS03fMe6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfCVLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbfCVLtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:24 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053BA21929;
        Fri, 22 Mar 2019 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255364;
        bh=ktE7TBIGIjZIiKUkkj1xT4cKT1mN4Hi12oqEATiFHns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hofcZabyqlTp8tGlkKZH6e4PBMj0Rr/zurFzszqiuvRhhw1xBRcI2vagpN3hmuP+Q
         7C1mj/Th6hAq4eKDPV49SWKSZjJZbNXaFOPtmnO6rP5MqOWaMJYbKqNZD9CgUHM0h1
         IwIqUebwpulcdnDXB+MPUcZhvV1Azts2OZFv/bMY=
Date:   Fri, 22 Mar 2019 19:49:19 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: remove redundant generic-y
Message-ID: <20190322114919.GA17767@guoren-Inspiron-7460>
References: <1553253554-5307-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553253554-5307-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Masahiro,

Approved and I'll add it into my tree.

Best Regards
 Guo Ren

On Fri, Mar 22, 2019 at 08:19:14PM +0900, Masahiro Yamada wrote:
> Since commit 7cbbbb8bc297 ("kbuild: warn redundant generic-y"),
> redundant generic-y is reported. I missed to delete this one.
> 
> scripts/Makefile.asm-generic:25: redundant generic-y found in arch/csky/include/asm/Kbuild: ftrace.h
> 
> In this case, csky-specific implementation exists in
> arch/csky/include/asm/ftrace.h
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/csky/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 2a0abe8..e01a576 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -12,7 +12,6 @@ generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
>  generic-y += fb.h
> -generic-y += ftrace.h
>  generic-y += futex.h
>  generic-y += gpio.h
>  generic-y += hardirq.h
> -- 
> 2.7.4
> 
