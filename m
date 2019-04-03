Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE74C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E01F2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDCIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:33:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:22906 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfDCIdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 01:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="288283251"
Received: from mylly.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2019 01:33:21 -0700
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rjw@rjwysocki.net
Cc:     lenb@kernel.org, hdegoede@redhat.com, rhowell@uwyo.edu,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <6ddb98c7-609c-0276-bea6-590965a3d5a1@linux.intel.com>
Date:   Wed, 3 Apr 2019 11:33:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403054352.30120-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 8:43 AM, Kai-Heng Feng wrote:
> i2c-designware-platdrv fails to work after the system restored from
> hibernation:
> [ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component type: 0xffffffff
> 
> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
> on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
> doesn't gets called by acpi_lpss_resume_early(), and this causes the
> issue.
> 
> Introduce acpi_lpss_{poweroff_late,restore_early}() to make sure
> driver's own poweroff_late and restore_early get called.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
> Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/acpi/acpi_lpss.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
On a BSW/CHT machine I have I see the warnings below at commit 
48402cee6889 after resuming from hibernation but I2C bus itself is 
working so obviously I tested only S3 when I gave the tested by.

This patch is fixing that so here's my tested by to this patch:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

But let's wait confirmation from Hans since he has machines and test 
cases where issues from shared I2C bus have shown up.

[  261.472892] ------------[ cut here ]------------
[  261.473361] 808622C1:03 already disabled
[  261.473688] WARNING: CPU: 0 PID: 149 at drivers/clk/clk.c:828 
clk_core_disable+0xca/0x210
[  261.473688] Modules linked in: hid_multitouch hid_generic i2c_hid 
iTCO_wdt atkbd libps2 intel_rapl coretemp aesni_intel aes_x86_64 
crypto_simd glue_helper intel_cstate i915 i2c_i801 intel_gtt 
i2c_algo_bit lpc_ich drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops drm battery tpm_tis i8042 serio i2c_designware_platform 
video i2c_designware_core tpm_tis_core tpm pinctrl_cherryview button 
rng_core ac i2c_dev i2c_core loop
[  261.473688] CPU: 0 PID: 149 Comm: kworker/0:2 Not tainted 4.19.0-rc3+ #8
[  261.473688] Workqueue: pm pm_runtime_work
[  261.473688] RIP: 0010:clk_core_disable+0xca/0x210
[  261.473688] Code: ff ff ff 48 8b 33 48 c7 c7 c3 09 e5 81 e8 98 02 c5 
ff 0f 0b 5b 41 5c 41 5d 5d c3 48 8b 33 48 c7 c7 ae 09 e5 81 e8 80 02 c5 
ff <0f> 0b e9 60 ff ff ff 65 8b 05 f8 84 c0 7e 89 c0 48 0f a3 05 ae 56
[  261.473688] RSP: 0000:ffffc900005ebc58 EFLAGS: 00010082
[  261.473688] RAX: 0000000000000000 RBX: ffff880179d02100 RCX: 
0000000000000006
[  261.473688] RDX: 0000000000000007 RSI: 0000000000000000 RDI: 
ffff88017ba156d0
[  261.473688] RBP: ffffc900005ebc70 R08: 0000000000000000 R09: 
0000000000000001
[  261.473688] R10: 0000000000000004 R11: 0000000000000000 R12: 
ffff880179d02100
[  261.473688] R13: ffff880179d31948 R14: ffffffff813b6030 R15: 
0000000000000008
[  261.473688] FS:  0000000000000000(0000) GS:ffff88017ba00000(0000) 
knlGS:0000000000000000
[  261.473688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  261.473688] CR2: 00000000570a34bc CR3: 00000001758df000 CR4: 
00000000001006f0
[  261.473688] Call Trace:
[  261.473688]  clk_core_disable_lock+0x1a/0x30
[  261.473688]  clk_disable+0x1a/0x20
[  261.473688]  i2c_dw_prepare_clk+0x25/0x60 [i2c_designware_core]
[  261.473688]  ? i2c_dw_disable+0xd/0x40 [i2c_designware_core]
[  261.473688]  dw_i2c_plat_suspend+0x2e/0x40 [i2c_designware_platform]
[  261.473688]  pm_generic_runtime_suspend+0x2c/0x30
[  261.473688]  acpi_lpss_runtime_suspend+0xd/0x30
[  261.473688]  __rpm_callback+0x75/0x1c0
[  261.473688]  ? acpi_lpss_suspend+0x1b0/0x1b0
[  261.473688]  rpm_callback+0x1f/0x80
[  261.473688]  ? acpi_lpss_suspend+0x1b0/0x1b0
[  261.473688]  rpm_suspend+0x143/0x6b0
[  261.473688]  rpm_idle+0x106/0x3c0
[  261.473688]  pm_runtime_work+0x7b/0xc0
[  261.473688]  process_one_work+0x206/0x5a0
[  261.473688]  worker_thread+0x3f/0x3a0
[  261.473688]  kthread+0x126/0x140
[  261.473688]  ? process_one_work+0x5a0/0x5a0
[  261.473688]  ? kthread_park+0x80/0x80
[  261.473688]  ret_from_fork+0x3a/0x50
[  261.473688] irq event stamp: 1506
[  261.473688] hardirqs last  enabled at (1505): [<ffffffff8170e797>] 
_raw_spin_unlock_irq+0x27/0x40
[  261.473688] hardirqs last disabled at (1506): [<ffffffff81406acd>] 
clk_enable_lock+0xd/0xa0
[  261.473688] softirqs last  enabled at (1310): [<ffffffff81a00285>] 
__do_softirq+0x285/0x464
[  261.473688] softirqs last disabled at (1303): [<ffffffff8105e3dd>] 
irq_exit+0x9d/0xd0
[  261.473688] ---[ end trace b9e91dac2ca18298 ]---
[  261.509646] done.
[  261.513366] PM: hibernation exit
[  261.530737] ------------[ cut here ]------------
[  261.531249] 808622C1:03 already unprepared
[  261.531629] WARNING: CPU: 0 PID: 149 at drivers/clk/clk.c:687 
clk_core_unprepare+0x1aa/0x2e0
[  261.532253] Modules linked in: hid_multitouch hid_generic i2c_hid 
iTCO_wdt atkbd libps2 intel_rapl coretemp aesni_intel aes_x86_64 
crypto_simd glue_helper intel_cstate i915 i2c_i801 intel_gtt 
i2c_algo_bit lpc_ich drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops drm battery tpm_tis i8042 serio i2c_designware_platform 
video i2c_designware_core tpm_tis_core tpm pinctrl_cherryview button 
rng_core ac i2c_dev i2c_core loop
[  261.532253] CPU: 0 PID: 149 Comm: kworker/0:2 Tainted: G        W 
     4.19.0-rc3+ #8
[  261.532253] Workqueue: pm pm_runtime_work
[  261.532253] RIP: 0010:clk_core_unprepare+0x1aa/0x2e0
[  261.532253] Code: 00 00 74 2d 65 ff 0d e5 e7 c0 7e 0f 85 11 ff ff ff 
e8 ea b3 bf ff e9 07 ff ff ff 48 8b 33 48 c7 c7 66 09 e5 81 e8 e0 07 c5 
ff <0f> 0b e9 91 fe ff ff e8 9a 58 cd ff 85 c0 75 ca 48 c7 c2 10 6a de
[  261.532253] RSP: 0018:ffffc900005ebc78 EFLAGS: 00210286
[  261.532253] RAX: 0000000000000000 RBX: ffff880179d02100 RCX: 
0000000000000006
[  261.532253] RDX: 0000000000000007 RSI: ffff880175a188d8 RDI: 
ffff88017ba156d0
[  261.532253] RBP: ffffc900005ebc88 R08: 000000007df0eb62 R09: 
0000000000000000
[  261.532253] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[  261.532253] R13: ffff880179d31948 R14: ffffffff813b6030 R15: 
0000000000000008
[  261.532253] FS:  0000000000000000(0000) GS:ffff88017ba00000(0000) 
knlGS:0000000000000000
[  261.532253] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  261.532253] CR2: 00000000f66ca000 CR3: 0000000177c85000 CR4: 
00000000001006f0
[  261.532253] Call Trace:
[  261.532253]  clk_unprepare+0x23/0x30
[  261.532253]  i2c_dw_prepare_clk+0x2d/0x60 [i2c_designware_core]
[  261.532253]  ? i2c_dw_disable+0xd/0x40 [i2c_designware_core]
[  261.532253]  dw_i2c_plat_suspend+0x2e/0x40 [i2c_designware_platform]
[  261.532253]  pm_generic_runtime_suspend+0x2c/0x30
[  261.532253]  acpi_lpss_runtime_suspend+0xd/0x30
[  261.532253]  __rpm_callback+0x75/0x1c0
[  261.532253]  ? acpi_lpss_suspend+0x1b0/0x1b0
[  261.532253]  rpm_callback+0x1f/0x80
[  261.532253]  ? acpi_lpss_suspend+0x1b0/0x1b0
[  261.532253]  rpm_suspend+0x143/0x6b0
[  261.532253]  rpm_idle+0x106/0x3c0
[  261.532253]  pm_runtime_work+0x7b/0xc0
[  261.532253]  process_one_work+0x206/0x5a0
[  261.532253]  worker_thread+0x3f/0x3a0
[  261.532253]  kthread+0x126/0x140
[  261.532253]  ? process_one_work+0x5a0/0x5a0
[  261.532253]  ? kthread_park+0x80/0x80
[  261.532253]  ret_from_fork+0x3a/0x50
[  261.532253] irq event stamp: 1542
[  261.532253] hardirqs last  enabled at (1541): [<ffffffff810cd4a5>] 
console_unlock+0x3f5/0x5c0
[  261.532253] hardirqs last disabled at (1542): [<ffffffff81001a6e>] 
trace_hardirqs_off_thunk+0x1a/0x1c
[  261.532253] softirqs last  enabled at (1522): [<ffffffff81a00285>] 
__do_softirq+0x285/0x464
[  261.532253] softirqs last disabled at (1509): [<ffffffff8105e3dd>] 
irq_exit+0x9d/0xd0
[  261.532253] ---[ end trace b9e91dac2ca18299 ]---
