Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4BC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15E208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu6for3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfFQQ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:28:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35796 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:28:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so17051678edr.2;
        Mon, 17 Jun 2019 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3rH22zxQ284IB8YCkCH6QkWClM8dExRyy9XYZnWPqk=;
        b=Iu6for3/XmxamV8VIiOIlI5JztCRwJo1pVQDLimBl3Dia9ixne4Y5w7FNziNJi5euU
         WRvDFYcWA/8kNANdDIU88YB4uNZNkjkFJ/m9G6GA7LkqS/zO8/uIU/mw6fZRMefikqBI
         67uyQdVxXeoeeiTnNw/ITyX/rd6IgtfDN//ka1iMbOwoXl1Q6qq/dbHyRVXhQ3pSiRU8
         oKC9FTlkwrOOgxWrsV8ytG10kq2QemV3clnAm2tEb6IVaU9mxOexSmw1fWCnjQT9eh3U
         aTbjYD7n767Ecw9YvlQaoG4KMPrZdQYZv4IN9IOApW+7SHHnCBEtdG05nZ4gYGOxGqjP
         Nj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a3rH22zxQ284IB8YCkCH6QkWClM8dExRyy9XYZnWPqk=;
        b=Mro0ZxIXlLoxkSZPHKu3rPvzaPvo6awBAzMR4aL4R1pPBqG8Dnsw+wLssLGIDldT1m
         5qdqJtt3WXEmNyW5MGRfDV0nCYsDpk7oBrcEYtvRPx+Fgv7SVMu8d4TmznueWKG9Mhe3
         p3bsA09THeEeIu0QTaEzM6JK5NuwtFg2TYiz9qWmpaY0GivbJKSXBA6E+xrgfQiE/MNl
         0OdpvJ8VtDx9mBJVDq05UCt7JQyMRE3NE/KD+Fgzy1UVOnaeMitt+ugdoGJK1SDNbgML
         bDM6/FbR0q7Aw1Zd5cP4uLecFy/PtwyMw1v2HwqkzJSzvAqD18VlY8FqykdkdTPQwLlI
         DhVQ==
X-Gm-Message-State: APjAAAUGnexxxBljV0n/ZA2X1IBzfQw/jtqAZ3UTU3hZUCDP6rf7+K/j
        E3zZoP/khlUWoMIdAW2YzT0=
X-Google-Smtp-Source: APXvYqw9VpoXZc5Ubgc+GWuXurCSC6CzXanks31C4SYqjdmaOGAOd3RuknqNl6M6K91SCxwJi+Be5A==
X-Received: by 2002:a17:906:8386:: with SMTP id p6mr76196658ejx.139.1560788903450;
        Mon, 17 Jun 2019 09:28:23 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.27])
        by smtp.gmail.com with ESMTPSA id u9sm2455104edm.71.2019.06.17.09.28.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 09:28:22 -0700 (PDT)
Subject: Re: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
To:     Pi-Hsun Shih <pihsun@chromium.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
 <1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
 <CANdKZ0emRPcTcL7Yq5nLH5z2_9fBuuczKehA8oEi0b+je15RPg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <99b3096f-ece2-f130-e86f-0e84c8315ff4@gmail.com>
Date:   Mon, 17 Jun 2019 18:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANdKZ0emRPcTcL7Yq5nLH5z2_9fBuuczKehA8oEi0b+je15RPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/2019 10:20, Pi-Hsun Shih wrote:
> (Sorry for the possibly double-posting, my last mail got rejected by
> some mailing lists.)
> 
> Hi,
> When I tested this patch series (Based on linux 5.2.0-rc2, and with
> various other patch series about MT8183) with lockdep enabled, and I'm
> seeing the following lockdep warning on boot.
> 
> By bisecting the commits, the first commit that introduce this warning
> is this patch. The warning also doesn't appear if

Are you sure about this?
From the lockdep call graph it looks more like patch
[PATCH v7 15/21] memory: mtk-smi: Invoke pm runtime_callback to enable clocks
has something to do with it.

But not an expert either, sorry.

Regards,
Matthias

> https://lore.kernel.org/patchwork/patch/1086582/ and
> https://lore.kernel.org/patchwork/patch/1086583/ are not applied.
> 
> Do anyone have idea on why this is happening, or any suggestion on
> which part I should be digging into to figure this out? Thanks.
> 
> [    4.664194] ======================================================
> [    4.670368] WARNING: possible circular locking dependency detected
> [    4.676545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G S
> [    4.684539] ------------------------------------------------------
> [    4.690714] kworker/4:1/51 is trying to acquire lock:
> [    4.695760] (____ptrval____) (regulator_list_mutex){+.+.},
> at:regulator_lock_dependent+0xdc/0x6c4
> [    4.704732]
> [    4.704732] but task is already holding lock:
> [    4.710556] (____ptrval____) (&genpd->mlock/1){+.+.},
> at:genpd_lock_nested_mtx+0x24/0x30
> [    4.718740]
> [    4.718740] which lock already depends on the new lock.
> [    4.718740]
> [    4.726908]
> [    4.726908] the existing dependency chain (in reverse order) is:
> [    4.734382]
> [    4.734382] -> #4 (&genpd->mlock/1){+.+.}:
> [    4.739963]        __mutex_lock_common+0x1a0/0x1fe8
> [    4.744836]        mutex_lock_nested+0x40/0x50
> [    4.749275]        genpd_lock_nested_mtx+0x24/0x30
> [    4.754063]        genpd_add_subdomain+0x150/0x524
> [    4.758850]        pm_genpd_add_subdomain+0x3c/0x5c
> [    4.763723]        scpsys_probe+0x520/0xe78
> [    4.767902]        platform_drv_probe+0xf4/0x134
> [    4.772517]        really_probe+0x214/0x4dc
> [    4.776696]        driver_probe_device+0xcc/0x1d4
> [    4.781396]        __device_attach_driver+0x10c/0x180
> [    4.786442]        bus_for_each_drv+0x124/0x184
> [    4.790968]        __device_attach+0x1c0/0x2d8
> [    4.795407]        device_initial_probe+0x20/0x2c
> [    4.800106]        bus_probe_device+0x80/0x16c
> [    4.804546]        deferred_probe_work_func+0x120/0x168
> [    4.809767]        process_one_work+0x858/0x1208
> [    4.814379]        worker_thread+0x9ec/0xcb8
> [    4.818644]        kthread+0x2b8/0x2d0
> [    4.822391]        ret_from_fork+0x10/0x18
> [    4.826480]
> [    4.826480] -> #3 (&genpd->mlock){+.+.}:
> [    4.831880]        __mutex_lock_common+0x1a0/0x1fe8
> [    4.836752]        mutex_lock_nested+0x40/0x50
> [    4.841190]        genpd_lock_mtx+0x20/0x2c
> [    4.845369]        genpd_runtime_resume+0x140/0x434
> [    4.850241]        __rpm_callback+0xb0/0x1e4
> [    4.854506]        rpm_callback+0x54/0x1a8
> [    4.858597]        rpm_resume+0xc6c/0x10c4
> [    4.862689]        __pm_runtime_resume+0xb4/0x124
> [    4.867387]        device_link_add+0x598/0x8d0
> [    4.871829]        mtk_smi_larb_probe+0x2b0/0x340
> [    4.876528]        platform_drv_probe+0xf4/0x134
> [    4.881141]        really_probe+0x214/0x4dc
> [    4.885320]        driver_probe_device+0xcc/0x1d4
> [    4.890020]        __device_attach_driver+0x10c/0x180
> [    4.895066]        bus_for_each_drv+0x124/0x184
> [    4.899591]        __device_attach+0x1c0/0x2d8
> [    4.904031]        device_initial_probe+0x20/0x2c
> [    4.908730]        bus_probe_device+0x80/0x16c
> [    4.913169]        deferred_probe_work_func+0x120/0x168
> [    4.918387]        process_one_work+0x858/0x1208
> [    4.923000]        worker_thread+0x9ec/0xcb8
> [    4.927264]        kthread+0x2b8/0x2d0
> [    4.931009]        ret_from_fork+0x10/0x18
> [    4.935098]
> [    4.935098] -> #2 (dpm_list_mtx){+.+.}:
> [    4.940412]        __mutex_lock_common+0x1a0/0x1fe8
> [    4.945284]        mutex_lock_nested+0x40/0x50
> [    4.949722]        device_pm_lock+0x1c/0x24
> [    4.953900]        device_link_add+0x98/0x8d0
> [    4.958252]        _regulator_get+0x3f0/0x504
> [    4.962606]        _devm_regulator_get+0x58/0xb8
> [    4.967218]        devm_regulator_get+0x28/0x34
> [    4.971746]        pwm_backlight_probe+0x61c/0x1b90
> [    4.976617]        platform_drv_probe+0xf4/0x134
> [    4.981230]        really_probe+0x214/0x4dc
> [    4.985409]        driver_probe_device+0xcc/0x1d4
> [    4.990108]        device_driver_attach+0xe4/0x104
> [    4.994894]        __driver_attach+0x134/0x14c
> [    4.999333]        bus_for_each_dev+0x120/0x180
> [    5.003859]        driver_attach+0x48/0x54
> [    5.007950]        bus_add_driver+0x2ac/0x44c
> [    5.012303]        driver_register+0x160/0x288
> [    5.016742]        __platform_driver_register+0xcc/0xdc
> [    5.021964]        pwm_backlight_driver_init+0x1c/0x24
> [    5.027097]        do_one_initcall+0x38c/0x994
> [    5.031536]        do_initcall_level+0x3a4/0x4b8
> [    5.036148]        do_basic_setup+0x84/0xa0
> [    5.036153]        kernel_init_freeable+0x23c/0x324
> [    5.036158]        kernel_init+0x14/0x110
> [    5.036164]        ret_from_fork+0x10/0x18
> [    5.036166]
> [    5.036166] -> #1 (device_links_lock){+.+.}:
> [    5.065905]        __mutex_lock_common+0x1a0/0x1fe8
> [    5.070777]        mutex_lock_nested+0x40/0x50
> [    5.075215]        device_link_remove+0x40/0xe0
> [    5.079740]        _regulator_put+0x104/0x2d8
> [    5.084093]        regulator_put+0x30/0x44
> [    5.088184]        devm_regulator_release+0x38/0x44
> [    5.093056]        release_nodes+0x604/0x670
> [    5.097320]        devres_release_all+0x70/0x8c
> [    5.101846]        really_probe+0x270/0x4dc
> [    5.106024]        driver_probe_device+0xcc/0x1d4
> [    5.110724]        device_driver_attach+0xe4/0x104
> [    5.115510]        __driver_attach+0x134/0x14c
> [    5.119949]        bus_for_each_dev+0x120/0x180
> [    5.124474]        driver_attach+0x48/0x54
> [    5.128566]        bus_add_driver+0x2ac/0x44c
> [    5.132919]        driver_register+0x160/0x288
> [    5.137357]        __platform_driver_register+0xcc/0xdc
> [    5.142576]        pwm_backlight_driver_init+0x1c/0x24
> [    5.147708]        do_one_initcall+0x38c/0x994
> [    5.152146]        do_initcall_level+0x3a4/0x4b8
> [    5.156758]        do_basic_setup+0x84/0xa0
> [    5.160936]        kernel_init_freeable+0x23c/0x324
> [    5.165807]        kernel_init+0x14/0x110
> [    5.169813]        ret_from_fork+0x10/0x18
> [    5.173901]
> [    5.173901] -> #0 (regulator_list_mutex){+.+.}:
> [    5.179910]        lock_acquire+0x350/0x4d4
> [    5.184088]        __mutex_lock_common+0x1a0/0x1fe8
> [    5.184095]        mutex_lock_nested+0x40/0x50
> [    5.197475]        regulator_lock_dependent+0xdc/0x6c4
> [    5.197482]        regulator_disable+0xa0/0x138
> [    5.197487]        scpsys_power_off+0x38c/0x4bc
> [    5.197495]        genpd_power_off+0x3d8/0x6a0
> [    5.209399]        genpd_power_off+0x530/0x6a0
> [    5.209406]        genpd_power_off_work_fn+0x74/0xc0
> [    5.209411]        process_one_work+0x858/0x1208
> [    5.209419]        worker_thread+0x9ec/0xcb8
> [    5.219067]        kthread+0x2b8/0x2d0
> [    5.219073]        ret_from_fork+0x10/0x18
> [    5.219077]
> [    5.219077] other info that might help us debug this:
> [    5.219077]
> [    5.219080] Chain exists of:
> [    5.219080]   regulator_list_mutex --> &genpd->mlock --> &genpd->mlock/1
> [    5.219080]
> [    5.228039]  Possible unsafe locking scenario:
> [    5.228039]
> [    5.228042]        CPU0                    CPU1
> [    5.228046]        ----                    ----
> [    5.228048]   lock(&genpd->mlock/1);
> [    5.228058]                                lock(&genpd->mlock);
> [    5.311647]                                lock(&genpd->mlock/1);
> [    5.317736]   lock(regulator_list_mutex);
> [    5.321742]
> [    5.321742]  *** DEADLOCK ***
> [    5.321742]
> [    5.327655] 4 locks held by kworker/4:1/51:
> [    5.331831]  #0: (____ptrval____) ((wq_completion)pm){+.+.},
> at:process_one_work+0x57c/0x1208
> [    5.340444]  #1: (____ptrval____)
> ((work_completion)(&genpd->power_off_work)){+.+.},
> at:process_one_work+0x5b8/0x1208
> [    5.351139]  #2: (____ptrval____) (&genpd->mlock){+.+.},
> at:genpd_lock_mtx+0x20/0x2c
> [    5.358970]  #3: (____ptrval____) (&genpd->mlock/1){+.+.},
> at:genpd_lock_nested_mtx+0x24/0x30
> [    5.367584]
> [    5.367584] stack backtrace:
> [    5.371939] CPU: 4 PID: 51 Comm: kworker/4:1 Tainted: G S
>      5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20
> [    5.382809] Workqueue: pm genpd_power_off_work_fn
> [    5.382816] Call trace:
> [    5.382822]  dump_backtrace+0x0/0x2c0
> [    5.382830]  show_stack+0x20/0x2c
> [    5.409174]  dump_stack+0x10c/0x17c
> [    5.412659]  print_circular_bug+0x42c/0x4d0
> [    5.416838]  __lock_acquire+0x4c88/0x5484
> [    5.420843]  lock_acquire+0x350/0x4d4
> [    5.424500]  __mutex_lock_common+0x1a0/0x1fe8
> [    5.428851]  mutex_lock_nested+0x40/0x50
> [    5.432770]  regulator_lock_dependent+0xdc/0x6c4
> [    5.437383]  regulator_disable+0xa0/0x138
> [    5.441389]  scpsys_power_off+0x38c/0x4bc
> [    5.445393]  genpd_power_off+0x3d8/0x6a0
> [    5.449310]  genpd_power_off+0x530/0x6a0
> [    5.453229]  genpd_power_off_work_fn+0x74/0xc0
> [    5.457667]  process_one_work+0x858/0x1208
> [    5.461758]  worker_thread+0x9ec/0xcb8
> [    5.465503]  kthread+0x2b8/0x2d0
> [    5.468727]  ret_from_fork+0x10/0x18
> 
> On Mon, Jun 10, 2019 at 8:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
>> ...
>> +       } else {
>> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +               common->base = devm_ioremap_resource(dev, res);
>> +               if (IS_ERR(common->base))
>> +                       return PTR_ERR(common->base);
>>         }
>>         pm_runtime_enable(dev);
>>         platform_set_drvdata(pdev, common);
