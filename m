Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F4C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7F2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfHaC6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:58:13 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:58380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbfHaC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:58:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3E89718224508;
        Sat, 31 Aug 2019 02:58:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mouth58_2a3e073eed542
X-Filterd-Recvd-Size: 1882
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 31 Aug 2019 02:58:10 +0000 (UTC)
Message-ID: <3dc5ac616a3c2bfc48b8b3dfa1213532610b6431.camel@perches.com>
Subject: Re: [PATCH v3] staging: rts5208: Fix checkpath warning
From:   Joe Perches <joe@perches.com>
To:     P SAI PRASANTH <saip2823@gmail.com>, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 19:58:09 -0700
In-Reply-To: <20190831022515.GA4917@dell-inspiron>
References: <20190831022515.GA4917@dell-inspiron>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 07:55 +0530, P SAI PRASANTH wrote:
> This patch fixes the following checkpath warning
> in the file drivers/staging/rts5208/rtsx_transport.c:546
> 
> WARNING: line over 80 characters
> +                               option = RTSX_SG_VALID | RTSX_SG_END |
> RTSX_SG_TRANS_DATA;
[]
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
[]
> @@ -540,11 +540,10 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
>  
>  			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
>  				(unsigned int)addr, len);
> -
> +

This same line delete then insert the same blank line
is very unusual.

What did you use to create this patch?

> +			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
>  			if (j == (sg_cnt - 1))
> -				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
> -			else
> -				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
> +				option |= RTSX_SG_END;
>  
>  			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
>  

