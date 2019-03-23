Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72163C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5DD218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfCWN5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:57:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:17145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:57:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 06:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="127999269"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2019 06:55:47 -0700
Received: from pbayerle-mobl.amr.corp.intel.com (pbayerle-mobl.amr.corp.intel.com [10.254.188.179])
        by linux.intel.com (Postfix) with ESMTP id 9916E5804B6;
        Sat, 23 Mar 2019 06:55:46 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
Date:   Sat, 23 Mar 2019 09:55:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 6:39 PM, Guenter Roeck wrote:
> If codec registration fails after the ASoC Intel SST driver has been probed,
> the kernel will Oops and crash at suspend/resume.
> 
> general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 2811 Comm: cat Tainted: G        W         4.19.30 #15
> Hardware name: GOOGLE Clapper, BIOS Google_Clapper.5216.199.7 08/22/2014
> RIP: 0010:snd_soc_suspend+0x5a/0xd21
> Code: 03 80 3c 10 00 49 89 d7 74 0b 48 89 df e8 71 72 c4 fe 4c 89
> fa 48 8b 03 48 89 45 d0 48 8d 98 a0 01 00 00 48 89 d8 48 c1 e8 03
> <8a> 04 10 84 c0 0f 85 85 0c 00 00 80 3b 00 0f 84 6b 0c 00 00 48 8b
> RSP: 0018:ffff888035407750 EFLAGS: 00010202
> RAX: 0000000000000034 RBX: 00000000000001a0 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88805c417098
> RBP: ffff8880354077b0 R08: dffffc0000000000 R09: ffffed100b975718
> R10: 0000000000000001 R11: ffffffff949ea4a3 R12: 1ffff1100b975746
> R13: dffffc0000000000 R14: ffff88805cba4588 R15: dffffc0000000000
> FS:  0000794a78e91b80(0000) GS:ffff888068d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007bd5283ccf58 CR3: 000000004b7aa000 CR4: 00000000001006e0
> Call Trace:
> ? dpm_complete+0x67b/0x67b
> ? i915_gem_suspend+0x14d/0x1ad
> sst_soc_prepare+0x91/0x1dd
> ? sst_be_hw_params+0x7e/0x7e
> dpm_prepare+0x39a/0x88b
> dpm_suspend_start+0x13/0x9d
> suspend_devices_and_enter+0x18f/0xbd7
> ? arch_suspend_enable_irqs+0x11/0x11
> ? printk+0xd9/0x12d
> ? lock_release+0x95f/0x95f
> ? log_buf_vmcoreinfo_setup+0x131/0x131
> ? rcu_read_lock_sched_held+0x140/0x22a
> ? __bpf_trace_rcu_utilization+0xa/0xa
> ? __pm_pr_dbg+0x186/0x190
> ? pm_notifier_call_chain+0x39/0x39
> ? suspend_test+0x9d/0x9d
> pm_suspend+0x2f4/0x728
> ? trace_suspend_resume+0x3da/0x3da
> ? lock_release+0x95f/0x95f
> ? kernfs_fop_write+0x19f/0x32d
> state_store+0xd8/0x147
> ? sysfs_kf_read+0x155/0x155
> kernfs_fop_write+0x23e/0x32d
> __vfs_write+0x108/0x608
> ? vfs_read+0x2e9/0x2e9
> ? rcu_read_lock_sched_held+0x140/0x22a
> ? __bpf_trace_rcu_utilization+0xa/0xa
> ? debug_smp_processor_id+0x10/0x10
> ? selinux_file_permission+0x1c5/0x3c8
> ? rcu_sync_lockdep_assert+0x6a/0xad
> ? __sb_start_write+0x129/0x2ac
> vfs_write+0x1aa/0x434
> ksys_write+0xfe/0x1be
> ? __ia32_sys_read+0x82/0x82
> do_syscall_64+0xcd/0x120
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> In the observed situation, the problem is seen because the codec driver
> failed to probe due to a hardware problem.
> 
> max98090 i2c-193C9890:00: Failed to read device revision: -1
> max98090 i2c-193C9890:00: ASoC: failed to probe component -1
> cht-bsw-max98090 cht-bsw-max98090: ASoC: failed to instantiate card -1
> cht-bsw-max98090 cht-bsw-max98090: snd_soc_register_card failed -1
> cht-bsw-max98090: probe of cht-bsw-max98090 failed with error -1
> 
> The problem is similar to the problem solved with commit 2fc995a87f2e
> ("ASoC: intel: Fix crash at suspend/resume without card registration"),
> but codec registration fails at a later point. At that time, the pointer
> checked with the above mentioned commit is already set, but it is not
> cleared if the device is subsequently removed. Adding a remove function
> to clear the pointer fixes the problem.

Makes sense

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I'd like to highlight that there is a fundamental flaw in the way the 
machine drivers are handled. Since we don't have a hook for the machine 
driver in the BIOS, the DSP driver creates a platform_device which will 
instantiate the machine driver. When errors happen in the machine driver 
probe, they are suppressed due to a 'feature' of the device model, so 
you can end-up with a broken configuration that is still reported as a 
successful strobe.

> 
> Cc: stable@vger.kernel.org
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Curtis Malainey <cujomalainey@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 08cea5b5cda9..0e8b1c5eec88 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -706,9 +706,17 @@ static int sst_soc_probe(struct snd_soc_component *component)
>   	return sst_dsp_init_v2_dpcm(component);
>   }
>   
> +static void sst_soc_remove(struct snd_soc_component *component)
> +{
> +	struct sst_data *drv = dev_get_drvdata(component->dev);
> +
> +	drv->soc_card = NULL;
> +}
> +
>   static const struct snd_soc_component_driver sst_soc_platform_drv  = {
>   	.name		= DRV_NAME,
>   	.probe		= sst_soc_probe,
> +	.remove		= sst_soc_remove,
>   	.ops		= &sst_platform_ops,
>   	.compr_ops	= &sst_platform_compr_ops,
>   	.pcm_new	= sst_pcm_new,
> 

