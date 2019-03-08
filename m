Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E820684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2K8o0lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfCHSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:41:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35152 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCHSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:41:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so18276829lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylm4GGs3k69mm0+P+ifUy0mBRCQkvW6nh2imUsERxTE=;
        b=m2K8o0lwm2cn6XcnlMgeBG4Jjzvuf3HwhgVrodtW0wNnips1msVCcWUZrjHD0WTs1o
         FQxktq+9GaVktGO7Cksbp6egpjLjb2GVxOwIijKJbWVf8Vitwg9AOC8q/hmSsk6GVt8R
         UYdPksA45A2I5WTdOtBGHJDrYtbHtroRkpmYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylm4GGs3k69mm0+P+ifUy0mBRCQkvW6nh2imUsERxTE=;
        b=YUE1YoWzX9vO0qCmwskTzJjUEkpwgqp3Rgw2I9tqBuPk8bgTbwKk6EdrFqDaXoY1a0
         dEX83Sv6NIpvD3me4CoXCXHLvE1fDNCBzk3nFD9KjZ18W7tnnjzKifs0aICZAJP0Bnhe
         EZgIJGtw10NoFWHpZGZjXNAdz1EqJYN0tQ4r/QP6hGP58ispnLVbxY7PdfkXJ1OjYnoC
         TjRuY3MTCKhii4sZ/yOw5WZ6lFmUPOAMavGvSxAu7u1ePDAwODJzmJLSFbjCrBEwIimA
         fcg0RdU7FtTJk/BtBzHazQC/fL/2t6DxmTdYb53pZz4ghVLYwNG4rNLvRPYB4pq6Md74
         DBCQ==
X-Gm-Message-State: APjAAAUHe5krNqFY24b4x0YPTAmfvFx+ASueWIzFz2zXCitMKglEykFc
        +j/KiRPpM3y1pSo0MSHriewt3/NoU5Y=
X-Google-Smtp-Source: APXvYqxNdq25V2LzcnL69vOmBO8ebxQX4UQevh9AlCZoFLWEUNAuGOUZBALhdxmR2lv7u8gL7t8+QA==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr8620274ljj.69.1552070478435;
        Fri, 08 Mar 2019 10:41:18 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o12sm1540954ljc.37.2019.03.08.10.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:41:17 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id t13so18276756lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:41:16 -0800 (PST)
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr10484072ljk.64.1552070476417;
 Fri, 08 Mar 2019 10:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20190208172152.1807-1-georgi.djakov@linaro.org> <20190208172152.1807-2-georgi.djakov@linaro.org>
In-Reply-To: <20190208172152.1807-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 8 Mar 2019 10:40:40 -0800
X-Gmail-Original-Message-ID: <CAE=gft7uKN_EXqkuPvu+sSmJU69Le18yfqHcfmFApUHQyaBZ-Q@mail.gmail.com>
Message-ID: <CAE=gft7uKN_EXqkuPvu+sSmJU69Le18yfqHcfmFApUHQyaBZ-Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] interconnect: Add support for path tags
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, daidavid1@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 9:21 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Consumers may have use cases with different bandwidth requirements based
> on the system or driver state. The consumer driver can append a specific
> tag to the path and pass this information to the interconnect platform
> driver to do the aggregation based on this state.
>
> Introduce icc_set_tag() function that will allow the consumers to append
> an optional tag to each path. The aggregation of these tagged paths is
> platform specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c           | 27 +++++++++++++++++++++++----
>  drivers/interconnect/qcom/sdm845.c    |  2 +-
>  include/linux/interconnect-provider.h |  4 ++--
>  include/linux/interconnect.h          |  5 +++++
>  4 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 6005a1c189f6..31eacd0f5349 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -42,10 +42,12 @@ struct icc_req {
>
>  /**
>   * struct icc_path - interconnect path structure
> + * @tag: path tag (optional)
>   * @num_nodes: number of hops (nodes)
>   * @reqs: array of the requests applicable to this path of nodes
>   */
>  struct icc_path {
> +       u32 tag;
>         size_t num_nodes;
>         struct icc_req reqs[];
>  };
> @@ -206,7 +208,7 @@ static struct icc_path *path_find(struct device *dev, struct icc_node *src,
>   * implementing its own aggregate() function.
>   */
>
> -static int aggregate_requests(struct icc_node *node)
> +static int aggregate_requests(struct icc_node *node, u32 tag)
>  {
>         struct icc_provider *p = node->provider;
>         struct icc_req *r;
> @@ -215,7 +217,7 @@ static int aggregate_requests(struct icc_node *node)
>         node->peak_bw = 0;

For my suggestion in patch 2, this is where you'd need the callback to
reset the SLEEP/WAKE shadow aggregation buckets that the provider is
keeping, since the core just reset the values here. I wonder if you'd
want to pass the &node->avg_bw and &node->peak_bw in with this
callback as well... not sure if that's useful. Something like:

        if (p->begin_aggregation)
                p->begin_aggregation(node);

>
>         hlist_for_each_entry(r, &node->req_list, req_node)
> -               p->aggregate(node, r->avg_bw, r->peak_bw,
> +               p->aggregate(node, tag, r->avg_bw, r->peak_bw,
>                              &node->avg_bw, &node->peak_bw);

Wait I'm confused. The tag is associated with a particular path. But
now aren't you looping over all the other requests and coloring them
with whatever tag this is? Don't you need to store the tag with the
request, and then pass r->tag for each r rather than the tag from
whichever request happened to initiate the re-aggregation?

>
>         return 0;
> @@ -396,6 +398,23 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>
