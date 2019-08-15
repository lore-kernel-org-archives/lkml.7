Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42F6C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFE22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUeoX1uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfHORh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:37:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39220 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHORh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:37:57 -0400
Received: by mail-io1-f67.google.com with SMTP id l7so757113ioj.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/qaXV9S7EqSXjJ9HVVNAqMBd3/53HT0f+nyTBIWkjQ=;
        b=wUeoX1uPuGsbMGnSpUBVS62MFU9GgL7ic0/36SPnwOTAguBfWA5Gak5iU8UcYL+6Dq
         eGzLlIckv3K1bz2qreTGE3JfD/5nCYhPO/tTJhCS/6LuqmPYxQj6ZwKSdD2VrjUKqbA9
         cF2gjQykZblgqUg090nE4cyIWH4OSJX1WMpYqrhjWe1o4KMHHqH1EHezZg37KrkJo5BF
         cL27sbU6YsXo3SELPEd7nMTo41502vReAZTx1EIqEBrmtKQi0wmLGx2pZ35M1iUIds9p
         9/NT5Q+9z7VMWJiJdQBCojS5ovGK4mfJLU7cI8ikaLIhf8fn56Ap8BsjZj11gMu94O9S
         2pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/qaXV9S7EqSXjJ9HVVNAqMBd3/53HT0f+nyTBIWkjQ=;
        b=FnJ3sWGnCByeXncBZGFHw24FpEIGLRtA8gZGqK3z+cmuAZrGp1Y77DwOOcaffzA9wx
         rqZayORxwlYXQzQfgSCSbFDumTZ5nwgDgKpaxUpdnqJzX0tfWJ4spfGi+XpoNTIviWYn
         nQ7CCeADPT/uAKABvuog7uuZc7Jx7N9cqnnlps5UEPkQgiSAzQJzoW4LHpYjI4D4Qj7e
         PhEmfZ+jvVBJzf9bEs9rVJrFfm8yuZYWKc5EgwEGZW+dnLMExsmfNXbf0BTb0qv/uo97
         A985enpR0yw642cnrUq+afmWqdl6mLHAMb7rD8S4VwJvRmMsAsy3p7a9/ggeQgMY0FHR
         4hAQ==
X-Gm-Message-State: APjAAAWDy13CeOrDli7N2e8twAF1fqQQ0klmu2XeI1gFHTPI6iR0OgSX
        3t2z6VIZk/WxwQMTDvbwCIEeEhtJOYIM1EE7JfloJQ==
X-Google-Smtp-Source: APXvYqzXDH761xotArU4aND1o5POeE8CAePCGs7xEh0u4TRFQawyaT1FFjR38e/5ItDgOAYVLnQdcE3hNtMTm5//Ma8=
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr6742403ioq.50.1565890677021;
 Thu, 15 Aug 2019 10:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190812190320.209988-1-yabinc@google.com>
In-Reply-To: <20190812190320.209988-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 15 Aug 2019 11:37:46 -0600
Message-ID: <CANLsYkxRVvWUxEAmRQ7nCuS-NaOogN4sYOipxBW5zsozyu+y2g@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: tmc-etr: Fix perf_data check.
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

On Mon, 12 Aug 2019 at 13:03, Yabin Cui <yabinc@google.com> wrote:
>
> When tracing etm data of multiple threads on multiple cpus through
> perf interface, each cpu has a unique etr_perf_buffer while sharing
> the same etr device. There is no guarantee that the last cpu starts
> etm tracing also stops last. This makes perf_data check fail.
>
> Fix it by checking etr_buf instead of etr_perf_buffer.
>
> Fixes: 3147da92a8a8 ("coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> v1 -> v2: rename perf_data to perf_buf. Add fixes tag.
>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 +++---
>  drivers/hwtracing/coresight/coresight-tmc.h     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..90d1548ad268 100644
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
> @@ -1497,7 +1497,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>
>         CS_LOCK(drvdata->base);
>         /* Reset perf specific data */
> -       drvdata->perf_data = NULL;
> +       drvdata->perf_buf = NULL;
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         size = etr_buf->len;
> @@ -1556,7 +1556,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>         }
>
>         etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
> -       drvdata->perf_data = etr_perf;
> +       drvdata->perf_buf = etr_perf->etr_buf;

Ok for the fix.  Looking a things again I don't see a need to do the
assignment for each event - this needs to be done only when the device
is assocated with a monitored process.  Please move it here [1].

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/hwtracing/coresight/coresight-tmc-etr.c#L1572
>
>         /*
>          * No HW configuration is needed if the sink is already in
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
>
>  struct etr_buf_operations {
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
