Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA7AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950872086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He0veXrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfFKFCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:02:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43939 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbfFKFCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:02:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so6611685pfg.10;
        Mon, 10 Jun 2019 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tP1svpltKO1fGLOzf67iO0MI+/MDJ8p+COkpulTN3F0=;
        b=He0veXrBWEYNKO8HWqPtN2lva11acLgl5Xjij261Ink30AkSnldWN/ChwB9tl/VJS8
         76Zygd3SY/Y7RTgU8mOOvf7nHiBE5agjkFg5WbPE6x3LXXsgT4XDGO/DSPWsJCDymKns
         Gg6ze2g/Qrnsiigz9wEKjLbmemguYS2UyNJ6PiLF8cdD0H4SCp6ZLge/A34F6jFni0Da
         uuv451tsM3OC8O1Ue4eeSBfOh+RWJOBN4rjg0/u7HUEC9XSyppkoNGdr5Ox1oE1jvX3t
         PbZCj8csfa5alENy4X0Ha5vBY2pL2iyekosKC4id5Nu729lBUt3qch+1zGbMzHUtiqQ/
         eJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tP1svpltKO1fGLOzf67iO0MI+/MDJ8p+COkpulTN3F0=;
        b=Za5/yW6FXOYWC7BYwR7Iqq+jmdgryVBgN0kRLDFowfz8i3bWzgCLML42/157RCEj5U
         6k9AUa4YPjHwnZuNjhlRcLBHTF1T5w83v1rKv04cxDi4rp0mqS3QSIN+J4IPir/rmT/u
         nqI2Z36ofZpVlg6dBOv39Zbv2B7C+6kIBBcrLaCYc69u6NVS9JxBsswj0TlLbiK70cRU
         cSdLpiDjNL+ip8oQxirnIbm2ETaYwjXATTqtwZcjtzU2YNehQj0QJIBUcod7RXtlGN85
         VQLt7CARwZCYwyMnNrM8Imr2qs1JX7eDSLHSJcbepBxyyfbWOsWIZ0AaVMi1BNyjeyM7
         NYcQ==
X-Gm-Message-State: APjAAAXIEqGj+0MTlYnguCsfRKTgeI1Bt1WJbYMoGkTWfLzG0TktLANA
        QWW+lAjeU8mF186JoQ/UmNK7WXL1
X-Google-Smtp-Source: APXvYqwwaXtX7T4BaAQhFUdzXjHyfTh4Nhk98pJzSFYQ3dJt5uMbgtxxJwj9ioXhCVkr9TPrBQ+viw==
X-Received: by 2002:a62:78c2:: with SMTP id t185mr8417912pfc.142.1560229361712;
        Mon, 10 Jun 2019 22:02:41 -0700 (PDT)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id p27sm8707081pfq.136.2019.06.10.22.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 22:02:41 -0700 (PDT)
Subject: Re: [PATCH] NCR5380: Support chained sg lists
To:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <739c214bafcb9af3f6d5037cc03f57f692966675.1560223509.git.fthain@telegraphics.com.au>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a1fe2d99-fc2f-c12d-41fe-025ee1f66c0b@gmail.com>
Date:   Tue, 11 Jun 2019 17:02:36 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <739c214bafcb9af3f6d5037cc03f57f692966675.1560223509.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Thanks - can't test this on my hardware but looks good to me.

Cheers,

	Michael

Am 11.06.2019 um 15:25 schrieb Finn Thain:
> My understanding is that support for chained scatterlists is to
> become mandatory for LLDs.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/scsi/NCR5380.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index d9fa9cf2fd8b..536426f25e86 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -149,12 +149,10 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
>
>  	if (scsi_bufflen(cmd)) {
>  		cmd->SCp.buffer = scsi_sglist(cmd);
> -		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
>  		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
>  		cmd->SCp.this_residual = cmd->SCp.buffer->length;
>  	} else {
>  		cmd->SCp.buffer = NULL;
> -		cmd->SCp.buffers_residual = 0;
>  		cmd->SCp.ptr = NULL;
>  		cmd->SCp.this_residual = 0;
>  	}
> @@ -163,6 +161,17 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
>  	cmd->SCp.Message = 0;
>  }
>
> +static inline void advance_sg_buffer(struct scsi_cmnd *cmd)
> +{
> +	struct scatterlist *s = cmd->SCp.buffer;
> +
> +	if (!cmd->SCp.this_residual && s && !sg_is_last(s)) {
> +		cmd->SCp.buffer = sg_next(s);
> +		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> +		cmd->SCp.this_residual = cmd->SCp.buffer->length;
> +	}
> +}
> +
>  /**
>   * NCR5380_poll_politely2 - wait for two chip register values
>   * @hostdata: host private data
> @@ -1670,12 +1679,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>  			    sun3_dma_setup_done != cmd) {
>  				int count;
>
> -				if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
> -					++cmd->SCp.buffer;
> -					--cmd->SCp.buffers_residual;
> -					cmd->SCp.this_residual = cmd->SCp.buffer->length;
> -					cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> -				}
> +				advance_sg_buffer(cmd);
>
>  				count = sun3scsi_dma_xfer_len(hostdata, cmd);
>
> @@ -1725,15 +1729,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>  				 * scatter-gather list, move onto the next one.
>  				 */
>
> -				if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
> -					++cmd->SCp.buffer;
> -					--cmd->SCp.buffers_residual;
> -					cmd->SCp.this_residual = cmd->SCp.buffer->length;
> -					cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> -					dsprintk(NDEBUG_INFORMATION, instance, "%d bytes and %d buffers left\n",
> -					         cmd->SCp.this_residual,
> -					         cmd->SCp.buffers_residual);
> -				}
> +				advance_sg_buffer(cmd);
> +				dsprintk(NDEBUG_INFORMATION, instance,
> +					"this residual %d, sg ents %d\n",
> +					cmd->SCp.this_residual,
> +					sg_nents(cmd->SCp.buffer));
>
>  				/*
>  				 * The preferred transfer method is going to be
> @@ -2126,12 +2126,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
>  	if (sun3_dma_setup_done != tmp) {
>  		int count;
>
> -		if (!tmp->SCp.this_residual && tmp->SCp.buffers_residual) {
> -			++tmp->SCp.buffer;
> -			--tmp->SCp.buffers_residual;
> -			tmp->SCp.this_residual = tmp->SCp.buffer->length;
> -			tmp->SCp.ptr = sg_virt(tmp->SCp.buffer);
> -		}
> +		advance_sg_buffer(tmp);
>
>  		count = sun3scsi_dma_xfer_len(hostdata, tmp);
>
>
