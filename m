Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73265C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319312067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMSFqw0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgAHRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:16:17 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:32774 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgAHRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:16:16 -0500
Received: by mail-qk1-f182.google.com with SMTP id d71so3364614qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=J9P3mIYsdB5bxwhFWKUb9qIhK6Yznwl9cvjBajFnswY=;
        b=nMSFqw0TrhxLMrP4i0k0G3dHKpTl+hDGw1oNS5A6XDTFxuPBwzWmBNIRtjaqjTLXWI
         NV06R7xpiLGysDrR1UCpBFK2f098bPw3o0H8oK4jKlyooygzn5nQDhF4ymLsBug84b/E
         pCX1ZCiSkUoLN9Yst2mOuFYhQJp+5ntdcxEDZ/0vBXymEKZbn33kDX0EgkhmFdYffqxt
         AShs+c+ytp+P/Pe/BhGKSYavQuJI4Lp7ZAr3EVxvZtc0elxQHAat+MrYHjWivRPaMcM5
         zoPHBFqZ8AcbrPhK04Hiu5OQ5W+dcvZ4qgG7iZPfWwTGHLojPRDDcy+puA33Q3G0YzSP
         JciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=J9P3mIYsdB5bxwhFWKUb9qIhK6Yznwl9cvjBajFnswY=;
        b=l9m1oehQ/qPH85iDqwOnm93GvJQcGcQ4uQ292UIWk1AuBkdd1ZYrL7yi3hyVgx4jje
         dawIOOp2kwWVO1DPlDX8731khqWim5L1pjKD0BZND5F54qEMyAzEgQe6nwpRF72gNpML
         CjjqtLGge4r+jmdk7TI7hs3cBRj+OeAhhaJXTc/tz0xjD5w3jEvuML1esiDmDRT/EG+p
         xvW0xeYtXI+twxFXYHlDyKuuOdyPjyGdeJxtR6saYSykpLbd3LCAIXuap5Jl5bxVoWoD
         wC5T5S40gkYpRdluPUkFTQw5mRQJKY1ycjar9gGhcA27hJYWNSQr4z6mc4zdDNzWmMSu
         N9LQ==
X-Gm-Message-State: APjAAAWfGC0jT0jbq6K2hB0m90mLiEDO41OD196Ugy9gIXuZ6QCQNwx8
        DMnCbZ80dpBuAYuNUawZ2d6k74HL0Fk=
X-Google-Smtp-Source: APXvYqzqYAan3nEIo9hFd92SMTQP+j09yfeL7ypEyc26L2gqNM99TWXOb8NTe7GEUUs6KgrtnIOBcw==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr5388671qkl.305.1578503775233;
        Wed, 08 Jan 2020 09:16:15 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 124sm1666061qko.11.2020.01.08.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 09:16:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7768640DFD; Wed,  8 Jan 2020 14:16:11 -0300 (-03)
Date:   Wed, 8 Jan 2020 14:16:11 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
        Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] list corruption while enabling multi call uprobes via perf
Message-ID: <20200108171611.GA8472@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami, ideas?

Trying to show a way to use perf tooling to show that libbpf functions
statically linked with perf were being used by 'perf test bpf' regression t=
ests
and count how many times those functions were used led me to a crash, steps=
 to reproduce:

[root@quaco ~]# ldd ~/bin/perf | grep bpf
[root@quaco ~]# nm ~/bin/perf | grep libbpf_ | head
00000000005dc088 t bpf_object__section_to_libbpf_map_type
00000000005e4101 T libbpf_attach_type_by_name
00000000005e3fa7 t libbpf_find_attach_btf_id
00000000005e3e7a t libbpf_find_prog_btf_id
00000000005e3d09 T libbpf_find_vmlinux_btf_id
00000000005e46b1 T libbpf_get_error
00000000005e3aae t libbpf_get_type_names
0000000000b810a9 b libbpf_initialized
00000000005f0119 t libbpf__load_raw_btf
00000000005eea9b t libbpf_netlink_open
[root@quaco ~]# set -o vi
[root@quaco ~]# perf probe -x ~/bin/perf libbpf_*
Added new events:
  probe_perf:libbpf_perf_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_num_possible_cpus (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_get_error (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_attach_type_by_name (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_attach_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_prog_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_vmlinux_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_prog_type_by_name (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_get_type_names (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_set_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_validate_opts (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_dump_errormsg (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_parse_nested (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_parse (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_len (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_data (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_strerror (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_strerror_r (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_filter (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_qdisc (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_class (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_link (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_netlink_open (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_getattr_u32 (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_getattr_u8 (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_data (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf__load_raw_btf (on libbpf_* in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:libbpf__load_raw_btf -aR sleep 1

[root@quaco ~]# perf stat -e probe_perf:libbpf* perf test bpf
41: BPF filter                                            :
41.1: Basic BPF filtering                                 :

And it gets stuck here:

[acme@quaco ~]$ uname -a
Linux quaco 5.5.0-rc4+ #2 SMP Thu Jan 2 11:17:21 -03 2020 x86_64 x86_64 x86=
_64 GNU/Linux
[acme@quaco ~]$=20

[228215.294840] list_add corruption. next->prev should be prev (ffff90786c3=
c8028), but was ffff90786c3c8568. (next=3Dffff9079403fb960).
[228215.294852] ------------[ cut here ]------------
[228215.294853] kernel BUG at lib/list_debug.c:23!
[228215.294860] invalid opcode: 0000 [#1] SMP PTI
[228215.294863] CPU: 3 PID: 9890 Comm: perf Not tainted 5.5.0-rc4+ #2
[228215.294864] Hardware name: LENOVO 20L8S2N70H/20L8S2N70H, BIOS N22ET48W =
(1.25 ) 07/18/2018
[228215.294868] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[228215.294870] Code: 39 fe 0f 85 71 00 00 00 48 8b 52 08 48 39 f2 0f 85 56=
 00 00 00 b8 01 00 00 00 c3 4c 89 c1 48 c7 c7 d0 8f 3a b6 e8 63 9c c4 ff <0=
f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 90 3a b6 e8 4c 9c c4
[228215.294871] RSP: 0018:ffffa9ec818efbc0 EFLAGS: 00010246
[228215.294873] RAX: 0000000000000075 RBX: ffff9079403fb960 RCX: 0000000000=
000000
[228215.294874] RDX: 0000000000000000 RSI: ffff9079464d9ce8 RDI: ffff907946=
4d9ce8
[228215.294875] RBP: ffff90786c3c8000 R08: 0000000000000001 R09: 0000000000=
000785
[228215.294876] R10: 000000000002b7d0 R11: 0000000000000003 R12: ffff90793b=
8d3000
[228215.294877] R13: ffff90793b8d3160 R14: 0000000000000001 R15: ffff90786c=
3c8028
[228215.294879] FS:  00007fa6f1f376c0(0000) GS:ffff9079464c0000(0000) knlGS=
:0000000000000000
[228215.294880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[228215.294881] CR2: 00000000004aafe0 CR3: 0000000125692001 CR4: 0000000000=
3626e0
[228215.294882] DR0: 000000000059ae50 DR1: 0000000000000000 DR2: 0000000000=
000000
[228215.294883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
[228215.294884] Call Trace:
[228215.294889]  uprobe_perf_open+0x58/0x110
[228215.294892]  ? uprobe_perf_close+0xc0/0xc0
[228215.294894]  ? perf_prepare_sample+0x630/0x630
[228215.294896]  uprobe_perf_multi_call+0x51/0x80
[228215.294898]  perf_trace_event_init+0x63/0x290
[228215.294901]  perf_trace_init+0x69/0xa0
[228215.294903]  perf_tp_event_init+0x1b/0x40
[228215.294905]  perf_try_init_event+0x45/0x120
[228215.294908]  perf_event_alloc+0x493/0xbf0
[228215.294911]  inherit_event.isra.0+0x47/0x250
[228215.294915]  inherit_task_group.isra.0.part.0+0x3a/0x100
[228215.294917]  perf_event_init_task+0x18a/0x2f0
[228215.294919]  copy_process+0x6e1/0x1a70
[228215.294922]  _do_fork+0x70/0x390
[228215.294924]  __x64_sys_clone+0x81/0xa0
[228215.294927]  do_syscall_64+0x5b/0x1b0
[228215.294932]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[228215.294934] RIP: 0033:0x7fa6f25d189f
[228215.294936] Code: ed 0f 85 f4 00 00 00 64 4c 8b 0c 25 10 00 00 00 45 31=
 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 0f 87 8d 00 00 00 41 89 c5 85 c0 0f 85 9a 00 00
[228215.294937] RSP: 002b:00007ffe12998c60 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000038
[228215.294939] RAX: ffffffffffffffda RBX: 00000000009d4b80 RCX: 00007fa6f2=
5d189f
[228215.294940] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001=
200011
[228215.294941] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fa6f1=
f376c0
[228215.294942] R10: 00007fa6f1f37990 R11: 0000000000000246 R12: 0000000000=
000000
[228215.294943] R13: 0000000000000000 R14: 0000000000000029 R15: 0000000000=
000001
[228215.294944] Modules linked in: rpcsec_gss_krb5 sctp cdc_ether usbnet ui=
nput xt_CHECKSUM xt_MASQUERADE tun bridge stp llc rfcomm nf_conntrack_netbi=
os_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6=
 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6ta=
ble_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw ipt=
able_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set n=
fnetlink ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep binfm=
t_misc vfat fat x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kv=
m snd_soc_skl irqbypass iwlmvm typec_displayport snd_soc_sst_ipc snd_soc_ss=
t_dsp elan_i2c snd_hda_ext_core snd_hda_codec_hdmi mac80211 snd_soc_acpi_in=
tel_match crct10dif_pclmul snd_soc_acpi crc32_pclmul snd_soc_core libarc4 s=
nd_hda_codec_realtek ghash_clmulni_intel snd_hda_codec_generic intel_cstate=
 snd_compress iwlwifi ac97_bus snd_pcm_dmaengine snd_hda_intel snd_usb_audi=
o snd_intel_dspcfg snd_hda_codec
[228215.294972]  snd_hda_core uvcvideo snd_usbmidi_lib snd_rawmidi snd_hwde=
p snd_seq snd_seq_device btusb videobuf2_vmalloc snd_pcm btrtl videobuf2_me=
mops btbcm videobuf2_v4l2 btintel mei_hdcp videobuf2_common mei_wdt bluetoo=
th intel_uncore videodev intel_rapl_msr thinkpad_acpi ucsi_acpi snd_timer m=
ei_me processor_thermal_device cfg80211 ledtrig_audio intel_lpss_pci intel_=
rapl_perf intel_wmi_thunderbolt iTCO_wdt wmi_bmof joydev typec_ucsi intel_r=
apl_common iTCO_vendor_support pcspkr thunderbolt ecdh_generic snd mc intel=
_xhci_usb_role_switch intel_lpss mei intel_soc_dts_iosf i2c_i801 intel_pch_=
thermal idma64 roles typec soundcore ecc rfkill int3403_thermal int340x_the=
rmal_zone int3400_thermal acpi_thermal_rel acpi_pad nfsd auth_rpcgss nfs_ac=
l lockd grace sunrpc i915 cec rc_core i2c_algo_bit drm_kms_helper uas nvme =
r8152 drm e1000e usb_storage crc32c_intel serio_raw nvme_core mii wmi video=
 fuse
[228215.295002] ---[ end trace ff70b427cb0ab835 ]---
[228215.295004] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[228215.295006] Code: 39 fe 0f 85 71 00 00 00 48 8b 52 08 48 39 f2 0f 85 56=
 00 00 00 b8 01 00 00 00 c3 4c 89 c1 48 c7 c7 d0 8f 3a b6 e8 63 9c c4 ff <0=
f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 90 3a b6 e8 4c 9c c4
[228215.295007] RSP: 0018:ffffa9ec818efbc0 EFLAGS: 00010246
[228215.295008] RAX: 0000000000000075 RBX: ffff9079403fb960 RCX: 0000000000=
000000
[228215.295009] RDX: 0000000000000000 RSI: ffff9079464d9ce8 RDI: ffff907946=
4d9ce8
[228215.295010] RBP: ffff90786c3c8000 R08: 0000000000000001 R09: 0000000000=
000785
[228215.295011] R10: 000000000002b7d0 R11: 0000000000000003 R12: ffff90793b=
8d3000
[228215.295012] R13: ffff90793b8d3160 R14: 0000000000000001 R15: ffff90786c=
3c8028
[228215.295013] FS:  00007fa6f1f376c0(0000) GS:ffff9079464c0000(0000) knlGS=
:0000000000000000
[228215.295014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[228215.295015] CR2: 00000000004aafe0 CR3: 0000000125692001 CR4: 0000000000=
3626e0
[228215.295016] DR0: 000000000059ae50 DR1: 0000000000000000 DR2: 0000000000=
000000
[228215.295017] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
[acme@quaco ~]$


- Arnaldo
