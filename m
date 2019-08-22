Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E2DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CBF23401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392524AbfHVUES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfHVUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC9181F11;
        Thu, 22 Aug 2019 20:04:17 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B3860CDA;
        Thu, 22 Aug 2019 20:04:16 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:04:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 08/18] objtool: Refactor switch-tables code to support
 other architectures
Message-ID: <20190822200415.t3hkjxf4m3lg5tgz@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-9-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-9-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 22 Aug 2019 20:04:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:53PM +0100, Raphael Gault wrote:
> The way to identify switch-tables and retrieves all the data necessary
> to handle the different execution branches is not the same on all
> architecture. In order to be able to add other architecture support,
> this patch defines arch-dependent functions to process jump-tables.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/objtool/arch/arm64/arch_special.c | 15 ++++
>  tools/objtool/arch/arm64/decode.c       |  4 +-
>  tools/objtool/arch/x86/arch_special.c   | 79 ++++++++++++++++++++
>  tools/objtool/check.c                   | 95 +------------------------
>  tools/objtool/check.h                   |  7 ++
>  tools/objtool/special.h                 | 10 ++-
>  6 files changed, 114 insertions(+), 96 deletions(-)
> 
> diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
> index a21d28876317..17a8a06aac2a 100644
> --- a/tools/objtool/arch/arm64/arch_special.c
> +++ b/tools/objtool/arch/arm64/arch_special.c
> @@ -20,3 +20,18 @@ void arch_force_alt_path(unsigned short feature,
>  			 struct special_alt *alt)
>  {
>  }
> +
> +int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
> +			struct rela *table, struct rela *next_table)
> +{
> +	return 0;
> +}
> +
> +struct rela *arch_find_switch_table(struct objtool_file *file,
> +				  struct rela *text_rela,
> +				  struct section *rodata_sec,
> +				  unsigned long table_offset)
> +{
> +	file->ignore_unreachables = true;
> +	return NULL;
> +}

If this refactoring is done before adding arm64 support then you won't
need intermediate hacks like this.

-- 
Josh
