Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6844FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZjXEn6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfG2Qip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:38:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44983 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfG2Qio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:38:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so28530160pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+08c+PdXIBVeY6sDHfUjTE9cNjO6KyMEPTgMj7V2IY4=;
        b=JZjXEn6QYGEaImI7V1iUAdLhYZw+xOBslJwMzGz0qIiJ1mxf2/qcPESNBb5IZQ6Zi0
         l0Hvc6j2QUyhIUuWRbNzPSyKiMbLB6WU5H0DWxMm29fVsPXeMsiHs8opmPpQXwdGrT9Q
         e1gVS+ZMXJlJodmV3Wc15altBqNOZou3V7FbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+08c+PdXIBVeY6sDHfUjTE9cNjO6KyMEPTgMj7V2IY4=;
        b=RW9u8wSdW39G6Siz2J7ki1s99kWt9sbPZDFWZiQKO3hlAvTbgeUYvJKDGE9ZHYhWUK
         S6kygWVLLaEZtD6Wax75n2aBIfQ8QCqwzUBSdY3N20Axc8ZAXj23maCbxBAbLNq/9mEc
         EuXP4pim+IUFnjk9izWmwezKC7jec0gY3ecGwyhO9bzj9xWTZzqyslTTK1/HigPUcdFR
         Lwe9j1YfyQvfEosLVSPMdC8om3/FjVYbzOaaPaBT6loE1m5OpORzm6knipzjtJMW/uZz
         g9ybqvHf8nnE1oXU0F4KCVL0Lj06FJhj7W1B4FYDOAPvVBmv9cQW+eR9XqbgK3ZSf+aI
         jiMg==
X-Gm-Message-State: APjAAAVrgiIfpYSbIyX0wFdi+96Q9T1jJsdxUpV6FJ/Kb8cmBSSihHCz
        qNux1iDJzAT37chGuYQ8VuWrig==
X-Google-Smtp-Source: APXvYqyELyrdfBSbaJc1b/4/p8QGl1qLzaYkHKBSMm8jZldpOoqQAfcTWUmpFaevBfT0PPNVUHwiBQ==
X-Received: by 2002:a63:494d:: with SMTP id y13mr106885695pgk.109.1564418324034;
        Mon, 29 Jul 2019 09:38:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q144sm63458340pfc.103.2019.07.29.09.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:38:43 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:38:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] scsi: ibmvfc: Mark expected switch fall-throughs
Message-ID: <201907290938.022D08EA@keescook>
References: <20190729002608.GA25263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729002608.GA25263@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:26:08PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_npiv_login_done':
> drivers/scsi/ibmvscsi/ibmvfc.c:4022:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    ibmvfc_retry_host_init(vhost);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:4023:2: note: here
>   case IBMVFC_MAD_DRIVER_FAILED:
>   ^~~~
> drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_bsg_request':
> drivers/scsi/ibmvscsi/ibmvfc.c:1830:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    port_id = (bsg_request->rqst_data.h_els.port_id[0] << 16) |
>    ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     (bsg_request->rqst_data.h_els.port_id[1] << 8) |
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     bsg_request->rqst_data.h_els.port_id[2];
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1833:2: note: here
>   case FC_BSG_RPT_ELS:
>   ^~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1838:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    port_id = (bsg_request->rqst_data.h_ct.port_id[0] << 16) |
>    ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     (bsg_request->rqst_data.h_ct.port_id[1] << 8) |
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     bsg_request->rqst_data.h_ct.port_id[2];
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1841:2: note: here
>   case FC_BSG_RPT_CT:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index 8cdbac076a1b..df897df5cafe 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -1830,6 +1830,7 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
>  		port_id = (bsg_request->rqst_data.h_els.port_id[0] << 16) |
>  			(bsg_request->rqst_data.h_els.port_id[1] << 8) |
>  			bsg_request->rqst_data.h_els.port_id[2];
> +		/* fall through */
>  	case FC_BSG_RPT_ELS:
>  		fc_flags = IBMVFC_FC_ELS;
>  		break;
> @@ -1838,6 +1839,7 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
>  		port_id = (bsg_request->rqst_data.h_ct.port_id[0] << 16) |
>  			(bsg_request->rqst_data.h_ct.port_id[1] << 8) |
>  			bsg_request->rqst_data.h_ct.port_id[2];
> +		/* fall through */
>  	case FC_BSG_RPT_CT:
>  		fc_flags = IBMVFC_FC_CT_IU;
>  		break;
> @@ -4020,6 +4022,7 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
>  		return;
>  	case IBMVFC_MAD_CRQ_ERROR:
>  		ibmvfc_retry_host_init(vhost);
> +		/* fall through */
>  	case IBMVFC_MAD_DRIVER_FAILED:
>  		ibmvfc_free_event(evt);
>  		return;
> -- 
> 2.22.0
> 

-- 
Kees Cook
