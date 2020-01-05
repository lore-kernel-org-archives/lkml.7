Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491CC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204272072C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578264502;
	bh=u4q3zA5VqMW6BKWunfbUWqm9bta/Fd54XzL2AfmPTxo=;
	h=From:Date:Subject:To:List-ID:From;
	b=a+nkGKHWyHvWdgcI4OgXhSdT2eRJCUMnY68o2puyz1wtUwSmXhn8+dd1MTAajye4t
	 3LteIM9MKRF0kmCc/zXJLaSW2+WsvJNaG4jOXa4SKUM62W4HFWrkPJHei21z9G04Se
	 i6t1UJe8sXhHPwJQ7q0fHgaUJkEWEnLr8CJiKeXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgAEWsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:48:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44991 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:48:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so49058480lje.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=EQ9Dg9Xz/Ns7deUBuCdPdlQ55Xeaf6JWpRcHJrr/Tlc=;
        b=RYLd29S1IYqzhW7dft6HGosxtPTdlsswYgFdTAAmqe1swjr9ucmCojh5KUxo3mqT9m
         /0djVoEO2o9B6m/dqcxCcGFWpB9teRcuzr19qpOJR7ZjhvQ+bxLc3HsNFkNvNLz3JQP5
         4DODADBeq0hhJ/I5bybuCHonE1EydIXjIgPPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EQ9Dg9Xz/Ns7deUBuCdPdlQ55Xeaf6JWpRcHJrr/Tlc=;
        b=sX1iI3LTjvKtLgS1ywNAR6EkO0LehpMst1rvggMcG5sIfEPDiZcQaLpkfVEF45MpGh
         uV249OP8p1BoZVHCAZygNQOkRwAUlRU45PXOwpYBGaTdk4qi482ZkcM4XCqk3x1Hqwgv
         lDfzcTsuvLPF9oO/4OEoiDQSETx/Q7qGYWfAQ3Sf4RJWEXaIZoOliBuTipdSHq1TcEUW
         nQ/SIUZdCZ8TUxSdJf1o0aHkLVBfCcuVtLirtZPfAPQN+uAEENl0CCXPzV9rjMSlnrKT
         62MoFyCxVGnIR0X35ZLecU2IrL0KigO5T89EwCxOobUhzy42Rn1YCSthxX50jpeg3U7K
         iHWA==
X-Gm-Message-State: APjAAAUrd1MJuG/yiXsmWeOakdjc3Tqy6zpacZ0yejeVtP2Q8Rt6xVG6
        J/UvgCY7RWZoHZBQR3d9lmsHcjcLNAU=
X-Google-Smtp-Source: APXvYqwstuDErEyGZ49PhqOC9Ocx3WKJ9tfyxwwUQc/5UhvuhUojik2hrz9LIEY3T9uI+8wyKFBjtw==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr57083882lji.93.1578264497553;
        Sun, 05 Jan 2020 14:48:17 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z11sm25576904ljc.97.2020.01.05.14.48.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 14:48:16 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id z22so44263198ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 14:48:16 -0800 (PST)
X-Received: by 2002:a2e:8946:: with SMTP id b6mr57145864ljk.1.1578264496360;
 Sun, 05 Jan 2020 14:48:16 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jan 2020 14:48:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwmJQwwMD06VfPapDmc52LFQhG3HP6VyVLXVA=nYi_ow@mail.gmail.com>
Message-ID: <CAHk-=whwmJQwwMD06VfPapDmc52LFQhG3HP6VyVLXVA=nYi_ow@mail.gmail.com>
Subject: Linux 5.5-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another rc.

And it's another quiet week, to no surprise.  I think things will
start picking up this upcoming week as everybody is getting back from
holidays, unless 5.5 just happens to be a particularly easy release
(but there's no reason to think that - or the reverse).

Nothing in rc5 really stands out, we have fixes all over

 - drivers (mainly networking, gpu, media, sound, block)

 - core networking

 - architectures (MIPS, RISC-V and Hexagon stand out in the diff, but
there's powerpc too, and some noise elsewhere from patches from Andrew
too)

 - security subsystem fixes (apparmor and tomoyo)

but it's generally just a bit of a mixed bag of small fixes all over.

Shortlog appended, it's small enough to easily scroll through for a
flavor of what's been going on.

            Linus

PS. One sad piece of news I got this past week was that Bruce Evans
has passed away. Bruce wasn't really ever really much directly
involved in Linux development - he was active on the BSD side - but he
was the developer behind Minix/i386, which was what I used for the
original Linux development in the very early days before Linux became
self-hosting.

---

Aleksandr Yashkin (1):
      pstore/ram: Write new dumps to start of recycled zones

Alex Deucher (6):
      ALSA: hda/hdmi - fix atpx_present when CLASS is not VGA
      Revert "drm/amdgpu: simplify ATPX detection"
      drm/amdgpu/smu: add metrics table lock
      drm/amdgpu/smu: add metrics table lock for arcturus (v2)
      drm/amdgpu/smu: add metrics table lock for navi (v2)
      drm/amdgpu/smu: add metrics table lock for vega20 (v2)

Alexander Lobakin (1):
      MIPS: BPF: eBPF JIT: check for MIPS ISA compliance in Kconfig

Alexander.Barabash@dell.com (1):
      ioat: ioat_alloc_ring() failure handling.

Alexandra Winter (3):
      s390/qeth: fix false reporting of VNIC CHAR config failure
      s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
      s390/qeth: vnicc Fix init to default

Amit Cohen (1):
      mlxsw: spectrum_router: Skip loopback RIFs during MAC validation

Andrey Konovalov (1):
      kcov: fix struct layout for kcov_remote_arg

Antonio Messina (1):
      udp: fix integer overflow while computing available space in sk_rcvbuf

Ard Biesheuvel (1):
      kbuild/deb-pkg: annotate libelf-dev dependency as :native

Arnd Bergmann (2):
      netfilter: nf_flow_table: fix big-endian integer overflow
      gcc-plugins: make it possible to disable CONFIG_GCC_PLUGINS again

Ben Dooks (Codethink) (1):
      drm/arm/mali: make malidp_mw_connector_helper_funcs static

Cambda Zhu (1):
      tcp: Fix highest_sack and highest_sack_seq

Chanho Min (1):
      mm/zsmalloc.c: fix the migrated zspage statistics.

Chris Chiu (1):
      ALSA: hda/realtek - Enable the bass speaker of ASUS UX431FLC

Christian Brauner (1):
      taskstats: fix data-race

Damien Le Moal (1):
      null_blk: Fix REQ_OP_ZONE_CLOSE handling

Daniel Borkmann (1):
      bpf: Fix precision tracking for unbounded scalars

David Hildenbrand (1):
      mm/memory_hotplug: shrink zones when offlining memory

David Howells (3):
      rxrpc: Unlock new call in rxrpc_new_incoming_call() rather than the caller
      rxrpc: Don't take call->user_mutex in rxrpc_new_incoming_call()
      rxrpc: Fix missing security check on incoming calls

Davide Caratti (1):
      net/sched: add delete_empty() to filters and use it in cls_flower

Dennis Zhou (2):
      btrfs: punt all bios created in btrfs_submit_compressed_write()
      btrfs: fix compressed write bio blkcg attribution

Dominik Brodowski (1):
      Revert "fs: remove ksys_dup()"

Eric Biggers (3):
      fs/direct-io.c: include fs/internal.h for missing prototype
      fs/nsfs.c: include headers for missing declarations
      fs/namespace.c: make to_mnt_ns() static

Eric Dumazet (1):
      net_sched: sch_fq: properly set sk->sk_pacing_status

Evan Quan (1):
      drm/amdgpu: correct RLC firmwares loading sequence

Filipe Manana (1):
      Btrfs: fix infinite loop during nocow writeback due to race

Florian Fainelli (1):
      net: dsa: bcm_sf2: Fix IP fragment location and behavior

Florian Westphal (2):
      selftests: netfilter: extend flowtable test script with dnat rule
      netfilter: ebtables: compat: reject all padding in matches/watchers

Gang He (1):
      ocfs2: fix the crash due to call ocfs2_get_dlm_debug once less

Geert Uytterhoeven (1):
      of: mdio: Add missing inline to of_mdiobus_child_is_phy() dummy

Guenter Roeck (1):
      MIPS: Fix boot on Fuloong2 systems

Hangbin Liu (8):
      net: add bool confirm_neigh parameter for dst_ops.update_pmtu
      ip6_gre: do not confirm neighbor when do pmtu update
      gtp: do not confirm neighbor when do pmtu update
      net/dst: add new function skb_dst_update_pmtu_no_confirm
      tunnel: do not confirm neighbor when do pmtu update
      vti: do not confirm neighbor when do pmtu update
      sit: do not confirm neighbor when do pmtu update
      net/dst: do not confirm neighbor for vxlan and geneve pmtu update

Hans Verkuil (4):
      media: cec: CEC 2.0-only bcast messages were ignored
      media: cec: avoid decrementing transmit_queue_sz if it is 0
      media: cec: check 'transmit_in_progress', not 'transmitting'
      media: pulse8-cec: fix lost cec_transmit_attempt_done() call

Hui Wang (1):
      ALSA: usb-audio: set the interface format after resume on Dell WD19

Ido Schimmel (1):
      mlxsw: spectrum: Use dedicated policer for VRRP packets

Ilya Dryomov (1):
      mm/oom: fix pgtables units mismatch in Killed process message

Jan Stancek (1):
      mm/hugetlbfs: fix for_each_hstate() loop in init_hugetlbfs_fs()

Jason A. Donenfeld (1):
      powerpc/spinlocks: Include correct header for static key

Jitao Shi (1):
      drm/mediatek: reduce the hbp and hfp for phy timing

Joe Perches (1):
      MIPS: Kconfig: Use correct form for 'depends on'

Johan Hovold (1):
      ALSA: usb-audio: fix set_format altsetting sanity check

John Johansen (2):
      apparmor: only get a label reference if the fast path check fails
      apparmor: fix aa_xattrs_match() may sleep while holding a RCU lock

John Stultz (1):
      dmaengine: k3dma: Avoid null pointer traversal

Jouni Hogander (1):
      MIPS: Prevent link failure with kcov instrumentation

Julian Wiedmann (3):
      s390/qeth: fix qdio teardown after early init error
      s390/qeth: lock the card while changing its hsuid
      s390/qeth: fix initialization on old HW

Kai Li (1):
      ocfs2: call journal flush to mark journal as empty after journal
recovery when mount

Kailang Yang (2):
      ALSA: hda/realtek - Add headset Mic no shutup for ALC283
      ALSA: hda/realtek - Add Bass Speaker and fixed dac for bass speaker

Kees Cook (2):
      kernel.h: Remove unused FIELD_SIZEOF()
      pstore/ram: Fix error-path memory leak in persistent_ram_new() callers

Linus Torvalds (1):
      Linux 5.5-rc5

Lukas Wunner (1):
      dmaengine: Fix access to uninitialized dma_slave_caps

Madalin Bucur (2):
      dpaa_eth: fix DMA mapping leak
      net: phy: aquantia: add suspend / resume ops for AQR105

Manish Chopra (2):
      bnx2x: Use appropriate define for vlan credit
      bnx2x: Fix accounting of vlan resources among the PFs

Marcelo Ricardo Leitner (1):
      sctp: fix err handling of stream initialization

Martin Blumenstingl (1):
      net: stmmac: dwmac-meson8b: Fix the RGMII TX delay on Meson8b/8m2 SoCs

Masahiro Yamada (1):
      gen_initramfs_list.sh: fix 'bad variable name' error

Michael Ellerman (1):
      powerpc/mm: Mark get_slice_psize() & slice_addr_is_low() as notrace

Ming Lei (2):
      block: add bio_truncate to fix guard_bio_eod
      block: fix splitting segments on boundary masks

Namhyung Kim (1):
      libbpf: Fix build on read-only filesystems

Navid Emamdoost (1):
      mm/gup: fix memory leak in __gup_benchmark_ioctl

Netanel Belgazal (1):
      MAINTAINERS: Add additional maintainers to ENA Ethernet driver

Nick Desaulniers (3):
      hexagon: parenthesize registers in asm predicates
      hexagon: work around compiler crash
      hexagon: define ioremap_uc

Patrick Steinhardt (1):
      apparmor: fix bind mounts aborting with -ENOMEM

Paul Burton (2):
      MIPS: BPF: Disable MIPS32 eBPF JIT
      MIPS: Avoid VDSO ABI breakage due to global register variable

Paul Cercueil (1):
      dmaengine: dma-jz4780: Also break descriptor chains on JZ4725B

Paul Walmsley (2):
      riscv: prefix IRQ_ macro names with an RV_ namespace
      Documentation: riscv: add patch acceptance guidelines

Peter Ujfalusi (1):
      dmaengine: virt-dma: Fix access after free in vchan_complete()

Phil Sutter (1):
      netfilter: nft_tproxy: Fix port selector on Big Endian

Pi-Hsun Shih (1):
      drm/mediatek: Check return value of mtk_drm_ddp_comp_for_plane.

Rahul Lakkireddy (1):
      cxgb4/cxgb4vf: fix flow control display for auto negotiation

Randy Dunlap (1):
      fs/posix_acl.c: fix kernel-doc warnings

Sakari Ailus (1):
      media: intel-ipu3: Align struct ipu3_uapi_awb_fr_config_s to 32 bytes

Sargun Dhillon (4):
      samples/seccomp: Zero out members based on seccomp_notif_sizes
      selftests/seccomp: Zero out seccomp_notif
      seccomp: Check that seccomp_notif is zeroed out by the user
      selftests/seccomp: Catch garbage on SECCOMP_IOCTL_NOTIF_RECV

Shakeel Butt (1):
      memcg: account security cred as well to kmemcg

Shmulik Ladkani (1):
      net/sched: act_mirred: Pull mac prior redir to non mac_header_xmit device

Stefan Mavrodiev (1):
      drm/sun4i: hdmi: Remove duplicate cleanup calls

Taehee Yoo (7):
      hsr: avoid debugfs warning message when module is remove
      hsr: fix error handling routine in hsr_dev_finalize()
      hsr: add hsr root debugfs directory
      hsr: rename debugfs file when interface name is changed
      hsr: fix a race condition in node list insertion and deletion
      hsr: reset network header when supervision frame is created
      hsr: fix slab-out-of-bounds Read in hsr_debugfs_rename()

Takashi Iwai (2):
      ALSA: hda - Apply sync-write workaround to old Intel platforms, too
      ALSA: ice1724: Fix sleep-in-atomic in Infrasonic Quartet support code

Tetsuo Handa (2):
      tomoyo: Don't use nifty names on sockets.
      tomoyo: Suppress RCU warning at list_for_each_entry_rcu().

Vincenzo Frascino (1):
      mips: Fix gettimeofday() in the vdso library

Vladimir Kondratiev (1):
      mips: cacheinfo: report shared CPU map

Vladimir Oltean (5):
      net: dsa: sja1105: Take PTP egress timestamp by port, not mgmt slot
      net: dsa: sja1105: Really make the PTP command read-write
      net: dsa: sja1105: Remove restriction of zero base-time for taprio offload
      Documentation: net: dsa: sja1105: Remove text about taprio
base-time limitation
      net: dsa: sja1105: Reconcile the meaning of TPID and TPID2 for
E/T and P/Q/R/S

Vladis Dronov (1):
      ptp: fix the race between the release of ptp_clock and cdev

Vladyslav Tarasiuk (1):
      net/mlxfw: Fix out-of-memory error in mfa2 flash burning

Waiman Long (1):
      mm/hugetlb: defer freeing of huge pages if in non-task context

Yang Shi (1):
      mm: move_pages: return valid node id in status if the page is
already on the target node

Yash Shah (1):
      riscv: dts: Add DT support for SiFive L2 cache controller

Yongqiang Niu (1):
      drm/mediatek: Fix can't get component for external display plane.

Yunfeng Ye (2):
      agp: remove unused variable mcapndx
      agp: remove unused variable arqsz in agp_3_5_enable()

Zong Li (4):
      riscv: mm: use __pa_symbol for kernel symbols
      riscv: gcov: enable gcov for RISC-V
      riscv: ftrace: correct the condition logic in function graph tracer
      clocksource: riscv: add notrace to riscv_sched_clock

changzhu (1):
      drm/amdgpu: enable gfxoff for raven1 refresh

chenqiwu (1):
      exit: panic before exit_mm() on global init exit
