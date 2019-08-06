Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8350FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD220B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbfHFKZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:25:43 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:42741 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732418AbfHFKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:25:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 54D5A100E86C5;
        Tue,  6 Aug 2019 10:25:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brake63_1474f17b51038
X-Filterd-Recvd-Size: 2055
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 10:25:40 +0000 (UTC)
Message-ID: <0de744027ce487b20c3c585f67133b9ad1c996ab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
From:   Joe Perches <joe@perches.com>
To:     Brendan Jackman <brendan.jackman@bluwireless.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 06 Aug 2019 03:25:37 -0700
In-Reply-To: <20190806065910.22600-1-brendan.jackman@bluwireless.co.uk>
References: <20190806065910.22600-1-brendan.jackman@bluwireless.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 06:59 +0000, Brendan Jackman wrote:
> The arguments of sizeof are not evaluated so arguments are safe to
> re-use in that context. Excludeing sizeof sub-expressions means
> macros like ARRAY_SIZE can pass checkpatch.

Seems sensible, thanks.

> Signed-off-by: Brendan Jackman <brendan.jackman@bluwireless.co.uk>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f05..907a8e8d80ae 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5191,7 +5191,7 @@ sub process {
>  			        next if ($arg =~ /\.\.\./);
>  			        next if ($arg =~ /^type$/i);
>  				my $tmp_stmt = $define_stmt;
> -				$tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
> +				$tmp_stmt =~ s/\b(sizeof|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
>  				$tmp_stmt =~ s/\#+\s*$arg\b//g;
>  				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
>  				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;

