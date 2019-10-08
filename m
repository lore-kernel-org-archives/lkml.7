Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA0C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E70206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfJHPU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:20:57 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:41673 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfJHPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:20:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0BBCA180A68B4;
        Tue,  8 Oct 2019 15:20:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horn44_806ca6b72c2e
X-Filterd-Recvd-Size: 2257
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 15:20:55 +0000 (UTC)
Message-ID: <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 08:20:53 -0700
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
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
>  	}
>  	while (<$FILE>) {
>  		chomp;
> +		if ($vname eq 'Your patch') {
> +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> +			$vname = '"' . $subject . '"' if $subject;

Hi again Geert.

Just some stylistic nits:

$filename is not quoted so I think adding quotes
before and after $subject may not be useful.

Can you please use what checkpatch uses as a more
common parenthesis style after an if?

i.e. use:
	if (foo)
not
	if foo

so maybe:

	if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/) {
		$vname = $1;
	}

or maybe

	$vname = $1 if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);


