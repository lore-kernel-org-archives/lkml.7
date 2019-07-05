Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBAC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135382085A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="MEgO1+Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGEKUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:20:18 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:26255 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGEKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:20:17 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 3B5A820187;
        Fri,  5 Jul 2019 12:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1562322011; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqP1kDs3lKOEgjeEkVTodlom9AD19S4tR3pqY3KFtgw=;
        b=MEgO1+BfIsDQc8pOkBn3pHjvimld1+SN2KkF4yyiyTfMeQf+rqv78/hExp6loEeCMzPhwm
        cnsepRC2otgLrZ+zIgznBk5HaLartyD+FODe/ZzF++A/QfoWpk+AP9tWE5n1YHSrWZ/cnd
        Fk43qi99i8wdHamvnXeVfWnJcUD24Suc4NTenYtElyDfFHCMoua5eE4BeUibGY4D1+23hh
        C70mkmtotnNSvGi0UDt/c0JyTAWxm/mLTsGhO9K5viylXF4lGFdXMQ7zWgtnx9pZEKAD8B
        YRpAT1zkoE95ZtssTTiY6RdJoOdXjUta0y3YmBAhkFKoWPbYS5DdpTtVG8UYug==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id CBABFBEEBD;
        Fri,  5 Jul 2019 12:20:10 +0200 (CEST)
Message-ID: <5D1F245A.7030203@bfs.de>
Date:   Fri, 05 Jul 2019 12:20:10 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: cs4281: remove redundant assignment to variable
 val and remove a goto
References: <20190705095704.26050-1-colin.king@canonical.com>
In-Reply-To: <20190705095704.26050-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_SOME(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.999,0];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 05.07.2019 11:57, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is being assigned with a value that is never
> read and it is being updated later with a new value. The
> assignment is redundant and can be removed.  Also remove a
> goto statement and a label and replace with a break statement.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/pci/cs4281.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
> index a2cce3ecda6f..04c712647853 100644
> --- a/sound/pci/cs4281.c
> +++ b/sound/pci/cs4281.c
> @@ -694,7 +694,7 @@ static int snd_cs4281_trigger(struct snd_pcm_substream *substream, int cmd)
>  
>  static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
>  {
> -	unsigned int val = ~0;
> +	unsigned int val;
>  	
>  	if (real_rate)
>  		*real_rate = rate;
> @@ -707,9 +707,8 @@ static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
>  	case 44100:	return 1;
>  	case 48000:	return 0;
>  	default:
> -		goto __variable;
> +		break;
>  	}
> -      __variable:
>  	val = 1536000 / rate;
>  	if (real_rate)
>  		*real_rate = 1536000 / val;
		^^^^^^^^^^^^^^^^^^^^^^^^^

this is confusing. is
*real_rate = rate
intended here ? (like above)

val could be eliminated by using

return  1536000 / rate ;

re,
 wh
