Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2372C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF89021852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGDUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:46:30 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:46513 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfGDUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:46:30 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id C4112180253B0;
        Thu,  4 Jul 2019 20:46:28 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E67D818225AF9;
        Thu,  4 Jul 2019 20:46:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: space91_1b23faa223b5f
X-Filterd-Recvd-Size: 2807
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 20:46:26 +0000 (UTC)
Message-ID: <f6a4c2b601bb59179cb2e3b8f4d836a1c11379a3.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Nitin Gote <nitin.r.gote@intel.com>, akpm@linux-foundation.org
Cc:     corbet@lwn.net, apw@canonical.com, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date:   Thu, 04 Jul 2019 13:46:25 -0700
In-Reply-To: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
References: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 11:24 +0530, Nitin Gote wrote:
> Added warnings in checkpatch.pl script to :
> 
> 1. Deprecate strcpy() in favor of strscpy().
> 2. Deprecate strlcpy() in favor of strscpy().
> 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> 
> Updated strncpy() section in Documentation/process/deprecated.rst
> to cover strscpy_pad() case.
> 
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>

OK, for whatever reason, this when into a spam folder.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -595,6 +595,11 @@ our %deprecated_apis = (
>  	"rcu_barrier_sched"			=> "rcu_barrier",
>  	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
>  	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
> +	"strcpy"				=> "strscpy",
> +	"strlcpy"				=> "strscpy",
> +	"strncpy"				=> "strscpy, strscpy_pad or for
> +	non-NUL-terminated strings, strncpy() can still be used, but
> +	destinations should be marked with the __nonstring",
>  );

$ git grep -w strcpy | wc -l
2239
$ git grep -w strlcpy | wc -l
1760
$ git grep -w strncpy | wc -l
839

These functions are _really_ commonly used in the kernel.

This should probably be a different %deprecated_string_api
and these should probably not be emitted at WARN level
when using command line option -f/--file but at CHECK level
so that novice script users just don't send bad patches.

Also, perhaps there could be some macro for the relatively
commonly used

	strscpy(foo, bar, sizeof(foo))
and
	strlcpy(foo, bar, sizeof(foo))

so argument 1 doesn't have to be repeated in the sizeof()

Something like:

#define stracpy(to, from)					\
({								\
	size_t size = ARRAY_SIZE(to);				\
	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
								\
	strscpy(to, from, size);				\
})


