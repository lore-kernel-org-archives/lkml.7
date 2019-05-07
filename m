Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E547205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbgXMp/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEGOxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:53:00 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45026 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEGOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:52:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id j4so13419344ywk.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsBH3/6csQjaE99mExw7IfFXVrloklkX9pCxbhdLh74=;
        b=mbgXMp/1KMUq1BUS9eZLhL8CKZK/DoGo3oNSSBQJjt5C4AfCcTEo8K03NsU2Qd7zzv
         i1JRhvOPD5EL2ftJF3As7EK4mS+lN0tF4wt28QOUQat71TEp+O+AuxHLdfo4pqZKsaEd
         kwR2mE/Oz3X/WeLW9csTbepgqy+SZfKktXiKawhU/AxNsXlehFKBMzYpLLbfwq8wBYcz
         C2+skA0IsJ2gBWmzmU85JpXxQZkyi8l/i5u9L8phzZl2jm+x0qtnOgKdyIOEnO/xl7tL
         ND6f+VSi2LXKf/z2y7f+hft23H3mSAVeIp51nrNe0AOI9ArlI8ew29HZIOTIyj5ziZeU
         T58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsBH3/6csQjaE99mExw7IfFXVrloklkX9pCxbhdLh74=;
        b=tlPsVdXRtJ3E2LmIe8GHB/qRM9eykskvdEbtnuxrV8qcqef/FQunu040cHmZKD2mww
         asUT/NTFs0kjV7F7+T3Ir821UXkywfqqhqcUAGzD/ZG7NoYeMZzHul3MuonMxBZfCjKg
         ammwGBLoS1bBPQYUl380nwhfmw6LUOEsthysab7RcD+3Viq6SXfqZ2x40EAbj/1ckZMj
         axJcwpN2DU8p7IwPIMDz/NXLBB/aVqk1693Hz1AllqZ2OPy1v0GJJOmeDnbP9TwKqNfL
         cly5TqVko1i7r22+Rebr7ZaqdBBss80phj4X+T560sODhwe8gjuRySSfmcYnVtINkif2
         52Ag==
X-Gm-Message-State: APjAAAVdTaPXUC0vebOWvhCm4jbHUaJ/cTD8utHkx8Yr2Fw870Ws/c7l
        97CoDrJ2EXV8IjOLPXFPAdjOCKmcJJksjjzC/WGx8g==
X-Google-Smtp-Source: APXvYqwSOyNWaXXqAR64Yl6lra7e1M+E9ZK/56Uz24VtVymWObkhiXt0imSNWCiPDevrgTPeJxA2O5ZLVLoebp5pxmc=
X-Received: by 2002:a25:5145:: with SMTP id f66mr20397598ybb.151.1557240778588;
 Tue, 07 May 2019 07:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190507044801.250396-1-dianders@chromium.org>
In-Reply-To: <20190507044801.250396-1-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 May 2019 07:52:47 -0700
Message-ID: <CABXOdTcsDU5dSAFWZBAvrOGRa+BokgKi9huGfs=fO4ObCOvnHQ@mail.gmail.com>
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 9:48 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> We'll add a dummy to just return false.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  include/linux/of.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0cf857012f11..62ae5c1cafa5 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -653,6 +653,11 @@ static inline bool of_have_populated_dt(void)
>         return false;
>  }
>
> +static inline bool of_node_is_root(const struct device_node *node)
> +{
> +       return false;
> +}
> +
>  static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
>                                         const char *compatible)
>  {
> --
> 2.21.0.1020.gf2820cf01a-goog
>
