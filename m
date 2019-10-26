Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D26CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB720863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJZRS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 13:18:57 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:46015 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfJZRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 13:18:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ED97F182CED34;
        Sat, 26 Oct 2019 17:18:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: maid80_30be03369d63b
X-Filterd-Recvd-Size: 1939
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 17:18:54 +0000 (UTC)
Message-ID: <2bc9e96ec06fe94505b5e7d967d1453f072738a6.camel@perches.com>
Subject: Re: [PATCH 7/7] staging: rtl8188eu: reduce indentation level in
 rtw_alloc_stainfo
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 26 Oct 2019 10:18:51 -0700
In-Reply-To: <20191026121135.181897-7-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
         <20191026121135.181897-7-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-26 at 14:11 +0200, Michael Straube wrote:
> Remove else-arm from if-else statement. Move the else code out of the
> if-else and skip it by adding goto exit to the if block. The exit label
> was directly after the else-arm, so there is no change in behaviour.
> Reduces indentation level and clears a line over 80 characters
> checkpatch warning.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
[]
> @@ -181,70 +181,71 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
>  					struct sta_info, list);
>  	if (!psta) {
>  		spin_unlock_bh(&pfree_sta_queue->lock);

Because exit does no cleanup, it's probably simpler as
		return NULL;
and then remove the exit label

> +	if (index >= NUM_STA) {
> +		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
> +			 ("ERROR => %s: index >= NUM_STA", __func__));
> +		psta = NULL;
> +		goto exit;

here too

[]

> +
>  exit:
>  	return psta;
>  }


