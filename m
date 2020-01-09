Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90BC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A67020705
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578535865;
	bh=qJENzGKmJAOagy+JSAucgmvBwgxCgfASmhLD/uICc18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RokKnXmcHcAcOdtkMVdvjqlXMJTNxnQRUpn0liT1tF8UE72b9bLk6RU7/YPqi5ZwS
	 eRMBj1HkMJBL5Kghk8lcpvrKYp0druQGq+ee8l8xz3eHW1UfKr2jWXu/pK6ELG573Z
	 NFAVQSOurvnILRmZCAada9UprobswxAnQ2sWEA/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgAICLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgAICLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:11:04 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE30206F0;
        Thu,  9 Jan 2020 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578535862;
        bh=HySFvkWC7t3JvMXRF7oV4bgs4bjQWkNUPYjuCImOQx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g5ciKMjArnEcpmm2G2wsKnIr3sstGdJnofLmDigENhtqU8O8hi9znsEFHi6MAdasM
         oNOS1uUDekBzmMtO/nc+7SOiKSIIsSo60N5S0MOX9ixPEqz6vNflepe9tPGL+6JbMG
         9nWcIwarZqHC7g2vR5YFxIZulp5uRCjoPzntkJxc=
Date:   Thu, 9 Jan 2020 11:10:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?= =?ISO-2022-JP?B?bnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] list corruption while enabling multi call uprobes via
 perf
Message-Id: <20200109111056.484a181fc6acc20196344f9a@kernel.org>
In-Reply-To: <20200108171611.GA8472@kernel.org>
References: <20200108171611.GA8472@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__9_Jan_2020_11_10_56_+0900_YCyAzUxBPnB=JcnZ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__9_Jan_2020_11_10_56_+0900_YCyAzUxBPnB=JcnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

On Wed, 8 Jan 2020 14:16:11 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Masami, ideas?
> 
> Trying to show a way to use perf tooling to show that libbpf functions
> statically linked with perf were being used by 'perf test bpf' regression tests
> and count how many times those functions were used led me to a crash, steps to reproduce:

Thanks for reporting!

> 
> [root@quaco ~]# ldd ~/bin/perf | grep bpf
> [root@quaco ~]# nm ~/bin/perf | grep libbpf_ | head
> 00000000005dc088 t bpf_object__section_to_libbpf_map_type
> 00000000005e4101 T libbpf_attach_type_by_name
> 00000000005e3fa7 t libbpf_find_attach_btf_id
> 00000000005e3e7a t libbpf_find_prog_btf_id
> 00000000005e3d09 T libbpf_find_vmlinux_btf_id
> 00000000005e46b1 T libbpf_get_error
> 00000000005e3aae t libbpf_get_type_names
> 0000000000b810a9 b libbpf_initialized
> 00000000005f0119 t libbpf__load_raw_btf
> 00000000005eea9b t libbpf_netlink_open
> [root@quaco ~]# set -o vi
> [root@quaco ~]# perf probe -x ~/bin/perf libbpf_*
> Added new events:
>   probe_perf:libbpf_perf_print (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_num_possible_cpus (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_get_error (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_attach_type_by_name (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_find_attach_btf_id (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_find_prog_btf_id (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_find_vmlinux_btf_id (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_prog_type_by_name (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_get_type_names (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_print (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_set_print (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_validate_opts (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_dump_errormsg (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_parse_nested (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_parse (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_len (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_data (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_strerror (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_strerror_r (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nl_get_filter (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nl_get_qdisc (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nl_get_class (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nl_get_link (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_netlink_open (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_getattr_u32 (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_getattr_u8 (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf_nla_data (on libbpf_* in /home/acme/bin/perf)
>   probe_perf:libbpf__load_raw_btf (on libbpf_* in /home/acme/bin/perf)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_perf:libbpf__load_raw_btf -aR sleep 1
> 
> [root@quaco ~]# perf stat -e probe_perf:libbpf* perf test bpf
> 41: BPF filter                                            :
> 41.1: Basic BPF filtering                                 :
> 
> And it gets stuck here:
> 
> [acme@quaco ~]$ uname -a
> Linux quaco 5.5.0-rc4+ #2 SMP Thu Jan 2 11:17:21 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> [acme@quaco ~]$ 
> 
> [228215.294840] list_add corruption. next->prev should be prev (ffff90786c3c8028), but was ffff90786c3c8568. (next=ffff9079403fb960).
> [228215.294852] ------------[ cut here ]------------
> [228215.294853] kernel BUG at lib/list_debug.c:23!
> [228215.294860] invalid opcode: 0000 [#1] SMP PTI
> [228215.294863] CPU: 3 PID: 9890 Comm: perf Not tainted 5.5.0-rc4+ #2
> [228215.294864] Hardware name: LENOVO 20L8S2N70H/20L8S2N70H, BIOS N22ET48W (1.25 ) 07/18/2018
> [228215.294868] RIP: 0010:__list_add_valid.cold+0xf/0x3f
> [228215.294870] Code: 39 fe 0f 85 71 00 00 00 48 8b 52 08 48 39 f2 0f 85 56 00 00 00 b8 01 00 00 00 c3 4c 89 c1 48 c7 c7 d0 8f 3a b6 e8 63 9c c4 ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 90 3a b6 e8 4c 9c c4
> [228215.294871] RSP: 0018:ffffa9ec818efbc0 EFLAGS: 00010246
> [228215.294873] RAX: 0000000000000075 RBX: ffff9079403fb960 RCX: 0000000000000000
> [228215.294874] RDX: 0000000000000000 RSI: ffff9079464d9ce8 RDI: ffff9079464d9ce8
> [228215.294875] RBP: ffff90786c3c8000 R08: 0000000000000001 R09: 0000000000000785
> [228215.294876] R10: 000000000002b7d0 R11: 0000000000000003 R12: ffff90793b8d3000
> [228215.294877] R13: ffff90793b8d3160 R14: 0000000000000001 R15: ffff90786c3c8028
> [228215.294879] FS:  00007fa6f1f376c0(0000) GS:ffff9079464c0000(0000) knlGS:0000000000000000
> [228215.294880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [228215.294881] CR2: 00000000004aafe0 CR3: 0000000125692001 CR4: 00000000003626e0
> [228215.294882] DR0: 000000000059ae50 DR1: 0000000000000000 DR2: 0000000000000000
> [228215.294883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [228215.294884] Call Trace:
> [228215.294889]  uprobe_perf_open+0x58/0x110
> [228215.294892]  ? uprobe_perf_close+0xc0/0xc0
> [228215.294894]  ? perf_prepare_sample+0x630/0x630
> [228215.294896]  uprobe_perf_multi_call+0x51/0x80
> [228215.294898]  perf_trace_event_init+0x63/0x290
> [228215.294901]  perf_trace_init+0x69/0xa0
> [228215.294903]  perf_tp_event_init+0x1b/0x40
> [228215.294905]  perf_try_init_event+0x45/0x120
> [228215.294908]  perf_event_alloc+0x493/0xbf0
> [228215.294911]  inherit_event.isra.0+0x47/0x250
> [228215.294915]  inherit_task_group.isra.0.part.0+0x3a/0x100
> [228215.294917]  perf_event_init_task+0x18a/0x2f0
> [228215.294919]  copy_process+0x6e1/0x1a70
> [228215.294922]  _do_fork+0x70/0x390
> [228215.294924]  __x64_sys_clone+0x81/0xa0
> [228215.294927]  do_syscall_64+0x5b/0x1b0
> [228215.294932]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [228215.294934] RIP: 0033:0x7fa6f25d189f
> [228215.294936] Code: ed 0f 85 f4 00 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 8d 00 00 00 41 89 c5 85 c0 0f 85 9a 00 00
> [228215.294937] RSP: 002b:00007ffe12998c60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [228215.294939] RAX: ffffffffffffffda RBX: 00000000009d4b80 RCX: 00007fa6f25d189f
> [228215.294940] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [228215.294941] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fa6f1f376c0
> [228215.294942] R10: 00007fa6f1f37990 R11: 0000000000000246 R12: 0000000000000000
> [228215.294943] R13: 0000000000000000 R14: 0000000000000029 R15: 0000000000000001
> [228215.294944] Modules linked in: rpcsec_gss_krb5 sctp cdc_ether usbnet uinput xt_CHECKSUM xt_MASQUERADE tun bridge stp llc rfcomm nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep binfmt_misc vfat fat x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_soc_skl irqbypass iwlmvm typec_displayport snd_soc_sst_ipc snd_soc_sst_dsp elan_i2c snd_hda_ext_core snd_hda_codec_hdmi mac80211 snd_soc_acpi_intel_match crct10dif_pclmul snd_soc_acpi crc32_pclmul snd_soc_core libarc4 snd_hda_codec_realtek ghash_clmulni_intel snd_hda_codec_generic intel_cstate snd_compress iwlwifi ac97_bus snd_pcm_dmaengine snd_hda_intel snd_usb_audio snd_intel_dspcfg sn
 d_hda_codec
> [228215.294972]  snd_hda_core uvcvideo snd_usbmidi_lib snd_rawmidi snd_hwdep snd_seq snd_seq_device btusb videobuf2_vmalloc snd_pcm btrtl videobuf2_memops btbcm videobuf2_v4l2 btintel mei_hdcp videobuf2_common mei_wdt bluetooth intel_uncore videodev intel_rapl_msr thinkpad_acpi ucsi_acpi snd_timer mei_me processor_thermal_device cfg80211 ledtrig_audio intel_lpss_pci intel_rapl_perf intel_wmi_thunderbolt iTCO_wdt wmi_bmof joydev typec_ucsi intel_rapl_common iTCO_vendor_support pcspkr thunderbolt ecdh_generic snd mc intel_xhci_usb_role_switch intel_lpss mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal idma64 roles typec soundcore ecc rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 cec rc_core i2c_algo_bit drm_kms_helper uas nvme r8152 drm e1000e usb_storage crc32c_intel serio_raw nvme_core mii wmi video fuse
> [228215.295002] ---[ end trace ff70b427cb0ab835 ]---
> [228215.295004] RIP: 0010:__list_add_valid.cold+0xf/0x3f
> [228215.295006] Code: 39 fe 0f 85 71 00 00 00 48 8b 52 08 48 39 f2 0f 85 56 00 00 00 b8 01 00 00 00 c3 4c 89 c1 48 c7 c7 d0 8f 3a b6 e8 63 9c c4 ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 90 3a b6 e8 4c 9c c4
> [228215.295007] RSP: 0018:ffffa9ec818efbc0 EFLAGS: 00010246
> [228215.295008] RAX: 0000000000000075 RBX: ffff9079403fb960 RCX: 0000000000000000
> [228215.295009] RDX: 0000000000000000 RSI: ffff9079464d9ce8 RDI: ffff9079464d9ce8
> [228215.295010] RBP: ffff90786c3c8000 R08: 0000000000000001 R09: 0000000000000785
> [228215.295011] R10: 000000000002b7d0 R11: 0000000000000003 R12: ffff90793b8d3000
> [228215.295012] R13: ffff90793b8d3160 R14: 0000000000000001 R15: ffff90786c3c8028
> [228215.295013] FS:  00007fa6f1f376c0(0000) GS:ffff9079464c0000(0000) knlGS:0000000000000000
> [228215.295014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [228215.295015] CR2: 00000000004aafe0 CR3: 0000000125692001 CR4: 00000000003626e0
> [228215.295016] DR0: 000000000059ae50 DR1: 0000000000000000 DR2: 0000000000000000
> [228215.295017] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [acme@quaco ~]$

Hmm, this seems that the event->hw.tp_list is not initialized when removing
from the list in uprobe_perf_close().
Could you try attached patch?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

--Multipart=_Thu__9_Jan_2020_11_10_56_+0900_YCyAzUxBPnB=JcnZ
Content-Type: application/octet-stream;
 name="tracing-uprobe-fix-to"
Content-Disposition: attachment;
 filename="tracing-uprobe-fix-to"
Content-Transfer-Encoding: base64

dHJhY2luZy91cHJvYmU6IEZpeCB0byBpbml0aWFsaXplIGh3LnRwX2xpc3Qgd2hlbiBjbG9zaW5n
CgpGcm9tOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPgoKRml4IHRvIGlu
aXRpYWxpemUgaHcudHBfbGlzdCB3aGVuIGNsb3NpbmcgdGhlIHVwcm9iZSBldmVudApmb3IgcGVy
ZiBmcmFtZXdvcmsgc28gdGhhdCB0aGUgZXZlbnQgY2FuIGJlIHJldXNlZC4KClNpZ25lZC1vZmYt
Ynk6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+Ci0tLQoga2VybmVsL3Ry
YWNlL3RyYWNlX3Vwcm9iZS5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9i
ZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jCmluZGV4IDM1MjA3M2QzNjU4NS4uZmE5
MGU0ZDY0Y2VhIDEwMDY0NAotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfdXByb2JlLmMKKysrIGIv
a2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jCkBAIC0xMjE2LDcgKzEyMTYsNyBAQCBzdGF0aWMg
aW50IHVwcm9iZV9wZXJmX2Nsb3NlKHN0cnVjdCB0cmFjZV91cHJvYmUgKnR1LCBzdHJ1Y3QgcGVy
Zl9ldmVudCAqZXZlbnQpCiAKIAl3cml0ZV9sb2NrKCZ0dS0+ZmlsdGVyLnJ3bG9jayk7CiAJaWYg
KGV2ZW50LT5ody50YXJnZXQpIHsKLQkJbGlzdF9kZWwoJmV2ZW50LT5ody50cF9saXN0KTsKKwkJ
bGlzdF9kZWxfaW5pdCgmZXZlbnQtPmh3LnRwX2xpc3QpOwogCQlkb25lID0gdHUtPmZpbHRlci5u
cl9zeXN0ZW13aWRlIHx8CiAJCQkoZXZlbnQtPmh3LnRhcmdldC0+ZmxhZ3MgJiBQRl9FWElUSU5H
KSB8fAogCQkJdXByb2JlX2ZpbHRlcl9ldmVudCh0dSwgZXZlbnQpOwo=

--Multipart=_Thu__9_Jan_2020_11_10_56_+0900_YCyAzUxBPnB=JcnZ--
