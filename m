Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE526C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C697A2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfHVT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfHVT7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:59:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19087307D868;
        Thu, 22 Aug 2019 19:59:22 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D3225D713;
        Thu, 22 Aug 2019 19:59:20 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:59:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 02/18] objtool: orc: Refactor ORC API for other
 architectures to implement.
Message-ID: <20190822195918.ify6hj5afu2x347t@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-3-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-3-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 22 Aug 2019 19:59:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:47PM +0100, Raphael Gault wrote:
> The ORC unwinder is only supported on x86 at the moment and should thus be
> in the x86 architecture code. In order not to break the whole structure in
> case another architecture decides to support the ORC unwinder via objtool

> we choose to let the implementation be done in the architecture dependent
> code.

A general comment for all the patch descriptions: they should use
imperative language, like:

  "move the implementation to the architecture-specific code."

Also the subjects shouldn't have periods.

It would be a good idea to review
Documentation/process/submitting-patches.rst.

> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/arch/x86/orc_gen.c
> @@ -6,11 +6,11 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> -#include "orc.h"
> -#include "check.h"
> -#include "warn.h"
> +#include "../../orc.h"
> +#include "../../check.h"
> +#include "../../warn.h"
>  
> -int create_orc(struct objtool_file *file)
> +int arch_create_orc(struct objtool_file *file)
>  {
>  	struct instruction *insn;
>  
> @@ -116,7 +116,7 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
>  	return 0;
>  }
>  
> -int create_orc_sections(struct objtool_file *file)
> +int arch_create_orc_sections(struct objtool_file *file)
>  {
>  	struct instruction *insn, *prev_insn;
>  	struct section *sec, *u_sec, *ip_relasec;
> @@ -209,3 +209,97 @@ int create_orc_sections(struct objtool_file *file)
>  
>  	return 0;
>  }
> +
> +int arch_orc_read_unwind_hints(struct objtool_file *file)
> +{

For naming consistency, please give them all an arch_orc prefix.  Also I
think arch_create_orc() should have a more specific name anyway, maybe
arch_orc_init().  So:

arch_orc_init()
arch_orc_create_sections()
arch_orc_read_unwind_hints()

-- 
Josh
