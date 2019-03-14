Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0321019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCNBvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:51:01 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:59787 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbfCNBvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:51:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CD2C1837F27D;
        Thu, 14 Mar 2019 01:50:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ear54_25ae0be96ae19
X-Filterd-Recvd-Size: 3445
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Mar 2019 01:50:58 +0000 (UTC)
Message-ID: <f7497e7ee0365364e8215d8ee3436812f75096c4.camel@perches.com>
Subject: Re: [PATCH v3] lib/siphash.c: annotate implicit fall throughs
From:   Joe Perches <joe@perches.com>
To:     Mathieu Malaterre <malat@debian.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Mar 2019 18:50:57 -0700
In-Reply-To: <20190313211230.17527-1-malat@debian.org>
References: <20190114201911.13725-1-malat@debian.org>
         <20190313211230.17527-1-malat@debian.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 22:12 +0100, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>   lib/siphash.c:71:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:72:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:73:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:75:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:108:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:109:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:110:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:112:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:434:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:462:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Move the break statement onto the next line to match the fall-through
> comment pattern. Also move the trailing statement onto the next line to
> pass checkpatch verification.
[]
> diff --git a/lib/siphash.c b/lib/siphash.c
[].
> @@ -68,13 +68,26 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48;
> -	case 6: b |= ((u64)end[5]) << 40;
> -	case 5: b |= ((u64)end[4]) << 32;

It might also be worth not casting to u64 then shift
as that can be
moderately expensive on 32 bit systems
and instead use ((char
*)&b)[<appropriate_index>].

> -	case 4: b |= le32_to_cpup(data); break;
> -	case 3: b |= ((u64)end[2]) << 16;

Perhaps an unnecessary cast before shift

> -	case 2: b |= le16_to_cpup(data); break;
> -	case 1: b |= end[0];

[]

> @@ -101,13 +114,26 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48;
> -	case 6: b |= ((u64)end[5]) << 40;
> -	case 5: b |= ((u64)end[4]) << 32;

etc...

> -	case 4: b |= get_unaligned_le32(end); break;
> -	case 3: b |= ((u64)end[2]) << 16;
> -	case 2: b |= get_unaligned_le16(end); break;
> -	case 1: b |= end[0];


