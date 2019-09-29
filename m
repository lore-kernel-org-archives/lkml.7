Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E49C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AA32082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="KoPkTZ3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfI2NJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:09:51 -0400
Received: from hz.preining.info ([95.216.25.247]:53908 "EHLO hz.preining.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfI2NJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ppgVLlqkVsOKnpBZSVm+M6uI9uNrUQPKpIDO4/1dEkA=; b=KoPkTZ3q7QhnU3VJKuK6GD6yMV
        sGWHFzj011hONE95gxj3rCvaLleUjSHIVUICVR6kzREa0vjyDMrEOSNN7Ucb7IfHrtfd8dl/z222j
        v5RG5n7ZFPW6MzxSa54+A4j3SW+xirkvt6St+aL4NyIqN+R+R53hXOEeNTV1iNYHRweb+zbOHU4+G
        4KyL5CLi8f4aPZalJ30A0LkFDjEB53JyydLZgBi33EDgGaVnxGJEb94BuHCnarBZaYs9Uy8cKjAdM
        EIBfjG7QLKY5ebWUZlE+su4S6cVoir+htIMVpdIPruDHBz6ilvob8ldoBRpPB5ywZorcCVdxwdIzr
        IASQVucw==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1iEYxO-0002SM-QO; Sun, 29 Sep 2019 13:09:47 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id 3CAED698B215; Sun, 29 Sep 2019 22:09:43 +0900 (JST)
Date:   Sun, 29 Sep 2019 22:09:43 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: kernel warning related to i915 code
Message-ID: <20190929130943.rfe6f2vsnaifrip5@burischnitzel.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

(please Cc)

linux 5.3.1
Debian/sid
Lenovo X260
[    2.472152] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.473035] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.473037] [drm] Driver supports precise vblank timestamp query.
[    2.473431] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.474796] [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
[    2.497068] [drm] Initialized i915 1.6.0 20190619 for 0000:00:02.0 on minor 0
[    2.499469] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.500011] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    2.697843] fbcon: i915drmfb (fb0) is primary device
[    2.711468] Console: switching to colour frame buffer device 240x67
[    2.732932] i915 0000:00:02.0: fb0: i915drmfb frame buffer device


I am seeing kernel warnings in flushqueue:
[ 6180.832664] workqueue: PF_MEMALLOC task 117(kswapd0) is flushing !WQ_MEM_RECLAIM events:gen6_pm_rps_work [i915]
[ 6180.832670] WARNING: CPU: 2 PID: 117 at check_flush_dependency+0xa0/0x130
[ 6180.832671] Modules linked in: hid_generic(E) usbhid(E) hid(E) xt_MASQUERADE(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(
E) xt_addrtype(E) xt_conntrack(E) br_netfilter(E) pci_stub(E) vboxpci(OE) vboxnetadp(OE) l2tp_ppp(E) l2tp_netlink(E) vboxnetflt(OE
) l2tp_core(E) ip6_udp_tunnel(E) udp_tunnel(E) pppox(E) ppp_generic(E) vboxdrv(OE) slhc(E) ccm(E) rfcomm(E) xt_CHECKSUM(E) ipt_REJ
ECT(E) nf_reject_ipv4(E) xt_tcpudp(E) nft_compat(E) nft_counter(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf
_defrag_ipv4(E) nf_tables(E) nfnetlink(E) tun(E) cmac(E) cpufreq_userspace(E) cpufreq_powersave(E) bnep(E) cpufreq_conservative(E)
 uinput(E) binfmt_misc(E) nls_ascii(E) nls_cp437(E) btusb(E) btrtl(E) btbcm(E) uvcvideo(E) btintel(E) intel_rapl_msr(E) snd_hda_co
dec_hdmi(E) videobuf2_vmalloc(E) intel_rapl_common(E) videobuf2_memops(E) videobuf2_v4l2(E) fuse(E) bluetooth(E) videobuf2_common(
E) iwlmvm(E) snd_hda_codec_realtek(E) ecdh_generic(E) videodev(E) ecc(E) snd_hda_codec_generic(E)
[ 6180.832696]  mac80211(E) mei_hdcp(E) x86_pkg_temp_thermal(E) libarc4(E) snd_hda_intel(E) intel_powerclamp(E) coretemp(E) iwlwif
i(E) snd_hda_codec(E) snd_hwdep(E) kvm_intel(E) snd_hda_core(E) efi_pstore(E) kvm(E) cfg80211(E) irqbypass(E) snd_pcm(E) thinkpad_
acpi(E) intel_pch_thermal(E) iTCO_wdt(E) joydev(E) mei_me(E) snd_timer(E) nvram(E) efivars(E) ledtrig_audio(E) iTCO_vendor_support
(E) serio_raw(E) sg(E) snd(E) tpm_crb(E) mei(E) evdev(E) pcspkr(E) soundcore(E) rfkill(E) tpm_tis(E) ac(E) tpm_tis_core(E) battery
(E) tpm(E) rng_core(E) button(E) sunrpc(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456
(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) s
d_mod(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) i915(E) ahci(E) i2c_algo_bit(E) libahci(E) drm
_kms_helper(E) aesni_intel(E) rtsx_pci_sdmmc(E) syscopyarea(E) xhci_pci(E) libata(E) mmc_core(E)
[ 6180.832721]  sysfillrect(E) aes_x86_64(E) sysimgblt(E) crypto_simd(E) fb_sys_fops(E) xhci_hcd(E) cryptd(E) glue_helper(E) psmou
se(E) i2c_i801(E) scsi_mod(E) drm(E) usbcore(E) thermal(E) video(E)
[ 6180.832730] CPU: 2 PID: 117 Comm: kswapd0 Tainted: G           OE     5.3.1+ #16
[ 6180.832731] Hardware name: LENOVO 20F5CTO1WW/20F5CTO1WW, BIOS R02ET71W (1.44 ) 05/08/2019
[ 6180.832733] RIP: 0010:check_flush_dependency+0xa0/0x130
[ 6180.832735] Code: 8d 8a 60 06 00 00 49 89 e8 48 c7 c7 f0 a0 87 97 48 8d 8b b0 00 00 00 4c 89 ca 48 89 04 24 c6 05 62 2b 28 01 0
1 e8 0e 16 fe ff <0f> 0b 48 8b 04 24 eb 10 4c 89 e7 e8 30 64 00 00 41 f6 44 24 25 08
[ 6180.832736] RSP: 0018:ffffaa41801e78e8 EFLAGS: 00010082
[ 6180.832738] RAX: 0000000000000000 RBX: ffff9e48d0414c00 RCX: 0000000000000000
[ 6180.832739] RDX: 0000000000000063 RSI: ffffffff980515e3 RDI: ffffffff980519e3
[ 6180.832740] RBP: ffffffffc05ae640 R08: 0000059f1655da91 R09: 0000000000000063
[ 6180.832741] R10: ffffffff98051960 R11: 00000000980515cb R12: ffff9e48cf87e080
[ 6180.832742] R13: ffff9e48d222c400 R14: 0000000000000001 R15: ffff9e48c97ede80
[ 6180.832743] FS:  0000000000000000(0000) GS:ffff9e48d2300000(0000) knlGS:0000000000000000
[ 6180.832744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6180.832745] CR2: 00007fc7a50c2000 CR3: 0000000118c0a005 CR4: 00000000003606e0
[ 6180.832746] Call Trace:
[ 6180.832750]  __flush_work+0x92/0x1b0
[ 6180.832753]  ? enqueue_hrtimer+0x36/0x90
[ 6180.832755]  ? hrtimer_start_range_ns+0x18b/0x2c0
[ 6180.832757]  __cancel_work_timer+0x100/0x190
[ 6180.832760]  ? _cond_resched+0x15/0x30
[ 6180.832762]  ? synchronize_irq+0x3a/0xa0
[ 6180.832764]  ? _raw_spin_lock_irqsave+0x25/0x30
[ 6180.832783]  ? fwtable_write32+0x4f/0x210 [i915]
[ 6180.832799]  gen6_disable_rps_interrupts+0x79/0xa0 [i915]
[ 6180.832817]  gen6_rps_idle+0x13/0xe0 [i915]
[ 6180.832836]  intel_gt_park+0x54/0x60 [i915]
[ 6180.832854]  __intel_wakeref_put_last+0x17/0x50 [i915]
[ 6180.832873]  __engine_park+0xbc/0xd0 [i915]
[ 6180.832890]  __intel_wakeref_put_last+0x17/0x50 [i915]
[ 6180.832912]  i915_request_retire+0x178/0x310 [i915]
[ 6180.832934]  ring_retire_requests+0x4e/0x60 [i915]
[ 6180.832955]  i915_retire_requests+0x43/0x80 [i915]
[ 6180.832976]  i915_gem_shrink+0xcb/0x4c0 [i915]
[ 6180.832997]  i915_gem_shrinker_scan+0x63/0x110 [i915]
[ 6180.833007]  do_shrink_slab+0x149/0x290
[ 6180.833011]  shrink_slab+0xac/0x2b0
[ 6180.833013]  shrink_node+0xf5/0x490
[ 6180.833016]  balance_pgdat+0x2bb/0x500
[ 6180.833019]  kswapd+0x1e8/0x3b0
[ 6180.833024]  ? wait_woken+0x70/0x70
[ 6180.833026]  ? balance_pgdat+0x500/0x500
[ 6180.833029]  kthread+0x118/0x130
[ 6180.833032]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 6180.833034]  ret_from_fork+0x35/0x40
[ 6180.833036] ---[ end trace 765b2991cf66218a ]---

Best

Norbert

--
PREINING Norbert                               http://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
