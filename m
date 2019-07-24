Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1901C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEEA21852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGXSDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:03:40 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:45288 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbfGXSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:03:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 416D2182CF674;
        Wed, 24 Jul 2019 18:03:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crush75_3ce39f3b86a14
X-Filterd-Recvd-Size: 2307
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 18:03:38 +0000 (UTC)
Message-ID: <4ce25249a42248e7762f22f40d6d9898365024ea.camel@perches.com>
Subject: Re: [PATCH 01/12] checkpatch: Add GENMASK tests
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 11:03:35 -0700
In-Reply-To: <c5cf9dd30360a395b50514f8fece2231e0180ce1.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
         <c5cf9dd30360a395b50514f8fece2231e0180ce1.1562734889.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> This macro is easy to misuse as it's odd argument order.
> 
> If specified with simple decimal values, make sure the arguments are
> ordered high then low.
> 
> Also check if any argument is > 32 where instead of GENMASK,
> GENMASK_ULL should be used.

Hey Andrew, can you add this please.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6cb99ec62000..d37bbe33524b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6368,6 +6368,21 @@ sub process {
>  			     "switch default: should use break\n" . $herectx);
>  		}
>  
> +# check for misuses of GENMASK
> +		if ($line =~ /\b(GENMASK(?:_ULL)?)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)/) {
> +			my $type = $1;
> +			my $high = $2;
> +			my $low = $3;
> +			if ($high < $low) {
> +				ERROR("GENMASK",
> +				      "$type argument order is high then low\n" . $herecurr);
> +			}
> +			if ($type eq "GENMASK" && ($high >= 32 || $low >= 32)) {
> +				ERROR("GENMASK",
> +				      "$type with arguments >= 32 should use GENMASK_ULL\n" . $herecurr);
> +			}
> +		}
> +
>  # check for gcc specific __FUNCTION__
>  		if ($line =~ /\b__FUNCTION__\b/) {
>  			if (WARN("USE_FUNC",

