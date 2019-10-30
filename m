Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B24320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUeOZga9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfJ3PPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:15:33 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39900 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJ3PPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:15:33 -0400
Received: by mail-il1-f193.google.com with SMTP id i12so2450991ils.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tR3hnUd+yG4qoXk3Lqg2RDqKdfqL6VoTN0RsHKmQlIs=;
        b=LUeOZga9i3mrP4nElmpbUqTWrPIizf0R2VC8M6isiG5SBj3+oVQ480HjLYb4fOIo/O
         ffwVwlDOkN6Ufa5I8wjVUu/DBGTAo67IMvCwvqrE2Lh2Ol0Vztj4w6GyzSSVgTrRhohA
         zjLRrCyMyygeXXbw6FZe41As0JMj41vnoLyOP1ChA1ARW4aMDNV2P4SZlHKtHFPRIIev
         jhmfOw4ykcc5b6R4mkGMXD/nno5NuphZJDNX+RAnDxEt00jzfBcrBUwEYUmdgDGPzB28
         LlFIwJzkKmTvG6PDiUdicXhmXPAVkNOZY//s4JmZcwt/I39oP/1k1w0sOXhiV3eNfgE6
         UJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tR3hnUd+yG4qoXk3Lqg2RDqKdfqL6VoTN0RsHKmQlIs=;
        b=WhTjrAI7NkmW+eToLQMBYIeooXAf/WcjnFHEXT7ma8svaY7wupVicyk1ibkox0r1Q0
         4LPI5CM3IlrYyiMapqQ92QltUxs+VLYRg82zDTiL6+Hm3yu43rLi2aOH2eKwK0Lom5cs
         aL6svjl5uG9+n6b6zpVJ/FWVJlhxDlsakfaE+6S/GxYxcsfIGI7Tjh0BHmGBcu+4BQDA
         6d5R4XL2U8/iV9FkKpaUQ4liQoGq9WibTvdiG6xEKcZvqR8JNIRtC7QTokjCUFUGleyu
         8YRVWIBUYBKfmoSt4Hb1cFcpIwitlrG++/wzFN6Hxk2JxO5/uIQZPQGgSKmY3C7yaHJV
         2Vnw==
X-Gm-Message-State: APjAAAXxSPBGtytMbGoBM+G0cK112ms220xWPV27UXj+77gBoMLQ48a8
        vH0y/Hd9mSg5FhHxobfOXN24r+iw9KvoxB3u9stQHKx5
X-Google-Smtp-Source: APXvYqxg8G219FSJceHeLxrzDX2VBdTQlji2SOCFmrTE+AT9wSMWhub0QhpKTHzyLbSys6Oba7Ban5916Q7A3RjDuC4=
X-Received: by 2002:a92:350a:: with SMTP id c10mr644570ila.140.1572448530327;
 Wed, 30 Oct 2019 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191025235321.181897-1-yabinc@google.com>
In-Reply-To: <20191025235321.181897-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 30 Oct 2019 09:15:19 -0600
Message-ID: <CANLsYkxexrP_uuNS6SUmj1DyE0q8whj4i=ZdZs+PRTazxzCgaA@mail.gmail.com>
Subject: Re: [PATCH v5] coresight: Serialize enabling/disabling a link device.
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

On Fri, 25 Oct 2019 at 17:53, Yabin Cui <yabinc@google.com> wrote:
>
> When tracing etm data of multiple threads on multiple cpus through perf
> interface, some link devices are shared between paths of different cpus.
> It creates race conditions when different cpus wants to enable/disable
> the same link device at the same time.
>
> Example 1:
> Two cpus want to enable different ports of a coresight funnel, thus
> calling the funnel enable operation at the same time. But the funnel
> enable operation isn't reentrantable.
>
> Example 2:
> For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
> to disable it, while another cpu wants to enable it. Ideally we still have
> an enabled replicator with refcnt=1 at the end. But in reality the result
> is uncertain.
>
> Since coresight devices claim themselves when enabled for self-hosted
> usage, the race conditions above usually make the link devices not usable
> after many cycles.
>
> To fix the race conditions, this patch uses spinlocks to serialize
> enabling/disabling link devices.
>
> Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> Sorry for the delay!
>
> v4 -> v5:
> added document for spinlock fields.
> moved dev_dbg() out of lock section, and verified printed debug msgs.
>
> split atomic_inc_return() into atomic_read() and atomic_inc() as
> commented.
> checked drvdata->reading before refcnt.
>
> ---
>  .../hwtracing/coresight/coresight-funnel.c    | 36 +++++++++++----
>  .../coresight/coresight-replicator.c          | 35 ++++++++++++---
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 26 ++++++++---
>  drivers/hwtracing/coresight/coresight.c       | 45 ++++++-------------
>  4 files changed, 90 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 05f7896c3a01..b605889b507a 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -38,12 +38,14 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
>   * @atclk:     optional clock for the core parts of the funnel.
>   * @csdev:     component vitals needed by the framework.
>   * @priority:  port selection order.
> + * @spinlock:  serialize enable/disable operations.
>   */
>  struct funnel_drvdata {
>         void __iomem            *base;
>         struct clk              *atclk;
>         struct coresight_device *csdev;
>         unsigned long           priority;
> +       spinlock_t              spinlock;
>  };
>
>  static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
> @@ -76,11 +78,21 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
>  {
>         int rc = 0;
>         struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -       if (drvdata->base)
> -               rc = dynamic_funnel_enable_hw(drvdata, inport);
> -
> +       unsigned long flags;
> +       bool first_enable = false;
> +
> +       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       if (atomic_read(&csdev->refcnt[inport]) == 0) {
> +               if (drvdata->base)
> +                       rc = dynamic_funnel_enable_hw(drvdata, inport);
> +               if (!rc)
> +                       first_enable = true;
> +       }
>         if (!rc)
> +               atomic_inc(&csdev->refcnt[inport]);
> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +       if (first_enable)
>                 dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
>         return rc;
>  }
> @@ -107,11 +119,19 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
>                            int outport)
>  {
>         struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       unsigned long flags;
> +       bool last_disable = false;
> +
> +       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
> +               if (drvdata->base)
> +                       dynamic_funnel_disable_hw(drvdata, inport);
> +               last_disable = true;
> +       }
> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> -       if (drvdata->base)
> -               dynamic_funnel_disable_hw(drvdata, inport);
> -
> -       dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
> +       if (last_disable)
> +               dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
>  }
>
>  static const struct coresight_ops_link funnel_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b29ba640eb25..43304196a1a6 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -31,11 +31,13 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>   *             whether this one is programmable or not.
>   * @atclk:     optional clock for the core parts of the replicator.
>   * @csdev:     component vitals needed by the framework
> + * @spinlock:  serialize enable/disable operations.
>   */
>  struct replicator_drvdata {
>         void __iomem            *base;
>         struct clk              *atclk;
>         struct coresight_device *csdev;
> +       spinlock_t              spinlock;
>  };
>
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> @@ -97,10 +99,22 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  {
>         int rc = 0;
>         struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -       if (drvdata->base)
> -               rc = dynamic_replicator_enable(drvdata, inport, outport);
> +       unsigned long flags;
> +       bool first_enable = false;
> +
> +       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       if (atomic_read(&csdev->refcnt[outport]) == 0) {
> +               if (drvdata->base)
> +                       rc = dynamic_replicator_enable(drvdata, inport,
> +                                                      outport);
> +               if (!rc)
> +                       first_enable = true;
> +       }
>         if (!rc)
> +               atomic_inc(&csdev->refcnt[outport]);
> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +       if (first_enable)
>                 dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
>         return rc;
>  }
> @@ -137,10 +151,19 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>                                int outport)
>  {
>         struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       unsigned long flags;
> +       bool last_disable = false;
> +
> +       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
> +               if (drvdata->base)
> +                       dynamic_replicator_disable(drvdata, inport, outport);
> +               last_disable = true;
> +       }
> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> -       if (drvdata->base)
> -               dynamic_replicator_disable(drvdata, inport, outport);
> -       dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> +       if (last_disable)
> +               dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
>  }
>
>  static const struct coresight_ops_link replicator_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 807416b75ecc..d0cc3985b72a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -334,9 +334,10 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
>  static int tmc_enable_etf_link(struct coresight_device *csdev,
>                                int inport, int outport)
>  {
> -       int ret;
> +       int ret = 0;
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       bool first_enable = false;
>
>         spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (drvdata->reading) {
> @@ -344,12 +345,18 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>                 return -EBUSY;
>         }
>
> -       ret = tmc_etf_enable_hw(drvdata);
> +       if (atomic_read(&csdev->refcnt[0]) == 0) {
> +               ret = tmc_etf_enable_hw(drvdata);
> +               if (!ret) {
> +                       drvdata->mode = CS_MODE_SYSFS;
> +                       first_enable = true;
> +               }
> +       }
>         if (!ret)
> -               drvdata->mode = CS_MODE_SYSFS;
> +               atomic_inc(&csdev->refcnt[0]);
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> -       if (!ret)
> +       if (first_enable)
>                 dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
>         return ret;
>  }
> @@ -359,6 +366,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>  {
>         unsigned long flags;
>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       bool last_disable = false;
>
>         spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (drvdata->reading) {
> @@ -366,11 +374,15 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>                 return;
>         }
>
> -       tmc_etf_disable_hw(drvdata);
> -       drvdata->mode = CS_MODE_DISABLED;
> +       if (atomic_dec_return(&csdev->refcnt[0]) == 0) {
> +               tmc_etf_disable_hw(drvdata);
> +               drvdata->mode = CS_MODE_DISABLED;
> +               last_disable = true;
> +       }
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> -       dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
> +       if (last_disable)
> +               dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
>  }
>
>  static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 6453c67a4d01..0bbce0d29158 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -253,9 +253,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
>                                  struct coresight_device *parent,
>                                  struct coresight_device *child)
>  {
> -       int ret;
> +       int ret = 0;
>         int link_subtype;
> -       int refport, inport, outport;
> +       int inport, outport;
>
>         if (!parent || !child)
>                 return -EINVAL;
> @@ -264,29 +264,17 @@ static int coresight_enable_link(struct coresight_device *csdev,
>         outport = coresight_find_link_outport(csdev, child);
>         link_subtype = csdev->subtype.link_subtype;
>
> -       if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
> -               refport = inport;
> -       else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
> -               refport = outport;
> -       else
> -               refport = 0;
> -
> -       if (refport < 0)
> -               return refport;
> +       if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
> +               return inport;
> +       if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && outport < 0)
> +               return outport;
>
> -       if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
> -               if (link_ops(csdev)->enable) {
> -                       ret = link_ops(csdev)->enable(csdev, inport, outport);
> -                       if (ret) {
> -                               atomic_dec(&csdev->refcnt[refport]);
> -                               return ret;
> -                       }
> -               }
> -       }
> -
> -       csdev->enable = true;
> +       if (link_ops(csdev)->enable)
> +               ret = link_ops(csdev)->enable(csdev, inport, outport);
> +       if (!ret)
> +               csdev->enable = true;
>
> -       return 0;
> +       return ret;
>  }
>
>  static void coresight_disable_link(struct coresight_device *csdev,
> @@ -295,7 +283,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
>  {
>         int i, nr_conns;
>         int link_subtype;
> -       int refport, inport, outport;
> +       int inport, outport;
>
>         if (!parent || !child)
>                 return;
> @@ -305,20 +293,15 @@ static void coresight_disable_link(struct coresight_device *csdev,
>         link_subtype = csdev->subtype.link_subtype;
>
>         if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
> -               refport = inport;
>                 nr_conns = csdev->pdata->nr_inport;
>         } else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
> -               refport = outport;
>                 nr_conns = csdev->pdata->nr_outport;
>         } else {
> -               refport = 0;
>                 nr_conns = 1;
>         }
>
> -       if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
> -               if (link_ops(csdev)->disable)
> -                       link_ops(csdev)->disable(csdev, inport, outport);
> -       }
> +       if (link_ops(csdev)->disable)
> +               link_ops(csdev)->disable(csdev, inport, outport);

I have picked up you work - thanks,
Mathieu

>
>         for (i = 0; i < nr_conns; i++)
>                 if (atomic_read(&csdev->refcnt[i]) != 0)
> --
> 2.24.0.rc0.303.g954a862665-goog
>
