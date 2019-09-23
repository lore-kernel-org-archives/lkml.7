Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF600C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8220882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fzuWAz6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501877AbfIWKbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:31:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501858AbfIWKbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:31:35 -0400
Received: from zn.tnic (p200300EC2F060400856443B6AC31000F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:8564:43b6:ac31:f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4760E1EC0819;
        Mon, 23 Sep 2019 12:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569234694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OzEauiKzs5TUo3H8T9Cb11zn4jhjc8YS2cm34loDntE=;
        b=fzuWAz6sVNZ2V/wJSH9QtjBbSVphnSwtEeh111PaD405rba1m7JxJHzrzV4DL3mgRSueUf
        cL5rmZ1xCbVlzrJvAFNzv/2cqs2Mh0QV/9GoYuJ06Nuo+OZe5spYZKIe+KfHgTay2HS7PG
        4cZOEQmwi7nGLIR2X/HNe1iHGQC5E9o=
Date:   Mon, 23 Sep 2019 12:31:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kbuild test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
Message-ID: <20190923103139.GD15355@zn.tnic>
References: <20190922083342.GO13569@xsang-OptiPlex-9020>
 <20190922150328.6722-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190922150328.6722-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Masami.

On Sun, Sep 22, 2019 at 06:03:28PM +0300, Alexander Kapshuk wrote:
> This patch fixes the regexp warnings shown below:

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> 
> The ':' and '&' characters need not escaping when used in string constants
> as part of regular expressions.

I could use a reasoning here, as in, "gawk manual doesn't have those two
characters in the list here:

https://www.gnu.org/software/gawk/manual/html_node/Escape-Sequences.html"

or so.

> 
> [Test-run]
> awk -f arch/x86/tools/gen-insn-attr-x86.awk \
> 	arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> 
> diff arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> 0
> 
> awk -f tools/arch/x86/tools/gen-insn-attr-x86.awk \
> 	tools/arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> 
> diff tools/objtool/arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> 0

No need for that - just say that diffing the output before and after
shows no changes.

> [Debugging output]
> DBG:ext:(66&F2)
> DBG:match(ext, ...):(66&F2)
> DBG:match(..., lprefix3_expr):\((F2|!F3|66&F2)\)

That is supposed to say what exactly? That it still does what it is
expected to do?

Leaving in the rest for Masami.

Thx.

> Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++--
>  tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
> index b02a36b2c14f..a42015b305f4 100644
> --- a/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -69,7 +69,7 @@ BEGIN {
> 
>  	lprefix1_expr = "\\((66|!F3)\\)"
>  	lprefix2_expr = "\\(F3\\)"
> -	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
> +	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
>  	lprefix_expr = "\\((66|F2|F3)\\)"
>  	max_lprefix = 4
> 
> @@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
>  	return add_flags(imm, mod)
>  }
> 
> -/^[0-9a-f]+\:/ {
> +/^[0-9a-f]+:/ {
>  	if (NR == 1)
>  		next
>  	# get index
> diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> index b02a36b2c14f..a42015b305f4 100644
> --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -69,7 +69,7 @@ BEGIN {
> 
>  	lprefix1_expr = "\\((66|!F3)\\)"
>  	lprefix2_expr = "\\(F3\\)"
> -	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
> +	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
>  	lprefix_expr = "\\((66|F2|F3)\\)"
>  	max_lprefix = 4
> 
> @@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
>  	return add_flags(imm, mod)
>  }
> 
> -/^[0-9a-f]+\:/ {
> +/^[0-9a-f]+:/ {
>  	if (NR == 1)
>  		next
>  	# get index
> --
> 2.23.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
