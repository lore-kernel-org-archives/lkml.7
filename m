Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B154BC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA3F20656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:10:21 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:43578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbfGIQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:10:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 23F1518039537;
        Tue,  9 Jul 2019 16:10:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: front40_59e25574f9562
X-Filterd-Recvd-Size: 2588
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 16:10:17 +0000 (UTC)
Message-ID: <040b50f00501ae131256bb13a5362731ebdd6bfe.camel@perches.com>
Subject: Re: [PATCH v4] Added warnings in checkpatch.pl script to :
From:   Joe Perches <joe@perches.com>
To:     NitinGote <nitin.r.gote@intel.com>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Tue, 09 Jul 2019 09:10:16 -0700
In-Reply-To: <20190709154806.26363-1-nitin.r.gote@intel.com>
References: <20190709154806.26363-1-nitin.r.gote@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 21:18 +0530, NitinGote wrote:
> From: Nitin Gote <nitin.r.gote@intel.com>
> 
> 1. Deprecate strcpy() in favor of strscpy().
> 2. Deprecate strlcpy() in favor of strscpy().
> 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> 
> Updated strncpy() section in Documentation/process/deprecated.rst
> to cover strscpy_pad() case.

Please slow down your patch submission rate for
this instance and respond appropriately to the
comments you've been given.

This stuff is not critical bug fixing.

The subject could be something like:

Subject: [PATCH v#] Documentation/checkpatch: Prefer strscpy over strcpy/strlcpy

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -605,6 +605,20 @@ foreach my $entry (keys %deprecated_apis) {
>  }
>  $deprecated_apis_search = "(?:${deprecated_apis_search})";
> 
> +our %deprecated_string_apis = (
> +        "strcpy"				=> "strscpy",
> +        "strlcpy"				=> "strscpy",
> +        "strncpy"				=> "strscpy, strscpy_pad or for non-NUL-terminated strings, strncpy() can still be used, but destinations should be marked with the __nonstring",

'the' is not necessary.

There could likely also be a strscat created for
strcat, strlcat and strncat.

btw:

There were several defects in the kernel for misuses
of strlcpy.

Did you or anyone else have an opinion on stracpy
to avoid duplicating the first argument in a
sizeof()?

	strlcpy(foo, bar, sizeof(foo))
to
	stracpy(foo, bar)

where foo must be char array compatible ?

https://lore.kernel.org/lkml/d1524130f91d7cfd61bc736623409693d2895f57.camel@perches.com/



