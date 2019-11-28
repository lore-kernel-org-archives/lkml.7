Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EEAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE426216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK1JaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:30:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:35389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK1JaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:30:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 01:30:01 -0800
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199470313"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 01:29:58 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
In-Reply-To: <1574906800-19901-1-git-send-email-krzk@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
Date:   Thu, 28 Nov 2019 11:29:56 +0200
Message-ID: <87a78gnyaz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Kconfig should be indented with one tab for first level and tab+2 spaces
> for second level.  There are many mixups of this so add a checkpatch
> rule.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I agree unifying the indentation is nice, and without something like
this it'll start bitrotting before Krzysztof's done fixing them all... I
think there's been quite a few fixes merged lately.

I approve of the idea, but I'm clueless about the implementation.

BR,
Jani.


> ---
>  scripts/checkpatch.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e41f4adcc1be..875e862cf076 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3046,6 +3046,13 @@ sub process {
>  			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
>  		}
>  
> +# Kconfig has special indentation
> +		if ($realfile =~ /Kconfig/ &&
> +		    ($rawline =~ /^\+ +\t* *[a-zA-Z-]/) || ($rawline =~ /^\+\t( |   )[a-zA-Z-]/)) {
> +			WARN("CONFIG_INDENTATION",
> +			     "Kconfig uses one tab indentation, optionally followed by two spaces.\n" . $herecurr);
> +		}
> +
>  		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
>  		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
>  			my $flag = $1;

-- 
Jani Nikula, Intel Open Source Graphics Center
