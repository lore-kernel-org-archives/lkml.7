Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D3EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF3F26371
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaAzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:55:31 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:53010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbfEaAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:55:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5ADDA837F252;
        Fri, 31 May 2019 00:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: watch56_12886697fdd3c
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350 (unknown [172.58.27.55])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 00:55:27 +0000 (UTC)
Message-ID: <685e8554eed17eebc731d62336ef30eb44bd14f7.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Warn on duplicate sysctl local variable
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 30 May 2019 17:54:57 -0700
In-Reply-To: <20190530235101.3248-1-mcroce@redhat.com>
References: <20190530235101.3248-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 01:51 +0200, Matteo Croce wrote:
> Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> adds some shared const variables to be used instead of a local copy in
> each source file.
> Warn when a chunk duplicates one of these values in a ctl_table struct:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6639,6 +6639,13 @@ sub process {
>  				     "unknown module license " . $extracted_string . "\n" . $herecurr);
>  			}
>  		}
> +
> +# check for sysctl duplicate constants
> +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> +			my $extracted_string = get_quoted_string($line, $rawline);
> +			WARN("DUPLICATED_SYSCTL_CONST",
> +				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h" . $extracted_string . "\n" . $herecurr);
> +		}

why is $extracted_string used here?


