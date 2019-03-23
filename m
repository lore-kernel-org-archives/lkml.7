Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6464C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB57D217D8
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCWVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:03:28 -0400
Received: from mail.emypeople.net ([216.220.167.73]:40303 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfCWVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:03:27 -0400
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Mar 2019 17:03:26 EDT
Received: from Shop7 ([166.182.243.197])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201903231650322124;
        Sat, 23 Mar 2019 16:50:32 -0400
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Miklos Szeredi'" <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>
Cc:     "'Edwin Zimmerman'" <edwin@211mainstreet.net>
Subject: Pagefault in fuse_do_ioctl
Date:   Sat, 23 Mar 2019 16:50:23 -0400
Message-ID: <000101d4e1ba$09f90b70$1deb2250$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdThuYDUPRAM4GeaSVSl7444X/9wcQ==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.0.0-rc4+, I encountered a pagefault in fuse_do_ioctl when fuzzing with trinity
on a ntfs filesystem mounted with fuse.  I have not been able to reproduce it
on other filesystem types.  The following python script will reproduce this bug 
when run on a fuse-mounted ntfs path.

>import fcntl
>f = open('testfile1', 'wb')
>fcntl.ioctl(f, 0x80046601, -8)

Running mount.ntfs outputs the following:

ntfs-3g 2017.3.23 integrated FUSE 28 - Third Generation NTFS Driver
		Configuration type 7, XATTRS are on, POSIX ACLS are on


Bug trace:
[ 8102.178279] BUG: pagefault on kernel address 0xfffffff8 in non-whitelisted uaccess
[ 8102.178296] BUG: unable to handle kernel paging request at fffffff8
[ 8102.178301] #PF error: [WRITE]
[ 8102.178305] *pdpt = 0000000012b90001 *pde = 0000000012b92063 *pte = 0000000000000000 
[ 8102.178317] Oops: 0002 [#1] SMP NOPTI
[ 8102.178326] CPU: 1 PID: 5122 Comm: python3 Not tainted 5.0.0-rc4+ #8
[ 8102.178330] Hardware name: Acer AOA150/, BIOS v0.3305 05/09/2008
[ 8102.178345] EIP: copy_page_to_iter+0xfd/0x2f1
[ 8102.178352] Code: ec ff ff 8b 55 dc 29 c2 01 55 ec 8d 0c 13 8b 5d f0 89 4d e0 29 d3 e9 86 00 00 00 39 55 e8 0f 87 b6 00 00 00 8b
45 e8 8d 76 00 <c6> 00 00 31 c9 eb 05 b9 f2 ff ff ff 8d 76 00 85 c9 0f 85 99 00 00
[ 8102.178358] EAX: fffffff8 EBX: 00000004 ECX: 00001000 EDX: fffffffb
[ 8102.178363] ESI: d3211000 EDI: d318de68 EBP: d318de18 ESP: d318ddf0
[ 8102.178369] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010293
[ 8102.178375] CR0: 80050033 CR2: fffffff8 CR3: 34cc5520 CR4: 000006e0
[ 8102.178379] Call Trace:
[ 8102.178396]  fuse_do_ioctl+0x438/0x4e2
[ 8102.178410]  fuse_ioctl_common+0x49/0x59
[ 8102.178417]  ? fuse_file_compat_ioctl+0x11/0x11
[ 8102.178424]  fuse_file_ioctl+0xf/0x11
[ 8102.178433]  vfs_ioctl+0x1f/0x29
[ 8102.178440]  do_vfs_ioctl+0x535/0x552
[ 8102.178447]  ? __do_sys_fstat64+0x33/0x49
[ 8102.178456]  ? fuse_direct_mmap+0x34/0x34
[ 8102.178464]  ksys_ioctl+0x46/0x66
[ 8102.178472]  sys_ioctl+0x16/0x18
[ 8102.178481]  do_fast_syscall_32+0x94/0xd3
[ 8102.178490]  entry_SYSENTER_32+0x6b/0xbe
[ 8102.178496] EIP: 0xb7fb27c5
[ 8102.178503] Code: cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 90 51 52 55 89
e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[ 8102.178509] EAX: ffffffda EBX: 00000003 ECX: 80046601 EDX: fffffff8
[ 8102.178514] ESI: bfa407f0 EDI: 80046601 EBP: 09c79a60 ESP: bfa407a8
[ 8102.178519] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[ 8102.178527] Modules linked in: usblp nls_iso8859_1 ccm arc4 snd_hda_codec_realtek snd_hda_codec_generic uvcvideo ledtrig_audio
snd_hda_intel snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hda_core videobuf2_v4l2 videobuf2_common snd_hwdep snd_pcm ath5k
videodev acerhdf ath snd_seq_midi coretemp media mac80211 snd_seq_midi_event snd_rawmidi joydev input_leds snd_seq serio_raw
snd_seq_device sparse_keymap snd_timer jmb38x_ms lpc_ich memstick snd cfg80211 soundcore mac_hid binfmt_misc sch_fq_codel parport_pc
ppdev lp parport ip_tables x_tables autofs4 dm_mirror dm_region_hash dm_log i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
sysimgblt psmouse sdhci_pci fb_sys_fops cqhci r8169 pata_acpi sdhci drm realtek wmi video uas usb_storage
[ 8102.178621] CR2: 00000000fffffff8
[ 8102.178628] ---[ end trace 526b529f6024cdd7 ]---
[ 8102.178636] EIP: copy_page_to_iter+0xfd/0x2f1
[ 8102.178642] Code: ec ff ff 8b 55 dc 29 c2 01 55 ec 8d 0c 13 8b 5d f0 89 4d e0 29 d3 e9 86 00 00 00 39 55 e8 0f 87 b6 00 00 00 8b
45 e8 8d 76 00 <c6> 00 00 31 c9 eb 05 b9 f2 ff ff ff 8d 76 00 85 c9 0f 85 99 00 00
[ 8102.178648] EAX: fffffff8 EBX: 00000004 ECX: 00001000 EDX: fffffffb
[ 8102.178653] ESI: d3211000 EDI: d318de68 EBP: d318de18 ESP: d2b9be5c
[ 8102.178658] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010293
[ 8102.178664] CR0: 80050033 CR2: fffffff8 CR3: 34cc5520 CR4: 000006e0

