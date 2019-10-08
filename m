Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF29C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F4220640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfJHMum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:50:42 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:42754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730605AbfJHMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:50:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 49108180A68C0;
        Tue,  8 Oct 2019 12:50:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run25_5bb555778148
X-Filterd-Recvd-Size: 2428
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 12:50:39 +0000 (UTC)
Message-ID: <5ccc9458aeb124d5c66baa8fd24e78e918609487.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 05:50:37 -0700
In-Reply-To: <20191008094006.8251-1-geert+renesas@glider.be>
References: <20191008094006.8251-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> When reading a patch file from standard input, checkpatch calls it "Your
> patch", and reports its state as:
> 
>     Your patch has style problems, please review.
> 
> or:
> 
>     Your patch has no obvious style problems and is ready for submission.
> 
> Hence when checking multiple patches by piping them to checkpatch, e.g.
> when checking patchwork bundles using:
> 
>     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> 
> it is difficult to identify which patches need to be reviewed and
> improved.
> 
> Fix this by replacing "Your patch" by the patch subject, if present.

Seems sensible, thanks Geert

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6fcc66afb0880830..6b9feb4d646a116b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
>  	}
>  	while (<$FILE>) {
>  		chomp;
> +		if ($vname eq 'Your patch') {
> +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> +			$vname = '"' . $subject . '"' if $subject;

trivia:

Not a big deal and is likely good enough but this will
cut off subjects that are continued on multiple lines.

e.g.:

Subject: [PATCH Vx n/M] very long description with a subject spanning
 multiple lines
From: patch submitter <submitter@domain.tld>

> +		}
>  		push(@rawlines, $_);
>  	}
>  	close($FILE);

