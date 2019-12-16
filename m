Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781CBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B344206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfLPMik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:38:40 -0500
Received: from foss.arm.com ([217.140.110.172]:53874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfLPMik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:38:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B77C1FB;
        Mon, 16 Dec 2019 04:38:39 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2708C3F719;
        Mon, 16 Dec 2019 04:38:38 -0800 (PST)
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
To:     Anand Moon <linux.amoon@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org
References: <cover.1575932654.git.robin.murphy@arm.com>
 <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
 <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
 <2681192.H4ySjFOPB8@diego>
 <CANAwSgTL-9VCFFj-+4xsLZOxKCHtjyN4P6fYnuRSOe7cZRiWew@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f29fbb91-ffd0-5650-30b4-5791c970a834@arm.com>
Date:   Mon, 16 Dec 2019 12:38:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgTL-9VCFFj-+4xsLZOxKCHtjyN4P6fYnuRSOe7cZRiWew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 9:50 am, Anand Moon wrote:
> Hi Heiko / Robin / Soeren,
> 
> On Mon, 16 Dec 2019 at 01:57, Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Hi Anand,
>>
>> Am Sonntag, 15. Dezember 2019, 19:51:50 CET schrieb Anand Moon:
>>> On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK817,
>>>> so it makes little sense for the driver to have to have two completely
>>>> different mechanisms to handle essentially the same thing. Bring RK805
>>>> in line with the RK809/RK817 flow to clean things up.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>
>> [...]
>>
>>> I am sill getting the kernel warning on issue poweroff see below.
>>> on my Rock960 Model A
>>> I feel the reason for this is we now have two poweroff callback
>>> 1  pm_power_off = rk808_device_shutdown
>>> 2  rk8xx_syscore_shutdown
>>
>> Nope, the issue is just the i2c subsystem complaining that the
>> Rocckhip i2c drives does not provide an atomic-transfer function, see
>>          "No atomic I2C transfer handler for 'i2c-0'"
>> in your warning.
>>
>> Somewhere it was suggested that the current transfer function just
>> works as atomic as well.
>>
>>
>>> In my investigation earlier common function for shutdown solve
>>> the issue of clean shutdown.
>>
>> This is simply a result of your syscore-shutdown function running way to
>> early, before the i2c subsystem switched to using atomic transfers.
>>
>> This also indicates that this would really be way to early, as other parts
>> of the kernel could also still be running.
>>
> 
> Yes, you are correct syscore-shutdown initiates
> shutdown before all the device do clean shutdown.
> 
> So for best approach for clean atomic shutdown is to use
>    /* driver model interfaces that don't relate to enumeration  */
>          void (*shutdown)(struct i2c_client *client);
> drop the registration of syscore and use core .i2c_shutdown.

Huh? If you understand that the syscore shutdown hook is too early, why 
would it seem a good idea to pull the plug even earlier from driver 
shutdown? Not to mention that your patch as proposed breaks all the 
GPIO-based shutdown flows.

If you really care about avoiding the spurious warning, implement the 
expected polled-mode transfer function in the I2C driver. Trying to hack 
around it by issuing I2C-based shutdown from anywhere other than 
pm_power_off is a waste of everyone's time.

> I have prepare this patch on top of this series for RTF
> This patch dose clean shutdown of all the devices before poweroff.
> see the log below.
> 
> *Note*: This feature will likely break the clean reboot feature.
> Rockchip device do not perform clean reboot as some of the IP
> block are not released before clean reboot and it's remain stuck.
> Like PCIe and MMC, We need to look into this as well.

As mentioned before, that likely has nothing to do with the PMIC, and 
really sounds like the issue with Trusted Firmware not reenabling all 
the SoC power domains before reset - a fix for that has already been 
identified, see here: 
https://forum.armbian.com/topic/7552-roc-rk3399-pc-renegade-elite/?do=findComment&comment=90289

Robin.

> Shutdown log of my RK3399 Rock960 Model A
> [0] https://pastebin.com/peYxmzb7
> ------------------------------------------------------------------------
> [  OK  ] Stopped LVM2 metadata daemon.
> [  OK  ] Reached target Shutdown.
> [  OK  ] Reached target Final Step.
> [  OK  ] Closed LVM2 metadata daemon socket.
> [  OK  ] Started Power-Off.
> [  OK  ] Reached target Power-Off.
> [  542.715237] systemd-shutdown[1]: Syncing filesystems and block devices.
> [  543.158314] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> [  543.168469] systemd-journald[280]: Received SIGTERM from PID 1
> (systemd-shutdow).
> [  543.202968] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
> [  543.212365] systemd-shutdown[1]: Unmounting file systems.
> [  543.214708] [535]: Remounting '/' read-only in with options '(null)'.
> [  543.229661] EXT4-fs (mmcblk1p1): re-mounted. Opts: (null)
> [  543.239978] systemd-shutdown[1]: All filesystems unmounted.
> [  543.240481] systemd-shutdown[1]: Deactivating swaps.
> [  543.241052] systemd-shutdown[1]: All swaps deactivated.
> [  543.241514] systemd-shutdown[1]: Detaching loop devices.
> [  543.244806] systemd-shutdown[1]: All loop devices detached.
> [  543.245307] systemd-shutdown[1]: Detaching DM devices.
> [  543.245994] systemd-shutdown[1]: All DM devices detached.
> [  543.246474] systemd-shutdown[1]: All filesystems, swaps, loop
> devices and DM devices detached.
> [  543.302732] systemd-shutdown[1]: Successfully changed into root pivot.
> [  543.303356] systemd-shutdown[1]: Returning to initrd...
> [  543.339679] shutdown[1]: Syncing filesystems and block devices.
> [  543.341084] shutdown[1]: Sending SIGTERM to remaining processes...
> [  543.348948] shutdown[1]: Sending SIGKILL to remaining processes...
> [  543.356551] shutdown[1]: Unmounting file systems.
> [  543.359097] sd-umoun[541]: Unmounting '/oldroot/sys/kernel/config'.
> [  543.361716] sd-umoun[542]: Unmounting '/oldroot/sys/kernel/debug'.
> [  543.364333] sd-umoun[543]: Unmounting '/oldroot/dev/mqueue'.
> [  543.366765] sd-umoun[544]: Unmounting '/oldroot/dev/hugepages'.
> [  543.369426] sd-umoun[545]: Unmounting '/oldroot/sys/fs/cgroup/memory'.
> [  543.372338] sd-umoun[546]: Unmounting '/oldroot/sys/fs/cgroup/perf_event'.
> [  543.375030] sd-umoun[547]: Unmounting '/oldroot/sys/fs/cgroup/cpu,cpuacct'.
> [  543.377744] sd-umoun[548]: Unmounting '/oldroot/sys/fs/cgroup/pids'.
> [  543.380620] sd-umoun[549]: Unmounting '/oldroot/sys/fs/cgroup/blkio'.
> [  543.383256] sd-umoun[550]: Unmounting '/oldroot/sys/fs/cgroup/hugetlb'.
> [  543.386015] sd-umoun[551]: Unmounting '/oldroot/sys/fs/cgroup/devices'.
> [  543.389114] sd-umoun[552]: Unmounting '/oldroot/sys/fs/cgroup/cpuset'.
> [  543.391817] sd-umoun[553]: Unmounting '/oldroot/sys/fs/pstore'.
> [  543.394401] sd-umoun[554]: Unmounting '/oldroot/sys/fs/cgroup/systemd'.
> [  543.397245] sd-umoun[555]: Unmounting '/oldroot/sys/fs/cgroup/unified'.
> [  543.400083] sd-umoun[556]: Unmounting '/oldroot/sys/fs/cgroup'.
> [  543.402654] sd-umoun[557]: Unmounting '/oldroot/dev/pts'.
> [  543.405351] sd-umoun[558]: Unmounting '/oldroot/dev/shm'.
> [  543.407876] sd-umoun[559]: Unmounting '/oldroot/sys/kernel/security'.
> [  543.410313] sd-umoun[560]: Unmounting '/oldroot'.
> [  543.410886] sd-umoun[560]: Failed to unmount /oldroot: Device or
> resource busy
> [  543.413355] sd-umoun[561]: Unmounting '/oldroot/run'.
> [  543.415750] sd-umoun[562]: Unmounting '/oldroot/dev'.
> [  543.418013] sd-umoun[563]: Unmounting '/oldroot/sys'.
> [  543.420892] sd-umoun[564]: Unmounting '/oldroot/proc'.
> [  543.423833] sd-umoun[565]: Unmounting '/oldroot'.
> [  543.486268] shutdown[1]: All filesystems unmounted.
> [  543.486710] shutdown[1]: Deactivating swaps.
> [  543.487153] shutdown[1]: All swaps deactivated.
> [  543.487556] shutdown[1]: Detaching loop devices.
> [  543.490300] shutdown[1]: All loop devices detached.
> [  543.490735] shutdown[1]: Detaching DM devices.
> [  543.491382] shutdown[1]: All DM devices detached.
> [  543.491801] shutdown[1]: All filesystems, swaps, loop devices and
> DM devices detached.
> [  543.494678] shutdown[1]: Syncing filesystems and block devices.
> [  543.495770] shutdown[1]: Powering off.
> [  543.496112] kvm: exiting hardware virtualization
> 
> -Anand
> 
