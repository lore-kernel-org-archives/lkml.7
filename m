Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B19E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfCFMML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:12:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:60055 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfCFMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:12:11 -0500
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 43EE2240004;
        Wed,  6 Mar 2019 12:12:09 +0000 (UTC)
Subject: Re: [PATCH] scripts: checkpatch: Check block comments start with /*
 empty line outside net
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20190305180238.32630-1-alex@ghiti.fr>
 <4b86da69fc4460a9992a5d90fe2a1673c2fa4f37.camel@perches.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <9d200724-6ca0-6412-7862-5166241bafa7@ghiti.fr>
Date:   Wed, 6 Mar 2019 13:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <4b86da69fc4460a9992a5d90fe2a1673c2fa4f37.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/6/19 à 12:08 AM, Joe Perches a écrit :
> On Tue, 2019-03-05 at 13:02 -0500, Alexandre Ghiti wrote:
>> This patch ensures that apart from net code, block comments start with an
>> empty /* line.
> I'm not sure it's useful to try to eliminate these types
> of lines as there are ~20K of them in the kernel
>
> $ git grep -P "^\/\*\s*\S" | \
>    grep -v "\*/\s*$" | \
>    grep -vP "^(drivers/net|net/)" | \
>    grep -vP "\/\*\**$" | \
>    wc -l
> 19437


This is part of the coding style, some people rely on checkpatch for 
this matter,
so I think we should at least warn user, that would avoid patch bouncing.


>
> Also, perhaps the code would be simpler using something like:
> ---
>   scripts/checkpatch.pl | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d0001fd1112d..c62dbd440c50 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3262,6 +3262,17 @@ sub process {
>   			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>   		}
>   
> +# Block comments use an initial blank /* unless self contained single line
> +# or a continuous header line like /**********************
> +# This also allows for introductory kernel-doc /** lines
> +		if ($realfile !~ m@(?:drivers/net|net/)@ &&
> +		    $rawline =~ m@^\+\s*/\*(?:\s*\*++)?\s*\S@ &&
> +		    $rawline !~ m@\*/\s*$@ &&
> +		    $realline > 2) {
> +			WARN("BLOCK_COMMENT_STYLE",
> +			     "Block comments start with only /* on an otherwise blank line\n" . $herecurr);
> +		}
> +
>   # Block comments use * on subsequent lines
>   		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
>   		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
>
>
Your version handles more cases, but why is it simpler ? Anyway, that's 
ok for me
if you prefer your version.

Thanks for your comments,

Alex


