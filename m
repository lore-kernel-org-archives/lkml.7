Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CBC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D66824CE0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559630221;
	bh=dwqyY5JxBtGqhxd/56EiAMH8oEK1rne586EbXZFul8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zbrTp3xK1xaLaCczLASD7E5FWcxOpRLNgDL2V6c0Lfhh34qnwTYAQP5nTOBePzWwk
	 lG7oAKF1/sIv9X7zSIRd3Z477wdS/9Vhmq8WZGEsDMeQVqcu0oBnjjcTumzyhZ/t5u
	 OCsuUEFtV9/Iy1l9KnO0Q35oK9M4wC/UI1l+GTjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFDGhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFDGhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:37:00 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B977C24CDC;
        Tue,  4 Jun 2019 06:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559630219;
        bh=dwqyY5JxBtGqhxd/56EiAMH8oEK1rne586EbXZFul8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fi7wRIBQMzbZwdXZCUmExlszkUUzTC3AtjeunLFRzvOYgvREE2vHuRQfPix4f6dNl
         R5znMCwJvjJEvn+0U4DD8Oo9tGGZ0sgsGVITSi586uM+kT/ea8qeTh73dqbmMqsCv1
         qVypskIrliuA1EO48FSx0eZaeM17fc/iRxMNQIpM=
Received: by mail-wr1-f43.google.com with SMTP id p11so9647187wre.7;
        Mon, 03 Jun 2019 23:36:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUHZr1bLatYMzZ7o8WGV+LVD6j3q+BFci6Au3J+FzhczsDyQbu5
        DCPxIgQJoyD5XHLXsJV+yVUUOue1dO78VxeWNX8=
X-Google-Smtp-Source: APXvYqytxN2X+i51RKFVvPXOAERiYwkXdDHjra69ZCjcXgPrtpSpY1rnDfnMpYjXQaCA2OR2Xaw3/AJ1qlf/uWd6uNQ=
X-Received: by 2002:adf:eb42:: with SMTP id u2mr18271932wrn.80.1559630217365;
 Mon, 03 Jun 2019 23:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559614824.git.han_mao@c-sky.com> <3a6a5379b4f692773d82ff5ad18a7b22ceaf5a80.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <3a6a5379b4f692773d82ff5ad18a7b22ceaf5a80.1559614824.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jun 2019 14:36:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSS7UhBOPYp=SMYAZ-OMhV21=4v3Gcp_80038QKLFWa6w@mail.gmail.com>
Message-ID: <CAJF2gTSS7UhBOPYp=SMYAZ-OMhV21=4v3Gcp_80038QKLFWa6w@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] csky: Fix perf record in kernel/user space
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just move attr.exclude_user after switch, like this:

OK?

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 376c972..3470cfa 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -844,15 +844,6 @@ static int csky_pmu_event_init(struct perf_event *event)
        struct hw_perf_event *hwc = &event->hw;
        int ret;

-       if (event->attr.exclude_user)
-               csky_pmu.hpcr = BIT(2);
-       else if (event->attr.exclude_kernel)
-               csky_pmu.hpcr = BIT(3);
-       else
-               csky_pmu.hpcr = BIT(2) | BIT(3);
-
-       csky_pmu.hpcr |= BIT(1) | BIT(0);
-
        switch (event->attr.type) {
        case PERF_TYPE_HARDWARE:
                if (event->attr.config >= PERF_COUNT_HW_MAX)
@@ -861,21 +852,31 @@ static int csky_pmu_event_init(struct perf_event *event)
                if (ret == HW_OP_UNSUPPORTED)
                        return -ENOENT;
                hwc->idx = ret;
-               return 0;
+               break;
        case PERF_TYPE_HW_CACHE:
                ret = csky_pmu_cache_event(event->attr.config);
                if (ret == CACHE_OP_UNSUPPORTED)
                        return -ENOENT;
                hwc->idx = ret;
-               return 0;
+               break;
        case PERF_TYPE_RAW:
                if (hw_raw_read_mapping[event->attr.config] == NULL)
                        return -ENOENT;
                hwc->idx = event->attr.config;
-               return 0;
+               break;
        default:
                return -ENOENT;
        }
+
+       if (event->attr.exclude_user)
+               csky_pmu.hpcr = BIT(2);
+       else if (event->attr.exclude_kernel)
+               csky_pmu.hpcr = BIT(3);
+       else
+               csky_pmu.hpcr = BIT(2) | BIT(3);
+
+       csky_pmu.hpcr |= BIT(1) | BIT(0);
+
 }

On Tue, Jun 4, 2019 at 10:25 AM Mao Han <han_mao@c-sky.com> wrote:
>
> csky_pmu_event_init is called several times during the perf record
> initialzation. After configure the event counter in either kernel
> space or user space, csky_pmu_event_init is called twice with no
> attr specified. Configuration will be overwritten with sampling in
> both kernel space and user space. --all-kernel/--all-user is
> useless without this patch applied.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/kernel/perf_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
> index dc84dc7..e3308ab 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -983,6 +983,12 @@ static int csky_pmu_event_init(struct perf_event *event)
>         struct hw_perf_event *hwc = &event->hw;
>         int ret;
>
> +       if (event->attr.type != PERF_TYPE_HARDWARE &&
> +           event->attr.type != PERF_TYPE_HW_CACHE &&
> +           event->attr.type != PERF_TYPE_RAW) {
> +               return -ENOENT;
> +       }
> +
>         if (event->attr.exclude_user)
>                 csky_pmu.hpcr = BIT(2);
>         else if (event->attr.exclude_kernel)
> --
> 2.7.4
>
