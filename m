Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D8AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BE120578
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foCPBm2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfHSWzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:55:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37068 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfHSWzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:55:39 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so8020808iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GghJ9osZeYRlwhn9lgUsUo7YRIX+Kbje8amKHVOldwk=;
        b=foCPBm2sO6lqJhtfvfEMGlgb1jYDxA3fd1zKEcMbyaUSS25p9vaVhA8ZaBzWiTbMfI
         Ra3VvFUA6yIh/TIVv/UZyDjVD9QBh+6TbAcTFdYdU159SLEmxSOIaDMXUQ1P0PqJQlkw
         rdE/brBFMwEdNdkIkAAgc3JxsYE0qnHGZBZRLWdSGlTBzIGsR+AGdVlvVd7FlQ77HqSA
         K0g4EAAkxlgxjau4D7OaKdcOU4saR+h01HOOuQ6rXFZdkSKuptEBn2FLl0jTxcTAkNrh
         wH9cvjB2fzd8ey/IN0FdVyk/G3+O2gqjEjWSYEshyP9BV9C+5I+AqldRmZiIlETki0gP
         MKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GghJ9osZeYRlwhn9lgUsUo7YRIX+Kbje8amKHVOldwk=;
        b=icci8hKXGO5t5RRjtynwupD6kmNLnzy5gvn1e0283aEVtm89Wo1gB+emtjjOSccA+U
         /4vBbjiCxDPEYpfZynOWHdbdEFX61hMAgcfveZCir2dHQQvNSx9aazD6aSMvYzY96YOI
         zkt2CLpant/fmba26p48ImVmBs+piQ7T/ALAlWhCjdNNWb5I3mBwqISWJu5sMdw8veHM
         TGCBSYBpaCowoTT/mbJv6o+LfkCcxFrsaJ2GpQNvoJgYM7KlSoRhPsYZ4rQ92JWGV+l4
         dwEXYOzjPPihHW0/G8Ru4RH78FBbNlZnLCPF7yUS5HFdkAKvQe0dYMVWUzApHxM+3bsS
         2Qug==
X-Gm-Message-State: APjAAAX0VvU+Zykgfr75NDDqDLmR64bvp6YzKxrreFTdQFLYWogqN6PS
        XacFAkI6+J7myRqIyUdOVk9wsFFR6KQDtHRuV5wiYQ==
X-Google-Smtp-Source: APXvYqwU1qqCvobEK1hY7OvjFoqxVgMiFTUVnihXOeQLPEVIjKWBUy90ZkRo/G2mDiqvJiwT4t3piCQRMO9Ia6wmNdI=
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr203059jar.71.1566255337742;
 Mon, 19 Aug 2019 15:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190815184628.183186-1-yabinc@google.com>
In-Reply-To: <20190815184628.183186-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Aug 2019 16:55:26 -0600
Message-ID: <CANLsYkwad9aGKkk_E2e-KPWYD+V9fUNp9og6qk6v-FGYfosMGQ@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: tmc-etr: Fix perf_data check.
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 at 12:46, Yabin Cui <yabinc@google.com> wrote:
>
> When tracing etm data of multiple threads on multiple cpus through
> perf interface, each cpu has a unique etr_perf_buffer while sharing
> the same etr device. There is no guarantee that the last cpu starts
> etm tracing also stops last. This makes perf_data check fail.
>
> Fix it by checking etr_buf instead of etr_perf_buffer.
> Also move the code setting and clearing perf_buf to more suitable
> places.
>
> Fixes: 3147da92a8a8 ("coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> v2 -> v3:
>   moved place of setting drvdata->perf_buf based on review comment.
>   Also moved place of clearing drvdata->perf_buf from
>   tmc_update_etr_buffer() to tmc_disable_etr_sink() for below
>   situation:
>
>   cpu 0 enable etr device (set perf_buf)
>   cpu 0 update etr buffer (clear perf_buf)
>   cpu 1 enable etr device (perf_buf isn't set because pid set by cpu 0)
>   cpu 0 disable etr device
>   cpu 1 update etr buffer (perf_buf == NULL, check fails)
>
>   To fix it, we need to move clearing perf_buf to the disable function.
>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++----
>  drivers/hwtracing/coresight/coresight-tmc.h     | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..80af313f55d7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1484,7 +1484,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>                 goto out;
>         }
>
> -       if (WARN_ON(drvdata->perf_data != etr_perf)) {
> +       if (WARN_ON(drvdata->perf_buf != etr_buf)) {
>                 lost = true;
>                 spin_unlock_irqrestore(&drvdata->spinlock, flags);
>                 goto out;
> @@ -1496,8 +1496,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>         tmc_sync_etr_buf(drvdata);
>
>         CS_LOCK(drvdata->base);
> -       /* Reset perf specific data */
> -       drvdata->perf_data = NULL;
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         size = etr_buf->len;
> @@ -1556,7 +1554,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>         }
>
>         etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
> -       drvdata->perf_data = etr_perf;
>
>         /*
>          * No HW configuration is needed if the sink is already in
> @@ -1572,6 +1569,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>                 /* Associate with monitored process. */
>                 drvdata->pid = pid;
>                 drvdata->mode = CS_MODE_PERF;
> +               drvdata->perf_buf = etr_perf->etr_buf;
>                 atomic_inc(csdev->refcnt);
>         }
>
> @@ -1617,6 +1615,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
>         /* Dissociate from monitored process. */
>         drvdata->pid = -1;
>         drvdata->mode = CS_MODE_DISABLED;
> +       /* Reset perf specific data */
> +       drvdata->perf_buf = NULL;
>
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 1ed50411cc3c..f9a0c95e9ba2 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -178,8 +178,8 @@ struct etr_buf {
>   *             device configuration register (DEVID)
>   * @idr:       Holds etr_bufs allocated for this ETR.
>   * @idr_mutex: Access serialisation for idr.
> - * @perf_data: PERF buffer for ETR.
> - * @sysfs_data:        SYSFS buffer for ETR.
> + * @sysfs_buf: SYSFS buffer for ETR.
> + * @perf_buf:  PERF buffer for ETR.
>   */
>  struct tmc_drvdata {
>         void __iomem            *base;
> @@ -202,7 +202,7 @@ struct tmc_drvdata {
>         struct idr              idr;
>         struct mutex            idr_mutex;
>         struct etr_buf          *sysfs_buf;
> -       void                    *perf_data;
> +       struct etr_buf          *perf_buf;
>  };

I have applied your patch.

Thanks,
Mathieu

>
>  struct etr_buf_operations {
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
