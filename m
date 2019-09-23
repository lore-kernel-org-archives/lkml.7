Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD41C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E8C20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569264547;
	bh=dKKAMQxEq0qZ0txahL1t4OC0ZXa/T0p6wRy7JHOYsYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jviw7Tre9nSn0TRkb3on5L+dL2ml5WrdZ3OzWI/yrh5LB99OXmhcw81uQH7iV/3Lz
	 W0BNsKA9ZU/El1xKx4YYGJ1fC/c3QsyoHYUjnnxh4yggk5TZtdK2OTm9kwWk4m07HD
	 H4dICQi2+6xTAhE+1GiK4uuDqjmFmcW7QxDJ6hkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfIWStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfIWStG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:49:06 -0400
Received: from devnote2 (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF70620820;
        Mon, 23 Sep 2019 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569264545;
        bh=dKKAMQxEq0qZ0txahL1t4OC0ZXa/T0p6wRy7JHOYsYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wvYBCeIXBQTHnT4L0ChVhOVE9warkiTyZCXbjz3q3qqWAgwO8Vb4MtvfsJEEJpHS3
         YplFMawpYAsWVwmitpq6L/Ql6OouIUzIJzag13K7gxOdQN43foRHPO14KOd4bd8TcG
         r9XriXd6/8MTzTw749D/O0KYT4pLWRp0RYRo/qtg=
Date:   Mon, 23 Sep 2019 11:49:04 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kbuild test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
Message-Id: <20190923114904.dd63949b3433376aeb4b7789@kernel.org>
In-Reply-To: <20190923103139.GD15355@zn.tnic>
References: <20190922083342.GO13569@xsang-OptiPlex-9020>
        <20190922150328.6722-1-alexander.kapshuk@gmail.com>
        <20190923103139.GD15355@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 12:31:39 +0200
Borislav Petkov <bp@alien8.de> wrote:

> + Masami.
> 
> On Sun, Sep 22, 2019 at 06:03:28PM +0300, Alexander Kapshuk wrote:
> > This patch fixes the regexp warnings shown below:
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
> > GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> > 
> > The ':' and '&' characters need not escaping when used in string constants
> > as part of regular expressions.
> 
> I could use a reasoning here, as in, "gawk manual doesn't have those two
> characters in the list here:
> 
> https://www.gnu.org/software/gawk/manual/html_node/Escape-Sequences.html"

Thank you for pointing it out. It is good to refer this page as the
reason of this patch.

I couldn't remember why I added those escapes on those... (maybe for
compatibility with mawk? anyway, nowadays there seems no problem)

> 
> or so.
> 
> > 
> > [Test-run]
> > awk -f arch/x86/tools/gen-insn-attr-x86.awk \
> > 	arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> > 
> > diff arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> > 0
> > 
> > awk -f tools/arch/x86/tools/gen-insn-attr-x86.awk \
> > 	tools/arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> > 
> > diff tools/objtool/arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> > 0
> 
> No need for that - just say that diffing the output before and after
> shows no changes.
> 
> > [Debugging output]
> > DBG:ext:(66&F2)
> > DBG:match(ext, ...):(66&F2)
> > DBG:match(..., lprefix3_expr):\((F2|!F3|66&F2)\)
> 
> That is supposed to say what exactly? That it still does what it is
> expected to do?
> 
> Leaving in the rest for Masami.

This looks good to me, except for the description pointed above.
So feel free to add my ack on your patch on next version.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,
> 
> Thx.
> 
> > Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> >  arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++--
> >  tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
> > index b02a36b2c14f..a42015b305f4 100644
> > --- a/arch/x86/tools/gen-insn-attr-x86.awk
> > +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> > @@ -69,7 +69,7 @@ BEGIN {
> > 
> >  	lprefix1_expr = "\\((66|!F3)\\)"
> >  	lprefix2_expr = "\\(F3\\)"
> > -	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
> > +	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
> >  	lprefix_expr = "\\((66|F2|F3)\\)"
> >  	max_lprefix = 4
> > 
> > @@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
> >  	return add_flags(imm, mod)
> >  }
> > 
> > -/^[0-9a-f]+\:/ {
> > +/^[0-9a-f]+:/ {
> >  	if (NR == 1)
> >  		next
> >  	# get index
> > diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > index b02a36b2c14f..a42015b305f4 100644
> > --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > @@ -69,7 +69,7 @@ BEGIN {
> > 
> >  	lprefix1_expr = "\\((66|!F3)\\)"
> >  	lprefix2_expr = "\\(F3\\)"
> > -	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
> > +	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
> >  	lprefix_expr = "\\((66|F2|F3)\\)"
> >  	max_lprefix = 4
> > 
> > @@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
> >  	return add_flags(imm, mod)
> >  }
> > 
> > -/^[0-9a-f]+\:/ {
> > +/^[0-9a-f]+:/ {
> >  	if (NR == 1)
> >  		next
> >  	# get index
> > --
> > 2.23.0
> > 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
