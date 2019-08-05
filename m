Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084CC32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430682064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wpyzd4Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfHEQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:05:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42066 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHEQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:05:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so58441445lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61p5AzjQF9OjwcCgDHmk+Gn1Hy4tPflyDpQWg2DQeqY=;
        b=Wpyzd4Y2/nkmPiRjFFM8P8mROdyXEGby1MykkxLW9L1Exfr+0LwcJOAJCMZms0c2Im
         /0Ir/txcMgrbgOV1l8OtAba+XUIKIq55sZqgoSCknx6AWCJpLu+LwC9fDZiEEiRBaHgL
         fqdm4ygFQZzcnCi4raOJMsAdKGJ9l+fKlol/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61p5AzjQF9OjwcCgDHmk+Gn1Hy4tPflyDpQWg2DQeqY=;
        b=O4XGGuR2pNKR6s97sEoj+gE4FMII/7pdfU3d4wNbGJehxB8OFn93iVLY13fZpaW7hy
         dJGxJxOA6kyS6wUsg3T7I7bnnzbcp78iMWxSiSSFxs3h6JI1c7zeCf01H5RJNOnaEzdB
         XcZxCkP1aRtz8QZu5Rm/DKBxX+uPzLUh4aT2mSJ/S7H73mn6KRCtbO0i2nC/gbH/YOMX
         ZZXi5X6YLvtJ81lwe/nNN2J1gm8ji9RLsyIXG6kJG1SNLMj7mqoBDATdq03HTrNYvpu3
         MBZx9bKRXL3C1/4xrGStl+TEdAE525MBThI0GenWTeYUqw+UaPYlRnijbwjwfFORCZ7V
         R7Kg==
X-Gm-Message-State: APjAAAUEzDieMFJa2oG0rnlBPk6zCpLduSD0ikrL5pUCghTAh/2yuhad
        ZuKT0VtomrtiX78uhs28i6Q8lDm+PYQ=
X-Google-Smtp-Source: APXvYqw0cpPKyFbGHZGLhGJh/73gJ0ffZk1LIenE9+jryA3yIXvWePh6TkIDRn1eayt/WALEJjECPg==
X-Received: by 2002:a19:a416:: with SMTP id q22mr3808640lfc.145.1565021121682;
        Mon, 05 Aug 2019 09:05:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d3sm14989360lfb.92.2019.08.05.09.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:05:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 62so53567690lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:05:20 -0700 (PDT)
X-Received: by 2002:a19:cbd3:: with SMTP id b202mr8777985lfg.185.1565021119654;
 Mon, 05 Aug 2019 09:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org> <20190805153332.10047-1-georgi.djakov@linaro.org>
In-Reply-To: <20190805153332.10047-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 5 Aug 2019 09:04:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft48ytM4Bb8iVdE7=mZkum-xx8TBm9=vE1Dj9fxnH7stnQ@mail.gmail.com>
Message-ID: <CAE=gft48ytM4Bb8iVdE7=mZkum-xx8TBm9=vE1Dj9fxnH7stnQ@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Add pre_aggregate() callback
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 8:33 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Introduce an optional callback in interconnect provider drivers. It can be
> used for implementing actions, that need to be executed before the actual
> aggregation of the bandwidth requests has started.
>
> The benefit of this for now is that it will significantly simplify the code
> in provider drivers.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi, I like it! We should confirm that it actually does
allow David to remove the sum_avg_cached and max_peak_cached shadow
arrays.

> ---
>  drivers/interconnect/core.c           | 3 +++
>  include/linux/interconnect-provider.h | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 251354bb7fdc..7b971228df38 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -205,6 +205,9 @@ static int aggregate_requests(struct icc_node *node)
>         node->avg_bw = 0;
>         node->peak_bw = 0;
>
> +       if (p->pre_aggregate)
> +               p->pre_aggregate(node);
> +
>         hlist_for_each_entry(r, &node->req_list, req_node)
>                 p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>                              &node->avg_bw, &node->peak_bw);
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 4ee19fd41568..fd42bd19302d 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -36,6 +36,8 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
>   * @nodes: internal list of the interconnect provider nodes
>   * @set: pointer to device specific set operation function
>   * @aggregate: pointer to device specific aggregate operation function
> + * @pre_aggregate: pointer to device specific function that is called
> + *                before the aggregation begins (optional)
>   * @xlate: provider-specific callback for mapping nodes from phandle arguments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
> @@ -47,6 +49,7 @@ struct icc_provider {
>         int (*set)(struct icc_node *src, struct icc_node *dst);
>         int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
>                          u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
> +       int (*pre_aggregate)(struct icc_node *node);
>         struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
>         struct device           *dev;
>         int                     users;
