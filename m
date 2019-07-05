Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EACC0651F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC4C218A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfGECGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:06:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28939 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbfGECGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:06:20 -0400
X-UUID: fb735ff16ef54588b3157d70f821c3d4-20190705
X-UUID: fb735ff16ef54588b3157d70f821c3d4-20190705
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1096487982; Fri, 05 Jul 2019 10:06:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 5 Jul 2019 10:06:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 5 Jul 2019 10:06:04 +0800
Message-ID: <1562292364.23476.4.camel@mtkswgap22>
Subject: Re: [PATCH v2] checkpatch: add several Kconfig default value tests
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Date:   Fri, 5 Jul 2019 10:06:04 +0800
In-Reply-To: <53b2351f14f246b57871226f7cf45b9800e264a8.camel@perches.com>
References: <20190704094024.16162-1-miles.chen@mediatek.com>
         <53b2351f14f246b57871226f7cf45b9800e264a8.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: FDE15EDAF12E67EF2B3A8083FFDFD53EA54C2081AFEDDA8A13D8C58C1C29F02C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 11:49 -0700, Joe Perches wrote:
> On Thu, 2019-07-04 at 17:40 +0800, Miles Chen wrote:
> > This change adds 3 Kconfig default value tests:
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3005,6 +3005,27 @@ sub process {
> >  			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
> >  		}
> >  
> > +# discourage redundant 'default n'
> > +		if ($realfile =~ /Kconfig/ &&
> > +		    $line =~ /^\+\s*default n$/) {
> > +			WARN("DEFAULT_VALUE_STYLE",
> > +			     "'default n' is the default value, no need to write it explicitly.\n" . $herecurr);
> > +		}
> > +
> > +# discourage quote: use default [ynm], not default "[ynm]"
> > +		if ($realfile =~ /Kconfig/ &&
> > +		    $rawline =~ /^\+\s*default\s*"[ynm]"/) {
> > +			WARN("DEFAULT_VALUE_STYLE",
> > +			     "Use default [ynm] instead of default \"[ynm]\"\n" . $herecurr);
> > +		}
> > +
> > +# discourage default \!?EXPERT
> > +		if ($realfile =~ /Kconfig/ &&
> > +		    $line =~ /^\+\s*default \!?EXPERT/) {
> > +			WARN("DEFAULT_VALUE_STYLE",
> > +			     "Avoid default turn on kernel configs by default !?EXPERT\n" . $herecurr);
> > +		}
> > +
> 
> I'd prefer to create a block for all the Kconfig file tests and
> avoid multiply determining if the filename includes Kconfig so
> the script runs a bit faster.
> 

Thanks for your comments.
yes, the script runs faster this way.

> Also some trivial changes to the added tests with added --fix
> capability.  Something like:

Thanks for posting the patch, I'll verify it and post as patch v3.

> ---
>  scripts/checkpatch.pl | 139 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 85 insertions(+), 54 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6cb99ec62000..4780149a8d30 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2934,60 +2934,98 @@ sub process {
>  				      "Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.\n" . $herevet)
>  		}
>  
> -# check for Kconfig help text having a real description
> -# Only applies when adding the entry originally, after that we do not have
> -# sufficient context to determine whether it is indeed long enough.
> -		if ($realfile =~ /Kconfig/ &&
> -		    # 'choice' is usually the last thing on the line (though
> -		    # Kconfig supports named choices), so use a word boundary
> -		    # (\b) rather than a whitespace character (\s)
> -		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
> -			my $length = 0;
> -			my $cnt = $realcnt;
> -			my $ln = $linenr + 1;
> -			my $f;
> -			my $is_start = 0;
> -			my $is_end = 0;
> -			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
> -				$f = $lines[$ln - 1];
> -				$cnt-- if ($lines[$ln - 1] !~ /^-/);
> -				$is_end = $lines[$ln - 1] =~ /^\+/;
> -
> -				next if ($f =~ /^-/);
> -				last if (!$file && $f =~ /^\@\@/);
> -
> -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> -					$is_start = 1;
> -				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
> -					if ($lines[$ln - 1] =~ "---help---") {
> -						WARN("CONFIG_DESCRIPTION",
> -						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
> +# Kconfig tests
> +		if ($realfile =~ /Kconfig/) {
> +			# check for Kconfig help text having a real description
> +			# Only applies when adding the entry originally, after
> +			# that we do not have sufficient context to determine
> +			# whether it is indeed long enough.
> +			# 'choice' is usually the last thing on the line (though
> +			# Kconfig supports named choices), so use a word
> +			# boundary (\b) rather than a whitespace character (\s)
> +			if ($line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
> +				my $length = 0;
> +				my $cnt = $realcnt;
> +				my $ln = $linenr + 1;
> +				my $f;
> +				my $is_start = 0;
> +				my $is_end = 0;
> +				for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
> +					$f = $lines[$ln - 1];
> +					$cnt-- if ($lines[$ln - 1] !~ /^-/);
> +					$is_end = $lines[$ln - 1] =~ /^\+/;
> +
> +					next if ($f =~ /^-/);
> +					last if (!$file && $f =~ /^\@\@/);
> +
> +					if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> +						$is_start = 1;
> +					} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
> +						if ($lines[$ln - 1] =~ "---help---") {
> +							WARN("CONFIG_DESCRIPTION",
> +							     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
> +						}
> +						$length = -1;
> +					}
> +
> +					$f =~ s/^.//;
> +					$f =~ s/#.*//;
> +					$f =~ s/^\s+//;
> +					next if ($f =~ /^$/);
> +
> +					# This only checks context lines in the patch
> +					# and so hopefully shouldn't trigger false
> +					# positives, even though some of these are
> +					# common words in help texts
> +					if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
> +							   if|endif|menu|endmenu|source)\b/x) {
> +						$is_end = 1;
> +						last;
>  					}
> -					$length = -1;
> +					$length++;
> +				}
> +				if ($is_start && $is_end && $length < $min_conf_desc_length) {
> +					WARN("CONFIG_DESCRIPTION",
> +					     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
>  				}
> +				#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
> +			}
>  
> -				$f =~ s/^.//;
> -				$f =~ s/#.*//;
> -				$f =~ s/^\s+//;
> -				next if ($f =~ /^$/);
> -
> -				# This only checks context lines in the patch
> -				# and so hopefully shouldn't trigger false
> -				# positives, even though some of these are
> -				# common words in help texts
> -				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
> -						  if|endif|menu|endmenu|source)\b/x) {
> -					$is_end = 1;
> -					last;
> +# discourage the use of boolean for type definition attributes
> +			if ($line =~ /^\+\s*\bboolean\b/) {
> +				if (WARN("CONFIG_TYPE_BOOLEAN",
> +					 "Use of boolean is deprecated, please use bool instead\n" . $herecurr) &&
> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\bboolean\b/bool/;
> +				}
> +			}
> +
> +# Kconfig: discourage redundant 'default n'
> +			if ($line =~ /^\+\s*default\s+n$/) {
> +				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +					 "'default n' is the default value, no need to write it explicitly\n" . $herecurr) &&
> +				    $fix) {
> +					fix_delete_line($fixlinenr, $rawline);
>  				}
> -				$length++;
>  			}
> -			if ($is_start && $is_end && $length < $min_conf_desc_length) {
> -				WARN("CONFIG_DESCRIPTION",
> -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> +
> +# Kconfig: discourage quoted defaults: use default [ynm], not default "[ynm]"
> +			if ($rawline =~ /^\+\s*default\s+"([ynm])"/) {
> +				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +					 "Use 'default $1' not 'default \"$1\"'\n" . $herecurr) &&
> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\b(default\s+)"(.)"/$1$2/;
> +				}
> +			}
> +
> +# Kconfig: discourage using default EXPERT or !EXPERT
> +			if ($line =~ /^\+\s*default\s+\!?\s*EXPERT\b/) {
> +				WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +				     "Avoid using default EXPERT\n" . $herecurr);
>  			}
> -			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
>  		}
> +# End of Kconfig tests
> +
>  
>  # check for MAINTAINERS entries that don't have the right form
>  		if ($realfile =~ /^MAINTAINERS$/ &&
> @@ -3000,13 +3038,6 @@ sub process {
>  			}
>  		}
>  
> -# discourage the use of boolean for type definition attributes of Kconfig options
> -		if ($realfile =~ /Kconfig/ &&
> -		    $line =~ /^\+\s*\bboolean\b/) {
> -			WARN("CONFIG_TYPE_BOOLEAN",
> -			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
> -		}
> -
>  		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
>  		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
>  			my $flag = $1;
> 
> 


