Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9553120830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDIJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:54:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:54:17 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3B8092820D9;
        Tue,  9 Apr 2019 10:54:15 +0100 (BST)
Date:   Tue, 9 Apr 2019 11:54:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: constify elements of
 NAND_OP_PARSER(_PATTERN)
Message-ID: <20190409115412.48c758d3@collabora.com>
In-Reply-To: <20190409045332.5452-1-yamada.masahiro@socionext.com>
References: <20190409045332.5452-1-yamada.masahiro@socionext.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 13:53:32 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Currently, drivers are able to constify a nand_op_parser array,
> but not nand_op_parser_pattern and nand_op_parser_pattern_elem
> since they are instantiated by using the NAND_OP_PARSER(_PATTERN).
> 
> Add 'const' to them in order to move more driver data from .data to
> .rodata section.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> 
>  include/linux/mtd/rawnand.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index b7445a44a814..ebde52088e4d 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -805,7 +805,7 @@ struct nand_op_parser_pattern {
>  #define NAND_OP_PARSER_PATTERN(_exec, ...)							\
>  	{											\
>  		.exec = _exec,									\
> -		.elems = (struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ },		\
> +		.elems = (const struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ },		\
>  		.nelems = sizeof((struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ }) /	\
>  			  sizeof(struct nand_op_parser_pattern_elem),				\
>  	}
> @@ -831,7 +831,7 @@ struct nand_op_parser {
>  
>  #define NAND_OP_PARSER(...)									\
>  	{											\
> -		.patterns = (struct nand_op_parser_pattern[]) { __VA_ARGS__ },			\
> +		.patterns = (const struct nand_op_parser_pattern[]) { __VA_ARGS__ },		\
>  		.npatterns = sizeof((struct nand_op_parser_pattern[]) { __VA_ARGS__ }) /	\
>  			     sizeof(struct nand_op_parser_pattern),				\
>  	}

