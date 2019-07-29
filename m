Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8294AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597A3206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNGpuKj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfG2QqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:46:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfG2QqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:46:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so28325223pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XB62ZlwhO0yjn1D18g6mJedhYXvVJ+OT4E/XDQe9ZCk=;
        b=kNGpuKj266Cp80GsF21mWtbjwjw0TwpMwcxKSTrWp1fKs229lQ5Q6fKNDlF8XNZOby
         DIzPP5WCZcmvdoALsMOTeDg/H1GNliIN45wzak4RfJPYn8DhadOjKojLjSnwjQKNX9+c
         F+p98alnCGB01sujC8ZfcDPZtrNUcOETIWJr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XB62ZlwhO0yjn1D18g6mJedhYXvVJ+OT4E/XDQe9ZCk=;
        b=uePudKXQaRAM58Lg9BRvC4dKCO5xwwAnHUDQQFvLsGpvshu5+nUC6vvkAOgN1Q55ul
         dr1fyZpggC86BMD9AdLFdDMB7aonl+6UySzMYMgtS8h04AVQp52cwVH2cfaEsfcFucyW
         ZDa0P7WIHiXP5irDrLc2G4k3ZYyK3rvdprW+SMpoWDqtTqui1dc/uk7j20Dmm8YAnuxx
         cw0GtxwbZ8IG3yBMnMkJP5zaB1agHEiwjpWhYofVOvXxpvWgH/JHo5mb20zKZ8BO3nzn
         sNcbWof4D3Svt95i1GOusnYBrz+QsT4piHP93AJBoFsQKbDrTE5EU1Bl7u2u9EEVme6x
         JiCg==
X-Gm-Message-State: APjAAAV2MkwRzohkemZS1IRq1hQdyiaGdEOMRVD1ZlxEfsggQenKIvYk
        Isj9OtgzUhQWSj7N7FEAprRDoA==
X-Google-Smtp-Source: APXvYqz9qJOM5dIi2ju6tb+8erAlPufIhyFtbb5+Wt/6x+Za99SlREIVsU/CBsi5YAwjGE7lxc5zNw==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr37126562pfi.139.1564418774350;
        Mon, 29 Jul 2019 09:46:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 35sm70258236pgw.91.2019.07.29.09.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:46:13 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:46:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Cyr <mikecyr@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: Mark expected switch fall-throughs
Message-ID: <201907290946.C8FFE767@keescook>
References: <20190729112902.GA3768@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729112902.GA3768@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:29:02AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: powerpc allyesconfig):
> 
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_adapter_info':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1582:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (connection_broken(vscsi))
>       ^
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1584:2: note: here
>   default:
>   ^~~~~~~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_ping_response':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2494:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    vscsi->flags |= CLIENT_FAILED;
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2495:2: note: here
>   case H_DROPPED:
>   ^~~~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2496:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    vscsi->flags |= RESPONSE_Q_DOWN;
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2497:2: note: here
>   case H_REMOTE_PARM:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index 7f9535392a93..a929fe76102b 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -1581,6 +1581,7 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
>  	case H_PERMISSION:
>  		if (connection_broken(vscsi))
>  			flag_bits = (RESPONSE_Q_DOWN | CLIENT_FAILED);
> +		/* Fall through */
>  	default:
>  		dev_err(&vscsi->dev, "adapter_info: h_copy_rdma to client failed, rc %ld\n",
>  			rc);
> @@ -2492,8 +2493,10 @@ static long ibmvscsis_ping_response(struct scsi_info *vscsi)
>  		break;
>  	case H_CLOSED:
>  		vscsi->flags |= CLIENT_FAILED;
> +		/* Fall through */
>  	case H_DROPPED:
>  		vscsi->flags |= RESPONSE_Q_DOWN;
> +		/* Fall through */
>  	case H_REMOTE_PARM:
>  		dev_err(&vscsi->dev, "ping_response: h_send_crq failed, rc %ld\n",
>  			rc);
> -- 
> 2.22.0
> 

-- 
Kees Cook
