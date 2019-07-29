Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FBC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01814206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/Ik2pRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfG2Qrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:47:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfG2Qrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:47:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so22241804pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HYM77T+SWMoihWfcbm2XFRaRtmpa4z+fIUs75oZAs8=;
        b=c/Ik2pRquSujLz7O5dBwwJjKKhgfAuZ5GQ4zew/ml3g8QlA/37IuwKHgZnSXdeMKVR
         e1i+h2U1u4hPdhRCBG1WuFHtfVl6wcrfWi0GnFJtD5pr/61XZmhTBkKRmaCokJaqIH9Z
         hp1h8SlIpdXRKq/RtgKYF8GkxQeHZWSWVupBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HYM77T+SWMoihWfcbm2XFRaRtmpa4z+fIUs75oZAs8=;
        b=M1birlferysCHa4GC43Lhv6p6aQe4IuQwvMz+OlcJj4LQCl7OoqSQezgN6buZLAzfl
         X1tFYb//UyZfH4PYg1egqiuPyzuG/m408RnBsZNAOTZbaYjP7YRpSJC71Bg59Uft5eb+
         dWy8gI1Y5dInxSuYYy/UK9nLiL4bsj3LGE7I2hetdQ7Q80snN9BTPjZFO4qvPkT8MNMw
         WIwN6+dN6HwDGCe32vrcD6Ii+keGLLVbF/TaaQC7p3hOetYkyZbFyYewJzN/mG6l7sNr
         LsI151OpvfU2ia0Fz4dkUnIgzxaUFGANdVrBp8vbocIxs8RtxGwhD9+thc+4aqeEISl1
         v2hA==
X-Gm-Message-State: APjAAAUgt2Fxwgab1EwkkLqLnRgDyfwoZt4VRMszaIuuwfy5xs3oZmMv
        ZuSiicLgv9RzHGHxHEV4YKBVrg==
X-Google-Smtp-Source: APXvYqwqyk7tZBLOXPCMqEp5goH/DD6//JX/K7sUovZfR0r1B5DokBw0Oi+u80x7UFb7YkFNVrl2iA==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr114851009pjb.42.1564418866179;
        Mon, 29 Jul 2019 09:47:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm80389486pjd.19.2019.07.29.09.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:47:45 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:47:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] scsi: cxlflash: Mark expected switch fall-throughs
Message-ID: <201907290947.4DC90F6@keescook>
References: <20190729002119.GA25068@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729002119.GA25068@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:21:19PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/scsi/cxlflash/main.c: In function 'send_afu_cmd':
> drivers/scsi/cxlflash/main.c:2347:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (rc) {
>       ^
> drivers/scsi/cxlflash/main.c:2357:2: note: here
>   case -EAGAIN:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'term_intr':
> drivers/scsi/cxlflash/main.c:754:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (index == PRIMARY_HWQ)
>       ^
> drivers/scsi/cxlflash/main.c:756:2: note: here
>   case UNMAP_TWO:
>   ^~~~
> drivers/scsi/cxlflash/main.c:757:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:758:2: note: here
>   case UNMAP_ONE:
>   ^~~~
> drivers/scsi/cxlflash/main.c:759:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:760:2: note: here
>   case FREE_IRQ:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'cxlflash_remove':
> drivers/scsi/cxlflash/main.c:975:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cxlflash_release_chrdev(cfg);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:976:2: note: here
>   case INIT_STATE_SCSI:
>   ^~~~
> drivers/scsi/cxlflash/main.c:978:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    scsi_remove_host(cfg->host);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:979:2: note: here
>   case INIT_STATE_AFU:
>   ^~~~
> drivers/scsi/cxlflash/main.c:980:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    term_afu(cfg);
>    ^~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:981:2: note: here
>   case INIT_STATE_PCI:
>   ^~~~
> drivers/scsi/cxlflash/main.c:983:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pci_disable_device(pdev);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:984:2: note: here
>   case INIT_STATE_NONE:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'num_hwqs_store':
> drivers/scsi/cxlflash/main.c:3018:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (cfg->state == STATE_NORMAL)
>       ^
> drivers/scsi/cxlflash/main.c:3020:2: note: here
>   default:
>   ^~~~~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/cxlflash/main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index b1f4724efde2..93ef97af22df 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -753,10 +753,13 @@ static void term_intr(struct cxlflash_cfg *cfg, enum undo_level level,
>  		/* SISL_MSI_ASYNC_ERROR is setup only for the primary HWQ */
>  		if (index == PRIMARY_HWQ)
>  			cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 3, hwq);
> +		/* fall through */
>  	case UNMAP_TWO:
>  		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
> +		/* fall through */
>  	case UNMAP_ONE:
>  		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
> +		/* fall through */
>  	case FREE_IRQ:
>  		cfg->ops->free_afu_irqs(hwq->ctx_cookie);
>  		/* fall through */
> @@ -973,14 +976,18 @@ static void cxlflash_remove(struct pci_dev *pdev)
>  	switch (cfg->init_state) {
>  	case INIT_STATE_CDEV:
>  		cxlflash_release_chrdev(cfg);
> +		/* fall through */
>  	case INIT_STATE_SCSI:
>  		cxlflash_term_local_luns(cfg);
>  		scsi_remove_host(cfg->host);
> +		/* fall through */
>  	case INIT_STATE_AFU:
>  		term_afu(cfg);
> +		/* fall through */
>  	case INIT_STATE_PCI:
>  		cfg->ops->destroy_afu(cfg->afu_cookie);
>  		pci_disable_device(pdev);
> +		/* fall through */
>  	case INIT_STATE_NONE:
>  		free_mem(cfg);
>  		scsi_host_put(cfg->host);
> @@ -2353,11 +2360,11 @@ static int send_afu_cmd(struct afu *afu, struct sisl_ioarcb *rcb)
>  			cxlflash_schedule_async_reset(cfg);
>  			break;
>  		}
> -		/* fall through to retry */
> +		/* fall through - to retry */
>  	case -EAGAIN:
>  		if (++nretry < 2)
>  			goto retry;
> -		/* fall through to exit */
> +		/* fall through - to exit */
>  	default:
>  		break;
>  	}
> @@ -3017,6 +3024,7 @@ static ssize_t num_hwqs_store(struct device *dev,
>  		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET);
>  		if (cfg->state == STATE_NORMAL)
>  			goto retry;
> +		/* else, fall through */
>  	default:
>  		/* Ideally should not happen */
>  		dev_err(dev, "%s: Device is not ready, state=%d\n",
> -- 
> 2.22.0
> 

-- 
Kees Cook
