Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C02C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98FA22CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfIARYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:24:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39115 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIARYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:24:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D5A4181500; Sun,  1 Sep 2019 19:23:50 +0200 (CEST)
Date:   Sun, 1 Sep 2019 19:24:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
Message-ID: <20190901172403.GA1047@bug>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch adds coccinelle script for detecting !likely and !unlikely
> > usage. It's better to use unlikely instead of !likely and vice versa.
> 
> Please explain _why_ is it better in the changelog.
> 
> btw: there are relatively few uses like this in the kernel.
> 
> $ git grep -P '!\s*(?:un)?likely\s*\(' | wc -l
> 40
> 
> afaict: It may save 2 bytes of x86/64 object code.
> 
> For instance:
> 
> $ diff -urN kernel/tsacct.lst.old kernel/tsacct.lst.new|less
> --- kernel/tsacct.lst.old       2019-08-25 09:21:39.936570183 -0700
> +++ kernel/tsacct.lst.new       2019-08-25 09:22:20.774324886 -0700
> @@ -24,158 +24,153 @@
>    15:  48 89 fb                mov    %rdi,%rbx
>         u64 time, delta;
>  
> -       if (!likely(tsk->mm))
> +       if (unlikely(tsk->mm))

Are you sure this is equivalent?

									Pavel



>    18:  4c 8d ab 28 02 00 00    lea    0x228(%rbx),%r13
>    1f:  e8 00 00 00 00          callq  24 <__acct_update_integrals+0x24>
>                         20: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
>    24:  4c 89 ef                mov    %r13,%rdi
>    27:  e8 00 00 00 00          callq  2c <__acct_update_integrals+0x2c>
>                         28: R_X86_64_PLT32      __asan_load8_noabort-0x4
> -  2c:  4c 8b bb 28 02 00 00    mov    0x228(%rbx),%r15
> -  33:  4d 85 ff                test   %r15,%r15
> -  36:  74 34                   je     6c <__acct_update_integrals+0x6c>
> +  2c:  48 83 bb 28 02 00 00    cmpq   $0x0,0x228(%rbx)
> +  33:  00 
> +  34:  75 34                   jne    6a <__acct_update_integrals+0x6a>
>                 return;
> 
> And here's a possible equivalent checkpatch test.
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 287fe73688f0..364603ad1a47 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6529,6 +6529,24 @@ sub process {
>  			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>  		}
>  
> +# !(likely|unlikely)(condition) use should be (unlikely|likely)(condition)
> +		if ($perl_version_ok &&
> +		    $line =~ /(\!\s*((?:un)?likely))\s*$balanced_parens/) {
> +			my $match = $1;
> +			my $type =  $2;
> +			my $reverse;
> +			if ($type eq "likely") {
> +				$reverse = "unlikely";
> +			} else {
> +				$reverse = "likely";
> +			}
> +			if (WARN("LIKELY_MISUSE",
> +				 "Prefer $reverse over $match\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\Q$match\E\s*\(/$reverse(/;
> +			}
> +		}
> +
>  # whine mightly about in_atomic
>  		if ($line =~ /\bin_atomic\s*\(/) {
>  			if ($realfile =~ m@^drivers/@) {
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
