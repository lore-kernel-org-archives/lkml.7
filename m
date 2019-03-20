Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22815C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="W+oVgI3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfCTOaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:30:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38642 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbfCTOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:30:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 627DB8EE10A;
        Wed, 20 Mar 2019 07:30:45 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G71zh68vwYKH; Wed, 20 Mar 2019 07:30:45 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACA1E8EE0CF;
        Wed, 20 Mar 2019 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1553092244;
        bh=GIn7yoSnPArPkrIyJL4Yj913wXPitEgfP98S9BP82qQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W+oVgI3OdtcJhSNGFBqIDhgLuVC3Ne4pPWpzXAAbWhIC53DutVSsSoowyEEc3Jvid
         lQ9ia3dTINusPXcBRutRTzy3Hpci4OYUGcuvfJqU4rXTCymHPWrRBAw1HmcQQPBOpJ
         HNOWqtcD5y8ucXRusNzh7qWP+cF0mw00bqx3mI0Q=
Message-ID: <1553092243.2835.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: fix an invalid condition in tpm_common_poll
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     grawity@gmail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 07:30:43 -0700
In-Reply-To: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
References: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 13:31 -0700, Tadeusz Struk wrote:
> The poll condition should only check response_length,
> because reads should only be issued if there is data to read.
> The response_read flag only prevents double writes.
> The problem was that the write set the response_read to false,
> enqued a tpm job, and returned. Then application called poll
> which checked the response_read flag and returned EPOLLIN.
> Then the application called read, but got nothing.
> After all that the async_work kicked in.
> Added also mutex_lock around the poll check to prevent
> other possible race conditions.
> 
> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> index 5eecad233ea1..7312d3214381 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -203,12 +203,14 @@ __poll_t tpm_common_poll(struct file *file,
> poll_table *wait)
>  	__poll_t mask = 0;
>  
>  	poll_wait(file, &priv->async_wait, wait);
> +	mutex_lock(&priv->buffer_mutex);
>  
> -	if (!priv->response_read || priv->response_length)
> +	if (priv->response_length)
>  		mask = EPOLLIN | EPOLLRDNORM;
>  	else
>  		mask = EPOLLOUT | EPOLLWRNORM;
>  
> +	mutex_unlock(&priv->buffer_mutex);

Just an observation on this: the mutex is now no-longer necessary
because a read on a size_t quantity is always atomic.

James

