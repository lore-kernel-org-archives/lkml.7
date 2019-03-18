Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404932064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Hzpnh2Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCRXT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:19:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60172 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfCRXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:19:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1207B8EE119;
        Mon, 18 Mar 2019 16:19:29 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jQsEcoY1EFiB; Mon, 18 Mar 2019 16:19:28 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 94F338EE10A;
        Mon, 18 Mar 2019 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552951168;
        bh=X51JQ1Cy+t84MAFc2SuFWUzvGQgnT/zXKW5/9miYgBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hzpnh2Zj6gyjxlBuPOKMrdaXmWs05f/FgUORA/wg79HLad3LGkWNmQDLX4SlJf4qn
         AtZ0sMpe+wGPNyshLYXbL9ka9epmAYIuEdaGKKeFK8LBn9oxlTmN4T+tMFK493fbki
         Sz6jY6EYhOXh48zOyuXDCpwBkqD2IKMP1D58cfgg=
Message-ID: <1552951167.2785.22.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix a race between poll and write in tpm-dev-common
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     grawity@gmail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 16:19:27 -0700
In-Reply-To: <155294749695.20367.14472779462229450620.stgit@tstruk-mobl1.jf.intel.com>
References: <155294749695.20367.14472779462229450620.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 15:18 -0700, Tadeusz Struk wrote:
> Since the poll returns EPOLLIN base on the state of two
> variables, the response_read being false and the
> response_length > 0 the poll needs to take the buffer_mutex
> after it is woken up.
> 
> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> index 5eecad233ea1..61e458d6f652 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -203,12 +203,14 @@ __poll_t tpm_common_poll(struct file *file,
> poll_table *wait)
>  	__poll_t mask = 0;
>  
>  	poll_wait(file, &priv->async_wait, wait);
> +	mutex_lock(&priv->buffer_mutex);
>  
>  	if (!priv->response_read || priv->response_length)
>  		mask = EPOLLIN | EPOLLRDNORM;
>  	else
>  		mask = EPOLLOUT | EPOLLWRNORM;
>  
> +	mutex_unlock(&priv->buffer_mutex);

This doesn't do anything to address the theory that the queued work
hasn't run before the poll wakes up, does it?  If you have an
alternative theory, could you explain it?

Thanks,

James

