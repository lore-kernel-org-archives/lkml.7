Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29EC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0FF21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEHOTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:19:34 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:47807 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbfEHOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:19:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CAE7F180A885B;
        Wed,  8 May 2019 14:19:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slip08_190566b4c9f11
X-Filterd-Recvd-Size: 1834
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:19:31 +0000 (UTC)
Message-ID: <b76eb950365b27848dfb0cfc851255d9af97ac90.camel@perches.com>
Subject: Re: [PATCH 2/4] checkpatch: add --fix for warning LINE_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:19:29 -0700
In-Reply-To: <20190508122721.7513-2-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-2-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> The warning LINE_CONTINUATIONS does not offer a --fix.
> 
> Add the trivial --fix.
> In case of consecutive lines with the same issue, this will
> fix only the first line.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5207,8 +5207,11 @@ sub process {
>  			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
>  			    $line !~ /^\+.*\b(__asm__|asm)\b.*\\$/ &&	# asm
>  			    $line =~ /^\+.*\\$/) {
> -				WARN("LINE_CONTINUATIONS",
> -				     "Avoid unnecessary line continuations\n" . $herecurr);
> +				if (WARN("LINE_CONTINUATIONS",
> +					 "Avoid unnecessary line continuations\n" . $herecurr) &&

I prefer to not apply this.

Problem here is that these should generally be fixed by hand
as the automated fix isn't very good style either.

> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\s*\\$//;
> +				}
>  			}
>  		}
>  

