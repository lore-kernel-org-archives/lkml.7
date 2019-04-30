Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB00C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9562720675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfD3LaP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfD3LaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:30:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79238AF95;
        Tue, 30 Apr 2019 11:30:12 +0000 (UTC)
Date:   Tue, 30 Apr 2019 13:30:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] [PATCH] oops: add "begin trace" + oops_id to match "end
 trace" + oops_id
Message-ID: <20190430113011.amg6cbpriityo2e5@pathway.suse.cz>
References: <9b8a2852-60ec-4519-fac8-4e1aa2763970@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9b8a2852-60ec-4519-fac8-4e1aa2763970@infradead.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-04-29 17:08:33, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Print a "begin trace" + oops ID number to match the current
> "end trace" + oops ID number.
> 
> Example:
> [  193.314027] ---[ begin trace cf01af0ff0925003 ]---
> [  193.314032] general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> [  193.314046] CPU: 2 PID: 2884 Comm: bash Tainted: G           O      5.1.0-rc6mod #1
> [  193.314048] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
> [  193.314058] RIP: 0010:proc_dump_test+0x7c/0x13b [dump_test]
> [  193.314062] Code: 5c 41 5d 5d c3 be 27 00 00 00 48 c7 c7 60 10 d9 c1 e8 58 b2 85 c6 4c 89 e0 e8 40 41 3f c8 85 c0 41 89 c5 75 39 80 fa 6f 75 3c <a0> 00 00 00 00 00 fc ff df 84 c0 74 04 84 c0 7e 12 c6 04 25 00 00
> [  193.314065] RSP: 0018:ffff88811ea4fce0 EFLAGS: 00010246
> [  193.314069] RAX: 0000000000000000 RBX: ffff88811ea4fd48 RCX: 0000000000000015
> [  193.314072] RDX: 000000000000006f RSI: 0000000000000027 RDI: ffff888117df0064
> [  193.314075] RBP: ffff88811ea4fcf8 R08: ffff88811ea4fe88 R09: fffffbfff1661c71
> [  193.314077] R10: 0000000000000001 R11: fffffbfff1661c70 R12: 000056103bd643f0
> [  193.314080] R13: 0000000000000000 R14: ffff888117c58b48 R15: ffffffffc1d920a0
> [  193.314083] FS:  00007ff067886b80(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
> [  193.314086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  193.314089] CR2: 000056103bd643f0 CR3: 0000000117ae4005 CR4: 00000000000606e0
> [  193.314090] Call Trace:
> {lines deleted for brevity}
> [  193.314187] RIP: 0033:0x7ff066f64c14
> [  193.314190] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 1a fc 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
> [  193.314193] RSP: 002b:00007fffaf5eaa08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  193.314197] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff066f64c14
> [  193.314199] RDX: 0000000000000002 RSI: 000056103bd643f0 RDI: 0000000000000001
> [  193.314202] RBP: 000056103bd643f0 R08: 000000000000000a R09: 0000000000000000
> [  193.314204] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000002
> [  193.314206] R13: 0000000000000001 R14: 00007ff067230720 R15: 0000000000000002
> [  193.314215] Modules linked in: dump_test(O) fuse xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack af_packet ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 hid_generic usbkbd usbmouse videobuf2_common btrfs usbhid videodev hid coretemp hwmon media intel_rapl msr x86_pkg_temp_thermal intel_powerclamp kvm_intel xor mei_hdcp kvm zstd_compress irqbypass raid6_pq arc4 crct10dif_pclmul iTCO_wdt iwldvm libcrc32c crc32_pclmul iTCO_vendor_support crc32c_intel zstd_decompress ghash_clmulni_intel snd_hda_codec_hdmi mac80211 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec aesni_intel
> [  193.314293]  aes_x86_64 crypto_simd snd_hda_core iwlwifi cryptd snd_hwdep glue_helper sdhci_pci intel_cstate toshiba_acpi sparse_keymap cqhci snd_pcm intel_uncore sr_mod joydev sdhci cdrom intel_rapl_perf wmi input_leds cfg80211 snd_timer mmc_core uio_pdrv_genirq mousedev uio serio_raw pcspkr mei_me rtc_cmos toshiba_haps led_class e1000e thermal snd rfkill evdev industrialio mac_hid mei soundcore lpc_ich pcc_cpufreq battery ac sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
> [  193.314358] ---[ end trace cf01af0ff0925003 ]---
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Can the "begin trace" event happen multiple times before "end trace"?
> If so, this code won't handle that situation and the output would be
> confusing, like this:
>   begin trace 000dead
>   begin trace 000deae
>   end trace 00deae
>   end trace 00deae
> That would be very bad and this patch should go away.

Oops called via oops_begin() and oops_end() are serialized on
different CPUs by die_lock. Though they can get nested.
The nesting level is counted by die_nest_count and could
be used to compute the correct oops_id.

__warn() does not seem to be serialized. It could get
solved by storing the ID in a local variable and
passing it as a parameter.

BTW: Using a function called print_oops_end_marker()
in a generic __warn() looks a bit misleading.
A more generic name would be useful. See also below.


>  kernel/panic.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- lnx-51-rc6.orig/kernel/panic.c
> +++ lnx-51-rc6/kernel/panic.c
> @@ -519,9 +522,14 @@ static int init_oops_id(void)
>  }
>  late_initcall(init_oops_id);
>  
> -void print_oops_end_marker(void)
> +void print_oops_begin_marker(void)
>  {
>  	init_oops_id();
> +	pr_warn("---[ begin trace %016llx ]---\n", (unsigned long long)oops_id);
> +}
> +
> +void print_oops_end_marker(void)
> +{
>  	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
>  }
>  
> @@ -546,8 +554,10 @@ void __warn(const char *file, int line,
>  {
>  	disable_trace_on_warning();
>  
> -	if (args)
> +	if (args) {
>  		pr_warn(CUT_HERE);
> +		print_oops_begin_marker();

Printing both CUT_HERE and begin_marker lines look redundant.

In fact, the code around pr_warn(CUT_HERE) looks hacky. It guess
that it is not easy to keep it paired. It might deserve
a clean up.

Best Regards,
Petr
