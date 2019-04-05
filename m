Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85CA21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="fiBhreVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfDEKVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:21:40 -0400
Received: from rush.cubic.ch ([176.9.78.115]:58032 "EHLO rush.cubic.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfDEKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa1;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=zaDiEQCm8CHaqr+7KCCddmLAA2oXPiRZlkzSNBHR1o0=;
        b=fiBhreVWrGlUtNluHyHHjKwd1GiyskijxDIRXNXZq6boXNgba9ygKWUlNt2R5cAsRDVjn9Ttd1fKoyZg8EB2yFxHXKyU+l0rChmU8IK+T8ups2VSMZ1TS30+EM8k8Nnn;
Received: from 83.41.150.83.ftth.as8758.net ([83.150.41.83] helo=[192.168.123.169])
        by rush.cubic.ch with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <stuff@decentral.ch>)
        id 1hCLyX-0003zM-EW; Fri, 05 Apr 2019 12:21:33 +0200
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190404.184718.1193600058567939028.davem@davemloft.net>
From:   Tim Tassonis <stuff@decentral.ch>
Message-ID: <5b573b34-661b-8881-5bc5-40115426042c@decentral.ch>
Date:   Fri, 5 Apr 2019 12:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404.184718.1193600058567939028.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 3:47 AM, David Miller wrote:
> 

...

> 
> David S. Miller (15):
>        Merge branch 'thunderx-fix-receive-buffer-page-recycling'
>        Merge tag 'batadv-net-for-davem-20190328' of git://git.open-mesh.org/linux-merge
>        Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
>        Merge branch 'nfp-fix-retcode-and-disable-netpoll-on-representors'
>        Revert "cxgb4: Update 1.23.3.0 as the latest firmware supported."
>        Merge tag 'mlx5-fixes-2019-03-29' of git://git.kernel.org/.../saeed/linux
>        Merge git://git.kernel.org/.../bpf/bpf
>        Merge branch 'net-stmmac-fix-handling-of-oversized-frames'
>        Merge branch 'tipc-a-batch-of-uninit-value-fixes-for-netlink_compat'
>        Merge branch 'net-sched-fix-stats-accounting-for-child-NOLOCK-qdiscs'
>        Merge branch 'nfp-flower-fix-matching-and-pushing-vlan-CFI-bit'
>        Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
>        Merge branch 'net-hns-bugfixes-for-HNS-Driver'
>        Merge branch 'sch_cake-fixes'
>        Merge git://git.kernel.org/.../bpf/bpf
> 
> 
> Paolo Abeni (3):
>        net: datagram: fix unbounded loop in __skb_try_recv_datagram()
>        net: sched: introduce and use qstats read helpers
>        net: sched: introduce and use qdisc tree flush/purge helpers
> 

Could it be that these changes, especially the ones from

net: sched: fix stats accounting for child NOLOCK qdiscs

are fixing the long-standing issue of random ethernet card adapter 
resets that were introduces somewhere between 4.14.xx and 4.19.xx?

There are numerous reports of different nics failing (mine is a igb), 
with no real solution found yet.

https://bugzilla.kernel.org/show_bug.cgi?id=199783

has a few examples.

I'm certainly no expert, but my kernel trace seems to point to that area:

[88273.078248] ------------[ cut here ]------------
[88273.083042] NETDEV WATCHDOG: enp2s0 (igb): transmit queue 2 timed out
[88273.089827] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:461 
dev_watchdog+0x1ee/0x200
[88273.098253] Modules linked in: ctr ccm xt_limit nfsd nfs_acl lockd 
grace sunrpc nf_log_ipv4 nf_log_common xt_LOG ipt_MASQUERADE 
xt_conntrack iptable_nat nf_nat_ipv4 iptable_filter nf_nat_ftp nf_nat 
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
bridge stp ipv6 crc_ccitt arc4 amd64_edac_mod kvm_amd kvm irqbypass 
crct10dif_pclmul crc32_pclmul ath10k_pci crc32c_intel ath10k_core 
ghash_clmulni_intel sdhci_pci ath pcbc mac80211 cqhci aesni_intel 
ehci_pci aes_x86_64 sdhci leds_apu xhci_pci crypto_simd ehci_hcd 
mmc_core fam15h_power cryptd glue_helper igb xhci_hcd k10temp cfg80211 
pcspkr rtc_cmos ptp hwmon dca usbcore usb_common ccp fuse
[88273.157981] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.31 #1
[88273.164223] Hardware name: PC Engines APU2/APU2, BIOS 4.0.7 02/28/2017
[88273.170918] RIP: 0010:dev_watchdog+0x1ee/0x200
[88273.175457] Code: 00 48 63 4d e0 eb 93 4c 89 e7 c6 05 f1 2a b1 00 01 
e8 e6 14 fd ff 89 d9 48 89 c2 4c 89 e6 48 c7 c7 38 24 dd 81 e8 02 ef aa 
ff <0f> 0b eb c0 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 48 c7 47 08
[88273.194827] RSP: 0018:ffff88811ab03e88 EFLAGS: 00010286
[88273.200160] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 
0000000000000000
[88273.207484] RDX: 0000000000040400 RSI: 00000000000000f6 RDI: 
0000000000000300
[88273.214941] RBP: ffff888117fd4480 R08: 0000000000000266 R09: 
0000000000000007
[88273.222315] R10: 0000000000000082 R11: ffffffff824d188d R12: 
ffff888117fd4000
[88273.229669] R13: 0000000000000002 R14: ffffffff82005100 R15: 
0000000000000001
[88273.236965] FS:  0000000000000000(0000) GS:ffff88811ab00000(0000) 
knlGS:0000000000000000
[88273.245318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88273.251170] CR2: 00007f68d06d8000 CR3: 000000011332e000 CR4: 
00000000000406e0
[88273.258571] Call Trace:
[88273.261124]  <IRQ>
[88273.263204]  ? qdisc_reset+0xe0/0xe0
[88273.266841]  call_timer_fn+0x2b/0x130
[88273.270620]  expire_timers+0x8e/0xe0
[88273.274328]  run_timer_softirq+0xb9/0x160
[88273.278480]  ? __hrtimer_run_queues+0x133/0x2b0
[88273.283175]  ? ktime_get+0x39/0x90
[88273.286655]  __do_softirq+0xd7/0x2f8
[88273.290338]  irq_exit+0xb2/0xc0
[88273.293559]  smp_apic_timer_interrupt+0x79/0x130
[88273.298414]  apic_timer_interrupt+0xf/0x20
[88273.302664]  </IRQ>
[88273.304873] RIP: 0010:cpuidle_enter_state+0xab/0x310
[88273.310016] Code: e8 ca c6 b5 ff 48 89 c3 8b 05 39 7a b9 00 85 c0 0f 
8f 33 01 00 00 31 ff e8 92 cf b5 ff 45 84 f6 0f 85 f1 00 00 00 fb 4c 29 
fb <48> ba cf f7 53 e3 a5 9b c4 20 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff
[88273.329275] RSP: 0018:ffffc900006a3e90 EFLAGS: 00000216 ORIG_RAX: 
ffffffffffffff13
[88273.337073] RAX: ffff88811ab20bc0 RBX: 00000000032f0f7e RCX: 
000000000000001f
[88273.344368] RDX: 00005048ad789efb RSI: 00000000803d7d59 RDI: 
0000000000000000
[88273.351650] RBP: 0000000000000002 R08: 0000000000000002 R09: 
0000000000020480
[88273.359007] R10: ffffc900006a3e78 R11: 0000000000002e10 R12: 
ffffffff8207d0f8
[88273.366481] R13: ffff888119647400 R14: 0000000000000000 R15: 
00005048aa498f7d
[88273.373838]  do_idle+0x1d8/0x230
[88273.377134]  cpu_startup_entry+0x6a/0x70
[88273.381189]  start_secondary+0x183/0x1b0
[88273.385202]  secondary_startup_64+0xa4/0xb0
[88273.389521] ---[ end trace 267a09c97ff9e7fd ]---








