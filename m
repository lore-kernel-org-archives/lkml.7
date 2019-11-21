Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E456206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUC3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:29:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:29715 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUC3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:29:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 18:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="290164598"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2019 18:29:31 -0800
Date:   Thu, 21 Nov 2019 10:36:43 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [LKP] Re: [irq_work] feb4a51323: BUG:soft_lockup-CPU##stuck_for#s
Message-ID: <20191121023643.GA8428@xsang-OptiPlex-9020>
References: <20191112090357.GB30590@shao2-debian>
 <20191112144954.GD27917@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112144954.GD27917@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:49:55PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 12, 2019 at 05:03:57PM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: feb4a51323babe13315c3b783ea7f1cf25368918 ("irq_work: Slightly simplify IRQ_WORK_PENDING clearing")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: blktests
> > with following parameters:
> > 
> > 	disk: 1SSD
> > 	test: block-group1
> > 
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +------------------------------------------------+------------+------------+
> > |                                                | 25269871db | feb4a51323 |
> > +------------------------------------------------+------------+------------+
> > | boot_successes                                 | 5          | 0          |
> > | boot_failures                                  | 0          | 10         |
> > | BUG:soft_lockup-CPU##stuck_for#s               | 0          | 10         |
> > | RIP:irq_work_sync                              | 0          | 10         |
> > | Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 10         |
> > +------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [   81.049506] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]
> 
> Duh! Of course we are dealing with the value of flags before we cleared IRQ_WORK_PENDING
> so later clearing IRQ_WORK_BUZY can't work.
> 

Hi Frederic Weisbecker, has this patch submited or merged to some branches? Ask this because feb4a51323
has already been merged to linux-next

> That would be the fix (cooking one with proper changelog):
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 49c53f80a13a..8ee907eb4d83 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -158,6 +158,7 @@ static void irq_work_run_list(struct llist_head *list)
>  		 * Clear the BUSY bit and return to the free state if
>  		 * no-one else claimed it meanwhile.
>  		 */
> +		flags ~= IRQ_WORK_PENDING;
>  		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
>  	}
>  }
> 
> 
> > [   81.055602] Modules linked in: scsi_debug loop intel_rapl_msr intel_rapl_common sr_mod cdrom crct10dif_pclmul crc32_pclmul bochs_drm crc32c_intel sd_mod sg ghash_clmulni_intel drm_vram_helper ata_generic pata_acpi ttm ppdev drm_kms_helper snd_pcm syscopyarea sysfillrect snd_timer aesni_intel snd sysimgblt fb_sys_fops ata_piix crypto_simd drm cryptd glue_helper libata soundcore pcspkr joydev serio_raw virtio_scsi i2c_piix4 parport_pc floppy parport ip_tables [last unloaded: scsi_debug]
> > [   81.071683] CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323bab #1
> > [   81.075435] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [   81.079031] RIP: 0010:irq_work_sync+0x4/0x10
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
