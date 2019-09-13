Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17709C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC0320830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="V7B1DB8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfIMHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:15:08 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:60327 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfIMHPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:15:07 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 2F06E20336;
        Fri, 13 Sep 2019 09:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1568358900; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVkHU8xTkfng95v5LvkWpFLKQOMF3L3dSrW+esXMm4o=;
        b=V7B1DB8iZf/MVKG6Ew3Jk4W8ZCl3lhOzA+Bp6XnPoZPCpHH3ve6TylesfQiclbvJGloa17
        C//uVPtGquPB3K/MhSd2vC6Hl4nEcxiUKW9bsQb8mt+QOPclXYiLAxn8VgW8fY4UNDJ4Y6
        CPZes9tEhNxxLGn0VheK1P0Efs3ScRkZNLNlrQyzzrzP2HvnxTLYHGz5LfpCd/cFok1Htj
        AS4cw6MH85sxX6i5+Fb4Qz5u/NciJpyB8B7x5aCRQOoqyA00ox+QDTCNA/ad9ur/GKsJUc
        K1O29Eg7eksVMcLnUwuBunslqgBjn22t2/k6H//wxUcmx7wNCMJSeO4f48V5SA==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 041F3BEEBD;
        Fri, 13 Sep 2019 09:14:59 +0200 (CEST)
Message-ID: <5D7B41F2.2080607@bfs.de>
Date:   Fri, 13 Sep 2019 09:14:58 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     mripard@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: v4l: cadence: Fix how unsued lanes are handled
 in 'csi2rx_start()'
References: <20190912204450.17625-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190912204450.17625-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.999,0];
         FREEMAIL_TO(0.00)[wanadoo.fr];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12.09.2019 22:44, schrieb Christophe JAILLET:
> The 2nd parameter of 'find_first_zero_bit()' is a number of bits, not of
> bytes. So use 'BITS_PER_LONG' instead of 'sizeof(lanes_used)'.
> 
> Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is purely speculative. Using BITS_PER_LONG looks logical to me,
> but I'm not 100% sure that it is what is expected here. 'csi2rx->max_lanes'
> could also be a good candidate.
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 31ace114eda1..28765ccb1b12 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -129,7 +129,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	 */
>  	for (i = csi2rx->num_lanes; i < csi2rx->max_lanes; i++) {
>  		unsigned int idx = find_first_zero_bit(&lanes_used,
> -						       sizeof(lanes_used));
> +						       BITS_PER_LONG);

why not CHAR_BIT*sizeof(lanes_used) ?
 this would have the advantage that it is independent of future changes of lanes_used.

re,
 wh

>  		set_bit(idx, &lanes_used);
>  		reg |= CSI2RX_STATIC_CFG_DLANE_MAP(i, i + 1);
>  	}
