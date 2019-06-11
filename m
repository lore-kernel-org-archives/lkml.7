Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9EC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD3B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhOuZSIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436469AbfFKXsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:48:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32826 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbfFKXsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:48:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id k187so7338312pga.0;
        Tue, 11 Jun 2019 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rQZeUVQ6RxiqAEW7WsFNWPKzRIxBC2e622V0NwiVfj8=;
        b=JhOuZSIwFe0oFF53PYSrxKAUzLnKxYXF3enN5K3WkjEWNf5o+aXe08SIYrulbIEm6p
         2LnH4OE/iXxG8SSqIT3JTjm8mUhsly1+F2TM+80en7Tu27EufyPEku/INQgwkNsGLAS8
         L52ox5SXXIWN35Cnv41YbI/v0AKFWXmBzgJIu9D4bvdd4jOc7fw0OAhj4maK9UhmXi6G
         xpbKcP4jF7f6eWuzyD4kbeoOPEOd/dMrgEryHTDwFtMrDGUhdPOCTIqzG239oezkIpPO
         +RS5ERit+Kc+g5b26QU+lM8DKzSFvWKdiW72LNu1ii7xoBHTrKVkJHTIq71j93XyHAEZ
         hV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rQZeUVQ6RxiqAEW7WsFNWPKzRIxBC2e622V0NwiVfj8=;
        b=KPMH2cBNrXPhr/gSnNq3CZ09wWA/LrAjOoXV2hbYb6uehGWvFugJaMYMILRUXOC9aj
         o+gkDEKE9d83ecXIwvA2ZO9/QHBhLpMPc30CpX4TZa94IOgQZnis/4noMpCK8TssT0oI
         Fv/cGYFWjOC8sOHVou76/tWK+joxJgEbau96Q9AB8hyWqfsZK1KxRKxIq5IS6SAaTs3o
         PEyr1UoCdlx71+B/cfxZCayDy8ckNuLCyZrDgirbBUNgtpnTfS5TjNyOCjohT+XqnujI
         haCVtSsFsZGN4nVK21R/LquLdYYe2YCNeyTcCC72F8AOB5LYyXX86FCkvFXGtZHe6TOn
         eyhw==
X-Gm-Message-State: APjAAAWp7CYKtBucQBMLP6q9HM7nZfkzvIJJUDDdNC+Ffq0WHRLCM+ut
        FueOdU0uLlSI/oU7vew3HnNrDbjq
X-Google-Smtp-Source: APXvYqxUx2Sy7+lan8lwCnaRlwtZHr6H574ZyeXVeqnyPritVWqcquM6Z4UosS7MBUDXGzLtdeF/2Q==
X-Received: by 2002:a63:e250:: with SMTP id y16mr21858926pgj.392.1560296886103;
        Tue, 11 Jun 2019 16:48:06 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:cd5b:7c57:228c:7f0a? ([2001:df0:0:200c:cd5b:7c57:228c:7f0a])
        by smtp.gmail.com with ESMTPSA id i3sm15448121pfa.175.2019.06.11.16.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 16:48:05 -0700 (PDT)
Subject: Re: [PATCH] NCR5380: Support chained sg lists
To:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <739c214bafcb9af3f6d5037cc03f57f692966675.1560223509.git.fthain@telegraphics.com.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a79e01ba-e47c-6b29-3625-29bfb7122ad8@gmail.com>
Date:   Wed, 12 Jun 2019 11:47:56 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <739c214bafcb9af3f6d5037cc03f57f692966675.1560223509.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 3:25 PM, Finn Thain wrote:

> My understanding is that support for chained scatterlists is to
> become mandatory for LLDs.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>   drivers/scsi/NCR5380.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index d9fa9cf2fd8b..536426f25e86 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -149,12 +149,10 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
>   
>   	if (scsi_bufflen(cmd)) {
>   		cmd->SCp.buffer = scsi_sglist(cmd);
> -		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
>   		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
>   		cmd->SCp.this_residual = cmd->SCp.buffer->length;
>   	} else {
>   		cmd->SCp.buffer = NULL;
> -		cmd->SCp.buffers_residual = 0;
>   		cmd->SCp.ptr = NULL;
>   		cmd->SCp.this_residual = 0;
>   	}
> @@ -163,6 +161,17 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
>   	cmd->SCp.Message = 0;
>   }
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
>   /**
>    * NCR5380_poll_politely2 - wait for two chip register values
>    * @hostdata: host private data
> @@ -1670,12 +1679,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>   			    sun3_dma_setup_done != cmd) {
>   				int count;
>   
> -				if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
> -					++cmd->SCp.buffer;
> -					--cmd->SCp.buffers_residual;
> -					cmd->SCp.this_residual = cmd->SCp.buffer->length;
> -					cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> -				}
> +				advance_sg_buffer(cmd);
>   
>   				count = sun3scsi_dma_xfer_len(hostdata, cmd);
>   
> @@ -1725,15 +1729,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>   				 * scatter-gather list, move onto the next one.
>   				 */
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
>   				/*
>   				 * The preferred transfer method is going to be
> @@ -2126,12 +2126,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
>   	if (sun3_dma_setup_done != tmp) {
>   		int count;
>   
> -		if (!tmp->SCp.this_residual && tmp->SCp.buffers_residual) {
> -			++tmp->SCp.buffer;
> -			--tmp->SCp.buffers_residual;
> -			tmp->SCp.this_residual = tmp->SCp.buffer->length;
> -			tmp->SCp.ptr = sg_virt(tmp->SCp.buffer);
> -		}
> +		advance_sg_buffer(tmp);
>   
>   		count = sun3scsi_dma_xfer_len(hostdata, tmp);
>   
