Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3128EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7520665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYu0s+BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfHMVae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:30:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45534 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHMVae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:30:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so24545737otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+G2zy96VnmH+zRcEgTdWubjTvGo5IMvJNYRtMTxw04=;
        b=rYu0s+BQvtmdoikVCTb6tLYsN1sDtbMeBmIDG0wOuMSsygNONs/e3TDuYfwpva1Xoo
         h7NPf+gsUEGZg+HcPEdFBtswVYcZFgAYfl0C+xFtm6G9biCG5VYrhGI8aUuMmp4bkinC
         tECbByKVkOb0JCEfQ+5w/kqI6rYmLMZO25nNzwdo5Hp18mLUscDNGI+Fr9W97fQKi/RO
         9/LredGzO8VPBZpt2FRHvwohU7FC+k2MA4YwfdaHIyu3EAxv1rRvzCK17PRSkK50aBjL
         pVB3OmCESjWKYPrZSs43tbZEyJ0BhBuXZgDis1mTNti1OcjPR7+ePRuwvv0O8BA8GkFd
         UH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+G2zy96VnmH+zRcEgTdWubjTvGo5IMvJNYRtMTxw04=;
        b=Vfl9iY6EpPWHF9gK6xqX16XT0xz4PZTk182WsVmkYcgixy6Cla7hlgI2p8iEBDLZ87
         j3sGy49xsOpY9ar9FsOVtP69P/otyUhhPy406WaMEervk3Ga+vcdiiMmzMixl32fi4hw
         wSvrM9SFnGmpxpNCNcD+i1ymdXyaPfpcs94K9tEHY58ADFFDaO+HyzN1g5KVqccNnuIU
         QxBDITIbj1MfYZ7e4oRUd2DUiO5rYnyHb3tIBiAg56FUgP4KzdYkCxsl3P2F6k20wC9Q
         77nzoM5AfEz/N9X1mgc7rNf4eQeKd6iDkwBToM4xsaxCYaUD2WtG5CoSjmEp+qVNm5PZ
         mMXQ==
X-Gm-Message-State: APjAAAW5Jq0OuNfm9XS+hL1Ap+Y0gDzTvKQsLv5F2VdqNFyJoPHzbZ4+
        crh5wqAWMZnjBCVNFK/AkMyXRgnHemiDBSvMr/x9Jw==
X-Google-Smtp-Source: APXvYqy2TmxV0nrsRl3QgD8/+Drr+1lMWGMeydxHOJ6S+P2RASj4gQx4YYrpxwDsLLfnwq1Yg5HYVQW1KKzejLihI8Q=
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr23818923iop.58.1565731832847;
 Tue, 13 Aug 2019 14:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190812195725.11793-1-yabinc@google.com>
In-Reply-To: <20190812195725.11793-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 13 Aug 2019 15:30:21 -0600
Message-ID: <CANLsYkzH-ZWV3qF4p4Yvfy3EfBvZUYyDH+SDdUyuS3fGw9h_Fw@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: Serialize enabling/disabling a link device.
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

On Mon, 12 Aug 2019 at 13:57, Yabin Cui <yabinc@google.com> wrote:
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
> To fix the race conditions, this patch adds a spinlock to serialize
> enabling/disabling a link device.
>
> Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")

When "a06ae8609b3d" was introduced there wasn't any race condition as
all access to links were guarded by the coresight_mutex in
coresight_enable/disable() functions.  The problem was really
introduced when integration with the perf subsystem was added, though
it would have been really difficult to trigger due to the HW
topologies available at the time.

So, to be exact:

Fixes: 0bcbf2e30ff2 ("coresight: etm-perf: new PMU driver for ETM tracers")

> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> v2 -> v3: extend lock range to protect csdev->enable for link devices.
>           Add fixes tag.
>
> ---
>  drivers/hwtracing/coresight/coresight.c | 12 +++++++++++-
>  include/linux/coresight.h               |  3 +++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 55db77f6410b..c069ada151b8 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -256,6 +256,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
>         int ret;
>         int link_subtype;
>         int refport, inport, outport;
> +       unsigned long flags;
>
>         if (!parent || !child)
>                 return -EINVAL;
> @@ -274,17 +275,20 @@ static int coresight_enable_link(struct coresight_device *csdev,
>         if (refport < 0)
>                 return refport;
>
> +       spin_lock_irqsave(&csdev->spinlock, flags);
>         if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
>                 if (link_ops(csdev)->enable) {
>                         ret = link_ops(csdev)->enable(csdev, inport, outport);
>                         if (ret) {
>                                 atomic_dec(&csdev->refcnt[refport]);
> +                               spin_unlock_irqrestore(&csdev->spinlock, flags);
>                                 return ret;
>                         }
>                 }
>         }
>
>         csdev->enable = true;
> +       spin_unlock_irqrestore(&csdev->spinlock, flags);
>
>         return 0;
>  }
> @@ -296,6 +300,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
>         int i, nr_conns;
>         int link_subtype;
>         int refport, inport, outport;
> +       unsigned long flags;
>
>         if (!parent || !child)
>                 return;
> @@ -315,16 +320,20 @@ static void coresight_disable_link(struct coresight_device *csdev,
>                 nr_conns = 1;
>         }
>
> +       spin_lock_irqsave(&csdev->spinlock, flags);
>         if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
>                 if (link_ops(csdev)->disable)
>                         link_ops(csdev)->disable(csdev, inport, outport);
>         }
>
>         for (i = 0; i < nr_conns; i++)
> -               if (atomic_read(&csdev->refcnt[i]) != 0)
> +               if (atomic_read(&csdev->refcnt[i]) != 0) {
> +                       spin_unlock_irqrestore(&csdev->spinlock, flags);
>                         return;
> +               }
>
>         csdev->enable = false;
> +       spin_unlock_irqrestore(&csdev->spinlock, flags);
>  }
>
>  static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
> @@ -1225,6 +1234,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         csdev->subtype = desc->subtype;
>         csdev->ops = desc->ops;
>         csdev->orphan = false;
> +       spin_lock_init(&csdev->spinlock);

Your patch will work and I see the problem it is addressing.  I
contemplated doing exactly the same thing for sink devices but
couldn't due to memory management issues.  In the end I moved the
reference counting inside each driver where it could be guarded by
drvdata->spinlock.

I suggest to do the same thing for links to avoid dealing with two
different ways of doing things.  As such we could get rid of the
"refport" thing I never liked in coresight_enable_link(), invariably
call link_ops()->enable() and let each driver deal with its own port
management.  The same logic applies to the disable() path.

The patch isn't difficult to do but does go deeper in each link
drivers (ETF, funnel, replicator).  Let me know if you are not
comfortable with the idea and I will see what I can do on my side.

Thanks,
Mathieu

>
>         csdev->dev.type = &coresight_dev_type[desc->type];
>         csdev->dev.groups = desc->groups;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a2b68823717b..dd28d9ab841d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/perf_event.h>
>  #include <linux/sched.h>
> +#include <linux/spinlock.h>
>
>  /* Peripheral id registers (0xFD0-0xFEC) */
>  #define CORESIGHT_PERIPHIDR4   0xfd0
> @@ -153,6 +154,7 @@ struct coresight_connection {
>   *             activated but not yet enabled.  Enabling for a _sink_
>   *             appens when a source has been selected for that it.
>   * @ea:                Device attribute for sink representation under PMU directory.
> + * @spinlock:  Serialize enabling/disabling this device.
>   */
>  struct coresight_device {
>         struct coresight_platform_data *pdata;
> @@ -166,6 +168,7 @@ struct coresight_device {
>         /* sink specific fields */
>         bool activated; /* true only if a sink is part of a path */
>         struct dev_ext_attribute *ea;
> +       spinlock_t spinlock;
>  };
>
>  /*
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
