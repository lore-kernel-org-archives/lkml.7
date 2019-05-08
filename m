Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4D1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzrG6iFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEHHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:33:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42704 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEHHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:33:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so9646959pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=j7gXF0s8Thb5c4owpM/k5bhaqI9Bqs89ZUG41ZbiHNY=;
        b=qzrG6iFVQmXOrkMPiJqgRLRoVyP/tzOPazJnpr6tP+Vm7Oy2xsXqYT7JBsYE/7f1eK
         HUE2DuvQ2UXJYfay+Cp6FIl6mWnPQy9w2/QExcrQK5APNOdKPTQwkg4NDG2KV4qQxpC2
         U74wsTZbxM3oLt41kvVxOCjxLrbiDomigt4vAxW2+w8iSkS4e312m6LtCWW09b+d6NQs
         JY+4ES1leSBy6QQgOINNpL0A/yozMwiZLydoe7FDeLwuHZB0CZPfCFHTLRlUorotJTRp
         4ZLVFPCaO+/QenpbCPa2vBlU6dnm69Ak9K2jj0b6eNdi6eSPAL9m+ju3hWVY76c/jJ6x
         /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j7gXF0s8Thb5c4owpM/k5bhaqI9Bqs89ZUG41ZbiHNY=;
        b=f5X65kYsrAPJLCBf+DQmihPfTLufXEWLqG2q4InjP9eugA53nlQ2BWpodSgoZSM1td
         JvhF2EvX9ZVqWX450KG5vn6y0dLbyybWGCOirl/k3DZ+HTiJJWasU4sbdYiXCShuPlil
         z+jbsYf/KkfdRmGh+PedPGnlqudzWKhPUxB91lWQ/ZFz+48Eliq0DL1w0gMzFPG2lCJd
         xTQW+W0MIxPiWpjJziNjh5mZ27Dc10GVw/hcQmZ7n5FIXwgOjA2M7YWLe11oqVclkawK
         DpZ/p4NnOkCiaxntOgQjw2u9YSZf2zww9AsdGmtlstTNkHwrw1V2oYhxCmqJQ4E1qbui
         12XQ==
X-Gm-Message-State: APjAAAVG+NqS95lXlQ3NUwGiK3bBibdwNM9fCKiAQKeX/SbCy+UBmyP7
        JQZKCSUL7PvWVNABAapOF3Q=
X-Google-Smtp-Source: APXvYqwdkrzhx43zan5V2uFyzMbITyzTVc7ZP+wgnRjNMYqbnQ2a94TjC97F0QxTnQo9g5H2Xc832w==
X-Received: by 2002:a62:6444:: with SMTP id y65mr38844954pfb.148.1557300792305;
        Wed, 08 May 2019 00:33:12 -0700 (PDT)
Received: from localhost ([175.223.21.172])
        by smtp.gmail.com with ESMTPSA id g188sm890080pfc.151.2019.05.08.00.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:33:11 -0700 (PDT)
Date:   Wed, 8 May 2019 16:33:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] [PATCH] oops: add "begin trace" + oops_id to match "end
 trace" + oops_id
Message-ID: <20190508073308.GA15704@jagdpanzerIV>
References: <9b8a2852-60ec-4519-fac8-4e1aa2763970@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b8a2852-60ec-4519-fac8-4e1aa2763970@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/29/19 17:08), Randy Dunlap wrote:
> Print a "begin trace" + oops ID number to match the current
> "end trace" + oops ID number.
>=20
> Example:
> [  193.314027] ---[ begin trace cf01af0ff0925003 ]---
> [  193.314032] general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> [  193.314046] CPU: 2 PID: 2884 Comm: bash Tainted: G           O      5.=
1.0-rc6mod #1
> [  193.314048] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Vers=
ion 4.10   01/08/2013
> [  193.314058] RIP: 0010:proc_dump_test+0x7c/0x13b [dump_test]
> [  193.314062] Code: 5c 41 5d 5d c3 be 27 00 00 00 48 c7 c7 60 10 d9 c1 e=
8 58 b2 85 c6 4c 89 e0 e8 40 41 3f c8 85 c0 41 89 c5 75 39 80 fa 6f 75 3c <=
a0> 00 00 00 00 00 fc ff df 84 c0 74 04 84 c0 7e 12 c6 04 25 00 00
> [  193.314065] RSP: 0018:ffff88811ea4fce0 EFLAGS: 00010246
> [  193.314069] RAX: 0000000000000000 RBX: ffff88811ea4fd48 RCX: 000000000=
0000015
> [  193.314072] RDX: 000000000000006f RSI: 0000000000000027 RDI: ffff88811=
7df0064
> [  193.314075] RBP: ffff88811ea4fcf8 R08: ffff88811ea4fe88 R09: fffffbfff=
1661c71
> [  193.314077] R10: 0000000000000001 R11: fffffbfff1661c70 R12: 000056103=
bd643f0
> [  193.314080] R13: 0000000000000000 R14: ffff888117c58b48 R15: ffffffffc=
1d920a0
> [  193.314083] FS:  00007ff067886b80(0000) GS:ffff88811f200000(0000) knlG=
S:0000000000000000
> [  193.314086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  193.314089] CR2: 000056103bd643f0 CR3: 0000000117ae4005 CR4: 000000000=
00606e0
> [  193.314090] Call Trace:
> {lines deleted for brevity}
> [  193.314187] RIP: 0033:0x7ff066f64c14
> [  193.314190] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 8=
0 00 00 00 00 8b 05 1a fc 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
> [  193.314193] RSP: 002b:00007fffaf5eaa08 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [  193.314197] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff06=
6f64c14
> [  193.314199] RDX: 0000000000000002 RSI: 000056103bd643f0 RDI: 000000000=
0000001
> [  193.314202] RBP: 000056103bd643f0 R08: 000000000000000a R09: 000000000=
0000000
> [  193.314204] R10: 000000000000000a R11: 0000000000000246 R12: 000000000=
0000002
> [  193.314206] R13: 0000000000000001 R14: 00007ff067230720 R15: 000000000=
0000002
> [  193.314215] Modules linked in: dump_test(O) fuse xt_tcpudp ip6t_rpfilt=
er ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack af_pac=
ket ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat=
 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_secur=
ity ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_ta=
bles x_tables bpfilter uvcvideo videobuf2_vmalloc videobuf2_memops videobuf=
2_v4l2 hid_generic usbkbd usbmouse videobuf2_common btrfs usbhid videodev h=
id coretemp hwmon media intel_rapl msr x86_pkg_temp_thermal intel_powerclam=
p kvm_intel xor mei_hdcp kvm zstd_compress irqbypass raid6_pq arc4 crct10di=
f_pclmul iTCO_wdt iwldvm libcrc32c crc32_pclmul iTCO_vendor_support crc32c_=
intel zstd_decompress ghash_clmulni_intel snd_hda_codec_hdmi mac80211 snd_h=
da_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_=
codec aesni_intel
> [  193.314293]  aes_x86_64 crypto_simd snd_hda_core iwlwifi cryptd snd_hw=
dep glue_helper sdhci_pci intel_cstate toshiba_acpi sparse_keymap cqhci snd=
_pcm intel_uncore sr_mod joydev sdhci cdrom intel_rapl_perf wmi input_leds =
cfg80211 snd_timer mmc_core uio_pdrv_genirq mousedev uio serio_raw pcspkr m=
ei_me rtc_cmos toshiba_haps led_class e1000e thermal snd rfkill evdev indus=
trialio mac_hid mei soundcore lpc_ich pcc_cpufreq battery ac sg dm_multipat=
h dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
> [  193.314358] ---[ end trace cf01af0ff0925003 ]---
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Can the "begin trace" event happen multiple times before "end trace"?

Depending on use cases, CONFIG_PRINTK_CALLER can do same or maybe
even better job. WARN->dump_stack() from different tasks/CPU will
have different CALLER id. Mind to give CONFIG_PRINTK_CALLER a try?

	-ss
