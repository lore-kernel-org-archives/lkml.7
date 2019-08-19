Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A9C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B12A2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxsy9k8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSDJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:09:59 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:33254 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfHSDJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:09:58 -0400
Received: by mail-lf1-f42.google.com with SMTP id x3so271401lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 20:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=g4MT+WUIltkX40Ci2qNW/mxgAGWOyYxUjxwTmptIExo=;
        b=Mxsy9k8HHUJSjNTLanOAAij2MYsMvE/Cslbso53OPQQdtQ7FDmVr/k3vvyqhV7krdB
         Jz8sJqvOkp1XvTIe2Gq4pdsMM6Dqbtw1vcu2kr3oqVMIQTMYiehbBEXyIR6+tdwmPLt2
         0hfPuewVlzUybUfmtu3J5UpSThwnQc8i9RkO+AlqnfZ336EMCCbpzI5QWyRG9b1z7yBc
         rSycHSxbIVXvk9P+q95+bgXAlQ4gGRvEaTLkiHh7jmVcHj+J3bDpsk0KA6iYCrNl+G0I
         B3PkR0OrVAWXo9vGer75L88VmOexMtVzkpN7eCVj3YzFzlNGUpVij8/epS8Gw9WB8wMi
         c0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g4MT+WUIltkX40Ci2qNW/mxgAGWOyYxUjxwTmptIExo=;
        b=Uyc2V9Giz7jblcR6W7hTTJUOBP1SC51xLtfNqh8d3VEijfZMAJfTfKj+uUtMBdJiaM
         eFOkEQXZjk57CQ+md8JFg6M+MXSTCO79j1zhoNRqvzC1PUgKF+EBqKPPi9Bw8uRGg7Rv
         6ss73KsKjKKwEfHMSBHHkY1WxJvAc1mthozG3v5dUI/63pzCiR2THfXeR6I7IUL+w85y
         Xp9ixs6K78a3+dKuouzIIE6vKQfeYtaAVFcj/gQdBHi0GacdWw2EmVU/ulHywG6ILfgp
         CdowzFT5bNLfLoLE8XPPY1dZqtOl3JZCl7/lgv56O5dX/qq3MsPPE7dB6Lw0pyvBBMeF
         /12Q==
X-Gm-Message-State: APjAAAX7JIAu/YwMZVOI+5SgKx+r9Nbhz8EsEVtDaIXtcwIqKTgZnZuV
        0ssoGcOJqK9oinVOUn22v6fWxlbP35GAlABP05YEFe8R
X-Google-Smtp-Source: APXvYqw0yuLrtjw9cw7gfXkHBJC+055VU+FNnNxjbCnQuYeyHbQyRmQMCtq1y6XzLjO89pl1NjQjmy2+p+EUBmdNy6k=
X-Received: by 2002:a19:e006:: with SMTP id x6mr10560027lfg.165.1566184196322;
 Sun, 18 Aug 2019 20:09:56 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 19 Aug 2019 13:09:44 +1000
Message-ID: <CAPM=9txWnUx9WBQNYYYDyC-Nz0vVnF2-1YxRfGWn9HxJxeLtGw@mail.gmail.com>
Subject: oops on cdrom eject
To:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I mentioned this on irc and I'll probably dig into a bit further.

Fedora 30, 5.1.18 was fine, 5.2.9 oops on CD eject with the below.

Dave.


[10384.391028] FAT-fs (sdc1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[10385.221284] ISO 9660 Extensions: Microsoft Joliet Level 3
[10385.351758] ISOFS: changing to secondary root
[10408.030879] VFS: busy inodes on changed media or resized disk sr0
[10408.338449] WARNING: CPU: 0 PID: 3026 at fs/block_dev.c:1868
__blkdev_put+0x1c0/0x1e0
[10408.338451] Modules linked in: nls_utf8 vfat fat isofs rfcomm fuse
xt_CHECKSUM xt_MASQUERADE tun bridge stp llc nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
ip_tables bnep sunrpc snd_hda_codec_analog snd_hda_codec_generic arc4
rt2800pci rt2800mmio rt2800lib ledtrig_audio rt2x00pci rt2x00mmio
coretemp rt2x00lib mac80211 iTCO_wdt iTCO_vendor_support kvm
snd_hda_intel snd_hda_codec uvcvideo snd_hda_core btusb
videobuf2_vmalloc irqbypass btrtl videobuf2_memops snd_hwdep
videobuf2_v4l2 snd_seq btbcm videobuf2_common btintel cfg80211
snd_seq_device bluetooth videodev snd_pcm ir_rc6_decoder rc_rc6_mce
mceusb joydev media snd_timer snd soundcore
[10408.338501]  eeprom_93cx6 ecdh_generic i2c_i801 rfkill lpc_ich ecc
pcc_cpufreq acpi_cpufreq binfmt_misc nouveau mxm_wmi wmi i2c_algo_bit
serio_raw firewire_ohci drm_kms_helper firewire_core ata_generic
pata_acpi ttm crc_itu_t drm r8169 video uas usb_storage
[10408.338519] CPU: 0 PID: 3026 Comm: umount Not tainted
5.2.8-200.fc30.x86_64 #1
[10408.338520] Hardware name: HP-Pavilion FK936AA-ABG IQ518a/EVE, BIOS
5.06    07/10/2008
[10408.338523] RIP: 0010:__blkdev_put+0x1c0/0x1e0
[10408.338525] Code: 41 5e 41 5f c3 49 8b 85 d8 03 00 00 48 8b 40 08
48 85 c0 0f 84 49 ff ff ff 8b 74 24 04 4c 89 ef e8 45 5c 8c 00 e9 38
ff ff ff <0f> 0b e9 97 fe ff ff e8 04 79 16 00 eb 9d e8 2d 31 da ff 66
66 2e
[10408.338527] RSP: 0018:ffffb547c37cbe40 EFLAGS: 00010202
[10408.338529] RAX: 0000000000000000 RBX: ffff8bc06474f0c0 RCX: 0000000000000000
[10408.338530] RDX: 0000000000000002 RSI: 0000000000000081 RDI: ffff8bc06474f0d8
[10408.338531] RBP: ffff8bc05faf4800 R08: 0000000000000001 R09: ffff8bc06bb294b0
[10408.338533] R10: 00000000045b0f50 R11: 0000000000000000 R12: ffff8bc06474f0d8
[10408.338534] R13: ffff8bc064ef2800 R14: ffff8bbffe1fa5dc R15: 0000000000000000
[10408.338536] FS:  00007fb3d486a080(0000) GS:ffff8bc06ba00000(0000)
knlGS:0000000000000000
[10408.338537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10408.338539] CR2: 000055c47e137d00 CR3: 00000000be11c000 CR4: 00000000000006f0
[10408.338540] Call Trace:
[10408.338549]  deactivate_locked_super+0x36/0x70
[10408.338552]  cleanup_mnt+0x3f/0x70
[10408.338555]  task_work_run+0x87/0xa0
[10408.338559]  exit_to_usermode_loop+0xc2/0xd0
[10408.338562]  do_syscall_64+0x183/0x1a0
[10408.338566]  ? page_fault+0x8/0x30
[10408.338568]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10408.338571] RIP: 0033:0x7fb3d4ab433b
[10408.338574] Code: 4b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 4b 0c 00 f7 d8 64 89
01 48
[10408.338575] RSP: 002b:00007ffed4ca5ae8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[10408.338577] RAX: 0000000000000000 RBX: 00007fb3d4be01c4 RCX: 00007fb3d4ab433b
[10408.338578] RDX: 00323131315f3832 RSI: 0000000000000000 RDI: 000055ab43d30630
[10408.338580] RBP: 000055ab43d30420 R08: 0000000000000000 R09: 00007fb3d4af55a0
[10408.338581] R10: 64656d2f6e75722f R11: 0000000000000246 R12: 000055ab43d30630
[10408.338582] R13: 0000000000000000 R14: 000055ab43d30518 R15: 000055ab43d30e60
[10408.338585] ---[ end trace 0c7c3cb099ae73de ]---
