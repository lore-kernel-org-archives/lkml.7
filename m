Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5693D20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+VetsYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfHENQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:16:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45756 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbfHENQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:16:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so79185009lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkIX5ZdYnCvGX5CLwyhvH07IjTJLE7wT5hDwDOqSmi8=;
        b=c+VetsYOrNiIQJJpliAISLKJ/GWL4edwcb+Q1umBrs5K2CqC7iONe7O0BHQ0sI8reL
         LnGCQiXHBMPaTiI6j2WwOBYphz4V7sL0xjyN2hzEFoej/Flj0aQNzXhFzjC5tctPqTvn
         TFC+MU3AEWVK5lOCmx9rh866Gw8QyWfsvptHWnkkvASk+WMUhM62ywtYy5dHDnGqw6G7
         E4vcwFN0e3NPyGNZwl1SptWApGQ7mx5lY+/1c+MHFNilKm2m+QGtNhBgVfE0oRvEndwq
         xaQt5htxa8rbVIsSKUOSmCyUtgAF2EbCHGkXoE6vlEvMLIjTOaz+1BdNLZd8XLZbELpu
         m75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkIX5ZdYnCvGX5CLwyhvH07IjTJLE7wT5hDwDOqSmi8=;
        b=tDM1kKOVoVU0dWew+KgQETHYgin2Jb5C0tPgf/cLvmAtLw3b2HBv9gJWMyGKu/F1bN
         eD+MGinaWAmtvW+/3Z8k4uf0ZDeE6dA/cpA9TQa/8c42GNBZs3JV2wEAZzbAL+C4Qt1M
         RdCUoum2A6wHdUeumcdGFpt8HK6gCDyCe5C2YKTFhVLxdyrIvkrvaNP+VMcAJKbNAGMK
         hb/spFbxpvDuqvnuU7Pvx1REDmFBYnc5lRUzhYGgbgDRkJ1JmsDa8KgPr7XvqUN9l7vE
         KEA9ADJrRaSGqdHTUaBeDWuBbEal0L+lIOc6N+K1aBcKYYWqDhjmOtOcpTPBkwtknFYa
         ZlbQ==
X-Gm-Message-State: APjAAAVmJfYpYKSRuZHshZ3C8hh1/vidl30bNmCV/0cAnZ/rie3bIYlR
        ZcHsNzywDIDgS3V1z69zGyddghtoKj22CQc9sl5CfA==
X-Google-Smtp-Source: APXvYqwymn69IcH0rOGNIrvvgwF0wZwLCmIPMON3Ogn2myxNValshmaRxcFgJDU7dUI26rvjavozqHXCbrfbpgc3rdM=
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr7612109ljg.168.1565011012008;
 Mon, 05 Aug 2019 06:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190726135954.11078-1-sudeep.holla@arm.com> <20190726135954.11078-3-sudeep.holla@arm.com>
In-Reply-To: <20190726135954.11078-3-sudeep.holla@arm.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 5 Aug 2019 15:16:41 +0200
Message-ID: <CAN5uoS-dgtz55O+AAxEFkgtijpHj_-NSy7SkNRAkhEJN5v4PWA@mail.gmail.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: Make use SCMI v2.0 fastchannel
 for performance protocol
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Quentin Perret <Quentin.Perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 16:00, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> SCMI v2.0 adds support for "FastChannel" which do not use a message
> header as they are specialized for a single message.
>
> Only PERFORMANCE_LIMITS_{SET,GET} and PERFORMANCE_LEVEL_{SET,GET}
> commands are supported over fastchannels. As they are optional, they
> need to be discovered by PERFORMANCE_DESCRIBE_FASTCHANNEL command.
> Further {LIMIT,LEVEL}_SET commands can have optional doorbell support.
>
> Add support for making use of these fastchannels.
>
> Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
> Cc: Chris Redpath <Chris.Redpath@arm.com>
> Cc: Quentin Perret <Quentin.Perret@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 104 +++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 6cce3e82e81e..b9144efbd6fb 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -8,6 +8,7 @@
>  #include <linux/bits.h>
>  #include <linux/of.h>
>  #include <linux/io.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/sort.h>
> @@ -293,7 +294,42 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
>         return ret;
>  }
>
> -static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
> +#define SCMI_PERF_FC_RING_DB(doorbell, w)              \

Suggest to reformat into a macro style:
    #define SCMI_PERF_FC_RING_DB(doorbell, w)              \
        do { \
                (...) \
        } while (0)

> +{                                                      \
> +       u##w val = 0;                                   \
> +       struct scmi_fc_db_info *db = doorbell;          \
> +                                                       \
> +       if ((db)->mask)                                 \

remove parentheses. I would say, could simply remove `if (db->mask)` here.

> +               val = ioread##w(db->addr) & db->mask;   \
> +       iowrite##w((u##w)db->set | val, db->addr);      \
> +}
> +
> +static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
> +{
> +       if (!db || !db->addr)
> +               return;
> +
> +       if (db->width == 1)
> +               SCMI_PERF_FC_RING_DB(db, 8)
> +       else if (db->width == 2)
> +               SCMI_PERF_FC_RING_DB(db, 16)
> +       else if (db->width == 4)
> +               SCMI_PERF_FC_RING_DB(db, 32)
> +       else /* db->width == 8 */
> +#ifdef CONFIG_64BIT
> +               SCMI_PERF_FC_RING_DB(db, 64)
> +#else
> +       {
> +               u64 val = 0;
> +
> +               if (db->mask)
> +                       val = ioread64_hi_lo(db->addr) & db->mask;
> +               iowrite64_hi_lo(db->set, db->addr);

Is `value` missing here?
Why not using SCMI_PERF_FC_RING_DB(db, 64) here?



> +       }
> +#endif
> +}
> +
> +static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
>                                    u32 max_perf, u32 min_perf)
>  {
>         int ret;
> @@ -316,7 +352,23 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
>         return ret;
>  }
>
> -static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
> +static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
> +                               u32 max_perf, u32 min_perf)
> +{
> +       struct scmi_perf_info *pi = handle->perf_priv;
> +       struct perf_dom_info *dom = pi->dom_info + domain;
> +
> +       if (dom->fc_info && dom->fc_info->limit_set_addr) {
> +               iowrite32(max_perf, dom->fc_info->limit_set_addr);
> +               iowrite32(min_perf, dom->fc_info->limit_set_addr + 4);
> +               scmi_perf_fc_ring_db(dom->fc_info->limit_set_db);
> +               return 0;
> +       }
> +
> +       return scmi_perf_mb_limits_set(handle, domain, max_perf, min_perf);
> +}
> +
> +static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
>                                    u32 *max_perf, u32 *min_perf)
>  {
>         int ret;
> @@ -342,7 +394,22 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
>         return ret;
>  }
>
> -static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
> +static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
> +                               u32 *max_perf, u32 *min_perf)
> +{
> +       struct scmi_perf_info *pi = handle->perf_priv;
> +       struct perf_dom_info *dom = pi->dom_info + domain;
> +
> +       if (dom->fc_info && dom->fc_info->limit_get_addr) {
> +               *max_perf = ioread32(dom->fc_info->limit_get_addr);
> +               *min_perf = ioread32(dom->fc_info->limit_get_addr + 4);
> +               return 0;
> +       }
> +
> +       return scmi_perf_mb_limits_get(handle, domain, max_perf, min_perf);
> +}
> +
> +static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
>                                   u32 level, bool poll)
>  {
>         int ret;
> @@ -365,7 +432,22 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
>         return ret;
>  }
>
> -static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
> +static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
> +                              u32 level, bool poll)
> +{
> +       struct scmi_perf_info *pi = handle->perf_priv;
> +       struct perf_dom_info *dom = pi->dom_info + domain;
> +
> +       if (dom->fc_info && dom->fc_info->level_set_addr) {
> +               iowrite32(level, dom->fc_info->level_set_addr);
> +               scmi_perf_fc_ring_db(dom->fc_info->level_set_db);
> +               return 0;
> +       }
> +
> +       return scmi_perf_mb_level_set(handle, domain, level, poll);
> +}
> +
> +static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
>                                   u32 *level, bool poll)
>  {
>         int ret;
> @@ -387,6 +469,20 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
>         return ret;
>  }
>
> +static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
> +                              u32 *level, bool poll)
> +{
> +       struct scmi_perf_info *pi = handle->perf_priv;
> +       struct perf_dom_info *dom = pi->dom_info + domain;
> +
> +       if (dom->fc_info && dom->fc_info->level_get_addr) {
> +               *level = ioread32(dom->fc_info->level_get_addr);
> +               return 0;
> +       }
> +
> +       return scmi_perf_mb_level_get(handle, domain, level, poll);
> +}
> +
>  static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
>  {
>         if ((msg == PERF_LEVEL_GET || msg == PERF_LEVEL_SET) && size == 4)
> --
> 2.17.1
>
