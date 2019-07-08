Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39FC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934A621738
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAmRxpxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfGHP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:59:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36660 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbfGHP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:59:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so17761270wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhoYdVDhN5ydgxX1VLJkMlHV7XsW0UoNaJF64lVsGBk=;
        b=DAmRxpxTPdcbbcK+O3HYTUcs16PFJYrX3FKsYaQ8ARene0pNY7/VYxMv28MiHrqKSd
         ziP7FSehowz+XtnvIhfzqDnMnaxcFtTI8UizF1Iai4nYy8dN8hZli9keuRW3qiFfc+U6
         bgeHUXMK7EWN/b8r2MPcUIED8wbkJ48HdvVh/WpoU3u5d0Qob191RGyPOha/ZS0C4AZU
         YBhHK286Xs/Jp3372/44rw6WNTmWLzgBc0VCAaQr9nhz9+xoUwYDZ6JK2sOvO2iUfNHT
         EbUx7t013TFxsXI+irQxn+QXARfvPOnCX0u0yZbPerk1sIZX0E/wrTubt7SPEuFwq57r
         qvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhoYdVDhN5ydgxX1VLJkMlHV7XsW0UoNaJF64lVsGBk=;
        b=BVNIcsmgt/FB5WKLj+IhQTRkHhDnboZ6R+077mCCc7hJaaAmglirruX29CLSzoe7SN
         LkEE8X1fo8D3dYS3OPB8dr4lWXz+sBD8YiJgsDAjze1VUwOTEDqFn2x7Grx8ngRVUDwM
         hsGKu0rPsTDg+JyW4A7iA/p7rjxsssyMoOoEyqXdlxjt4p9CIn3BQpHa26MWbmejaLq2
         D+0paz2uz7TGkVCNj1wGfTugJ+PJc66aGpWdmat3vABYuTZ28/bCM9ESG4kq9kZAKbgt
         6N0tSyLx76lrHSgJWApPr3qLFyhpIrsygrLlgNePi56ZLi0vUzW1A/qGjzhIcITij6OH
         ThDw==
X-Gm-Message-State: APjAAAUarCZHfDViB+Pz1vIv5QqoJScjuBaLUcAPC4Q/FJul+HqsAACy
        eoxi0gDBN6LKyTdSAeQOeC5zJqz55zDWRUtq9qA=
X-Google-Smtp-Source: APXvYqzOWGyb0Raf4FDZ29HUA5m1lTCjYaZUm5S9loe+lEPW8cJi0cTQLV9I1lj73jWGDid/rYCzvpSKiVZ31ITPSUg=
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr14725529wrm.341.1562601541504;
 Mon, 08 Jul 2019 08:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190708144205.2770771-1-arnd@arndb.de>
In-Reply-To: <20190708144205.2770771-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 11:58:50 -0400
Message-ID: <CADnq5_PT8HyLUi-tSNdXbJVJiVWV-f_io8gOabiPxDfDONEfKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] amdgpu: make pmu support optional
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>,
        Jonathan Kim <Jonathan.Kim@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Emily Deng <Emily.Deng@amd.com>, Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 10:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_PERF_EVENTS is disabled, we cannot compile the pmu
> portion of the amdgpu driver:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:48:38: error: no member named 'hw' in 'struct perf_event'
>         struct hw_perf_event *hwc = &event->hw;
>                                      ~~~~~  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:51:13: error: no member named 'attr' in 'struct perf_event'
>         if (event->attr.type != event->pmu->type)
>             ~~~~~  ^
> ...
>
> Use conditional compilation for this file.
>
> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied this patch.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3a15a46b4ecb..3f5329906fce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -54,7 +54,9 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>         amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o amdgpu_atomfirmware.o \
>         amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
>         amdgpu_gmc.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
> -       amdgpu_vm_sdma.o amdgpu_pmu.o amdgpu_discovery.o
> +       amdgpu_vm_sdma.o amdgpu_discovery.o
> +
> +amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>
>  # add asic specific block
>  amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 30989b455047..a02ccce7bf53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2816,7 +2816,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 return r;
>         }
>
> -       r = amdgpu_pmu_init(adev);
> +       if (IS_ENABLED(CONFIG_PERF_EVENTS))
> +               r = amdgpu_pmu_init(adev);
>         if (r)
>                 dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> @@ -2888,7 +2889,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         amdgpu_debugfs_regs_cleanup(adev);
>         device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>         amdgpu_ucode_sysfs_fini(adev);
> -       amdgpu_pmu_fini(adev);
> +       if (IS_ENABLED(CONFIG_PERF_EVENTS))
> +               amdgpu_pmu_fini(adev);
>         amdgpu_debugfs_preempt_cleanup(adev);
>         if (amdgpu_discovery)
>                 amdgpu_discovery_fini(adev);
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
