Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6772070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfFRK4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:56:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:15500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFRK4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:56:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 03:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,388,1557212400"; 
   d="scan'208";a="161833962"
Received: from xxx.igk.intel.com (HELO xxx) ([10.237.93.170])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2019 03:56:18 -0700
Date:   Tue, 18 Jun 2019 13:00:15 +0200
From:   Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
Message-ID: <20190618130015.0fc388b4@xxx>
In-Reply-To: <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
 <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 13:51:42 -0700
Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:

> On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:
> > When we unload Skylake driver we may end up calling
> > hdac_component_master_unbind(), it uses acomp->audio_ops, which we
> > set
> > in hdmi_codec_probe(), so we need to set it to NULL in
> > hdmi_codec_remove(),
> > otherwise we will dereference no longer existing pointer.  
> 
> Hi Amadeusz,
> 
> It looks like the audio_ops should be deleted snd_hdac_acomp_exit().
> Also, this doesnt seem to be the case with when the SOF driver is
> removed.
> Could you please give a bit more context on what error you see when
> this happens?

Hi,

I get Oops. This is what happens with all other patches in this series and only this one reverted:

root@APL:~# rmmod snd_soc_sst_bxt_rt298
root@APL:~# rmmod snd_soc_hdac_hdmi
root@APL:~# rmmod snd_soc_skl
Killed

[   57.007783] BUG: unable to handle page fault for address: fffffbfff4067038
[   57.007956] #PF: supervisor read access in kernel mode
[   57.008065] #PF: error_code(0x0000) - not-present page
[   57.008173] PGD 268266067 P4D 268266067 PUD 23809a067 PMD 22b545067 PTE 0
[   57.008322] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[   57.008453] CPU: 3 PID: 1045 Comm: rmmod Tainted: G                T 5.2.0-rc4-dev #824
[   57.008617] Hardware name: Intel Corp. Broxton P/Apollolake RVP1C, BIOS APLKRVPA.X64.0151.B25.1609151411 09/15/2016
[   57.008834] RIP: 0010:__asan_load8+0x39/0x90
[   57.008931] Code: ff ff ff ff 7f ff ff 48 39 c3 76 40 48 8d 43 07 48 89 c2 83 e2 07 48 83 fa 07 75 19 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 <0f> b6 04 10 84 c0 75 2c 5b 5d c3 48 be 00 00 00 00 00 f
c ff df 48
[   57.009299] RSP: 0018:ffff88822431fa68 EFLAGS: 00010203
[   57.009411] RAX: 1ffffffff4067038 RBX: ffffffffa03381c0 RCX: ffffffffa01bd8a4
[   57.009557] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffffffffa03381c0
[   57.009704] RBP: ffff88822431fa70 R08: ffffed1046a6d8f3 R09: ffffed1046a6d8f3
[   57.009851] R10: ffffed1046a6d8f3 R11: 0000000000000000 R12: ffff88823536c4b0
[   57.009998] R13: ffffffffa03381a0 R14: ffffffffa01bd860 R15: ffff888223108538
[   57.010147] FS:  00007fedb579f540(0000) GS:ffff888237780000(0000) knlGS:0000000000000000
[   57.010312] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.010433] CR2: fffffbfff4067038 CR3: 000000022260a000 CR4: 00000000003406e0
[   57.010580] Call Trace:
[   57.010667]  hdac_component_master_unbind+0x44/0xb0 [snd_hda_core]
[   57.010822]  ? snd_hdac_acomp_exit+0x130/0x130 [snd_hda_core]
[   57.010949]  take_down_master+0x53/0x80
[   57.011037]  component_master_del+0x76/0xa0
[   57.011144]  snd_hdac_acomp_exit+0x97/0x130 [snd_hda_core]
[   57.011275]  ? snd_hdac_display_power+0x12e/0x1d0 [snd_hda_core]
[   57.011414]  skl_free+0xbf/0xd0 [snd_soc_skl]
[   57.011519]  skl_remove+0xf1/0x110 [snd_soc_skl]
[   57.011623]  pci_device_remove+0xd9/0x1f0
[   57.011714]  ? pcibios_free_irq+0x10/0x10
[   57.011806]  ? preempt_count_sub+0x18/0xd0
[   57.011898]  ? _raw_spin_unlock_irqrestore+0x26/0x40
[   57.012009]  device_release_driver_internal+0x140/0x270
[   57.012124]  driver_detach+0x7a/0xe0
[   57.012207]  bus_remove_driver+0x95/0x160
[   57.012303]  driver_unregister+0x43/0x60
[   57.012392]  pci_unregister_driver+0x29/0x110
[   57.012501]  skl_driver_exit+0x10/0x1b [snd_soc_skl]
[   57.012610]  __x64_sys_delete_module+0x235/0x3d0
[   57.012712]  ? free_module+0x380/0x380
[   57.012804]  do_syscall_64+0xcd/0x650
[   57.012887]  ? syscall_return_slowpath+0x1e0/0x1e0
[   57.012998]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   57.013107] RIP: 0033:0x7fedb52bc1b7
[   57.013189] Code: 73 01 c3 48 8b 0d d1 8c 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 8c 2c 00 f7 d8 64 89 01 48
[   57.013556] RSP: 002b:00007ffcfc17ce18 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[   57.013712] RAX: ffffffffffffffda RBX: 00007ffcfc17ce78 RCX: 00007fedb52bc1b7
[   57.013858] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005649a5309a98
[   57.014004] RBP: 00005649a5309a30 R08: 00007ffcfc17bd91 R09: 0000000000000000
[   57.014149] R10: 00007fedb5338cc0 R11: 0000000000000206 R12: 00007ffcfc17d040
[   57.014294] R13: 00007ffcfc17e79b R14: 00005649a5309260 R15: 00005649a5309a30
[   57.014446] Modules linked in: i2c_designware_platform i2c_designware_core snd_soc_dmic joydev x86_pkg_temp_thermal intel_powerclamp coretemp crc32c_intel serio_raw pwm_lpss_pci pwm_lpss intel_lpss_pci intel_lpss snd_soc_rt298 mei_me mei snd_soc_rt286 snd_soc_rl6347a snd_soc_skl(-) snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core snd_hda_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress snd_pcm_dmaengine snd_pcm snd_timer parport_pc lp parport ip_tables x_tables igb dca pinctrl_broxton pinctrl_intel [last unloaded: snd_soc_hdac_hdmi]
[   57.015477] CR2: fffffbfff4067038
[   57.015556] ---[ end trace 794bf9fb0862965b ]---

Amadeusz
