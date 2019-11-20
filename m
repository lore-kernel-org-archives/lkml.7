Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E68C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD820857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSqtAHyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKTWZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:25:58 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36555 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:25:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id y64so602538ywe.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 14:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=to2G/iq7aT/AMZVmPTn7EBtCpD2Z1XKliSNNqbMoX8g=;
        b=jSqtAHyMVqQU4Zm7/llBUi4axY2JgRjlqD15Z3fVr3Om21Rjm4TAmoyjj83S5XGpL3
         Jf2Cpys77Wiz5gBuB8YJ7GxucOP2AXYN7IHSCgpDARPF132S0hdb7tgJ2ATOx0ys1ww5
         f9YNDtBULMZp2lfGXFwihIhFRfDuPY8yiT2spCGF39PigvSqayIwqippemUbwswoiXoD
         US9DanjLM7HWU+/VqqzVr9lY3YA52Uf9nvSjrKLv44S251K6CbReT085uNtb4ZocFz1Y
         fBnSp4LI+oWw1rrlVAh2K5S2GkjYFF/VaYAi2mZFl6lJdlFmDpKDi6Jvei3FpvIHxXVM
         1Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=to2G/iq7aT/AMZVmPTn7EBtCpD2Z1XKliSNNqbMoX8g=;
        b=NNOn7WcrvflaqMsYolUEbyc3AOm9SDhnn0nM4/BsurE5uNj0319C65q0tsxT8uv1QR
         WjHeNapUj1aaRoJo8Q4ehRqfyc3YvSje2OF2Z8KEjm5QNCn6kEtBVPZ9N3tS+oXDC7f4
         fNvz1jdYQdmGauX/RPeEIMbOHeN4yg/EZezpEyj2KP8rGRvqPp1GdSkv8xfCk4kNJyec
         Ohdf3E2o1R8M08pDT5fVT+gIPtYO7hWQsoD1MHgcl2f3whOxQkuTdulAoFkLWmyHDlMD
         jKlxq6GDWhj34MptF1dX+7s8Ngu/OccR6Ijbs/rG/wM0I+E0wCBXofHdiNL3z0g3UOxC
         e9dQ==
X-Gm-Message-State: APjAAAVlYPzS1CSKC1ibEyk9rWsepCBxa9X6jhnR2cUWw6qgXZ9P0fj/
        KpaWcxN2VQXaSyJMHfEWI7DK6iNB
X-Google-Smtp-Source: APXvYqzQGXveIZwuxrErJfol1lMxTKcV1HsyHDUEbYxoIuB9z2Sx62Rb8quonD+ILJ0/CFg1FeGFcQ==
X-Received: by 2002:a0d:d701:: with SMTP id z1mr3216451ywd.430.1574288755400;
        Wed, 20 Nov 2019 14:25:55 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id l34sm436843ywh.40.2019.11.20.14.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 14:25:54 -0800 (PST)
Subject: [x86/iopl PATCH] x86/ioperm: Fix use of deprecated config option
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, mingo@kernel.org, luto@kernel.org
Date:   Wed, 20 Nov 2019 14:25:53 -0800
Message-ID: <20191120222426.3060.18462.stgit@localhost.localdomain>
In-Reply-To: <157390508218.12247.10003209681229427208.tip-bot2@tip-bot2>
References: <157390508218.12247.10003209681229427208.tip-bot2@tip-bot2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In "x86/ioperm: Extend IOPL config to control ioperm()" the config option
X86_IOPL_EMULATION was replaced with X86_IOPL_IOPERM. However it appears
that there was at least one spot missed as tss_update_io_bitmap still had a
reference to it contained in the code.

The result of this is that it exposed a NULL pointer dereference as seen
below with a linux-next next-20191120 kernel:
[   17.626562] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   17.626563] #PF: supervisor read access in kernel mode
[   17.626564] #PF: error_code(0x0000) - not-present page
[   17.626564] PGD 0 P4D 0
[   17.626566] Oops: 0000 [#1] SMP PTI
[   17.626568] CPU: 5 PID: 1542 Comm: ovs-vswitchd Tainted: G        W
5.4.0-rc8-next-20191120 #125
[   17.626568] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D8 WS/Z10PE-D8 WS,
BIOS 3903 09/11/2018
[   17.626570] RIP: 0010:tss_update_io_bitmap+0x4e/0x180
[   17.626572] Code: 10 31 c0 65 48 03 1d 69 54 5d 6d 65 48 8b 04 25 40 8c 01 00
48 8b 10 f7 c2 00 00 40 00 0f 84 8c 00 00 00 4c 8b a0 c0 22 00 00 <49> 8b 04 24
48 39 43 68 74 2e 8b 53 70 41 39 54 24 0c 48 8d 7b 78
[   17.626572] RSP: 0018:ffffb8888a0ebf08 EFLAGS: 00010006
[   17.626573] RAX: ffff8a429811a680 RBX: ffff8a4c3f946000 RCX: 0000000000000011
[   17.626574] RDX: 0000000000400080 RSI: 0000000000400080 RDI: 0000000000000000
[   17.626575] RBP: ffffb8888a0ebf30 R08: 00007ffffb5d7ce0 R09: 0000000000000000
[   17.626576] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   17.626576] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   17.626578] FS:  00007f68a9635c40(0000) GS:ffff8a4c3f940000(0000)
knlGS:0000000000000000
[   17.626578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.626579] CR2: 0000000000000000 CR3: 000000103572a001 CR4: 00000000001606e0
[   17.626580] Call Trace:
[   17.626582]  ? syscall_slow_exit_work+0x39/0xdb
[   17.626584]  do_syscall_64+0x1a5/0x200
[   17.626586]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   17.626587] RIP: 0033:0x7f68a7aff797
[   17.626588] Code: 73 01 c3 48 8b 0d d9 86 2c 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 ac 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d a9 86 2c 00 f7 d8 64 89 01 48
[   17.626588] RSP: 002b:00007ffffb5d8218 EFLAGS: 00000202 ORIG_RAX:
00000000000000ac
[   17.626589] RAX: 0000000000000000 RBX: 0000000000000014 RCX: 00007f68a7aff797
[   17.626590] RDX: 00007ffffb5d8370 RSI: 00007ffffb5d8358 RDI: 0000000000000003
[   17.626590] RBP: 00000000000000e6 R08: 0000000000000000 R09: 0000000000000000
[   17.626591] R10: 00007ffffb5d7ce0 R11: 0000000000000202 R12: 0000564c9e3e2d80
[   17.626592] R13: 00007ffffb5d8370 R14: 00007ffffb5d8358 R15: 0000000000000002
[   17.626593] Modules linked in: iptable_filter sb_edac(+) acpi_cpufreq(-)
pcc_cpufreq(-) x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio kvm snd_hda_intel
snd_intel_dspcfg irqbypass snd_hda_codec snd_hda_core snd_hwdep crct10dif_pclmul
eeepc_wmi crc32_pclmul snd_seq asus_wmi vfat snd_seq_device sparse_keymap rfkill
snd_pcm ghash_clmulni_intel video wmi_bmof mxm_wmi fat aesni_intel snd_timer
crypto_simd ixgbe snd cryptd mei_me mdio glue_helper pcspkr joydev dca i2c_i801
lpc_ich soundcore mei ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter
acpi_pad ip_tables xfs libcrc32c ast drm_vram_helper drm_ttm_helper ttm
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm ahci libahci
crc32c_intel libata nvme nvme_core dm_mod
[   17.626619] CR2: 0000000000000000
[   17.626633] ---[ end trace e5d62f4aae005116 ]---

Fixes: 111e7b15cf10 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 arch/x86/kernel/process.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7964d7db9366..bd2a11ca5dd6 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -382,8 +382,7 @@ void tss_update_io_bitmap(void)
 	if (test_thread_flag(TIF_IO_BITMAP)) {
 		struct thread_struct *t = &current->thread;
 
-		if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION) &&
-		    t->iopl_emul == 3) {
+		if (IS_ENABLED(CONFIG_X86_IOPL_IOPERM) && t->iopl_emul == 3) {
 			*base = IO_BITMAP_OFFSET_VALID_ALL;
 		} else {
 			struct io_bitmap *iobm = t->io_bitmap;

