Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A6C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NI8CWqaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfIQNLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:11:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40899 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfIQNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:11:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so2970879ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agGD+OceeAoSXyajv3PLn4SDyOKUdKoL2Dvecn2XVuI=;
        b=NI8CWqaW08mcBrLutRb++lRrcHXUvc2JQi2cH2CVWH9OG5Rr37gGqw1TPJz6GyXqDX
         2lyTr+EECGSw1TlHrNS2MOGprJfxP6oXNdp1pYAwqtzb3h4Tkg/KWoykdc2773MEe+2b
         x3pJ9MaS+PFrFrj84OItstJBqN33igh8WDWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agGD+OceeAoSXyajv3PLn4SDyOKUdKoL2Dvecn2XVuI=;
        b=BNseP6jpfE8z6YXD18WJxZL0Ha8pYjl8cXjqa9BZoo1lYhlBHkMh4/mqpujZaYuQBw
         tPfdK+Jk2PHiWRlBoxrX9/SUBpxuARuWhRdjdPOkqvDJJSclmpsTBXZUpewWtjOWTuuf
         uALh6X3RAU4j2+elI3VYyoQvduUd0JiSaFwUuVBDSbZSxHHcx0/Q05v+DVV0PKcMuP4M
         B8QXhn3mPIT7gb7eUNh8yWJeWfVff5gyNatravuxWQIyOrbRMXhltdRuiFZesoTK+GjL
         jdrOZgBCSwBXKWmVMfEQTjC4C8ZYNos/f32MMw3iTbA3g1rhI3ZWCjbUO27uuDjb+Mi3
         ofDA==
X-Gm-Message-State: APjAAAX2I2IDCk0Jdl8NdRGuaEi2lbBArlkQT+Lz6BtBLR+TrlYuw+AD
        Rfik8ezhizBzEkakGHqfsb7OVZZjJ45QeOirtgtGtA==
X-Google-Smtp-Source: APXvYqyGRMXtfIvCXpkFVAN1LiGA5oRDUDj+yJKHpCyq4Ouhe7ZX38Xh97Mn6/YKy848RQA13Ipj8REcmxWTapa75sg=
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr2740374oto.281.1568725899790;
 Tue, 17 Sep 2019 06:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 17 Sep 2019 15:11:27 +0200
Message-ID: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 11:43 AM Lowry Li (Arm Technology China)
<Lowry.Li@arm.com> wrote:
>
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>
> Adds to print the event message when error happens and the same event
> will not be printed until next vsync.
>
> Changes since v2:
> 1. Refine komeda_sprintf();
> 2. Not using STR_SZ macro for the string size in komeda_print_events().
>
> Changes since v1:
> 1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
> 2. Changing the max string size to 256.
>
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/Kconfig               |   6 +
>  drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 140 ++++++++++++++++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
>  5 files changed, 167 insertions(+)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
>
> diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/display/Kconfig
> index cec0639..e87ff86 100644
> --- a/drivers/gpu/drm/arm/display/Kconfig
> +++ b/drivers/gpu/drm/arm/display/Kconfig
> @@ -12,3 +12,9 @@ config DRM_KOMEDA
>           Processor driver. It supports the D71 variants of the hardware.
>
>           If compiled as a module it will be called komeda.
> +
> +config DRM_KOMEDA_ERROR_PRINT
> +       bool "Enable komeda error print"
> +       depends on DRM_KOMEDA
> +       help
> +         Choose this option to enable error printing.
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> index 5c3900c..f095a1c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -22,4 +22,6 @@ komeda-y += \
>         d71/d71_dev.o \
>         d71/d71_component.o
>
> +komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) += komeda_event.o
> +
>  obj-$(CONFIG_DRM_KOMEDA) += komeda.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index d1c86b6..e28e7e6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -40,6 +40,17 @@
>  #define KOMEDA_ERR_TTNG                        BIT_ULL(30)
>  #define KOMEDA_ERR_TTF                 BIT_ULL(31)
>
> +#define KOMEDA_ERR_EVENTS      \
> +       (KOMEDA_EVENT_URUN      | KOMEDA_EVENT_IBSY     | KOMEDA_EVENT_OVR |\
> +       KOMEDA_ERR_TETO         | KOMEDA_ERR_TEMR       | KOMEDA_ERR_TITR |\
> +       KOMEDA_ERR_CPE          | KOMEDA_ERR_CFGE       | KOMEDA_ERR_AXIE |\
> +       KOMEDA_ERR_ACE0         | KOMEDA_ERR_ACE1       | KOMEDA_ERR_ACE2 |\
> +       KOMEDA_ERR_ACE3         | KOMEDA_ERR_DRIFTTO    | KOMEDA_ERR_FRAMETO |\
> +       KOMEDA_ERR_ZME          | KOMEDA_ERR_MERR       | KOMEDA_ERR_TCF |\
> +       KOMEDA_ERR_TTNG         | KOMEDA_ERR_TTF)
> +
> +#define KOMEDA_WARN_EVENTS     KOMEDA_ERR_CSCE
> +
>  /* malidp device id */
>  enum {
>         MALI_D71 = 0,
> @@ -207,4 +218,8 @@ struct komeda_dev {
>
>  struct komeda_dev *dev_to_mdev(struct device *dev);
>
> +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> +void komeda_print_events(struct komeda_events *evts);
> +#endif
> +
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> new file mode 100644
> index 0000000..a36fb86
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <drm/drm_print.h>
> +
> +#include "komeda_dev.h"
> +
> +struct komeda_str {
> +       char *str;
> +       u32 sz;
> +       u32 len;
> +};
> +
> +/* return 0 on success,  < 0 on no space.
> + */
> +static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...)
> +{
> +       va_list args;
> +       int num, free_sz;
> +       int err;
> +
> +       free_sz = str->sz - str->len - 1;
> +       if (free_sz <= 0)
> +               return -ENOSPC;
> +
> +       va_start(args, fmt);
> +
> +       num = vsnprintf(str->str + str->len, free_sz, fmt, args);
> +
> +       va_end(args);
> +
> +       if (num < free_sz) {
> +               str->len += num;
> +               err = 0;
> +       } else {
> +               str->len = str->sz - 1;
> +               err = -ENOSPC;
> +       }
> +
> +       return err;
> +}
> +
> +static void evt_sprintf(struct komeda_str *str, u64 evt, const char *msg)
> +{
> +       if (evt)
> +               komeda_sprintf(str, msg);
> +}
> +
> +static void evt_str(struct komeda_str *str, u64 events)
> +{
> +       if (events == 0ULL) {
> +               komeda_sprintf(str, "None");
> +               return;
> +       }
> +
> +       evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
> +       evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
> +       evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
> +       evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
> +
> +       evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
> +       evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
> +
> +       /* GLB error */
> +       evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
> +       evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> +
> +       /* DOU error */
> +       evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
> +       evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
> +       evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
> +
> +       /* LPU errors or events */
> +       evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
> +       evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
> +       evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
> +       evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
> +       evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
> +       evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
> +
> +       /* LPU TBU errors*/
> +       evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
> +
> +       /* CU errors*/
> +       evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
> +       evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
> +       evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
> +       evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> +
> +       if (str->len > 0 && (str->str[str->len - 1] == '|')) {
> +               str->str[str->len - 1] = 0;
> +               str->len--;
> +       }
> +}
> +
> +static bool is_new_frame(struct komeda_events *a)
> +{
> +       return (a->pipes[0] | a->pipes[1]) &
> +              (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
> +}
> +
> +void komeda_print_events(struct komeda_events *evts)
> +{
> +       u64 print_evts = KOMEDA_ERR_EVENTS;
> +       static bool en_print = true;
> +
> +       /* reduce the same msg print, only print the first evt for one frame */
> +       if (evts->global || is_new_frame(evts))
> +               en_print = true;
> +       if (!en_print)
> +               return;
> +
> +       if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
> +               char msg[256];
> +               struct komeda_str str;
> +
> +               str.str = msg;
> +               str.sz  = sizeof(msg);
> +               str.len = 0;
> +
> +               komeda_sprintf(&str, "gcu: ");
> +               evt_str(&str, evts->global);
> +               komeda_sprintf(&str, ", pipes[0]: ");
> +               evt_str(&str, evts->pipes[0]);
> +               komeda_sprintf(&str, ", pipes[1]: ");
> +               evt_str(&str, evts->pipes[1]);
> +
> +               DRM_ERROR("err detect: %s\n", msg);
> +
> +               en_print = false;
> +       }
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 419a8b0..0fafc36 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -47,6 +47,10 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
>         memset(&evts, 0, sizeof(evts));
>         status = mdev->funcs->irq_handler(mdev, &evts);
>
> +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> +       komeda_print_events(&evts);
> +#endif

#ifdef in code is discouraged, the usual way we handle these cases is
by having a dummy static inline function which does nothing in the
headers for the case a config option isn't enabled.
-Daniel

> +
>         /* Notify the crtc to handle the events */
>         for (i = 0; i < kms->n_crtcs; i++)
>                 komeda_crtc_handle_event(&kms->crtcs[i], &evts);
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
