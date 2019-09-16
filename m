Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9C2206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsJQjfcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfIPXLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:11:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44210 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPXLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:11:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so833041pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vXYdGqPDZM+NPePS/5Jwb2aUiY74/dpzWm8plNldnis=;
        b=AsJQjfcODTLEi6ISfaOneaEzIWhMD6r3I+rK2M1rqWhbEnZQQxOfEsKkizJEDoBVod
         h0GkT3gp7m0FsrwodxPrwAVP181bkD0Qbd0zLdGvPpkLL4ALUG79yb5UAv81e4JyluuC
         oFtuLbLvcNAiFFENdP4XxwVYmQ//UUTDMDVhmN1IFU4ibpJYaH9uB4+FbkrZu4Hu004E
         xvTHKuflAaX/Sw6D9PoaiXJMcnmOhla58gHqyC7NQNP67uozbGPyrfLQwDox4G139mna
         TgG+rO990M89Mvd1NMf/vcfJasYyG+lDCDxWCKLMvROd1pX7DrngJWTs5Y1reXHuE/M5
         jbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXYdGqPDZM+NPePS/5Jwb2aUiY74/dpzWm8plNldnis=;
        b=txDwkME1peSVY9bszlYzHKhlM8lE2H4smSjTx+QHYqnEclAQLfWXjZCKjhKnWnaQMA
         yGCA2CytM9N2R4eyRoFRJ8i4wwuAoR923t70Q9A6Uh7U1x6AWCpSyxhXmujp/gDa9kjR
         H4YNvhTvBCX8s5w8w3Dx3x8oiw1XJzhr7iN1l71nykVmxzuqq4T5QdII71sJgNZABDe7
         BGpiTK5VR+ig4Kb0hdHxO5kfdg7bcjnLuhvjYDtDDg65FCINOyeNHGfyC8z75eVfKCjo
         8ESKYxdEi2NKwuUPrsiLKbRQpLCH8YMSpbu7l11KFbzt7IFceOIXNA30bgBBYVjnIf5R
         ubsg==
X-Gm-Message-State: APjAAAUqZO3VAI1MtoFw9jOK5HgBgdzk9DnoVl4kAN4cZcUWg3MZFiWQ
        ni/bbW0b0yYSxolXxPFBjUk=
X-Google-Smtp-Source: APXvYqxvfpv6SgXSwE0epprq0vUNZdDpJT1erTYjGihUH8dkTrdAZLrZ2NaOfexshSPpoutWjitWsQ==
X-Received: by 2002:a17:90a:ca05:: with SMTP id x5mr1740392pjt.66.1568675494336;
        Mon, 16 Sep 2019 16:11:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v12sm152839pgr.31.2019.09.16.16.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 16:11:34 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:11:15 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_sai: Fix TCSR.TE/RCSR.RE in synchronous
 mode
Message-ID: <20190916231115.GD12789@Asurada-Nvidia.nvidia.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
 <20190913192807.8423-4-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913192807.8423-4-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On Fri, Sep 13, 2019 at 10:28:07PM +0300, Daniel Baluta wrote:
> The SAI transmitter and receiver can be configured to operate with
> synchronous bit clock and frame sync.
> 
> When Tx is synchronous with receiver RCSR.RE should be set in playback
> to enable the receiver which provides bit clock and frame sync.
> 
> When Rx is synchronous with transmitter TCSR.TE should be set in record
> to enable the transmitter which provides bit clock and frame sync.

I don't quite get what this patch fixes....can you explain?

> @@ -539,8 +539,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
>  
>  	/*
> -	 * It is recommended that the transmitter is the last enabled
> -	 * and the first disabled.

This is copied from iMX6SX Reference Manual, IIRC...And I just
took a look at iMX8DXP/QXP RM: it has the exact same statement
in "16.16.3.3.1 Synchronous mode" section.

> +	 * it is recommended that the asynchronous block to be the last enabled
> +	 * and the first disabled

So... why are we changing to this? Any update/explain?

Thank you
