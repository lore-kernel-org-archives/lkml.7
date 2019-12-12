Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6722073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLLANd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:13:33 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:34102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbfLLANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:13:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B768C2839;
        Thu, 12 Dec 2019 00:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: map45_5862a42f9f662
X-Filterd-Recvd-Size: 4204
Received: from XPS-9350 (unknown [66.178.38.77])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Dec 2019 00:13:26 +0000 (UTC)
Message-ID: <6202bccc888809dcb76ea6ba8c0a87d138ce1bbd.camel@perches.com>
Subject: Re: get_maintainer.pl produces non-deterministic results
From:   Joe Perches <joe@perches.com>
To:     Vegard Nossum <vegard.nossum@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 11 Dec 2019 16:12:44 -0800
In-Reply-To: <CAOMGZ=FhJjQcv-49gQyAYkXW1LhtYcgis8rKASMo_dDKQ+dMkw@mail.gmail.com>
References: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
         <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
         <CAOMGZ=FhJjQcv-49gQyAYkXW1LhtYcgis8rKASMo_dDKQ+dMkw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 07:41 +0100, Vegard Nossum wrote:
> On Wed, 11 Dec 2019 at 01:02, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-12-10 at 14:47 +0100, Dmitry Vyukov wrote:
> > > Hi Joe,
> > > 
> > > scripts/get_maintainer.pl fs/proc/task_mmu.c
> > > non-deterministically gives me from 13 to 16 results, different number
> > > every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
> > > this with v5.28.2.
> > > Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
> > > non-determinism. But I guess it's not the right solution, there should
> > > be some logical problem.
> > > My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.
> > > 
> > > Thanks
> > 
> > https://lkml.org/lkml/2017/7/13/789
> 
> Right, so you can make it reproducible if you add a tie-break to the sorting:
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2c..109d9fb134dad 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -2179,7 +2179,7 @@ sub vcs_assign {
>      $hash{$_}++ for @lines;
> 
>      # sort -rn
> -    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
> +    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
>         my $sign_offs = $hash{$line};
>         my $percent = $sign_offs * 100 / $divisor;
> 
> This would actually favour names that start with early letters (A, B,
> ...) over late letters (..., Y, Z), which might also be a bad thing. I
> think to fix that you could include everybody who has the same number
> of signoffs at the cutoff:
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2c..80d3ed2ee6d70 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -2179,7 +2179,8 @@ sub vcs_assign {
>      $hash{$_}++ for @lines;
> 
>      # sort -rn
> -    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
> +    my $prev_sign_offs = -1;
> +    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
>         my $sign_offs = $hash{$line};
>         my $percent = $sign_offs * 100 / $divisor;
> 
> @@ -2187,7 +2188,7 @@ sub vcs_assign {
>         next if (ignore_email_address($line));
>         $count++;
>         last if ($sign_offs < $email_git_min_signatures ||
> -                $count > $email_git_max_maintainers ||
> +                ($prev_sign_offs != $sign_offs && $count >
> $email_git_max_maintainers) ||
>                  $percent < $email_git_min_percent);
>         push_email_address($line, '');
>         if ($output_rolestats) {
> @@ -2196,6 +2197,8 @@ sub vcs_assign {
>         } else {
>             add_role($line, $role);
>         }
> +
> +       $prev_sign_offs = $sign_offs;
>      }
>  }
> 
> These patches are probably horribly whitespace damaged, hopefully you
> get the gist of it though...

I get the gist, but I think it's also not particularly important
to be repeatable.  I think it's more important to get more pattern
coverage of the MAINTAINERS file as that is more important than
any use of git history.


