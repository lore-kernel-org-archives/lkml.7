Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED48C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBA021721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RsNUrK+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbfFMQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32941 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFMIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:20:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so1959871edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlRxJCwiPwkUyH7EE3nyXqgO0XVluxp/0ZdmWf9P5Z0=;
        b=RsNUrK+UEn6zsAOC9w9pM7uhwHxwQMGD+8t/Un0aIPb541XG2VU7OTMQe7tJ/AYugG
         G3FTQ65psDJrM6tPTQKU2rOXirC03jEhQDBtSNCzKL3RlSh+B4h4RysAzf/GD6k/xBvY
         5d4Mj8gKd6ko8kFxspCeqeasrIc8irCflYt1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlRxJCwiPwkUyH7EE3nyXqgO0XVluxp/0ZdmWf9P5Z0=;
        b=CEse12PrCJiMv/zVkHknbRB3IU+KEKxfhhSTBzimpTpksdz2YOqyHZpco18NoafJRQ
         M6xKJPMMeN2m2EYsUAHYtMUXUWuG0MvfwJ1kFf5oOzRo+wR6bJRYt15dkf62nsiU+xOe
         4zXa4t3chL3764u+WRQw5xgv4yJC6h5O5hhXpmSzSu2KAmDPz974yCm5qNgsKYHOMPj8
         fdLoByK42hB8T8DAmmluu+0o3qfCtHHj7y6NezjUaJct+MQuHtDqOh69NXnb7WBveVA/
         qGd8Z68TkZPP7wshOaEs0i3jnQnh2OkSyOcYvgzBYI07cNvbZ4ilyqavslZ4Gra3482I
         9tmQ==
X-Gm-Message-State: APjAAAXcvelRCvrBOZijPWgM5v5G1yinZk5aaHqzqo126FAz/3LpHNwj
        vYuf0uIIPm9GrVesPvNrr/QoZ2xB4cagD4QqjP7jbQ==
X-Google-Smtp-Source: APXvYqxy4qqaJLhUmiQHMs45thTIqa/dGytvJgClVC9B5jpzBc/xWQ86XsED1JEqZnHBmphRLW0uSlK+Ywh5heGNQts=
X-Received: by 2002:a50:b561:: with SMTP id z30mr38225104edd.87.1560414039622;
 Thu, 13 Jun 2019 01:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com> <1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 13 Jun 2019 16:20:03 +0800
Message-ID: <CANdKZ0emRPcTcL7Yq5nLH5z2_9fBuuczKehA8oEi0b+je15RPg@mail.gmail.com>
Subject: Re: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the possibly double-posting, my last mail got rejected by
some mailing lists.)

Hi,
When I tested this patch series (Based on linux 5.2.0-rc2, and with
various other patch series about MT8183) with lockdep enabled, and I'm
seeing the following lockdep warning on boot.

By bisecting the commits, the first commit that introduce this warning
is this patch. The warning also doesn't appear if
https://lore.kernel.org/patchwork/patch/1086582/ and
https://lore.kernel.org/patchwork/patch/1086583/ are not applied.

Do anyone have idea on why this is happening, or any suggestion on
which part I should be digging into to figure this out? Thanks.

[    4.664194] ======================================================
[    4.670368] WARNING: possible circular locking dependency detected
[    4.676545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G S
[    4.684539] ------------------------------------------------------
[    4.690714] kworker/4:1/51 is trying to acquire lock:
[    4.695760] (____ptrval____) (regulator_list_mutex){+.+.},
at:regulator_lock_dependent+0xdc/0x6c4
[    4.704732]
[    4.704732] but task is already holding lock:
[    4.710556] (____ptrval____) (&genpd->mlock/1){+.+.},
at:genpd_lock_nested_mtx+0x24/0x30
[    4.718740]
[    4.718740] which lock already depends on the new lock.
[    4.718740]
[    4.726908]
[    4.726908] the existing dependency chain (in reverse order) is:
[    4.734382]
[    4.734382] -> #4 (&genpd->mlock/1){+.+.}:
[    4.739963]        __mutex_lock_common+0x1a0/0x1fe8
[    4.744836]        mutex_lock_nested+0x40/0x50
[    4.749275]        genpd_lock_nested_mtx+0x24/0x30
[    4.754063]        genpd_add_subdomain+0x150/0x524
[    4.758850]        pm_genpd_add_subdomain+0x3c/0x5c
[    4.763723]        scpsys_probe+0x520/0xe78
[    4.767902]        platform_drv_probe+0xf4/0x134
[    4.772517]        really_probe+0x214/0x4dc
[    4.776696]        driver_probe_device+0xcc/0x1d4
[    4.781396]        __device_attach_driver+0x10c/0x180
[    4.786442]        bus_for_each_drv+0x124/0x184
[    4.790968]        __device_attach+0x1c0/0x2d8
[    4.795407]        device_initial_probe+0x20/0x2c
[    4.800106]        bus_probe_device+0x80/0x16c
[    4.804546]        deferred_probe_work_func+0x120/0x168
[    4.809767]        process_one_work+0x858/0x1208
[    4.814379]        worker_thread+0x9ec/0xcb8
[    4.818644]        kthread+0x2b8/0x2d0
[    4.822391]        ret_from_fork+0x10/0x18
[    4.826480]
[    4.826480] -> #3 (&genpd->mlock){+.+.}:
[    4.831880]        __mutex_lock_common+0x1a0/0x1fe8
[    4.836752]        mutex_lock_nested+0x40/0x50
[    4.841190]        genpd_lock_mtx+0x20/0x2c
[    4.845369]        genpd_runtime_resume+0x140/0x434
[    4.850241]        __rpm_callback+0xb0/0x1e4
[    4.854506]        rpm_callback+0x54/0x1a8
[    4.858597]        rpm_resume+0xc6c/0x10c4
[    4.862689]        __pm_runtime_resume+0xb4/0x124
[    4.867387]        device_link_add+0x598/0x8d0
[    4.871829]        mtk_smi_larb_probe+0x2b0/0x340
[    4.876528]        platform_drv_probe+0xf4/0x134
[    4.881141]        really_probe+0x214/0x4dc
[    4.885320]        driver_probe_device+0xcc/0x1d4
[    4.890020]        __device_attach_driver+0x10c/0x180
[    4.895066]        bus_for_each_drv+0x124/0x184
[    4.899591]        __device_attach+0x1c0/0x2d8
[    4.904031]        device_initial_probe+0x20/0x2c
[    4.908730]        bus_probe_device+0x80/0x16c
[    4.913169]        deferred_probe_work_func+0x120/0x168
[    4.918387]        process_one_work+0x858/0x1208
[    4.923000]        worker_thread+0x9ec/0xcb8
[    4.927264]        kthread+0x2b8/0x2d0
[    4.931009]        ret_from_fork+0x10/0x18
[    4.935098]
[    4.935098] -> #2 (dpm_list_mtx){+.+.}:
[    4.940412]        __mutex_lock_common+0x1a0/0x1fe8
[    4.945284]        mutex_lock_nested+0x40/0x50
[    4.949722]        device_pm_lock+0x1c/0x24
[    4.953900]        device_link_add+0x98/0x8d0
[    4.958252]        _regulator_get+0x3f0/0x504
[    4.962606]        _devm_regulator_get+0x58/0xb8
[    4.967218]        devm_regulator_get+0x28/0x34
[    4.971746]        pwm_backlight_probe+0x61c/0x1b90
[    4.976617]        platform_drv_probe+0xf4/0x134
[    4.981230]        really_probe+0x214/0x4dc
[    4.985409]        driver_probe_device+0xcc/0x1d4
[    4.990108]        device_driver_attach+0xe4/0x104
[    4.994894]        __driver_attach+0x134/0x14c
[    4.999333]        bus_for_each_dev+0x120/0x180
[    5.003859]        driver_attach+0x48/0x54
[    5.007950]        bus_add_driver+0x2ac/0x44c
[    5.012303]        driver_register+0x160/0x288
[    5.016742]        __platform_driver_register+0xcc/0xdc
[    5.021964]        pwm_backlight_driver_init+0x1c/0x24
[    5.027097]        do_one_initcall+0x38c/0x994
[    5.031536]        do_initcall_level+0x3a4/0x4b8
[    5.036148]        do_basic_setup+0x84/0xa0
[    5.036153]        kernel_init_freeable+0x23c/0x324
[    5.036158]        kernel_init+0x14/0x110
[    5.036164]        ret_from_fork+0x10/0x18
[    5.036166]
[    5.036166] -> #1 (device_links_lock){+.+.}:
[    5.065905]        __mutex_lock_common+0x1a0/0x1fe8
[    5.070777]        mutex_lock_nested+0x40/0x50
[    5.075215]        device_link_remove+0x40/0xe0
[    5.079740]        _regulator_put+0x104/0x2d8
[    5.084093]        regulator_put+0x30/0x44
[    5.088184]        devm_regulator_release+0x38/0x44
[    5.093056]        release_nodes+0x604/0x670
[    5.097320]        devres_release_all+0x70/0x8c
[    5.101846]        really_probe+0x270/0x4dc
[    5.106024]        driver_probe_device+0xcc/0x1d4
[    5.110724]        device_driver_attach+0xe4/0x104
[    5.115510]        __driver_attach+0x134/0x14c
[    5.119949]        bus_for_each_dev+0x120/0x180
[    5.124474]        driver_attach+0x48/0x54
[    5.128566]        bus_add_driver+0x2ac/0x44c
[    5.132919]        driver_register+0x160/0x288
[    5.137357]        __platform_driver_register+0xcc/0xdc
[    5.142576]        pwm_backlight_driver_init+0x1c/0x24
[    5.147708]        do_one_initcall+0x38c/0x994
[    5.152146]        do_initcall_level+0x3a4/0x4b8
[    5.156758]        do_basic_setup+0x84/0xa0
[    5.160936]        kernel_init_freeable+0x23c/0x324
[    5.165807]        kernel_init+0x14/0x110
[    5.169813]        ret_from_fork+0x10/0x18
[    5.173901]
[    5.173901] -> #0 (regulator_list_mutex){+.+.}:
[    5.179910]        lock_acquire+0x350/0x4d4
[    5.184088]        __mutex_lock_common+0x1a0/0x1fe8
[    5.184095]        mutex_lock_nested+0x40/0x50
[    5.197475]        regulator_lock_dependent+0xdc/0x6c4
[    5.197482]        regulator_disable+0xa0/0x138
[    5.197487]        scpsys_power_off+0x38c/0x4bc
[    5.197495]        genpd_power_off+0x3d8/0x6a0
[    5.209399]        genpd_power_off+0x530/0x6a0
[    5.209406]        genpd_power_off_work_fn+0x74/0xc0
[    5.209411]        process_one_work+0x858/0x1208
[    5.209419]        worker_thread+0x9ec/0xcb8
[    5.219067]        kthread+0x2b8/0x2d0
[    5.219073]        ret_from_fork+0x10/0x18
[    5.219077]
[    5.219077] other info that might help us debug this:
[    5.219077]
[    5.219080] Chain exists of:
[    5.219080]   regulator_list_mutex --> &genpd->mlock --> &genpd->mlock/1
[    5.219080]
[    5.228039]  Possible unsafe locking scenario:
[    5.228039]
[    5.228042]        CPU0                    CPU1
[    5.228046]        ----                    ----
[    5.228048]   lock(&genpd->mlock/1);
[    5.228058]                                lock(&genpd->mlock);
[    5.311647]                                lock(&genpd->mlock/1);
[    5.317736]   lock(regulator_list_mutex);
[    5.321742]
[    5.321742]  *** DEADLOCK ***
[    5.321742]
[    5.327655] 4 locks held by kworker/4:1/51:
[    5.331831]  #0: (____ptrval____) ((wq_completion)pm){+.+.},
at:process_one_work+0x57c/0x1208
[    5.340444]  #1: (____ptrval____)
((work_completion)(&genpd->power_off_work)){+.+.},
at:process_one_work+0x5b8/0x1208
[    5.351139]  #2: (____ptrval____) (&genpd->mlock){+.+.},
at:genpd_lock_mtx+0x20/0x2c
[    5.358970]  #3: (____ptrval____) (&genpd->mlock/1){+.+.},
at:genpd_lock_nested_mtx+0x24/0x30
[    5.367584]
[    5.367584] stack backtrace:
[    5.371939] CPU: 4 PID: 51 Comm: kworker/4:1 Tainted: G S
     5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20
[    5.382809] Workqueue: pm genpd_power_off_work_fn
[    5.382816] Call trace:
[    5.382822]  dump_backtrace+0x0/0x2c0
[    5.382830]  show_stack+0x20/0x2c
[    5.409174]  dump_stack+0x10c/0x17c
[    5.412659]  print_circular_bug+0x42c/0x4d0
[    5.416838]  __lock_acquire+0x4c88/0x5484
[    5.420843]  lock_acquire+0x350/0x4d4
[    5.424500]  __mutex_lock_common+0x1a0/0x1fe8
[    5.428851]  mutex_lock_nested+0x40/0x50
[    5.432770]  regulator_lock_dependent+0xdc/0x6c4
[    5.437383]  regulator_disable+0xa0/0x138
[    5.441389]  scpsys_power_off+0x38c/0x4bc
[    5.445393]  genpd_power_off+0x3d8/0x6a0
[    5.449310]  genpd_power_off+0x530/0x6a0
[    5.453229]  genpd_power_off_work_fn+0x74/0xc0
[    5.457667]  process_one_work+0x858/0x1208
[    5.461758]  worker_thread+0x9ec/0xcb8
[    5.465503]  kthread+0x2b8/0x2d0
[    5.468727]  ret_from_fork+0x10/0x18

On Mon, Jun 10, 2019 at 8:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
> ...
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);
>         }
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, common);
