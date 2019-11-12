Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8439BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552082196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573570201;
	bh=4fqdvP6up2gG/YlhVpibyd2Zd4xfS9zZ2TTUfxfKFhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWtX9PbTfq9CGAapE/7UmlNn0/Vj3P/8PWnfsnPFlj4ciiVcZaPPME1HF5FxBq3Mn
	 uM7TKcAJdH2lLDFqg8BXEtt8ZRZ2A9fzbF08U+NIJNxXE15dYGbsGbEJ1K+Cn7xHZY
	 xZvhouxeDTkt/39nJLYT7uOIAVKOO5iR41Dpy/b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKLOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfKLOt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:49:59 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167A82067B;
        Tue, 12 Nov 2019 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573570198;
        bh=4fqdvP6up2gG/YlhVpibyd2Zd4xfS9zZ2TTUfxfKFhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mAmBugc+9QMbKP4PBKpwLLbQle12+8kgtbznCY1VlcBQ+btM4tYhpCmnqgca95G1
         KMNjvHpRxEYKmIME/13KN1egmLAaA2bj1lxOWxQxujxSVrVZ7URDXNrTMZEaMqRXj2
         gixK760JdHFs/uIZ15HlaGTSzROwR6GIZmE3g3Eg=
Date:   Tue, 12 Nov 2019 15:49:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [irq_work] feb4a51323: BUG:soft_lockup-CPU##stuck_for#s
Message-ID: <20191112144954.GD27917@lenoir>
References: <20191112090357.GB30590@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112090357.GB30590@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 05:03:57PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: feb4a51323babe13315c3b783ea7f1cf25368918 ("irq_work: Slightly simplify IRQ_WORK_PENDING clearing")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: blktests
> with following parameters:
> 
> 	disk: 1SSD
> 	test: block-group1
> 
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------+------------+------------+
> |                                                | 25269871db | feb4a51323 |
> +------------------------------------------------+------------+------------+
> | boot_successes                                 | 5          | 0          |
> | boot_failures                                  | 0          | 10         |
> | BUG:soft_lockup-CPU##stuck_for#s               | 0          | 10         |
> | RIP:irq_work_sync                              | 0          | 10         |
> | Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 10         |
> +------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   81.049506] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]

Duh! Of course we are dealing with the value of flags before we cleared IRQ_WORK_PENDING
so later clearing IRQ_WORK_BUZY can't work.

That would be the fix (cooking one with proper changelog):

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 49c53f80a13a..8ee907eb4d83 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -158,6 +158,7 @@ static void irq_work_run_list(struct llist_head *list)
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
 		 */
+		flags ~= IRQ_WORK_PENDING;
 		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
 	}
 }


> [   81.055602] Modules linked in: scsi_debug loop intel_rapl_msr intel_rapl_common sr_mod cdrom crct10dif_pclmul crc32_pclmul bochs_drm crc32c_intel sd_mod sg ghash_clmulni_intel drm_vram_helper ata_generic pata_acpi ttm ppdev drm_kms_helper snd_pcm syscopyarea sysfillrect snd_timer aesni_intel snd sysimgblt fb_sys_fops ata_piix crypto_simd drm cryptd glue_helper libata soundcore pcspkr joydev serio_raw virtio_scsi i2c_piix4 parport_pc floppy parport ip_tables [last unloaded: scsi_debug]
> [   81.071683] CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323bab #1
> [   81.075435] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   81.079031] RIP: 0010:irq_work_sync+0x4/0x10
