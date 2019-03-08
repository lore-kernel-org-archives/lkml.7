Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A5420868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bt8QeK6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfCHSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:36:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39698 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfCHSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:36:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id m13so1460405lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AX8IcMRfKsa3xPGnO2FE2GyE4Gfzqkce/slKXcRL/k=;
        b=Bt8QeK6jCxaNg6lMN/af4aCbeQ/lYuHnuCTHTbYYixBzOBD4AycuJslj3lKXglhyDa
         +9RxipOMOpoZsA9hg8CJEFTtXaJEYOA5OGyMK+wwgyUw61ZDbFkQ+TIysD+XoQfjQyNH
         yHmzUkbq6dKFF7mBPpwOp3P8q1yFETBxXtfSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AX8IcMRfKsa3xPGnO2FE2GyE4Gfzqkce/slKXcRL/k=;
        b=WYg6O7thbmsqG4S1Zl7wdiX+HoPTfuaVCf0USWVQ6AXTw5/UogE3OGanvY6zyWZv4q
         y8anaCBhsYq3J3h7j//tzwGv5apT8dL1lx46S7XccBq2LPyGGuuhOr/YK3nkvaiYS74g
         4TwWXARF+aRDXoopk6QtCOYEXp455EQWP7vij0qk7kDSl7EVFJiyeTXfYqh4xq9pHT45
         ZlQm/qVkX9f6pUFju9+RQi1zLtfZiqqX0WOr9i4PcqwW+7WDqigUeUPUT584X8+WtmWr
         WSEZvqc8X1v8MpCqwJHAl7Upzi6KlNC4WbS1MJMrUQpROGJfkVge0vjN7mpiW6omEy5b
         YbLg==
X-Gm-Message-State: APjAAAWw2de30GEbYvpTP9QjUWduAGUVoV3fkwXtqy33G0RaDDijGa2N
        AVHev2NH+Bk7R79FDRIKdT+2LLRjOLY=
X-Google-Smtp-Source: APXvYqzl0jlTJromxXBKgIgTobjwsGBIDiz49JoT2M52rBCc+is4CHnsIi3cDDYHR57SmTUO7Ekw0A==
X-Received: by 2002:a19:d4cf:: with SMTP id l198mr2714721lfg.151.1552070168134;
        Fri, 08 Mar 2019 10:36:08 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 13sm1670786lju.27.2019.03.08.10.36.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:36:06 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m13so1460325lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:36:06 -0800 (PST)
X-Received: by 2002:ac2:5228:: with SMTP id i8mr10887858lfl.162.1552070165462;
 Fri, 08 Mar 2019 10:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20190208172152.1807-1-georgi.djakov@linaro.org> <20190208172152.1807-3-georgi.djakov@linaro.org>
In-Reply-To: <20190208172152.1807-3-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 8 Mar 2019 10:35:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft47bF-zJReobnUnsVGtiMCMqz4jWZLDWdMJ5qRUL+PH7g@mail.gmail.com>
Message-ID: <CAE=gft47bF-zJReobnUnsVGtiMCMqz4jWZLDWdMJ5qRUL+PH7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
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

On Fri, Feb 8, 2019 at 9:22 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add support for wake and sleep commands by using a tag to indicate
> whether or not the aggregate and set requests are active only or
> dual context for a particular path.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index fb526004c82e..13499f681160 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -65,6 +65,12 @@ struct bcm_db {
>  #define SDM845_MAX_BCMS                30
>  #define SDM845_MAX_BCM_PER_NODE        2
>  #define SDM845_MAX_VCD         10
> +#define SDM845_MAX_CTX         2
> +#define SDM845_EE_STATE                2
> +#define EE_STATE_WAKE          0
> +#define EE_STATE_SLEEP         1
> +#define AO_CTX                 0
> +#define DUAL_CTX               1
>

I get really lost with these two sets of numbers here. I think this
needs some explanation in the comments. From staring at this what I've
understood so far is:
1) Clients pass in a tag that buckets their requests into either AO or
DUAL within the node. (Although, the requests all seem to get
aggregated together no matter what the tag is, more on that later).
2) During icc_set(), we go through the many-to-many mapping of BCMs to
nodes. For each BCM, we aggregate all the nodes it has, bucketed again
by AO or DUAL.
3) The actual votes sent to RPMh are in terms of WAKE and SLEEP.
4) The mapping from AO/DUAL to WAKE/SLEEP for a particular BCM is:
WAKE = AO+DUAL, SLEEP=DUAL.
5) qcom_icc_set() sends EE_STATE_WAKE stuff to RPMH_ACTIVE_ONLY_STATE.
6) If there's any difference between SLEEP and WAKE, then the
EE_STATE_WAKE commands are gathered together and sent to
RPMH_WAKE_ONLY_STATE, and all the EE_STATE_SLEEP commands are sent to
RPMH_SLEEP_STATE.

So ultimately the muxing ends up like
RPMH_ACTIVE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL
RPMH_SLEEP_STATE <-- EE_STATE_SLEEP <-- DUAL
RPMH_WAKE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL

Why do we need this complicated muxing to happen? Is it because we're
trying to avoid requiring drivers to specify three different paths in
the simple case, when all they care about is "use this bandwidth all
the time"?

What I think would make more sense would be to use the "tag" as a
bitfield instead. So you'd have

#define QCOM_ICC_TAG_ACTIVE_ONLY 0x00000001
#define QCOM_ICC_TAG_SLEEP 0x00000002
#define QCOM_ICC_TAG_WAKE 0x00000004
#define QCOM_ICC_TAG_ALL_TIMES (QCOM_ICC_TAG_ACTIVE_ONLY |
QCOM_ICC_TAG_SLEEP | QCOM_ICC_TAG_WAKE)

Drivers that don't care about sleep/wake sets would just not set a
tag, or set a tag of QCOM_ICC_TAG_ALL_TIMES. Then in
qcom_icc_aggregate(), you aggregate the same values up to three times,
one for each bit they have set. Finally in qcom_icc_set, you can pass
the votes directly down in their buckets, without doing a weird
mapping from AO/DUAL to SLEEP/WAKE/ACTIVE_ONLY.

The sticky part about this is that now rather than one set of sum/peak
values, there are now three independent ones, corresponding to each of
the tag bits. It seems like the interconnect core wouldn't want to
mandate whether providers use the tag as a bitfield or a value. So the
provider would need to keep not only the official set of aggregates
that are returned back to the core (probably ACTIVE_ONLY, or maybe a
max of the three), but also the two shadow copies internally for SLEEP
and WAKE.

If you organized the tag that way, the only extra thing you'd need is
a callback to the provider just before the core starts aggregation, so
that the provider can reset the shadow buckets to 0 the same way the
core resets the main sum/peak to 0 before looping.With this, we've
plumbed out the full abilities of RPMh to the client drivers, but
without complicating the simple case of "set this bandwidth all the
time". What do you think?

>  /**
>   * struct qcom_icc_node - Qualcomm specific interconnect nodes
> @@ -86,8 +92,8 @@ struct qcom_icc_node {
>         u16 num_links;
>         u16 channels;
>         u16 buswidth;
> -       u64 sum_avg;
> -       u64 max_peak;
> +       u64 sum_avg[SDM845_MAX_CTX];
> +       u64 max_peak[SDM845_MAX_CTX];
>         struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
>         size_t num_bcms;
>  };
> @@ -112,8 +118,8 @@ struct qcom_icc_bcm {
>         const char *name;
>         u32 type;
>         u32 addr;
> -       u64 vote_x;
> -       u64 vote_y;
> +       u64 vote_x[SDM845_EE_STATE];
> +       u64 vote_y[SDM845_EE_STATE];
>         bool dirty;
>         bool keepalive;
>         struct bcm_db aux_data;
> @@ -555,7 +561,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
>                 cmd->wait = true;
>  }
>
> -static void tcs_list_gen(struct list_head *bcm_list,
> +static void tcs_list_gen(struct list_head *bcm_list, int ee_state,
>                          struct tcs_cmd tcs_list[SDM845_MAX_VCD],
>                          int n[SDM845_MAX_VCD])
>  {
> @@ -573,8 +579,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
>                         commit = true;
>                         cur_vcd_size = 0;
>                 }
> -               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
> -                           bcm->addr, commit);
> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[ee_state],
> +                           bcm->vote_y[ee_state], bcm->addr, commit);
>                 idx++;
>                 n[batch]++;
>                 /*
> @@ -595,32 +601,42 @@ static void tcs_list_gen(struct list_head *bcm_list,
>
>  static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  {
> -       size_t i;
> -       u64 agg_avg = 0;
> -       u64 agg_peak = 0;
> +       size_t i, ctx;
> +       u64 agg_avg[SDM845_MAX_CTX] = {0};
> +       u64 agg_peak[SDM845_MAX_CTX] = {0};
>         u64 temp;
>
> -       for (i = 0; i < bcm->num_nodes; i++) {
> -               temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
> -               do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
> -               agg_avg = max(agg_avg, temp);
> +       for (ctx = 0; ctx < SDM845_MAX_CTX; ctx++) {
> +               for (i = 0; i < bcm->num_nodes; i++) {
> +                       temp = bcm->nodes[i]->sum_avg[ctx] * bcm->aux_data.width;
> +                       do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
> +                       agg_avg[ctx] = max(agg_avg[ctx], temp);
>
> -               temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
> -               do_div(temp, bcm->nodes[i]->buswidth);
> -               agg_peak = max(agg_peak, temp);
> +                       temp = bcm->nodes[i]->max_peak[ctx] * bcm->aux_data.width;
> +                       do_div(temp, bcm->nodes[i]->buswidth);
> +                       agg_peak[ctx] = max(agg_peak[ctx], temp);
> +               }
>         }
>
> -       temp = agg_avg * 1000ULL;
> +       temp = agg_avg[AO_CTX] + agg_avg[DUAL_CTX] * 1000ULL;
> +       do_div(temp, bcm->aux_data.unit);
> +       bcm->vote_x[EE_STATE_WAKE] = temp;
> +
> +       temp = max(agg_peak[AO_CTX], agg_peak[DUAL_CTX]) * 1000ULL;
> +       do_div(temp, bcm->aux_data.unit);
> +       bcm->vote_y[EE_STATE_WAKE] = temp;
> +
> +       temp = agg_avg[DUAL_CTX] * 1000ULL;
>         do_div(temp, bcm->aux_data.unit);
> -       bcm->vote_x = temp;
> +       bcm->vote_x[EE_STATE_SLEEP] = temp;
>
> -       temp = agg_peak * 1000ULL;
> +       temp = agg_peak[DUAL_CTX] * 1000ULL;
>         do_div(temp, bcm->aux_data.unit);
> -       bcm->vote_y = temp;
> +       bcm->vote_y[EE_STATE_SLEEP] = temp;
>
>         if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
> -               bcm->vote_x = 1;
> -               bcm->vote_y = 1;
> +               bcm->vote_x[EE_STATE_WAKE] = 1;
> +               bcm->vote_y[EE_STATE_WAKE] = 1;
>         }
>
>         bcm->dirty = false;
> @@ -631,14 +647,16 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  {
>         size_t i;
>         struct qcom_icc_node *qn;
> +       u32 ctx = 0;
>
>         qn = node->data;
> +       ctx = (!!tag) ? AO_CTX : DUAL_CTX;
>
>         *agg_avg += avg_bw;
>         *agg_peak = max_t(u32, *agg_peak, peak_bw);
>
> -       qn->sum_avg = *agg_avg;
> -       qn->max_peak = *agg_peak;
> +       qn->sum_avg[ctx] = *agg_avg;
> +       qn->max_peak[ctx] = *agg_peak;

I'm confused that you seem to aggregate agg_avg and agg_peak
regardless of what the tag is, but then save them into buckets as if
they had been kept separate. Doesn't this just end up as a mish-mash
of all tag aggregates, but whose final value is dependent on the order
of requests? (Said another way, what gets saved into each [ctx] bucket
is the the aggregate of all requests regardless of tag, but only up
until the last request of that tag type was seen.)
