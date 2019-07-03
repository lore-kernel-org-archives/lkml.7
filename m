Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B5C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8880721881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLxNmeQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCHb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:31:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38553 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfGCHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:31:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so1262542ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmGs6N+d4N8CvwdaN2wAJuo6+nfCeYD4Fe/EKzN0kuI=;
        b=RLxNmeQ0KtAAaJ4k0hsm5Brwiw4hlOOadU4jP0CDKHF0A0n2WVLyailxPk0c/0Rvny
         cRUh+chYaT1xboAL239n7ZAyqNE7jklYbad+WNE3c9gwJ/R4Bs7yfu45LXu1pBvu50fL
         RbScZ+yk6a/lL97Y/UcgKHUZCUFaAd8UHWxk5jMY/7gBoOOLt40cBWCL5dxNoJwSMeBz
         pTdcXjTUmTNHgcv8l4E96RAON0e33hJM/mqgE5eZpyW2gcwA2BpEx1tATF2/fq3cxDFu
         7yCKrJgkAf65eEZOe6HAWnaoNgn6hEdDt/RlYrhKQmwKobnQPpiVHXPrzCu1X6Yiy/pv
         oDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmGs6N+d4N8CvwdaN2wAJuo6+nfCeYD4Fe/EKzN0kuI=;
        b=I9gGj3eJ3v1jV1sHMIXaHAZQG6Cw0eFqsj47e2J72/PgVxPwgmNJ8g0YcOpgltQ1Ae
         TwSEtrh9ca8mnqjd8iHeEg1saAq6C1KsbdsWELWxQwE9LRIH1+Kzjri/9e1xjO0bdFQo
         GAAVv9g10Ro6re7Hazt64dfu2DGHLb0K5Oz4bSmmQO0mdMmYMvpiml9S8ZCzWqlXueOC
         Ym74+3QQmscQwx9H+CJ2ZGcab5joT3fFKDdPsSPhBOwS4ylXAPgxeJcE9oE6ks+nTd7J
         HKaKjNo/qQ/o9t8WHKoYBWJjxX6wij9eILQeJEfmIV+5CQtycUSzqNMLcH5mGJMb6hdD
         gakw==
X-Gm-Message-State: APjAAAVdgJ+Whkqg3zPUyzEQPiUEklNPBhLFMD0CWCKkTu7vyRVLSYGI
        E6sb+fOxXotCNGHZZSHoBN2930IVXZWrHepelDcUrj8A7Nc=
X-Google-Smtp-Source: APXvYqwJQ965pGQR682i8TU6YxbZ5HLEEpVUcNgUFk1Jy1uHJlTD7dQKHAsU+RI9UMKJ908nU3QfTKmHmVz3sDYSjZY=
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr20189402ljk.106.1562139115209;
 Wed, 03 Jul 2019 00:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190701135933.30544-1-ttayar@habana.ai> <20190701135933.30544-3-ttayar@habana.ai>
In-Reply-To: <20190701135933.30544-3-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 3 Jul 2019 10:31:28 +0300
Message-ID: <CAFCwf12mnOY+QxVY-Ro5vkuso_Zb5LLAka9AJy4hvMQ4i7G3nQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] habanalabs: Add busy engines bitmask to HW idle IOCTL
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 4:59 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The information which is currently provided as a response to the
> "HL_INFO_HW_IDLE" IOCTL is merely a general boolean value.
> This patch extends it and provides also a bitmask that indicates which
> of the device engines are busy.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/debugfs.c          |  2 +-
>  drivers/misc/habanalabs/goya/goya.c        | 11 ++++++--
>  drivers/misc/habanalabs/habanalabs.h       |  3 ++-
>  drivers/misc/habanalabs/habanalabs_ioctl.c |  3 ++-
>  include/uapi/misc/habanalabs.h             | 30 +++++++++++++++++++++-
>  5 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
> index 6a5dfb14eca1..18e499c900c7 100644
> --- a/drivers/misc/habanalabs/debugfs.c
> +++ b/drivers/misc/habanalabs/debugfs.c
> @@ -506,7 +506,7 @@ static int engines_show(struct seq_file *s, void *data)
>         struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
>         struct hl_device *hdev = dev_entry->hdev;
>
> -       hdev->asic_funcs->is_device_idle(hdev, s);
> +       hdev->asic_funcs->is_device_idle(hdev, NULL, s);
>
>         return 0;
>  }
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 41e97531f300..75294ec65257 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2828,7 +2828,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
>         else
>                 timeout = HL_DEVICE_TIMEOUT_USEC;
>
> -       if (!hdev->asic_funcs->is_device_idle(hdev, NULL)) {
> +       if (!hdev->asic_funcs->is_device_idle(hdev, NULL, NULL)) {
>                 dev_err_ratelimited(hdev->dev,
>                         "Can't send KMD job on QMAN0 because the device is not idle\n");
>                 return -EBUSY;
> @@ -4914,7 +4914,8 @@ int goya_armcp_info_get(struct hl_device *hdev)
>         return 0;
>  }
>
> -static bool goya_is_device_idle(struct hl_device *hdev, struct seq_file *s)
> +static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
> +                               struct seq_file *s)
>  {
>         const char *fmt = "%-5d%-9s%#-14x%#-16x%#x\n";
>         const char *dma_fmt = "%-5d%-9s%#-14x%#x\n";
> @@ -4937,6 +4938,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, struct seq_file *s)
>                                 IS_DMA_IDLE(dma_core_sts0);
>                 is_idle &= is_eng_idle;
>
> +               if (mask)
> +                       *mask |= !is_eng_idle << (GOYA_ENGINE_ID_DMA_0 + i);
>                 if (s)
>                         seq_printf(s, dma_fmt, i, is_eng_idle ? "Y" : "N",
>                                         qm_glbl_sts0, dma_core_sts0);
> @@ -4958,6 +4961,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, struct seq_file *s)
>                                 IS_TPC_IDLE(tpc_cfg_sts);
>                 is_idle &= is_eng_idle;
>
> +               if (mask)
> +                       *mask |= !is_eng_idle << (GOYA_ENGINE_ID_TPC_0 + i);
>                 if (s)
>                         seq_printf(s, fmt, i, is_eng_idle ? "Y" : "N",
>                                 qm_glbl_sts0, cmdq_glbl_sts0, tpc_cfg_sts);
> @@ -4976,6 +4981,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, struct seq_file *s)
>                         IS_MME_IDLE(mme_arch_sts);
>         is_idle &= is_eng_idle;
>
> +       if (mask)
> +               *mask |= !is_eng_idle << GOYA_ENGINE_ID_MME_0;
>         if (s) {
>                 seq_printf(s, fmt, 0, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
>                                 cmdq_glbl_sts0, mme_arch_sts);
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index 2c9ea61099b4..10da9940ee0d 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -557,7 +557,8 @@ struct hl_asic_funcs {
>                         u32 asid, u64 va, u64 size);
>         int (*send_heartbeat)(struct hl_device *hdev);
>         int (*debug_coresight)(struct hl_device *hdev, void *data);
> -       bool (*is_device_idle)(struct hl_device *hdev, struct seq_file *s);
> +       bool (*is_device_idle)(struct hl_device *hdev, u32 *mask,
> +                               struct seq_file *s);
>         int (*soft_reset_late_init)(struct hl_device *hdev);
>         void (*hw_queues_lock)(struct hl_device *hdev);
>         void (*hw_queues_unlock)(struct hl_device *hdev);
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
> index b04585af27ad..07127576b3e8 100644
> --- a/drivers/misc/habanalabs/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
> @@ -119,7 +119,8 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
>         if ((!max_size) || (!out))
>                 return -EINVAL;
>
> -       hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev, NULL);
> +       hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev,
> +                                       &hw_idle.busy_engines_mask, NULL);
>
>         return copy_to_user(out, &hw_idle,
>                 min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index 204ab9b4ae67..3956c226ca35 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -45,6 +45,30 @@ enum goya_queue_id {
>         GOYA_QUEUE_ID_SIZE
>  };
>
> +/*
> + * Engine Numbering
> + *
> + * Used in the "busy_engines_mask" field in `struct hl_info_hw_idle'
> + */
> +
> +enum goya_engine_id {
> +       GOYA_ENGINE_ID_DMA_0 = 0,
> +       GOYA_ENGINE_ID_DMA_1,
> +       GOYA_ENGINE_ID_DMA_2,
> +       GOYA_ENGINE_ID_DMA_3,
> +       GOYA_ENGINE_ID_DMA_4,
> +       GOYA_ENGINE_ID_MME_0,
> +       GOYA_ENGINE_ID_TPC_0,
> +       GOYA_ENGINE_ID_TPC_1,
> +       GOYA_ENGINE_ID_TPC_2,
> +       GOYA_ENGINE_ID_TPC_3,
> +       GOYA_ENGINE_ID_TPC_4,
> +       GOYA_ENGINE_ID_TPC_5,
> +       GOYA_ENGINE_ID_TPC_6,
> +       GOYA_ENGINE_ID_TPC_7,
> +       GOYA_ENGINE_ID_SIZE
> +};
> +
>  enum hl_device_status {
>         HL_DEVICE_STATUS_OPERATIONAL,
>         HL_DEVICE_STATUS_IN_RESET,
> @@ -86,7 +110,11 @@ struct hl_info_dram_usage {
>
>  struct hl_info_hw_idle {
>         __u32 is_idle;
> -       __u32 pad;
> +       /*
> +        * Bitmask of busy engines.
> +        * Bits definition is according to `enum <chip>_enging_id'.
> +        */
> +       __u32 busy_engines_mask;
>  };
>
>  struct hl_info_device_status {
> --
> 2.17.1
>

This patch-set is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
