Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C61C606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229612073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnbG1dpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGIFok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:44:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44483 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGIFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:44:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so18642668otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqaZJyYgM0Os8ebMGdlkWjjcPY48Zl3Ke8JX40ALnsw=;
        b=jnbG1dpqI0K+YHq/9S1CeaYEP7TPEOBIvVGhWbP/GwvHf0hUw0j7jJmO2BrWnkkr0q
         rTzbdUNc641u+BMwgQEzAAC35Xy0R1R3oHIE0W4okbM3zaEsBFkdzLQiSTh+JmMzpGGi
         umUsPNbjX7wYWsnzhnSuiCvm9txeL5ajrc6XT8gRo9J4Vj3KBidkZ6AWBzszzmDvfUnb
         0I7u4pCq6i5Nz3vCPZmBuNpeOAGJO/w0ST+jsHQs/i0W7A5thVxLvEpW6KPXYYhxadVY
         OFFDEFCWqMgujbWTVHrfsNxLcwYXRgZaO/4dZNIyI39rQ1GpQYlBsuHMJknNLH58Cs3l
         pSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqaZJyYgM0Os8ebMGdlkWjjcPY48Zl3Ke8JX40ALnsw=;
        b=nVNXQgyTV8nuzGr1j4cCZ3BXQc5gyjtTRArm3Qo38M2Zlloaj+s7IrmE7DOR8gUSZk
         77qoBMppeYHR5HZuXkDxQ8siKnN5tbjLaVYTftE2hVzEVTMtF+NvDa4QfSu3wwmMbV+O
         k86tHtxo1GE8FMjC2hwSDvQjiwQuvU1WLYlAmP3tUzqxxrdyGStKN4Gh9UGvM07Mf5xe
         SRGfHTcUGbswX41UpnDslFw3dUPTyGvbiXSs/TH885xleIJ55lrGAuLL8c7GR1jWKTNq
         HTrby0xCCa7ztwYWM7NB5bMNkReyGIn6xEf8PN2n4cC9VzeWJa/xOXACWAOkQbUuXCdl
         bCQg==
X-Gm-Message-State: APjAAAUzE8pOVDOqnlHDNM+UJGnrUBlx7v3GWY+pWymCF/JFpQO97vdd
        n6IiWE2WcHBYQyT2D0mqX89L6REAKbfMK/M7mco+fQ==
X-Google-Smtp-Source: APXvYqxrhFRqVKYyJq1ZhsiBjelse+AtAmo3grTsG7ZGewv362i4vAyCgqz/v7JpkkyAnIm3AsGpr09SzdI4qPyUoVc=
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr15699382otq.123.1562651079043;
 Mon, 08 Jul 2019 22:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190708123259.11805-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190708123259.11805-1-huangfq.daxian@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 9 Jul 2019 13:44:27 +0800
Message-ID: <CAMz4kuK6FOw2bxPzyrg0014zrU57k1KhUymyTfFYV6pVfw1vdQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] power: supply: sc27xx: Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuqian,

On Mon, 8 Jul 2019 at 20:33, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> devm_add_action_or_reset() is introduced as a helper function which
> internally calls devm_add_action(). If devm_add_action() fails
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice)
> and reduce the likelyhood of bugs.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index 9c184d80088b..58b2970cd359 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -1023,9 +1023,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = devm_add_action(dev, sc27xx_fgu_disable, data);
> +       ret = devm_add_action_or_reset(dev, sc27xx_fgu_disable, data);
>         if (ret) {
> -               sc27xx_fgu_disable(data);
>                 dev_err(dev, "failed to add fgu disable action\n");
>                 return ret;
>         }
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
