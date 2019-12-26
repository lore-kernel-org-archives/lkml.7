Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D5C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8B3206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI+apV1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLZQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 11:53:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37892 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfLZQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 11:53:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so24095657wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r+OmUwwAlQttzT+mSlN6jlxfiaSi8KzPwCt8RJDeWic=;
        b=rI+apV1qoWolpf4sei/0P62ooozXupxVaNZoB+YxFIYDDwDfKJMWGuqfz8lDvVAbGk
         7auNmmU0EtN2Y0iwLG2tVJv6/HgTXFQnqA+EKzuM9zW5S97D8S7u+2JVs89qJT3aGyXQ
         RINe3yiGVHgSqsvNgtC3Gt3KNt3j2rEa3fjCUGkNDm+c8OPNeRL2OE7HueNdUKX3SPaO
         EHHKtwDAo0W4fcoJpDGEaAo9awX9DVePrvkEVbsula+M6tQ9d8QQY1W+v62eCGkDNwbZ
         6qReiY53z44SwR0ZwShdcepR0Y0hXnewMIHDNTAeIMyo+VFznfEcXSeR8myR03RZLEOv
         ZIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r+OmUwwAlQttzT+mSlN6jlxfiaSi8KzPwCt8RJDeWic=;
        b=MGrMxtnSpGtBcQLMMJQf8O00McVc8Gub842qCG0EiEOyX2RdfxwLap/kOcAdJg+LZz
         TJjXWy0RjsUfLdy5d2uwtXNk+UMrOgj3GmopOUnvyUPe5xpfoIUn0p1pNp+DHC0ktCmh
         vNMgbiSfXV/oeUtJV5a9gZQpyZiqpx7sfsZwPLWD+di6e4ilh/MxjyiXGeNaOhsdkylt
         3B9PIk+hTm85hef49Tjo9lrqAdfovv5h6Wo3OPI0kQq6+JY3TUIsOZvxirLPw0RLc1je
         7ffHppbYG/IzlUUP4Q865CD0TPpRWPGAlLLFmFiuMWbHh0jSEzQxbH0qemeUTJNi/isI
         jP6A==
X-Gm-Message-State: APjAAAUhoJ7izFaEqaEwWDcS+cMsfvWfqff3MRagcQgRFMp4298V/flT
        NqebHTpTF4I9q6d+sEx+ZWI6qoZ5zk3Z15hogU0Iltnq
X-Google-Smtp-Source: APXvYqws3Q/pRD4jjCV/gsNL7y8lYhpjz115FAgjZPJZOJgo0jrfewIPbbKi62IBm8Jg+URTUnMVZ4ac2LpsR0edERs=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr46096517wru.40.1577379209441;
 Thu, 26 Dec 2019 08:53:29 -0800 (PST)
MIME-Version: 1.0
References: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
In-Reply-To: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 26 Dec 2019 11:53:17 -0500
Message-ID: <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
Subject: Re: Warning: check cp_fw_version and update it to realize GRBM
 requires 1-cycle delay in cp firmware
To:     Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Cc:     Chang Zhu <Changfeng.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 5:11 AM Paul Menzel
<pmenzel+amd-gfx@molgen.mpg.de> wrote:
>
> Dear Chang, Christian, and Alex,
>
>
> With Linux 5.5-rc3 I am seeing the warning and null pointer dereference
> below. Are those related?

They are not related.

>
> > [   13.406253] [drm] amdgpu kernel modesetting enabled.
> > [   13.406294] checking generic (7fe0000000 300000) vs hw (7fe0000000 1=
0000000)
> > [   13.406294] fb0: switching to amdgpudrmfb from EFI VGA
> > [   13.406380] Console: switching to colour dummy device 80x25
> > [   13.406423] amdgpu 0000:26:00.0: vgaarb: deactivate vga console
> > [   13.406805] amdgpu 0000:26:00.0: enabling device (0006 -> 0007)
> > [   13.408153] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15=
DD 0x1002:0x15DD 0xC8).
> > [   13.408175] [drm] register mmio base: 0xFCC00000
> > [   13.408175] [drm] register mmio size: 524288
> > [   13.408201] [drm] add ip block number 0 <soc15_common>
> > [   13.408202] [drm] add ip block number 1 <gmc_v9_0>
> > [   13.408202] [drm] add ip block number 2 <vega10_ih>
> > [   13.408203] [drm] add ip block number 3 <psp>
> > [   13.408203] [drm] add ip block number 4 <gfx_v9_0>
> > [   13.408204] [drm] add ip block number 5 <sdma_v4_0>
> > [   13.408205] [drm] add ip block number 6 <powerplay>
> > [   13.408205] [drm] add ip block number 7 <dm>
> > [   13.408206] [drm] add ip block number 8 <vcn_v1_0>
> > [   13.408687] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0=
000:00/0000:00:08.1/0000:26:00.1/sound/card0/input5
> > [   13.408863] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0=
000:00/0000:00:08.1/0000:26:00.1/sound/card0/input6
> > [   13.409048] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0=
000:00/0000:00:08.1/0000:26:00.1/sound/card0/input7
> > [   13.409069] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC892=
: line_outs=3D3 (0x14/0x15/0x16/0x0/0x0) type:line
> > [   13.409070] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (=
0x0/0x0/0x0/0x0/0x0)
> > [   13.409072] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x1b/=
0x0/0x0/0x0/0x0)
> > [   13.409073] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0=
x0
> > [   13.409073] snd_hda_codec_realtek hdaudioC1D0:    dig-out=3D0x1e/0x0
> > [   13.409074] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> > [   13.409075] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=3D0x19
> > [   13.409076] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=3D0x18
> > [   13.409077] snd_hda_codec_realtek hdaudioC1D0:      Line=3D0x1a
> > [   13.415816] ATOM BIOS: 113-RAVEN-114
> > [   13.416590] [drm] VCN decode is enabled in VM mode
> > [   13.416591] [drm] VCN encode is enabled in VM mode
> > [   13.416591] [drm] VCN jpeg decode is enabled in VM mode
> > [   13.416831] [drm] vm size is 262144 GB, 4 levels, block size is 9-bi=
t, fragment size is 9-bit
> > [   13.416939] amdgpu 0000:26:00.0: VRAM: 2048M 0x000000F400000000 - 0x=
000000F47FFFFFFF (2048M used)
> > [   13.416940] amdgpu 0000:26:00.0: GART: 1024M 0x0000000000000000 - 0x=
000000003FFFFFFF
> > [   13.416941] amdgpu 0000:26:00.0: AGP: 267419648M 0x000000F800000000 =
- 0x0000FFFFFFFFFFFF
> > [   13.416955] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
> > [   13.416956] [drm] RAM width 128bits DDR4
> > [   13.419381] [TTM] Zone  kernel: Available graphics memory: 7168268 K=
iB
> > [   13.419382] [TTM] Zone   dma32: Available graphics memory: 2097152 K=
iB
> > [   13.419382] [TTM] Initializing pool allocator
> > [   13.419399] [TTM] Initializing DMA pool allocator
> > [   13.419570] [drm] amdgpu: 2048M of VRAM memory ready
> > [   13.419583] [drm] amdgpu: 3072M of GTT memory ready.
> > [   13.419664] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > [   13.419903] [drm] PCIE GART of 1024M enabled (table at 0x000000F4009=
00000).
> > [   13.421454] amdgpu 0000:26:00.0: Direct firmware load for amdgpu/rav=
en_ta.bin failed with error -2
> > [   13.421456] amdgpu 0000:26:00.0: psp v10.0: Failed to load firmware =
"amdgpu/raven_ta.bin"
> > [   13.435852] input: HD-Audio Generic Front Mic as /devices/pci0000:00=
/0000:00:08.1/0000:26:00.6/sound/card1/input8
> > [   13.436026] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/=
0000:00:08.1/0000:26:00.6/sound/card1/input9
> > [   13.436220] input: HD-Audio Generic Line as /devices/pci0000:00/0000=
:00:08.1/0000:26:00.6/sound/card1/input10
> > [   13.436790] input: HD-Audio Generic Line Out Front as /devices/pci00=
00:00/0000:00:08.1/0000:26:00.6/sound/card1/input11
> > [   13.436974] input: HD-Audio Generic Line Out Surround as /devices/pc=
i0000:00/0000:00:08.1/0000:26:00.6/sound/card1/input12
> > [   13.437240] input: HD-Audio Generic Line Out CLFE as /devices/pci000=
0:00/0000:00:08.1/0000:26:00.6/sound/card1/input13
> > [   13.437403] input: HD-Audio Generic Front Headphone as /devices/pci0=
000:00/0000:00:08.1/0000:26:00.6/sound/card1/input14
> > [   13.446975] [drm] Warning: check cp_fw_version and update it to real=
ize                          GRBM requires 1-cycle delay in cp firmware
> > [   13.448211] BUG: kernel NULL pointer dereference, address: 000000000=
0000026
> > [   13.448216] #PF: supervisor read access in kernel mode
> > [   13.448217] #PF: error_code(0x0000) - not-present page
> > [   13.448219] PGD 0 P4D 0
> > [   13.448221] Oops: 0000 [#1] SMP
> > [   13.448223] CPU: 2 PID: 354 Comm: comp_1.0.0 Not tainted 5.5.0-rc3-0=
0045-g7618e88ac987 #25
> > [   13.448225] Hardware name: Micro-Star International Co., Ltd. MS-7A3=
7/B350M MORTAR (MS-7A37), BIOS 1.MR 12/02/2019
> > [   13.448231] RIP: 0010:__kthread_should_park+0x5/0x30
> > [   13.448233] Code: 7d 01 00 f6 40 26 20 74 11 48 8b 80 88 05 00 00 48=
 8b 00 48 d1 e8 83 e0 01 c3 0f 0b eb eb 0f 1f 80 00 00 00 00 0f 1f 44 00 00=
 <f6> 47 26 20 74 12 48 8b 87 88 05 00 00 48 8b 00 48 c1 e8 02 83 e0
> > [   13.448235] RSP: 0018:ffffbe1b804bfe50 EFLAGS: 00010246
> > [   13.448237] RAX: 7fffffffffffffff RBX: ffff988638f72e78 RCX: 0000000=
000000294
> > [   13.448238] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000=
000000000
> > [   13.448240] RBP: ffff988636827f50 R08: ffff98863da34058 R09: ffff988=
63e80e8d8
> > [   13.448241] R10: ffffbe1b804bfeac R11: ffffffffc466dad2 R12: ffff988=
636827f50
> > [   13.448243] R13: ffffbe1b808c77e0 R14: ffff988636827f50 R15: ffff988=
63da33c80
> > [   13.448245] FS:  0000000000000000(0000) GS:ffff988640680000(0000) kn=
lGS:0000000000000000
> > [   13.448247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   13.448248] CR2: 0000000000000026 CR3: 0000000378783000 CR4: 0000000=
0003406e0
> > [   13.448250] Call Trace:
> > [   13.448254]  drm_sched_get_cleanup_job+0x42/0x100 [gpu_sched]
> > [   13.448257]  drm_sched_main+0x5c/0x390 [gpu_sched]
> > [   13.448261]  ? __schedule+0x298/0x6c0
> > [   13.448263]  ? __wake_up_common+0x80/0x180
> > [   13.448265]  kthread+0xfb/0x130
> > [   13.448267]  ? drm_sched_get_cleanup_job+0x100/0x100 [gpu_sched]
> > [   13.448269]  ? kthread_park+0x90/0x90
> > [   13.448272]  ret_from_fork+0x22/0x40
> > [   13.448273] Modules linked in: snd_hda_codec_realtek snd_hda_codec_g=
eneric snd_hda_codec_hdmi amdgpu(+) snd_hda_intel snd_intel_dspcfg snd_hda_=
codec snd_hda_core k10temp i2c_piix4 snd_hwdep snd_pcm snd_timer gpu_sched =
snd soundcore r8169 realtek wmi video acpi_cpufreq crc32c_intel xhci_pci xh=
ci_hcd
> > [   13.448286] CR2: 0000000000000026
> > [   13.448288] ---[ end trace 22194bd02a932bab ]---
> > [   13.448290] RIP: 0010:__kthread_should_park+0x5/0x30
> > [   13.448292] Code: 7d 01 00 f6 40 26 20 74 11 48 8b 80 88 05 00 00 48=
 8b 00 48 d1 e8 83 e0 01 c3 0f 0b eb eb 0f 1f 80 00 00 00 00 0f 1f 44 00 00=
 <f6> 47 26 20 74 12 48 8b 87 88 05 00 00 48 8b 00 48 c1 e8 02 83 e0
> > [   13.448295] RSP: 0018:ffffbe1b804bfe50 EFLAGS: 00010246
> > [   13.448296] RAX: 7fffffffffffffff RBX: ffff988638f72e78 RCX: 0000000=
000000294
> > [   13.448298] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000=
000000000
> > [   13.448299] RBP: ffff988636827f50 R08: ffff98863da34058 R09: ffff988=
63e80e8d8
> > [   13.448300] R10: ffffbe1b804bfeac R11: ffffffffc466dad2 R12: ffff988=
636827f50
> > [   13.448302] R13: ffffbe1b808c77e0 R14: ffff988636827f50 R15: ffff988=
63da33c80
> > [   13.448303] FS:  0000000000000000(0000) GS:ffff988640680000(0000) kn=
lGS:0000000000000000
> > [   13.448305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   13.448307] CR2: 0000000000000026 CR3: 0000000378783000 CR4: 0000000=
0003406e0
> > [   13.474706] [drm] use_doorbell being set to: [true]
> > [   13.474886] amdgpu: [powerplay] hwmgr_sw_init smu backed is smu10_sm=
u
> > [   13.497484] [drm] Found VCN firmware Version ENC: 1.9 DEC: 1 VEP: 0 =
Revision: 28
> > [   13.497508] [drm] PSP loading VCN firmware
> > [   13.518866] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
> > [   13.533919] EXT4-fs (sda2): mounted filesystem with ordered data mod=
e. Opts: errors=3Dremount-ro
> > [   13.533962] ext4 filesystem being mounted at /boot supports timestam=
ps until 2038 (0x7fffffff)
> > [   13.563013] r8169 0000:22:00.0 enp34s0: renamed from eth0
> > [   13.605292] [drm] DM_PPLIB: values for F clock
> > [   13.605297] [drm] DM_PPLIB:         0 in kHz, 3649 in mV
> > [   13.605299] [drm] DM_PPLIB:         400000 in kHz, 3649 in mV
> > [   13.605300] [drm] DM_PPLIB:         933000 in kHz, 4074 in mV
> > [   13.605301] [drm] DM_PPLIB:         1067000 in kHz, 4250 in mV
> > [   13.605303] [drm] DM_PPLIB: values for DCF clock
> > [   13.605304] [drm] DM_PPLIB:         300000 in kHz, 3649 in mV
> > [   13.605305] [drm] DM_PPLIB:         600000 in kHz, 4074 in mV
> > [   13.605307] [drm] DM_PPLIB:         626000 in kHz, 4250 in mV
> > [   13.605308] [drm] DM_PPLIB:         654000 in kHz, 4399 in mV
> > [   13.606355] [drm] Display Core initialized with v3.2.56!
> > [   13.638961] snd_hda_intel 0000:26:00.1: bound 0000:26:00.0 (ops amdg=
pu_dm_audio_component_bind_ops [amdgpu])
> > [   13.653730] [drm:dm_helpers_parse_edid_caps [amdgpu]] *ERROR* Couldn=
't read SADs: -2
> > [   13.656251] [drm] Supports vblank timestamp caching Rev 2 (21.10.201=
3).
> > [   13.656255] [drm] Driver supports precise vblank timestamp query.
> > [   13.658879] [drm] VCN decode and encode initialized successfully(und=
er DPG Mode).
> > [   13.662388] [drm] fb mappable at 0x38FBC1000
> > [   13.662393] [drm] vram apper at 0x38F000000
> > [   13.662395] [drm] size 5242880
> > [   13.662396] [drm] fb depth is 24
> > [   13.662397] [drm]    pitch is 5120
> > [   13.662706] fbcon: amdgpudrmfb (fb0) is primary device
> > [   13.673551] Console: switching to colour frame buffer device 160x64
> > [   13.694375] amdgpu 0000:26:00.0: fb0: amdgpudrmfb frame buffer devic=
e
> > [   13.700769] amdgpu 0000:26:00.0: ring gfx uses VM inv eng 0 on hub 0
> > [   13.700814] amdgpu 0000:26:00.0: ring comp_1.0.0 uses VM inv eng 1 o=
n hub 0
> > [   13.700856] amdgpu 0000:26:00.0: ring comp_1.1.0 uses VM inv eng 4 o=
n hub 0
> > [   13.700898] amdgpu 0000:26:00.0: ring comp_1.2.0 uses VM inv eng 5 o=
n hub 0
> > [   13.700940] amdgpu 0000:26:00.0: ring comp_1.3.0 uses VM inv eng 6 o=
n hub 0
> > [   13.700982] amdgpu 0000:26:00.0: ring comp_1.0.1 uses VM inv eng 7 o=
n hub 0
> > [   13.701035] amdgpu 0000:26:00.0: ring comp_1.1.1 uses VM inv eng 8 o=
n hub 0
> > [   13.701077] amdgpu 0000:26:00.0: ring comp_1.2.1 uses VM inv eng 9 o=
n hub 0
> > [   13.701119] amdgpu 0000:26:00.0: ring comp_1.3.1 uses VM inv eng 10 =
on hub 0
> > [   13.701162] amdgpu 0000:26:00.0: ring kiq_2.1.0 uses VM inv eng 11 o=
n hub 0
> > [   13.701204] amdgpu 0000:26:00.0: ring sdma0 uses VM inv eng 0 on hub=
 1
> > [   13.701243] amdgpu 0000:26:00.0: ring vcn_dec uses VM inv eng 1 on h=
ub 1
> > [   13.701284] amdgpu 0000:26:00.0: ring vcn_enc0 uses VM inv eng 4 on =
hub 1
> > [   13.701325] amdgpu 0000:26:00.0: ring vcn_enc1 uses VM inv eng 5 on =
hub 1
> > [   13.701366] amdgpu 0000:26:00.0: ring vcn_jpeg uses VM inv eng 6 on =
hub 1
> > [   13.754721] [drm] Initialized amdgpu 3.36.0 20150101 for 0000:26:00.=
0 on minor 0
>
> Chang, it looks like you added that warning in commit 11c6108934.
>
> > drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9
> >
> > It needs to add warning to update firmware in gfx9
> > in case that firmware is too old to have function to
> > realize dummy read in cp firmware.
>
> Unfortunately, it looks like you did not even check how the warning is
> formatted (needless spaces), so I guess this was totally untested. Also,
> what is that warning about, and what is the user supposed to do? I am
> unable to find `cp_fw_version` in the source code at all.
>

The code looks fine.  Not sure why it's rendering funny in your log.
               DRM_WARN_ONCE("Warning: check cp_fw_version and update
it to realize \
                             GRBM requires 1-cycle delay in cp firmware\n")=
;

You an read this file in debugfs to get the firmware versions
currently in use by the driver:
/sys/kernel/debug/dri/0/amdgpu_firmware_info

> Where can I get updated firmware? What version do I need? I think, this
> should be thought over again, and you should gracefully deal with old
> firmware.
>

You can get the latest firmware from the Linux firmware git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
You need <asic>_mec.bin version 0x000001a5 or newer and <asic>_pfp.bin
version 0x000000b7 or newer.  Some gfx9 asics already have newer
firmware in linux-firmware git and some others are currently in QA and
will be released any day now (probably after the holidays) once the
current cycle finishes.  The old firmware is handled fine; the driver
will continue to work as before.  The message is just telling you that
newer firmware has the proper workaround for the hw issue and you
should update.

> Please tell me, if you want me to create a bug report, or something else
> to get this fixed.
>
> The package *firmware-amd-graphics* 20190717-2 from Debian Sid/unstable
> is installed, which lacks `raven_ta.bin`, but which is not even in the
> upstream linux-firmware repository [1]. :( It=E2=80=99s off-topic to this
> thread, but how can upstream Linux have code for unpublished blobs?
>

The ta firmware is optional (only required for HDCP functionality) and
is currently in QA.  It will be released any day now (probably after
the holidays) as well.

Alex

>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/tree/amdgpu?id=3D7319341e6e40f8bae1f2623eb5e4ddc0e2b50076
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
