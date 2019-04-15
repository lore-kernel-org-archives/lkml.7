Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138EC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B1D218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355250;
	bh=xbq8+N/Rmnb9W4kf7biegwCefl9XjEhlodcaUAF9ov4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqOWSLmQiVoNod0Z0tah9/csUjsrUbwFQbpQQ0OhjXMbpWoD3aQ0blLRTytBOR7vp
	 baKewKyrrxiCFOGrVl7ysIInJIKderbPs7IW+u6VJq8unJu/Cq/52GK/PGztt4MYtj
	 CsHZ62CnqQc7Sz/2aaFLT7DJ1+MPes11N0du7JD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfDOTH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbfDOTH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60BB218FF;
        Mon, 15 Apr 2019 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355245;
        bh=xbq8+N/Rmnb9W4kf7biegwCefl9XjEhlodcaUAF9ov4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waf90+s8EsAu+R5Xt7hrGKnJuh5Koecwfmv1TOY+031+ZgNHB1HZ985cIKDgt6zgF
         NDi1B8Zv5EvD2b20kq+uNisTZFvE+XrvzJfQgxRSV1OawIIEsevk35SV5TmXPMPE9k
         soculFypjYTRaF5fwTNkCTS/hmFgNxGxIhZvMtns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 065/101] ASoC: intel: Fix crash at suspend/resume after failed codec registration
Date:   Mon, 15 Apr 2019 20:59:03 +0200
Message-Id: <20190415183743.929772812@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

commit 8f71370f4b02730e8c27faf460af7a3586e24e1f upstream.

If codec registration fails after the ASoC Intel SST driver has been probed,
the kernel will Oops and crash at suspend/resume.

general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 2811 Comm: cat Tainted: G        W         4.19.30 #15
Hardware name: GOOGLE Clapper, BIOS Google_Clapper.5216.199.7 08/22/2014
RIP: 0010:snd_soc_suspend+0x5a/0xd21
Code: 03 80 3c 10 00 49 89 d7 74 0b 48 89 df e8 71 72 c4 fe 4c 89
fa 48 8b 03 48 89 45 d0 48 8d 98 a0 01 00 00 48 89 d8 48 c1 e8 03
<8a> 04 10 84 c0 0f 85 85 0c 00 00 80 3b 00 0f 84 6b 0c 00 00 48 8b
RSP: 0018:ffff888035407750 EFLAGS: 00010202
RAX: 0000000000000034 RBX: 00000000000001a0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88805c417098
RBP: ffff8880354077b0 R08: dffffc0000000000 R09: ffffed100b975718
R10: 0000000000000001 R11: ffffffff949ea4a3 R12: 1ffff1100b975746
R13: dffffc0000000000 R14: ffff88805cba4588 R15: dffffc0000000000
FS:  0000794a78e91b80(0000) GS:ffff888068d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007bd5283ccf58 CR3: 000000004b7aa000 CR4: 00000000001006e0
Call Trace:
? dpm_complete+0x67b/0x67b
? i915_gem_suspend+0x14d/0x1ad
sst_soc_prepare+0x91/0x1dd
? sst_be_hw_params+0x7e/0x7e
dpm_prepare+0x39a/0x88b
dpm_suspend_start+0x13/0x9d
suspend_devices_and_enter+0x18f/0xbd7
? arch_suspend_enable_irqs+0x11/0x11
? printk+0xd9/0x12d
? lock_release+0x95f/0x95f
? log_buf_vmcoreinfo_setup+0x131/0x131
? rcu_read_lock_sched_held+0x140/0x22a
? __bpf_trace_rcu_utilization+0xa/0xa
? __pm_pr_dbg+0x186/0x190
? pm_notifier_call_chain+0x39/0x39
? suspend_test+0x9d/0x9d
pm_suspend+0x2f4/0x728
? trace_suspend_resume+0x3da/0x3da
? lock_release+0x95f/0x95f
? kernfs_fop_write+0x19f/0x32d
state_store+0xd8/0x147
? sysfs_kf_read+0x155/0x155
kernfs_fop_write+0x23e/0x32d
__vfs_write+0x108/0x608
? vfs_read+0x2e9/0x2e9
? rcu_read_lock_sched_held+0x140/0x22a
? __bpf_trace_rcu_utilization+0xa/0xa
? debug_smp_processor_id+0x10/0x10
? selinux_file_permission+0x1c5/0x3c8
? rcu_sync_lockdep_assert+0x6a/0xad
? __sb_start_write+0x129/0x2ac
vfs_write+0x1aa/0x434
ksys_write+0xfe/0x1be
? __ia32_sys_read+0x82/0x82
do_syscall_64+0xcd/0x120
entry_SYSCALL_64_after_hwframe+0x49/0xbe

In the observed situation, the problem is seen because the codec driver
failed to probe due to a hardware problem.

max98090 i2c-193C9890:00: Failed to read device revision: -1
max98090 i2c-193C9890:00: ASoC: failed to probe component -1
cht-bsw-max98090 cht-bsw-max98090: ASoC: failed to instantiate card -1
cht-bsw-max98090 cht-bsw-max98090: snd_soc_register_card failed -1
cht-bsw-max98090: probe of cht-bsw-max98090 failed with error -1

The problem is similar to the problem solved with commit 2fc995a87f2e
("ASoC: intel: Fix crash at suspend/resume without card registration"),
but codec registration fails at a later point. At that time, the pointer
checked with the above mentioned commit is already set, but it is not
cleared if the device is subsequently removed. Adding a remove function
to clear the pointer fixes the problem.

Cc: stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -711,9 +711,17 @@ static int sst_soc_probe(struct snd_soc_
 	return sst_dsp_init_v2_dpcm(component);
 }
 
+static void sst_soc_remove(struct snd_soc_component *component)
+{
+	struct sst_data *drv = dev_get_drvdata(component->dev);
+
+	drv->soc_card = NULL;
+}
+
 static const struct snd_soc_component_driver sst_soc_platform_drv  = {
 	.name		= DRV_NAME,
 	.probe		= sst_soc_probe,
+	.remove		= sst_soc_remove,
 	.ops		= &sst_platform_ops,
 	.compr_ops	= &sst_platform_compr_ops,
 	.pcm_new	= sst_pcm_new,


