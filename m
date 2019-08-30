Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB568C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCECC2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH3KEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:04:00 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:36676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbfH3KEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:04:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ED946182CF665;
        Fri, 30 Aug 2019 10:03:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town56_3fb8114aab143
X-Filterd-Recvd-Size: 1891
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 10:03:57 +0000 (UTC)
Message-ID: <ef0c0782216006d187954e5b80f412bf4b8e6392.camel@perches.com>
Subject: Re: [PATCH] staging: rts5208: Fixed checkpath warning.
From:   Joe Perches <joe@perches.com>
To:     Prakhar Sinha <prakharsinha2808@gmail.com>,
        gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 03:03:56 -0700
In-Reply-To: <20190830071144.GA29987@MeraComputer>
References: <20190830071144.GA29987@MeraComputer>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 12:41 +0530, Prakhar Sinha wrote:
> This patch solves the following checkpatch.pl's message in drivers/staging/rts5208/rtsx_transport.c:397.
> WARNING: line over 80 characters
> +                               option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
[]
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
[]
> @@ -394,7 +394,8 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
>  			*index = *index + 1;
>  		}
>  		if ((i == (sg_cnt - 1)) || !resid)
> -			option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
> +			option = RTSX_SG_VALID | RTSX_SG_END | 
> +				 RTSX_SG_TRANS_DATA;
>  		else
>  			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;

probably more readable as:

		option = RTXS_SG_VALID | RTSX_SG_TRANS_DATA;
		if (i == sg_cnt - 1 || !resid)
			option |= RTXS_SG_END;

The compiler should produce the same object code.

Add parentheses in the if to suit, but they are not
necessary.


