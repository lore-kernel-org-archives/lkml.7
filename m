Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0CBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EB820851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558712971;
	bh=Ue20M96ypy+Qc6e726x8xv/xePzE+90k4htRnP3iTDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gXlD0p77bUA1ywryvQ2fMxwg/iWKqM5Gwxv7kp4pLHGbK2nqTnZk2ObW1DrUMSE66
	 XrkdcXY2A0OSsRDEE/y8JyYKNfdQR1Yx0wLFrJOiXLeQ+8B3JcTypLfmmBexcJg5j4
	 0kv6JPtSvg0FCgcekwT/dszq4CJ45tQQv1HyvGkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbfEXPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:49:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:61328 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390152AbfEXPta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:49:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:49:28 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2019 08:49:28 -0700
Date:   Fri, 24 May 2019 09:44:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [5.2-rc1 regression]: nvme vs. hibernation
Message-ID: <20190524154429.GE15192@localhost.localdomain>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:22:30PM +0200, Jiri Kosina wrote:
> Hi,
> 
> Something is broken in Linus' tree (4dde821e429) with respec to 
> hibernation on my thinkpad x270, and it seems to be nvme related.
> 
> I reliably see the warning below during hibernation, and then sometimes 
> resume sort of works but the machine misbehaves here and there (seems like 
> lost IRQs), sometimes it never comes back from the hibernated state.
> 
> I will not have too much have time to look into this over weekend, so I am 
> sending this out as-is in case anyone has immediate idea. Otherwise I'll 
> bisect it on monday (I don't even know at the moment what exactly was the 
> last version that worked reliably, I'll have to figure that out as well 
> later).

I believe the warning call trace was introduced when we converted nvme to
lock-less completions. On device shutdown, we'll check queues for any
pending completions, and we temporarily disable the interrupts to make
sure that queues interrupt handler can't run concurrently.

On hibernation, most CPUs are offline, and the interrupt re-enabling
is hitting this warning that says the IRQ is not associated with any
online CPUs.

I'm sure we can find a way to fix this warning, but I'm not sure that
explains the rest of the symptoms you're describing though.
 
 
>  WARNING: CPU: 0 PID: 363 at kernel/irq/chip.c:210 irq_startup+0xff/0x110
>  Modules linked in: bnep ccm af_packet fuse 8021q garp stp mrp llc tun ip6table_mangle ip6table_filter ip6_tables iptable_mangle xt_DSCP xt_tcpudp xt_conntrac
>   snd_hda_core aes_x86_64 glue_helper crypto_simd snd_pcm cryptd e1000e ptp pcspkr joydev pps_core snd_timer i2c_i801 cfg80211 mei_me mei intel_pch_thermal th
>  CPU: 0 PID: 363 Comm: kworker/u8:4 Not tainted 5.1.0-08122-ga2d635decbfa #9
>  Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
>  Workqueue: events_unbound async_run_entry_fn
>  RIP: 0010:irq_startup+0xff/0x110
>  Code: f6 4c 89 e7 e8 92 34 00 00 85 c0 75 21 4c 89 e7 31 d2 4c 89 ee e8 e1 cc ff ff 48 89 df e8 89 fe ff ff 41 89 c4 e9 37 ff ff ff <0f> 0b eb b0 0f 0b eb ac 66 0f 1f 84 00 00 
>  44 00 00
>  RSP: 0018:ffffa05100f13bd0 EFLAGS: 00010002
>  RAX: 0000000000000200 RBX: ffff9168e360ec00 RCX: 0000000000000200
>  RDX: 0000000000000200 RSI: ffffffff9f383600 RDI: ffff9168e360ec18
>  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000007
>  R10: 000000007a6a7b55 R11: 0000000000000000 R12: 0000000000000001
>  R13: ffff9168e360ec18 R14: ffff9168e6c97000 R15: ffff9168df76c000
>  FS:  0000000000000000(0000) GS:ffff9168e7280000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fc942c4bf60 CR3: 00000001f1210002 CR4: 00000000003606e0
>  Call Trace:
>   ? __irq_get_desc_lock+0x4e/0x90
>   enable_irq+0x39/0x70
>   nvme_poll_irqdisable+0x3a3/0x470 [nvme]
>   __nvme_disable_io_queues.isra.42+0x16a/0x1d0 [nvme]
>   nvme_dev_disable+0x17e/0x1e0 [nvme]
>   ? pci_pm_poweroff+0xf0/0xf0
>   nvme_suspend+0x13/0x20 [nvme]
>   pci_pm_freeze+0x52/0xd0
>   dpm_run_callback+0x6b/0x2e0
>   __device_suspend+0x147/0x630
>   ? dpm_show_time+0xe0/0xe0
>   async_suspend+0x1a/0x90
>   async_run_entry_fn+0x39/0x160
>   process_one_work+0x1f0/0x5b0
>   ? process_one_work+0x16a/0x5b0
>   worker_thread+0x4c/0x3f0
>   kthread+0x103/0x140
>   ? process_one_work+0x5b0/0x5b0
>   ? kthread_bind+0x10/0x10
>   ret_from_fork+0x3a/0x50
>  irq event stamp: 381230
>  hardirqs last  enabled at (381229): [<ffffffff9e90910d>] _raw_spin_unlock_irqrestore+0x4d/0x70
>  hardirqs last disabled at (381230): [<ffffffff9e908fa4>] _raw_spin_lock_irqsave+0x24/0x60
>  softirqs last  enabled at (381104): [<ffffffffc0eeb734>] __iwl_mvm_mac_stop+0xa4/0x1a0 [iwlmvm]
>  softirqs last disabled at (381102): [<ffffffffc0eeeda6>] iwl_mvm_async_handlers_purge+0x26/0xa0 [iwlmvm]
