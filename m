Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF2CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD221D82
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJZBud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:50:33 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:37245 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725954AbfJZBuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:50:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 45A38180A55F2;
        Sat, 26 Oct 2019 01:50:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth15_5ba9bbbc1535a
X-Filterd-Recvd-Size: 2324
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 01:50:29 +0000 (UTC)
Message-ID: <25960b2a5dfe3f5f2c6579ef718f90a139ba84d7.camel@perches.com>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Oct 2019 18:50:25 -0700
In-Reply-To: <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
         <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 22:09 -0300, Cristiane Naves wrote:
> Fix alignment should match open parenthesis.Issue found by checkpatch.

Beyond doing style cleanups, please always try
to make the code more readable.

> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
[]
> @@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
>  		precvbuf->ref_cnt = 0;
>  		precvbuf->adapter = padapter;
>  		list_add_tail(&precvbuf->list,
> -				 &(precvpriv->free_recv_buf_queue.queue));
> +			      &(precvpriv->free_recv_buf_queue.queue));

Please remove the unnecessary parentheses too

>  		precvbuf++;
>  	}
>  	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
>  	tasklet_init(&precvpriv->recv_tasklet,
> -	     (void(*)(unsigned long))recv_tasklet,
> -	     (unsigned long)padapter);
> +		     (void(*)(unsigned long))recv_tasklet,
> +		     (unsigned long)padapter);

It's probably better to change the recv_tasklet function
declaration to
use the more common style of

static void recv_tasklet(unsigned long priv)

and do the cast in the recv_tasklet function.


