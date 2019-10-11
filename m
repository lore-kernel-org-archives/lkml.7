Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A30C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6771214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GznRhmLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfJKTBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:01:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40806 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfJKTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:01:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so6300154pgl.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=snyWrZAMzq5lG4lRitPx2HIrUxhSjSwDEgHLW43m85M=;
        b=GznRhmLrbiSnSNMpKRKnZtnlVJUIMgZ5Igqj7k9gAh6/KvPPfvWFNm4bhCg1Mjmon4
         QWfPt7fCzGhhjewfN7/xsx1noFZf/yGyTuHATAyzBFFdqKhf3aUtwrWOl4/GAHGDz7wN
         m95NHX/mg+2ktdRy+xO5ADuqFShgN1Fh+GuTUMvkFeJ5230WGT1RQ6hHyY5er+XwKBVZ
         oHeE102rEFQdllfnccTjWkHAtgT3oTF5lt+iFboSsSp8ux7FNO64p0/Qbk/zDYcS8szC
         6edlryYvHz1TGfH/ZKKmM956bYuizF4DOVQLn9Vo9qfQo2AVRfqN/PYmw8aKHsj3gfOm
         SVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=snyWrZAMzq5lG4lRitPx2HIrUxhSjSwDEgHLW43m85M=;
        b=Gz8nbXe2vKPueUyPP/laR6ZtIK+HHUcMSWWgYghZjmfRqSWZdBh2Yq/7Y82Sdmiviz
         kw9uxYr90QI2ApsA3aEqsoAQm73PgZtr2wsabzu/WlsBVY40sXK+Mqi3ns0UEJOKYKbd
         4KUoLfXDqwojLCSp0WhSChjRSrzFGOy66xdQk+0x7rX7KxsvOFvXms4vyTBBNbJLrDqo
         y4n93Fi9WV0aZyYDm/UAO4cH2hni8ZjgfGf7S+MT26qlvyCpGuevwLwZoKc7R6iQCmOE
         ZfztehVadsYOlxhot/xtbLvObhRKva5SKdwzD7jOFzP32VFEBQHVKOlMPfMEZOFW2/dr
         WNbA==
X-Gm-Message-State: APjAAAWzfq3mELALei5AxfDrmJeh0H7gfkB91TWxp9fM+m4VoYwZxfYV
        F4vXpUwr4qKg8+JQn7IaBaY=
X-Google-Smtp-Source: APXvYqyNO2jGjTM35Zx7/wYo2IA/ONK6kVXQIM80NOoaCi6xPGZ50ucYajK+oHsuTMe+0WILniPrqg==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr19140199pjs.96.1570820506438;
        Fri, 11 Oct 2019 12:01:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q13sm11663683pfn.150.2019.10.11.12.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 12:01:45 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:01:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] ASoC: fsl_mqs: Move static keyword to the front
 of declarations
Message-ID: <20191011190105.GA18114@Asurada-Nvidia.nvidia.com>
References: <20191011105606.19428-1-yuehaibing@huawei.com>
 <20191011143538.15300-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011143538.15300-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:35:38PM +0800, YueHaibing wrote:
> gcc warn about this:
> 
> sound/soc/fsl/fsl_mqs.c:146:1: warning:
>  static is not at beginning of declaration [-Wold-style-declaration]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> v2: Fix patch title
> ---
>  sound/soc/fsl/fsl_mqs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index f7fc44e..0c813a4 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -143,7 +143,7 @@ static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
>  				   MQS_EN_MASK, 0);
>  }
>  
> -const static struct snd_soc_component_driver soc_codec_fsl_mqs = {
> +static const struct snd_soc_component_driver soc_codec_fsl_mqs = {
>  	.idle_bias_on = 1,
>  	.non_legacy_dai_naming	= 1,
>  };
> -- 
> 2.7.4
> 
> 
