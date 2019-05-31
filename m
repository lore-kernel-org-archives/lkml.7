Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F5C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CE525734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEaDHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:07:33 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:37136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbfEaDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:07:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 721EB18029DB3;
        Fri, 31 May 2019 03:07:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: knot32_72f49817301f
X-Filterd-Recvd-Size: 2415
Received: from XPS-9350 (unknown [172.58.75.234])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 03:07:29 +0000 (UTC)
Message-ID: <e41c7ff9ae38363fe8c32346fea0f7efe551d162.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local
 variable
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 30 May 2019 20:06:58 -0700
In-Reply-To: <20190531011227.21181-1-mcroce@redhat.com>
References: <20190531011227.21181-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 03:12 +0200, Matteo Croce wrote:
> Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> adds some shared const variables to be used instead of a local copy in
> each source file.
> Warn when a chunk duplicates one of these values in a ctl_table struct:
> 
>     $ scripts/checkpatch.pl 0001-test-commit.patch
>     WARNING: duplicated sysctl range checking value 'zero', consider using the shared one in include/linux/sysctl.h
>     #27: FILE: arch/arm/kernel/isa.c:48:
>     +               .extra1         = &zero,
> 
>     WARNING: duplicated sysctl range checking value 'int_max', consider using the shared one in include/linux/sysctl.h
>     #28: FILE: arch/arm/kernel/isa.c:49:
>     +               .extra2         = &int_max,
> 
>     total: 0 errors, 2 warnings, 14 lines checked
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 342c7c781ba5..629c31435487 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6639,6 +6639,12 @@ sub process {
>  				     "unknown module license " . $extracted_string . "\n" . $herecurr);
>  			}
>  		}
> +
> +# check for sysctl duplicate constants
> +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {

why max_int, there isn't a single use of it in the kernel ?


