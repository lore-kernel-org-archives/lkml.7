Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C309C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1890620823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581885;
	bh=8S5TFXDgYLqYIiO2NIHKjgJTDxlMnPoDMdEQ6SYkO9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5UqZRHyJ9e8OKLbNFuVd+Of/ctnXlsaUqAYDaqMEwsEIhT7YWX5Ry3h7rCBfkz2h
	 uH1YnoXuctS1jZZkxCC+XNYqEroTjr1tKb8VVeDrphtnCvy5rBs7jgWpc1oLv1vpiZ
	 cd+dRGlLaip+1muS/3VTbmuDTktEoXBna4um0ByU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfCZGbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZGbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:21 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA63C20856;
        Tue, 26 Mar 2019 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581880;
        bh=8S5TFXDgYLqYIiO2NIHKjgJTDxlMnPoDMdEQ6SYkO9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq4I3PA3TB1kSDk1tLMSTkvUNfk+2S5bMEnNCS0KyNWMF2dhkUK2KVJtbqaqQGez/
         yiMKSRBpgm4XHlyzXmf0Iv0HuLsDKtRQZ0RR90Pc+NUAfhnYHQS1n7cUf3J412+e90
         FjKhykdak6YcjtY8rgtV2Wz0+lMiJegn9/XdeH7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jan Viktorin <jan.viktorin@gmail.com>
Subject: [PATCH 4.9 03/30] iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE
Date:   Tue, 26 Mar 2019 15:29:42 +0900
Message-Id: <20190326042607.692688142@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit 4e50ce03976fbc8ae995a000c4b10c737467beaa upstream.

Take into account that sg->offset can be bigger than PAGE_SIZE when
setting segment sg->dma_address. Otherwise sg->dma_address will point
at diffrent page, what makes DMA not possible with erros like this:

xhci_hcd 0000:38:00.3: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000 =
address=3D0x00000000fdaa70c0 flags=3D0x0020]
xhci_hcd 0000:38:00.3: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000 =
address=3D0x00000000fdaa7040 flags=3D0x0020]
xhci_hcd 0000:38:00.3: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000 =
address=3D0x00000000fdaa7080 flags=3D0x0020]
xhci_hcd 0000:38:00.3: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000 =
address=3D0x00000000fdaa7100 flags=3D0x0020]
xhci_hcd 0000:38:00.3: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000 =
address=3D0x00000000fdaa7000 flags=3D0x0020]

Additinally with wrong sg->dma_address unmap_sg will free wrong pages,
what what can cause crashes like this:

Feb 28 19:27:45 kernel: BUG: Bad page state in process cinnamon  pfn:39e8b1
Feb 28 19:27:45 kernel: Disabling lock debugging due to kernel taint
Feb 28 19:27:45 kernel: flags: 0x2ffff0000000000()
Feb 28 19:27:45 kernel: raw: 02ffff0000000000 0000000000000000 ffffffff0000=
0301 0000000000000000
Feb 28 19:27:45 kernel: raw: 0000000000000000 0000000000000000 00000001ffff=
ffff 0000000000000000
Feb 28 19:27:45 kernel: page dumped because: nonzero _refcount
Feb 28 19:27:45 kernel: Modules linked in: ccm fuse arc4 nct6775 hwmon_vid =
amdgpu nls_iso8859_1 nls_cp437 edac_mce_amd vfat fat kvm_amd ccp rng_core k=
vm mt76x0u mt76x0_common mt76x02_usb irqbypass mt76_usb mt76x02_lib mt76 cr=
ct10dif_pclmul crc32_pclmul chash mac80211 amd_iommu_v2 ghash_clmulni_intel=
 gpu_sched i2c_algo_bit ttm wmi_bmof snd_hda_codec_realtek snd_hda_codec_ge=
neric drm_kms_helper snd_hda_codec_hdmi snd_hda_intel drm snd_hda_codec aes=
ni_intel snd_hda_core snd_hwdep aes_x86_64 crypto_simd snd_pcm cfg80211 cry=
ptd mousedev snd_timer glue_helper pcspkr r8169 input_leds realtek agpgart =
libphy rfkill snd syscopyarea sysfillrect sysimgblt fb_sys_fops soundcore s=
p5100_tco k10temp i2c_piix4 wmi evdev gpio_amdpt pinctrl_amd mac_hid pcc_cp=
ufreq acpi_cpufreq sg ip_tables x_tables ext4(E) crc32c_generic(E) crc16(E)=
 mbcache(E) jbd2(E) fscrypto(E) sd_mod(E) hid_generic(E) usbhid(E) hid(E) d=
m_mod(E) serio_raw(E) atkbd(E) libps2(E) crc32c_intel(E) ahci(E) libahci(E)=
 libata(E) xhci_pci(E) xhci_hcd(E)
Feb 28 19:27:45 kernel:  scsi_mod(E) i8042(E) serio(E) bcache(E) crc64(E)
Feb 28 19:27:45 kernel: CPU: 2 PID: 896 Comm: cinnamon Tainted: G    B   W =
  E     4.20.12-arch1-1-custom #1
Feb 28 19:27:45 kernel: Hardware name: To Be Filled By O.E.M. To Be Filled =
By O.E.M./B450M Pro4, BIOS P1.20 06/26/2018
Feb 28 19:27:45 kernel: Call Trace:
Feb 28 19:27:45 kernel:  dump_stack+0x5c/0x80
Feb 28 19:27:45 kernel:  bad_page.cold.29+0x7f/0xb2
Feb 28 19:27:45 kernel:  __free_pages_ok+0x2c0/0x2d0
Feb 28 19:27:45 kernel:  skb_release_data+0x96/0x180
Feb 28 19:27:45 kernel:  __kfree_skb+0xe/0x20
Feb 28 19:27:45 kernel:  tcp_recvmsg+0x894/0xc60
Feb 28 19:27:45 kernel:  ? reuse_swap_page+0x120/0x340
Feb 28 19:27:45 kernel:  ? ptep_set_access_flags+0x23/0x30
Feb 28 19:27:45 kernel:  inet_recvmsg+0x5b/0x100
Feb 28 19:27:45 kernel:  __sys_recvfrom+0xc3/0x180
Feb 28 19:27:45 kernel:  ? handle_mm_fault+0x10a/0x250
Feb 28 19:27:45 kernel:  ? syscall_trace_enter+0x1d3/0x2d0
Feb 28 19:27:45 kernel:  ? __audit_syscall_exit+0x22a/0x290
Feb 28 19:27:45 kernel:  __x64_sys_recvfrom+0x24/0x30
Feb 28 19:27:45 kernel:  do_syscall_64+0x5b/0x170
Feb 28 19:27:45 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Cc: stable@vger.kernel.org
Reported-and-tested-by: Jan Viktorin <jan.viktorin@gmail.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Fixes: 80187fd39dcb ('iommu/amd: Optimize map_sg and unmap_sg')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/amd_iommu.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2599,7 +2599,12 @@ static int map_sg(struct device *dev, st
=20
 	/* Everything is mapped - write the right values into s->dma_address */
 	for_each_sg(sglist, s, nelems, i) {
-		s->dma_address +=3D address + s->offset;
+		/*
+		 * Add in the remaining piece of the scatter-gather offset that
+		 * was masked out when we were determining the physical address
+		 * via (sg_phys(s) & PAGE_MASK) earlier.
+		 */
+		s->dma_address +=3D address + (s->offset & ~PAGE_MASK);
 		s->dma_length   =3D s->length;
 	}
=20


