Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A76C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF692166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGIF6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:58:01 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:57194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfGIF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:58:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8AC98181D3417;
        Tue,  9 Jul 2019 05:57:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: month28_7fc9c36087e4a
X-Filterd-Recvd-Size: 3399
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 05:57:58 +0000 (UTC)
Message-ID: <5e2fb063f50b0d0d8caac5742117488245c4b052.camel@perches.com>
Subject: Re: [PATCH v2] Added warnings in checkpatch.pl script to :
From:   Joe Perches <joe@perches.com>
To:     NitinGote <nitin.r.gote@intel.com>, akpm@linux-foundation.org
Cc:     corbet@lwn.net, apw@canonical.com, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date:   Mon, 08 Jul 2019 22:57:56 -0700
In-Reply-To: <20190709054055.21984-1-nitin.r.gote@intel.com>
References: <20190709054055.21984-1-nitin.r.gote@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 11:10 +0530, NitinGote wrote:
> From: Nitin Gote <nitin.r.gote@intel.com>
> 
> 1. Deprecate strcpy() in favor of strscpy().
> 2. Deprecate strlcpy() in favor of strscpy().
> 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> 
> Updated strncpy() section in Documentation/process/deprecated.rst
> to cover strscpy_pad() case.
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Kees, I think the concept is fine, but perhaps your
acked-by here isn't great.  There are a few clear
defects in the checkpatch code that you also might
have overlooked.

>  Change log:
>  v1->v2
>  - For string related apis, created different %deprecated_string_api
>    and these will get emitted at CHECK Level using command line option
>    -f/--file to avoid bad patched from novice script users.
> 

[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl

[]
> @@ -605,6 +605,21 @@ foreach my $entry (keys %deprecated_apis) {
>  }
>  $deprecated_apis_search = "(?:${deprecated_apis_search})";
> 
> +our %deprecated_string_apis = (
> +        "strcpy"                                => "strscpy",
> +        "strlcpy"                               => "strscpy",
> +        "strncpy"                               => "strscpy, strscpy_pad or for non-NUL-terminated strings,
> +         strncpy() can still be used, but destinations should be marked with the __nonstring",

This last strncpy line should not be on multiple lines.
checkpatch output is single line.

[]

> @@ -6446,6 +6461,16 @@ sub process {
>  			     "Deprecated use of '$deprecated_api', prefer '$new_api' instead\n" . $herecurr);
>  		}
> 
> +# check for string deprecated apis
> +                if ($line =~ /\b($deprecated_string_apis_search)\b\s*\(/) {
> +                        my $deprecated_string_api = $1;
> +                        my $new_api = $deprecated_string_apis{$deprecated_string_api};
> +			$check = 1;
> +                        CHK("DEPRECATED_API",
> +                             "Deprecated use of '$deprecated_string_api', prefer '$new_api' instead\n" . $herecurr);
> +			$check = 0;

nack.

Please use consistent tab indentation and no,
do not set and unset $check.

Please use the same style as the rest of the script
when emitting at different levels for -f uses

			my $msg_level = \&WARN;
			$msg_level = \&CHK if ($file);
			&{$msg_level}("DEPRECATED_API", etc...


