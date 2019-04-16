Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600FBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295E220868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnXlMowR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfDPHta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:49:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39884 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfDPHta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:49:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id d5so6413622uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1URUvFC+k98C9AYaqeiQs7T2+ovEiN+2yKlco1Ij/EM=;
        b=rnXlMowRiUiH21A8ViBdrw6hKItMjbSI5wBEHG59AIrE2LpwN+dpUWR2AD/mz1HZdE
         M1cQ3vUgrZp6OpBG8Hcl1aNQZ8Tdb/ppw3kNj2/qbv/A08RGYHmgn7O7oVCGrQcnlCPY
         2yVXSanTsQM0DlCbZtCDb9uI8aRpsK3LDFyu++1XOLhP5KCHJ1VELFxZTA7YEhF1B4dl
         VwYaFONGMLe8FdWYJ7qULK2b1Ez/74mgpwk1+Ty2meKqUwFjp0OrayMyuxqk1ryG7lXi
         D+3yMKB3WAsiQrEDrgfosdEloChtoArD4xeYAfn1xfu6flqwlzUQd8T/nAMq+dm3GKRJ
         JNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1URUvFC+k98C9AYaqeiQs7T2+ovEiN+2yKlco1Ij/EM=;
        b=iXQKrUi7aa+tWlNmQhS+F/MH7QMOUy5WwVoXOjQZa1JjwVDt48A+Bg88ifNPGD/TX/
         1CV8ZkhGwXpBP/Wr5iTIJQwGZBARH51yRWl9A/DI8X1hd13QbzTjuJ4E8DonqSE/rhvs
         bwAiBPmX3PnNf2ChylBZUlIm8NmY0usGcekoP9AC2omu0JRbqAOb3reQcHdejcJN8KAk
         lekZiyW/qHVoCaO1tF6JuQGGepGrqbL5ms6hOUB0/s2ucDAXYX1hKUW6gZwiwpth6BJU
         PsazW/l6dPt2mNFLowiu6YHgHai4hzmuLn2TyZkVCstGdQGCxBrhZKrgFpyRsubZj/6b
         pVmA==
X-Gm-Message-State: APjAAAXcR3poTgvuiM2yngid47kEOvsFGJaZSzvVljgIYKUJWprxJplg
        PTvQUrqG5yvCkiz1aNk+/ayyH2QkrtiTLD2GMbQJCQ==
X-Google-Smtp-Source: APXvYqxEdFX67ZJQPDCZmeOOpEoHHg2SCFtlpLuOfnf5KqHJzKuDMlVPTN9GWTgJSZo+q22u7xTqjOcGTY0ojZM58bY=
X-Received: by 2002:ab0:7486:: with SMTP id n6mr16764768uap.66.1555400968811;
 Tue, 16 Apr 2019 00:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190412093434.GA24516@amd>
In-Reply-To: <20190412093434.GA24516@amd>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Apr 2019 09:48:51 +0200
Message-ID: <CAPDyKFo2cZOqyCqBaZJzReaWfMenn6zgHcpCpf+XfegwqwNKxQ@mail.gmail.com>
Subject: Re: [PATCH] Fix warning and undefined behavior in mmc voltage handling
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        Trivial patch monkey <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 11:34, Pavel Machek <pavel@ucw.cz> wrote:
>
> !voltage_ranges is tested for too late, allowing warning and undefined
> behavior. Fix that.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Pavel, thanks for your patch.

Would you mind re-posting to linux-mmc so I can get it into the
patchtracker. Please also change the prefix of the header to "mmc:
core:".

Otherwise this looks good to me.

Kind regards
Uffe

>
> ---
>
> Plus I guess author should add parenthesis in the expression. a / b /
> c is _not_ common idiom.
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..b3fa9c9 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>         int num_ranges, i;
>
>         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> -       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!voltage_ranges) {
>                 pr_debug("%pOF: voltage-ranges unspecified\n", np);
>                 return 0;
>         }
> +       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!num_ranges) {
>                 pr_err("%pOF: voltage-ranges empty\n", np);
>                 return -EINVAL;
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
