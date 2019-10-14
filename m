Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30594C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066FA2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfJNK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:58:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731812AbfJNK6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:58:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CD6499825EADBBABE62;
        Mon, 14 Oct 2019 18:58:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 18:58:29 +0800
Subject: Re: [PATCH 0/3] arm64: defconfig: set/unset for allmodconfig
To:     Anders Roxell <anders.roxell@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Will Deacon <will@kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        <linux@armlinux.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <507325a3-030e-2843-0f46-7e18c60257de@huawei.com>
Date:   Mon, 14 Oct 2019 11:58:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190926193030.5843-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 20:30, Anders Roxell wrote:
> Hi,
>
> I'm trying to get an allmodconfig kernel to boot. The way I configure
> the kernel is:
> 'make allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig'
> allmodconfig will use the KCONFIG_ALLCONFIG file as the base and then
> turn the rest into modules.
>
> The idea behind using the defconfig as base and then configure the rest
> as modules is to get a bootbable kernel that have as many features
> turned on as possible. That will make it possible to run as wide a
> range of testsuites as possible on a single kernel.
>
> These patches makes it possible to boot a LE kernel.

JFYI, the CMDLINE_FORCE and CPU_BIG_ENDIAN changes only allow the 
5.4-rc3 allmodconfig kernel to start to boot, but finally die, on my 
arm64 ACPI-based system.

There is a lot of complaining from the kernel during its *10 minutes* of 
booting, like this ...

    39.993176][    T1] BUG: KASAN: use-after-free in 
ghes_edac_unregister+0x28/0x70
[   39.993187][    T1] Read of size 8 at addr ffff00235a099bdc by task 
swapper/0/1
[   39.993195][    T1]
[   39.993209][    T1] CPU: 65 PID: 1 Comm: swapper/0 Tainted: G 
W         5.4.0-rc3+ #1133
[   39.993218][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   39.993227][    T1] Call trace:
[   39.993239][    T1]  dump_backtrace+0x0/0x298
[   39.993250][    T1]  show_stack+0x20/0x30
[   39.993262][    T1]  dump_stack+0x190/0x21c
[   39.993275][    T1]  print_address_description.isra.6+0x80/0x3d0
[   39.993286][    T1]  __kasan_report+0x174/0x23c
[   39.993298][    T1]  kasan_report+0xc/0x18
[   39.993310][    T1]  __asan_load8+0xa4/0xb0
[   39.993321][    T1]  ghes_edac_unregister+0x28/0x70
[   39.993333][    T1]  ghes_remove+0x274/0x2a0
[  driver_probe_device+0x190/0x1f0
[   39.993378][    T1]  device_driver_attach+0x7c/0xb0
[   39.993389][    T1]  __driver_attach+0x1b8/0x1d0
[   39.993401][    T1]  bus_for_each_dev+0xf8/0x190
[   39.993411][    T1]  driver_attach+0x34/0x40
[   39.993422][    T1]  bus_add_driver+0x1d8/0x340

and then finally a watchdog timeout panic due to a hung task:

[  624.246846][ T1143] kobject: '(null)' ((____ptrval____)): calling 
ktype release
[  624.263168][  T723]  async_synchronize_cookie_domain+0x194/0x288
[  624.269210][  T723]  async_synchronize_cookie+0x28/0x38
[  624.274473][  T723]  async_port_probe+0x70/0xa8
[  624.278833][  T850] kobject: '(null)' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[  624.278844][ T1157] kobject: '(null)' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[  624.278856][ T1157] kobject: '(null)' ((____ptrval____)): calling 
ktype release
[  624.279046][  T723]  async_run_entry_fn+0x118/0x340
[  624.287997][  T850] kobject: '(null)' ((____ptrval____)): calling 
ktype release
[  624.296975][  T723]  process_one_work+0x7b8/0xdb8
[  624.296989][  T723]  worker_thread+0x414/0x6b8
[  624.325726][  T723]  kthread+0x1d4/0x1f0
[  624.329684][  T723]  ret_from_fork+0x10/0x18
[  624.334007][  T723] INFO: task kworker/u195:4:1019 blocked for more 
than 121 seconds.
[  624.341871][  T723]       Tainted: G    B   W         5.4.0-rc3+ #1133
[  624.342853][  T415] kobject: '(null)' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[  624.348427][  T723] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  624.348439][  T723] kworker/u195:4  D28496  1019      2 0x00000028
[  624.357420][  T415] kobject: '(null)' ((____ptrval____)): calling 
ktype release
[  624.365968][  T723] Workqueue: events_unbound async_run_entry_fn
[  624.385519][  T723] Call trace:
[  624.388696][  T723]  __switch_to+0x300/0x3e8
[  624.393000][  T723]  __schedule+0xc6c/0xd38
[  624.397217][  T723]  schedule+0x10c/0x168
[  624.401262][  T723]  async_synchronize_cookie_domain+0x194/0x288
[  624.406842][  T950] kobject: '(null)' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[  624.407300][  T723]  async_synchronize_cookc_port_probe+0x5c/0xa8
[  624.421511][  T723]  async_run_entry_fn+0x118/0x340
[  624.438286][  T723]  process_one_work+0x7b8/0xdb8
[  624.443027][  T723]  worker_thread+0x414/0x6b8
[  624.447504][  T723]  kthread+0x1d4/0x1f0
[  624.451462][  T723]  ret_from_fork+0x10/0x18
[  624.455932][  T723] INFO: lockdep is turned off.
[  624.460587][  T723] Kernel panic - not syncing: hung_task: blocked tasks
[  624.467292][  T723] CPU: 48 PID: 723 Comm: khungtaskd Tainted: G    B 
   W         5.4.0-rc3+ #1133
[  624.476248][  T723] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[  624.485461][  T723] Call trace:
[  624.488603][  T723]  dump_backtrace+0x0/0x298
[  624.492958][  T723]  show_stack+0x20/0x30
[  624.496966][  T723]  dump_stack+0x190/0x21c
[  624.501148][  T723]  panic+0x274/0x5a8
[  624.504898][  T723]  watchdog+0xa44/0xa88
[  624.508906][  T723]  kthread+0x1d4/0x1f0
[  624.512827][  T723]  ret_from_fork+0x10/0x18
[  624.517387][  T723] SMP: stopping secondary CPUs
[  624.522033][  T723] Kernel Offset: disabled
[  624.526215][  T723] CPU features: 0x0002,23208a38
[  624.530915][  T723] Memory Limit: none
[  624.534815][  T723] ---[ end Kernel panic - not syncing: hung_task: 
blocked tasks ]---

I think that I'm opening a can of worms here...

John

>
> Cheers,
> Anders
>
> Anders Roxell (3):
>   arm64: configs: defconfig: enable DEBUG_PREEMPT and FTRACE
>   arm64: configs: unset CMDLINE_FORCE
>   arm64: configs: unset CPU_BIG_ENDIAN
>
>  arch/arm64/configs/defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>


