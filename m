Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A23C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0842E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvsiIRt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfHNXAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:00:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44166 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfHNXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:00:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so1879101ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ps+EFQIEbsT8mGGr5ReNIIuoSPs/AsNLmAuvUEMVino=;
        b=cvsiIRt/q2PKJ+VpL3Fd62IdjDLmnHGn+HTaU21QLcJw1Jup7UMKeumGGkwOUABcOW
         fWQ3QGzSwQp2KAiPS9pQv6iujr8L6+py/pVn91frnOxWvRx5c1SrSAtqdzpgWkACoZ0B
         LiBj5GgIsnPVZNG9l0rmE/U2Pq5un8h+6oS/HquEEEexpCkl5hUdBtINucL0fflGilNI
         eV3PJvu//w/RVW/v1v8V4QkrevQvkkDPYmbnyUYOCSRj21jGLJ/77EIkBi7Lw7VLFeRX
         I1XX4xQmrzdfg5V2vIgZisR4BdgXYRrUW+NveYDY3MO6JPqfEV76wqglJkm60bRneJ4L
         MTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ps+EFQIEbsT8mGGr5ReNIIuoSPs/AsNLmAuvUEMVino=;
        b=MXY4JnT3bCeyBOhi99AQWZq5hpItzREt3sDgZaseG6FDv0TW1MrTS5MnnQFUFuHr3E
         h6qY4QvmUU1WEsBKio9TbCB7olWJXdOXIHZUeIYdpW+f4PbfPw/DlkMKzO6z110YcefN
         rEOgD8f2xc9wXBZ1ek+8ChjLS/g31GZ1/4Q5T+NLKcGPqZq71wCX3EyqPCsVtfvbhjC9
         14AMzGGUerfpK9zGnq1g0w4lcVuhidbRKlfd9mIIHUN4PRrTVQyeiPLG2yB3PdqI2RYC
         NN3zQU6Edu0oswVe8uQgsRq0PXrMf861wG24QrRvbfo/d+gsR31j18NF3Qr5KxckK8w6
         /r9A==
X-Gm-Message-State: APjAAAUqG8vni1/uY0C+y4dELwTIUzFTYF7ipEJLjvjTro5Wd8vrLeji
        LSXKUeFDYbwqpsRpVObqs4WuPJElXFRAfMJ0dkyaLw==
X-Google-Smtp-Source: APXvYqy/6uir6KpedrdY7ikNHexU+YPtfY9RLm7TaKlLdD+19hn7XeEaev/rKerNWentmbYt2c2CGqJT4irjg1lIWkU=
X-Received: by 2002:a5d:9710:: with SMTP id h16mr2505936iol.237.1565823641440;
 Wed, 14 Aug 2019 16:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812190320.209988-1-yabinc@google.com>
In-Reply-To: <20190812190320.209988-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 14 Aug 2019 17:00:30 -0600
Message-ID: <CANLsYkz3_bzRCQEVb00Tbf3Rdww13mePN-woncctOu7OanF00A@mail.gmail.com>
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

Hi Yabin,

On Mon, 12 Aug 2019 at 13:03, Yabin Cui <yabinc@google.com> wrote:
>
> When tracing etm data of multiple threads on multiple cpus through
> perf interface, each cpu has a unique etr_perf_buffer while sharing
> the same etr device. There is no guarantee that the last cpu starts
> etm tracing also stops last. This makes perf_data check fail.

Did you actually see the check fail or is this a theoretical thing?
I'm really perplex here has I have tested this scenario many times
without issues.

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

In CPU wide scenarios each perf event (one per CPU) is associated with
an event_data during the setup process.  The event_data is the
etr_perf holding a reference to the perf ring buffer for that specific
event along with the etr_buf, regardless of who created the latter.
From there, when the event is installed on a CPU, the csdev for that
CPU is given a reference to the event_data of that event[1].  Before
going further notice how there is a per CPU csdev and event handle to
keep track of event specifics[2]. As such both (per CPU) csdev and
event handle carry the exact same reference to the etr_perf.

When an event is stopped the exact same per CPU references are
taken[3] and later fed to sink->update_buffer().  If
sink->update_buffer() is called on an event (again one per CPU)
function etm_event_start() must have been called and
(drvdata->perf_data == etf_perf) needs to hold.

If that is not the case, an event from a completely different trace
session has been installed on that CPU and that can't happen thanks to
drvdata->id.

As such if you get a condition where (drvdata->perf_buf != etr_buf),
one of two things has happened:

1) Something went seriously wrong and the WARN_ON() did its job.
2) A corner case is manifesting in your test environment that I
haven't provisioned for.  If that is the case we need to figure out
exactly what is happening before considering a fix.

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/hwtracing/coresight/coresight-tmc-etr.c#L1559
[2]. https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/hwtracing/coresight/coresight-etm-perf.c#L298
[3]. https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/hwtracing/coresight/coresight-etm-perf.c#L348

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
