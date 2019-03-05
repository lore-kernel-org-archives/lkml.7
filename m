Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C3C20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCEXRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:17:21 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:43927 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbfCEXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:17:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 814F78368F17;
        Tue,  5 Mar 2019 23:17:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: front84_7a10272ae8a18
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Mar 2019 23:17:18 +0000 (UTC)
Message-ID: <266fda3bba4d9d73dd6268d2fd332c4bfb0ab4a2.camel@perches.com>
Subject: Re: [PATCH v2] scripts: checkpatch: Check multiple blank lines when
 deleting code
From:   Joe Perches <joe@perches.com>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Mar 2019 15:17:17 -0800
In-Reply-To: <20190305071251.28427-1-alex@ghiti.fr>
References: <20190305071251.28427-1-alex@ghiti.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 02:12 -0500, Alexandre Ghiti wrote:
> By matching only current line starting with '+', we miss the case
> when deleting code makes consecutive blank lines appear: this patch
> then makes it possible to detect this case by also matching current
> line starting with ' ', which is an already existing blank line.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2081,10 +2081,15 @@ sub fix_inserted_deleted_lines {
>  		}
>  
>  		while (defined($inserted) && ${$inserted}{'LINENR'} == $old_linenr) {
> +			my $len = 1;
>  			push(@lines, ${$inserted}{'LINE'});
> +			# Do not increment the length when inserting a deletion line.
> +			if (${$inserted}{'LINE'} =~ /^\-/) {
> +				$len = 0;
> +			}
>  			$inserted = @{$insertedRef}[$next_insert++];
>  			$new_linenr++;
> -			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, 1);
> +			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, $len);

I think this is confusing and unnecessary.
Using --fix can not delete context lines from a patch.

>  		}
>  
>  		if ($save_line) {
> @@ -3298,12 +3303,18 @@ sub process {
>  
>  # check for multiple consecutive blank lines
>  		if ($prevline =~ /^[\+ ]\s*$/ &&
> -		    $line =~ /^\+\s*$/ &&
> +		    $line =~ /^[\+ ]\s*$/ &&
>  		    $last_blank_line != ($linenr - 1)) {
>  			if (CHK("LINE_SPACING",
>  				"Please don't use multiple blank lines\n" . $hereprev) &&
>  			    $fix) {

It's simpler to add a check that $line starts /^\+/ before $fix

Maybe it'd be better to have a separate test for this to make
the output message clearer too.

Something like
	"Avoid deleting lines that create consecutive blank lines"

>  				fix_delete_line($fixlinenr, $rawline);
> +				if ($line =~ /^ \s*$/) {
> +					# If the line is not an inserted blank line, the multiple
> +					# consecutive blank lines are caused by deletion: fix this
> +					# by replacing the blank line with a deletion line.
> +					fix_insert_line($fixlinenr, "\-");
> +				}
>  			}
>  
>  			$last_blank_line = $linenr;

