Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E57213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDHKDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:03:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:32937 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDHKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:03:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 03:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="162363666"
Received: from cbackhau-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.45.163])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2019 03:03:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] kernel-doc: Rename -function to -symbol
In-Reply-To: <20190405214453.18768-4-sean.j.christopherson@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190405214453.18768-1-sean.j.christopherson@intel.com> <20190405214453.18768-4-sean.j.christopherson@intel.com>
Date:   Mon, 08 Apr 2019 13:03:49 +0300
Message-ID: <87pnpwizju.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> The -function option applies to all symbol types, not just functions.
> Rename it and update its help text and comments to reflect reality.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  Documentation/sphinx/kerneldoc.py | 4 ++--
>  scripts/kernel-doc                | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 9d0a7f08f93b..c52b6caac356 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -73,12 +73,12 @@ class KernelDocDirective(Directive):
>              cmd += ['-internal']
>              export_file_patterns = str(self.options.get('internal')).split()
>          elif 'doc' in self.options:
> -            cmd += ['-function', str(self.options.get('doc'))]
> +            cmd += ['-symbol', str(self.options.get('doc'))]
>          elif 'functions' in self.options:
>              functions = self.options.get('functions').split()
>              if functions:
>                  for f in functions:
> -                    cmd += ['-function', f]
> +                    cmd += ['-symbol', f]
>              else:
>                  cmd += ['-no-doc-sections']
>  
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 9190110b9802..60ef90222a51 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -63,10 +63,10 @@ Output selection (mutually exclusive):
>    -internal		Only output documentation for symbols that have NOT been
>  			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
>                          in any input FILE or -export-file FILE.
> -  -function NAME	Only output documentation for the given function(s)
> -			or DOC: section title(s). All other functions and DOC:
> +  -symbols	NAME	Only output documentation for the given symbol(s)
> +			or DOC: section title(s). All other symbols and DOC:
>  			sections are ignored. May be specified multiple times.
> -  -nosymbol NAME	Do NOT output documentation for the given symbol(s);
> +  -nosymbol	NAME	Do NOT output documentation for the given symbol(s);
>  			only output documentation for the other symbols and
>  			DOC: sections. May be specified multiple times.

Please decide whether to use singular or prular, and stick to it
throughout.

BR,
Jani.


>  
> @@ -409,7 +409,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
>  	$output_mode = "none";
>      } elsif ($cmd eq "module") { # not needed for XML, inherits from calling document
>  	$modulename = shift @ARGV;
> -    } elsif ($cmd eq "function") { # to only output specific function
> +    } elsif ($cmd eq "symbol") { # to only output specific symbol
>  	$output_selection = OUTPUT_INCLUDE;
>  	$function = shift @ARGV;
>  	$function_table{$function} = 1;

-- 
Jani Nikula, Intel Open Source Graphics Center
