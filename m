Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D67C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032D20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+/I1I4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:04:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46463 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:04:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id g12so15198073lfb.13;
        Fri, 08 Mar 2019 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzpGHxOhuzmCwQUu597Gv7oDndytfHCGzFPVLQY4IFA=;
        b=B+/I1I4+hN5w9W+NXDls4bzmW1aAwnzVZaMWn6LaxwYALMIzp3hay5RJ6PVOeNd8RO
         WV1L2crUu19EhflyVBkYshLOoi8NrZ8SGk2TjfDfWlWtpfU+2FsDEGhKL1rwNSV/bo2h
         2qvVgKGCRJfKZ9MPoQpEcW8zR8BcFCrOJaZqfl589dwZULwulOAEyJDbo1hkOLOdMvUD
         ir4HYeavDRpdrda/sp30oQ7Yb6ZEW9yPCrCyu6GgMYzruzCTdevlT0CLhCHdvnig5/s/
         jcP6qsYbsYLqxcDUZXCe/73qybquphjzqUbeVG2tOs+Lvj7m9hH6YhXlPl3ehMqIouaB
         ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzpGHxOhuzmCwQUu597Gv7oDndytfHCGzFPVLQY4IFA=;
        b=oW5luJwWQ/Bn1ghPW280GB96NE2IJE+4OnACN+pfJTDsgnzCIYzc5Yo6IVy6DNySrX
         Q1EHFrCNZwKo/Bf/Itfex0Nu91/DxkxgDLDR45Jqr+ZPOYpIn/VhwsU/199YkjG3Aw9M
         rgfgyQeuHfwwNKKVtnhSTEy1vywXIZIP3nYM7IjW/VMpiEmB4/rarNJfPW8khJltT55j
         4Fa1UmYgUCoFJNh45CHXaCXUx0QnCoXT/1pC8Pj51kJO/Sa0S0L0i0800O/LPaCbsCC9
         LTo0YBkGwAe5iZrRRlb/sgqrvCHN42KeBwkBGjg59973J++4MCv++JS+Y4B8vYjYDlzc
         vNmQ==
X-Gm-Message-State: APjAAAVOUelfFlmVStta+9/bWsUfV0ZpMqFeMcsQOxt7mLFKEsN9OW5y
        ckkjclFVxRDilqwebXee/+s=
X-Google-Smtp-Source: APXvYqz5N9knG9ed4kDk5i+mid/AmhcIA72PvJvs4IoGL0zILtIxJY6aCl/PuchSc6qWujo4C5C8Yg==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr10980469lfc.1.1552079092088;
        Fri, 08 Mar 2019 13:04:52 -0800 (PST)
Received: from localhost (89-64-60-178.dynamic.chello.pl. [89.64.60.178])
        by smtp.gmail.com with ESMTPSA id u26sm1647476lfi.41.2019.03.08.13.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 13:04:51 -0800 (PST)
Date:   Fri, 8 Mar 2019 22:04:26 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 1/4] iio:potentiostat:lmp91000: remove unnecessary
 parentheses
Message-ID: <20190308210425.GB32641@arch>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
 <20190308194655.5983-2-anderson.reis.rosa@usp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308194655.5983-2-anderson.reis.rosa@usp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 04:46:52PM -0300, Anderson Reis wrote:
> From: Lucas Oshiro <lucasseikioshiro@gmail.com>
>
> Remove unnecessary parentheses on line 116, and solve these checkpatch.pl

No need to explicitly point finger at changed lines. This is what
context lines are for.

> CHECKs:
>
> - lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
> - lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> ---
>  drivers/iio/potentiostat/lmp91000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 90e895adf997..03d277621861 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -113,7 +113,7 @@ static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
>  		return -EINVAL;
>
>  	/* delay till first temperature reading is complete */
> -	if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
> +	if (state != channel && channel == LMP91000_REG_MODECN_TEMP)
>  		usleep_range(3000, 4000);
>
>  	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
> --
> 2.20.1
>
