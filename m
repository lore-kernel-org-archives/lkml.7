Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D48C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F83321841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGRGmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:42:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbfGRGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:42:44 -0400
X-UUID: 6dbb75515c5f4f37ad7455b853d4817a-20190718
X-UUID: 6dbb75515c5f4f37ad7455b853d4817a-20190718
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 43158966; Thu, 18 Jul 2019 14:42:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 14:42:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 14:42:31 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <chao.hao@mediatek.com>,
        <cui.zhang@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH] regulator: core: Move device_link_remove out from regulator_list_mutex
Date:   Thu, 18 Jul 2019 14:42:26 +0800
Message-ID: <1563432146-28097-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek SMI adding device_link patch looks reveal a deadlock
issue reported in [1], This patch is to fix this deadlock issue.

This is the detailed log:

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

[1] https://patchwork.kernel.org/patch/10984803/

Reported-by: Pi-Hsun Shih <pihsun@chromium.org>
Suggested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
We are not so familiar with lockdep and regulator, Mark this as RFC.
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 955a0a1..3db9350 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2048,7 +2048,9 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
+		mutex_unlock(&regulator_list_mutex);
 		device_link_remove(regulator->dev, &rdev->dev);
+		mutex_lock(&regulator_list_mutex);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-- 
1.9.1

