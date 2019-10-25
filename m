Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F55A21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9n9pfj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJYVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:10:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJYVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:10:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so2410957pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4SQYqLXX0XdL1+ct2NCqP0blLyo4HQV7tsLhnLw7hQs=;
        b=M9n9pfj8q7l6P50lkgGdxZehMpVLDK8ZmI6h116XJC4/64SSNK/YYVX+xv3DRF2ivG
         Zzgg3mBivr6x3cWPjemy+EWNbPRXm/iIW8aNbCrb94Ls9MlU5jU/jb0mn3yNCTdBo9Wa
         GmH4WJ6y/7gjeq5BRvdgW8izUhckGGyiGd6AsuGFEcjVRuFiy4McVtTy2Z+/FH/qAd80
         pmDXrACAkqPxzboLhwXjbCgOhhFJ9jplmG2pc5ZjNF2ksSd46aYvZ0QbZ6CgvzGvsiCH
         EPNUqMYwahXzG8Vj/dr8l6pm6uxAspTidvfzU2fWuZvxPsaWFfUfz3wbEzJum84O0QfG
         vMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SQYqLXX0XdL1+ct2NCqP0blLyo4HQV7tsLhnLw7hQs=;
        b=r+P9UDjBn2UHUQHIbiq702cWeauFJnBP9wKs0AbJXGvIq5eL6V+/pp5Zm5Sfe0KpdK
         A3RHXuMFvTGN/rpLHoBYMfrpYKButhdceRocQpb1i5SCXAYfPh+CKxMM2dFI20Ksy+0O
         0El21DX0P4wI37M1Cddd7GRZL494WrgInBaJQkqaROf11Rx0nSbsMRURmZcxFDQABVgM
         CdDJHx1QSej0bfqbCJ4dBQ6cUW8lC/xEdfdYYDSsx1nxYB+OzOJoSsGVSbly2YZRjZjQ
         cTq93M6ujAqkP9s0KjPpD/ARWSD4SfGval3VgKTt+2yt9fKiBzue65TLvxPgxCEx1ZLf
         ewwQ==
X-Gm-Message-State: APjAAAWQwOL14fXNpfe+mTxqbRlj1fsqiD40fm5AwoO6HRUwRegW8Lam
        bXFLU1wqH+muHgA/AWayRzE=
X-Google-Smtp-Source: APXvYqzzjTnv2D4OYrUqWzMN8fCAnpjvEbjHAwrTNhaiVf/2Enfk58DhQ/EGZoxwOZADuV5bHAi7cw==
X-Received: by 2002:a63:e056:: with SMTP id n22mr6675498pgj.73.1572037836935;
        Fri, 25 Oct 2019 14:10:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z13sm3550450pfg.172.2019.10.25.14.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 14:10:36 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:10:14 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ASoC: fsl_esai: Add spin lock to protect reset, stop
 and start
Message-ID: <20191025211013.GA15101@Asurada-Nvidia.nvidia.com>
References: <36e1d0157d2b71985b88e841d416d04c584c04fe.1571986436.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e1d0157d2b71985b88e841d416d04c584c04fe.1571986436.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:13:53PM +0800, Shengjiu Wang wrote:
> xrun may happen at the end of stream, the
> trigger->fsl_esai_trigger_stop maybe called in the middle of
> fsl_esai_hw_reset, this may cause esai in wrong state
> after stop, and there may be endless xrun interrupt.
> 
> This issue may also happen with trigger->fsl_esai_trigger_start.
> 
> So Add spin lock to lock those functions.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Some small comments inline. Once they are addressed, please add:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
> Change in v2
> -add lock for fsl_esai_trigger_start.
> 
>  sound/soc/fsl/fsl_esai.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 37b14c48b537..9b28e2af26e4 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -33,6 +33,7 @@
>   * @fsysclk: system clock source to derive HCK, SCK and FS
>   * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @task: tasklet to handle the reset operation
> + * @lock: spin lock to handle reset and stop behavior

Should be "between hw_reset() and trigger()" now.

>   * @fifo_depth: depth of tx/rx FIFO
>   * @slot_width: width of each DAI slot
>   * @slots: number of slots
> @@ -56,6 +57,7 @@ struct fsl_esai {
>  	struct clk *fsysclk;
>  	struct clk *spbaclk;
>  	struct tasklet_struct task;
> +	spinlock_t lock; /* Protect reset and stop */

We can drop the comments here since you add it to the top.
