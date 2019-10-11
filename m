Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48592ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A222206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfJKK1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:27:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:10251 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfJKK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:27:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 03:27:28 -0700
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; 
   d="scan'208";a="200752857"
Received: from jkrzyszt-desk.igk.intel.com (HELO jkrzyszt-desk.ger.corp.intel.com) ([172.22.244.17])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 03:27:26 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Fri, 11 Oct 2019 12:27:15 +0200
Message-ID: <1638600.GGFdda3v3R@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <19f435fc-7318-4abd-5c73-78ce253d5f07@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com> <2674326.ZPvzKFr69O@jkrzyszt-desk.ger.corp.intel.com> <19f435fc-7318-4abd-5c73-78ce253d5f07@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Friday, October 11, 2019 8:54:09 AM CEST Lu Baolu wrote:
> Hi Janusz,
> 
> On 9/3/19 3:41 PM, Janusz Krzysztofik wrote:
> > Hi Baolu,
> > 
> > On Tuesday, September 3, 2019 3:29:40 AM CEST Lu Baolu wrote:
> >> Hi Janusz,
> >>
> >> On 9/2/19 4:37 PM, Janusz Krzysztofik wrote:
> >>>> I am not saying that keeping data is not acceptable. I just want to
> >>>> check whether there are any other solutions.
> >>> Then reverting 458b7c8e0dde and applying this patch still resolves the
> > issue
> >>> for me.  No errors appear when mappings are unmapped on device close after
> > the
> >>> device has been removed, and domain info preserved on device removal is
> >>> successfully reused on device re-plug.
> >> This patch doesn't look good to me although I agree that keeping data is
> >> acceptable. It updates dev->archdata.iommu, but leaves the hardware
> >> context/pasid table unchanged. This might cause problems somewhere.
> >>
> >>> Is there anything else I can do to help?
> >> Can you please tell me how to reproduce the problem?
> > The most simple way to reproduce the issue, assuming there are no non-Intel
> > graphics adapters installed, is to run the following shell commands:
> > 
> > #!/bin/sh
> > # load i915 module
> > modprobe i915
> > # open an i915 device and keep it open in background
> > cat /dev/dri/card0 >/dev/null &
> > sleep 2
> > # simulate device unplug
> > echo 1 >/sys/class/drm/card0/device/remove
> > # make the background process close the device on exit
> > kill $!
> > 
> 
> I tried to reproduce the issue with above instructions. I got below
> kernel messages after above operation. Is it the same as what you've
> seen? I can't find anything explicitly related to iommu except an IOMMU
> fault generated after device got removed and the DMA translation
> structures got torn down. Can you please help me to understand how IOMMU
> driver triggers the issue?
> 
> 
> [  182.217672] ------------[ cut here ]------------
> [  182.217679] WARNING: CPU: 1 PID: 1285 at 
> drivers/gpu/drm/drm_mode_config.c:495 drm_mode_config_cleanup+0x2cb/0x2e0
> [  182.217680] Modules linked in: nls_iso8859_1 snd_soc_skl 
> snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core 
> snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core intel_rapl_msr 
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_compress 
> snd_hda_codec_generic ledtrig_audio ac97_bus snd_pcm_dmaengine 
> snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core snd_hwdep 
> snd_pcm intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp 
> kvm_intel kvm snd_seq_midi irqbypass snd_seq_midi_event snd_rawmidi 
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iwlmvm snd_seq 
> mac80211 libarc4 aesni_intel snd_seq_device snd_timer crypto_simd 
> ipu3_cio2 cryptd glue_helper iwlwifi v4l2_fwnode intel_cstate 
> videobuf2_dma_sg videobuf2_memops intel_rapl_perf asix videobuf2_v4l2 
> videobuf2_common usbnet mii cfg80211 input_leds serio_raw 
> intel_wmi_thunderbolt snd mei_me videodev soundcore 
> intel_xhci_usb_role_switch mei 8250_dw mc roles intel_pch_thermal 
> hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_press
> [  182.217709]  hid_sensor_incl_3d hid_sensor_als hid_sensor_rotation 
> hid_sensor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer 
> kfifo_buf hid_sensor_iio_common industrialio intel_vbtn mac_hid 
> intel_hid acpi_pad sparse_keymap sch_fq_codel parport_pc ppdev lp 
> parport ip_tables x_tables hid_sensor_custom hid_sensor_hub 
> intel_ishtp_hid hid_generic dwc3 ulpi udc_core i2c_designware_platform 
> i2c_designware_core e1000e psmouse i2c_i801 tg3 usbhid dwc3_pci hid 
> intel_ish_ipc intel_lpss_pci intel_ishtp intel_lpss wmi 
> pinctrl_sunrisepoint pinctrl_intel
> [  182.217727] CPU: 1 PID: 1285 Comm: bash Not tainted 5.4.0-rc2+ #2704
> [  182.217728] Hardware name: Intel Corporation Skylake Client 
> platform/Skylake Y LPDDR3 RVP3, BIOS SKLSE2R1.R00.B105.B00.1512051901 
> 12/05/2015
> [  182.217731] RIP: 0010:drm_mode_config_cleanup+0x2cb/0x2e0
> [  182.217732] Code: eb 0c 48 8b 70 48 4c 89 e7 e8 31 f4 ff ff 48 8d 7d 
> a0 e8 d8 95 ff ff 48 85 c0 75 e6 48 8d 7d a0 e8 1a 87 ff ff e9 ef fd ff 
> ff <0f> 0b e9 ed fe ff ff 0f 0b eb 98 e8 05 ec 98 ff 0f 1f 44 00 00 0f
> [  182.217733] RSP: 0018:ffffa1c481d37c78 EFLAGS: 00010216
> [  182.217735] RAX: ffff95c7da326e08 RBX: ffff95c7dcf60000 RCX: 
> 000000008010000e
> [  182.217735] RDX: ffff95c7dcf603b8 RSI: 000000008010000e RDI: 
> ffff95c7dcf60390
> [  182.217736] RBP: ffffa1c481d37cd8 R08: 0000000000000000 R09: 
> ffffffff9e035e00
> [  182.217737] R10: ffffa1c481d37be0 R11: 0000000000000001 R12: 
> ffff95c7dcf60250
> [  182.217737] R13: ffff95c7dcf603b8 R14: ffffa1c481d37ee8 R15: 
> fffffffffffffff2
> [  182.217739] FS:  00007f804af7f740(0000) GS:ffff95c7e7a80000(0000) 
> knlGS:0000000000000000
> [  182.217739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  182.217740] CR2: 00007ffebc530cec CR3: 0000000137e0e003 CR4: 
> 00000000003606e0
> [  182.217741] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  182.217742] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  182.217742] Call Trace:
> [  182.217748]  ? _cond_resched+0x19/0x40
> [  182.217752]  intel_modeset_driver_remove+0xd1/0x150
> [  182.217754]  i915_driver_remove+0xb8/0x120
> [  182.217756]  i915_pci_remove+0x23/0x40
> [  182.217758]  pci_device_remove+0x3e/0xc0
> [  182.217761]  device_release_driver_internal+0xec/0x1b0
> [  182.217762]  device_release_driver+0x12/0x20
> [  182.217764]  pci_stop_bus_device+0x68/0x90
> [  182.217766]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
> [  182.217767]  remove_store+0x7c/0x90
> [  182.217770]  dev_attr_store+0x17/0x30
> [  182.217772]  sysfs_kf_write+0x3c/0x50
> [  182.217773]  kernfs_fop_write+0x125/0x1a0
> [  182.217776]  __vfs_write+0x1b/0x40
> [  182.217778]  vfs_write+0xb1/0x1a0
> [  182.217779]  ksys_write+0xa7/0xe0
> [  182.217780]  __x64_sys_write+0x1a/0x20
> [  182.217783]  do_syscall_64+0x57/0x1c0
> [  182.217785]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  182.217787] RIP: 0033:0x7f804b08f024
> [  182.217788] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 
> 80 00 00 00 00 48 8d 05 b9 d3 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 
> 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> [  182.217789] RSP: 002b:00007ffdbe4bc0b8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000001
> [  182.217790] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
> 00007f804b08f024
> [  182.217791] RDX: 0000000000000002 RSI: 000055bf20640470 RDI: 
> 0000000000000001
> [  182.217792] RBP: 000055bf20640470 R08: 000000000000000a R09: 
> 0000000000008000
> [  182.217792] R10: 000000000000000a R11: 0000000000000246 R12: 
> 00007f804b167760
> [  182.217793] R13: 0000000000000002 R14: 00007f804b168560 R15: 
> 00007f804b167960
> [  182.217795] ---[ end trace 292e6caf66ddf0df ]---
> [  182.217797] [leaked fb] framebuffer[118]:
> [  182.217798] [leaked fb] 	allocated by = gnome-shell

It looks like you may be trying to reproduce the issue with a graphics adapter 
which is occupied by a graphical environment.  While maybe this should be 
possible, other issues seem to interfere, making the picture less clear.  
Would you be able to try on an otherwise unused device?

Thanks,
Janusz

> [  182.217799] [leaked fb] 	refcount=1
> [  182.217801] [leaked fb] 	format=XR24 little-endian (0x34325258)
> [  182.217802] [leaked fb] 	modifier=0x100000000000001
> [  182.217803] [leaked fb] 	size=3200x1800
> [  182.217803] [leaked fb] 	layers:
> [  182.217805] [leaked fb] 		size[0]=3200x1800
> [  182.217805] [leaked fb] 		pitch[0]=12800
> [  182.217806] [leaked fb] 		offset[0]=0
> [  182.217807] [leaked fb] 		obj[0]:
> [  182.217808] [leaked fb] 			name=0
> [  182.217809] [leaked fb] 			refcount=3
> [  182.217810] [leaked fb] 			start=00000000
> [  182.217810] [leaked fb] 			size=25165824
> [  182.217811] [leaked fb] 			imported=no
> [  182.241857] pci 0000:00:02.0: Removing from iommu group 1
> [  182.241858] DMAR: DRHD: handling fault status reg 2
> [  182.241864] DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff 
> fault addr 0 [fault reason 02] Present bit in context entry is clear
> [  189.181789] general protection fault: 0000 [#1] SMP PTI
> [  189.181795] CPU: 0 PID: 836 Comm: gdbus Tainted: G        W 
> 5.4.0-rc2+ #2704
> [  189.181797] Hardware name: Intel Corporation Skylake Client 
> platform/Skylake Y LPDDR3 RVP3, BIOS SKLSE2R1.R00.B105.B00.1512051901 
> 12/05/2015
> [  189.181804] RIP: 0010:drm_mode_object_unregister+0xe/0x70
> [  189.181806] Code: 54 00 4c 89 e7 e8 d2 d8 56 00 5b 41 5c 41 5d 5d c3 
> 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 
> 53 <48> 8b 47 20 48 89 fb 49 89 f5 48 83 38 00 74 3a 4c 8d a3 d8 01 00
> [  189.181809] RSP: 0018:ffffa1c481e73b60 EFLAGS: 00010246
> [  189.181811] RAX: ffffffff9e502a90 RBX: ffff95c7da326e28 RCX: 
> 0000000000000001
> [  189.181813] RDX: 0000000000000000 RSI: ffff95c7da326e18 RDI: 
> f1ca50a8ff50515a
> [  189.181815] RBP: ffffa1c481e73b78 R08: 0000000000000001 R09: 
> 0000000000000000
> [  189.181817] R10: 0000000000000008 R11: ffff95c7dcf53770 R12: 
> ffff95c7da326e00
> [  189.181818] R13: ffffa1c481e73bf0 R14: ffff95c7e3cb7ac8 R15: 
> ffff95c7e6cb23c0
> [  189.181821] FS:  00007f688ccf1700(0000) GS:ffff95c7e7a00000(0000) 
> knlGS:0000000000000000
> [  189.181823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  189.181825] CR2: 000056427674ff10 CR3: 000000015e376004 CR4: 
> 00000000003606f0
> [  189.181826] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  189.181828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  189.181829] Call Trace:
> [  189.181834]  drm_framebuffer_free+0x21/0x40
> [  189.181837]  drm_mode_object_put.part.2+0x3c/0x40
> [  189.181839]  drm_mode_object_put+0x15/0x20
> [  189.181841]  drm_fb_release+0xbc/0x130
> [  189.181845]  drm_file_free.part.5+0x2ac/0x2e0
> [  189.181847]  drm_close_helper.isra.6+0x60/0x70
> [  189.181850]  drm_release+0x50/0x80
> [  189.181853]  __fput+0xc6/0x260
> [  189.181856]  ____fput+0xe/0x10
> [  189.181859]  task_work_run+0x9d/0xc0
> [  189.181862]  do_exit+0x2ed/0xbb0
> [  189.181866]  ? poll_select_finish+0x210/0x210
> [  189.181869]  do_group_exit+0x43/0xa0
> [  189.181872]  get_signal+0x144/0x840
> [  189.181876]  ? eventfd_read+0xe9/0x260
> [  189.181879]  do_signal+0x34/0x6d0
> [  189.181884]  exit_to_usermode_loop+0x8e/0x100
> [  189.181887]  do_syscall_64+0x186/0x1c0
> [  189.181890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  189.181895] RIP: 0033:0x7f6895119729
> [  189.181899] Code: Bad RIP value.
> [  189.181901] RSP: 002b:00007f688ccf08a0 EFLAGS: 00000293 ORIG_RAX: 
> 0000000000000007
> [  189.181903] RAX: fffffffffffffdfc RBX: 00007f687c023170 RCX: 
> 00007f6895119729
> [  189.181905] RDX: 00000000ffffffff RSI: 0000000000000005 RDI: 
> 00007f687c023170
> [  189.181906] RBP: 0000000000000005 R08: 0000000000000000 R09: 
> 0000000000000001
> [  189.181908] R10: 000055cc6ed5dd80 R11: 0000000000000293 R12: 
> 00000000ffffffff
> [  189.181909] R13: 00007f6895d8b4c0 R14: 00000000ffffffff R15: 
> 0000000000000005
> [  189.181911] Modules linked in: nls_iso8859_1 snd_soc_skl 
> snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core 
> snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core intel_rapl_msr 
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_compress 
> snd_hda_codec_generic ledtrig_audio ac97_bus snd_pcm_dmaengine 
> snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core snd_hwdep 
> snd_pcm intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp 
> kvm_intel kvm snd_seq_midi irqbypass snd_seq_midi_event snd_rawmidi 
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iwlmvm snd_seq 
> mac80211 libarc4 aesni_intel snd_seq_device snd_timer crypto_simd 
> ipu3_cio2 cryptd glue_helper iwlwifi v4l2_fwnode intel_cstate 
> videobuf2_dma_sg videobuf2_memops intel_rapl_perf asix videobuf2_v4l2 
> videobuf2_common usbnet mii cfg80211 input_leds serio_raw 
> intel_wmi_thunderbolt snd mei_me videodev soundcore 
> intel_xhci_usb_role_switch mei 8250_dw mc roles intel_pch_thermal 
> hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_press
> [  189.181950]  hid_sensor_incl_3d hid_sensor_als hid_sensor_rotation 
> hid_sensor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer 
> kfifo_buf hid_sensor_iio_common industrialio intel_vbtn mac_hid 
> intel_hid acpi_pad sparse_keymap sch_fq_codel parport_pc ppdev lp 
> parport ip_tables x_tables hid_sensor_custom hid_sensor_hub 
> intel_ishtp_hid hid_generic dwc3 ulpi udc_core i2c_designware_platform 
> i2c_designware_core e1000e psmouse i2c_i801 tg3 usbhid dwc3_pci hid 
> intel_ish_ipc intel_lpss_pci intel_ishtp intel_lpss wmi 
> pinctrl_sunrisepoint pinctrl_intel
> [  189.181981] ---[ end trace 292e6caf66ddf0e0 ]---
> [  189.201970] RIP: 0010:drm_mode_object_unregister+0xe/0x70
> [  189.201975] Code: 54 00 4c 89 e7 e8 d2 d8 56 00 5b 41 5c 41 5d 5d c3 
> 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 
> 53 <48> 8b 47 20 48 89 fb 49 89 f5 48 83 38 00 74 3a 4c 8d a3 d8 01 00
> [  189.201978] RSP: 0018:ffffa1c481e73b60 EFLAGS: 00010246
> [  189.201981] RAX: ffffffff9e502a90 RBX: ffff95c7da326e28 RCX: 
> 0000000000000001
> [  189.201982] RDX: 0000000000000000 RSI: ffff95c7da326e18 RDI: 
> f1ca50a8ff50515a
> [  189.201984] RBP: ffffa1c481e73b78 R08: 0000000000000001 R09: 
> 0000000000000000
> [  189.201986] R10: 0000000000000008 R11: ffff95c7dcf53770 R12: 
> ffff95c7da326e00
> [  189.201987] R13: ffffa1c481e73bf0 R14: ffff95c7e3cb7ac8 R15: 
> ffff95c7e6cb23c0
> [  189.201990] FS:  00007f688ccf1700(0000) GS:ffff95c7e7a00000(0000) 
> knlGS:0000000000000000
> [  189.201991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  189.201993] CR2: 00007f68951196ff CR3: 000000015e376004 CR4: 
> 00000000003606f0
> [  189.201995] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  189.201997] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> 
> Best regards,
> Baolu
> 




