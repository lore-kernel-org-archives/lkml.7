Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DAFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9720857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554683750;
	bh=/Cy5f/4pYViZqhk4rHwruiigWMzDf37eZjPwhsCLm0w=;
	h=From:Date:Subject:To:List-ID:From;
	b=BM/TEgIL4KmeNiFtJsSpYBrQrhdSSxDkE/5McveFmyZfhdWaMHOWUIIN48cJ/9kYW
	 gmgxbg8WOaRsoydC+IUsyalq3gnQ0FJ08sexcgYlvvPoYYirqVTOfRt8hI7Te5SCIe
	 0dKN4t5B97z/vHVVogPyAQ9/x6sxuqaUhPMcad9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDHAft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:35:49 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36528 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfDHAfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:35:48 -0400
Received: by mail-lj1-f169.google.com with SMTP id r24so9627122ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yYf6yLS6MeYMvwOku0ykZ3ZYtqmuAUnHdSPHmLYBqkA=;
        b=QtisXKolzNQFEKqNv9KWDhTYaV+R6y120t014bc4qbAfROAgpFc6Oki3vMCDIpiTqG
         c87/10/WnWlZg7UMK3FHGnT+25lhQ3RtKo6DNMmJfdOAnNK62tqGPqFBPS0ySt9IhXMi
         khKDojQC5vyitEDjsO7QB4na9p4H5qFUlI0d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yYf6yLS6MeYMvwOku0ykZ3ZYtqmuAUnHdSPHmLYBqkA=;
        b=MCS+aqgLOmPuVxUV/XwD45j+BPvwG5TnmRXi7ZWVRf74YIzCO8tr6idiKCX0ZgQZoq
         OYEmCiXtfxyIt7k/TJ3JqprFB9tPUw44jw5FMsMm/K3OAyg8bmQDmSIz2CMiVNXAPNXQ
         Eufsc+hQH2rtI3DXM83upSpxtLX6VkyQWqQCarPpostE9wS57w/Z9Xhhk0WKvQEe0hev
         XhLYvviwhfNEjKSjP346V1eL4mmN9iO6L4gqHhoqbssuBQLN9XQ4n/l6z3e9fUisFY6O
         +tygQLA2lPgOa+tcmb7Z5+5zJyqOEENLkli2pt3MgyxVMVENddbKOScvgQRUJ7Il19P4
         OauA==
X-Gm-Message-State: APjAAAWtQ7XwcmxpBuAB9Qd9g4A7dYdwHsIggKuATdOoNLZe6+myU4OM
        XGwzH3TfHkmk15t1Yu8FvfNRhlKWB40=
X-Google-Smtp-Source: APXvYqyzrLER/toE8I20LP5P5/U5svJtmXHd5+g0scEyJnVEm9d3YBX/JO/qDEgkGnAyZ9lTWDlMvg==
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr13793206ljb.53.1554683744548;
        Sun, 07 Apr 2019 17:35:44 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a22sm5775438lfg.37.2019.04.07.17.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 17:35:43 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q66so9621334ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:35:43 -0700 (PDT)
X-Received: by 2002:a2e:8316:: with SMTP id a22mr13753767ljh.171.1554683743204;
 Sun, 07 Apr 2019 17:35:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Apr 2019 14:35:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=widsb0vN7kqt8ATfNuNW6a54JpKjc6W0XPjt5=LW7UeGQ@mail.gmail.com>
Message-ID: <CAHk-=widsb0vN7kqt8ATfNuNW6a54JpKjc6W0XPjt5=LW7UeGQ@mail.gmail.com>
Subject: Linux 5.1-rc4
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another rc. Smaller than rc3, I'm happy to say. Nothing
particularly big in here, just a  number of small things all over.

And it really is all over. Drivers are about a third (networking,
block, gpu, scsi), with the rest being a mix of arch updates,
filesystem updates, documentation, core networking, tooling.. So
there's no single theme here, just spread out smallish fixes all over.

Shortlog appended for people who want to get an overview of the details,

                 Linus

---

Aaro Koskinen (6):
      net: stmmac: use correct DMA buffer size in the RX descriptor
      net: stmmac: ratelimit RX error logs
      net: stmmac: don't stop NAPI processing when dropping a packet
      net: stmmac: don't overwrite discard_frame status
      net: stmmac: fix dropping of multi-descriptor RX frames
      net: stmmac: don't log oversized frames

Aditya Pakki (1):
      net: mlx5: Add a missing check on idr_find, free buf

Al Viro (11):
      aio: fold lookup_kiocb() into its sole caller
      aio: keep io_event in aio_kiocb
      aio: store event at final iocb_put()
      Fix aio_poll() races
      make aio_read()/aio_write() return int
      aio: move dropping ->ki_eventfd into iocb_destroy()
      deal with get_reqs_available() in aio_get_req() itself
      aio: move sanity checks and request allocation to io_submit_one()
      jffs2: fix use-after-free on symlink traversal
      ubifs: fix use-after-free on symlink traversal
      debugfs: fix use-after-free on symlink traversal

Alan Kao (1):
      riscv: fix accessing 8-byte variable from RV32

Alex Williamson (1):
      vfio/type1: Limit DMA mappings per container

Alexander Lobakin (1):
      net: core: netif_receive_skb_list: unlist skb before passing to pt->f=
unc

Alexandre Belloni (2):
      rtc: sd3078: fix manufacturer name
      rtc: da9063: set uie_unsupported when relevant

Anders Roxell (1):
      batman-adv: fix warning in function batadv_v_elp_get_throughput

Andi Kleen (1):
      dm init: fix const confusion for dm_allowed_targets array

Andrea Righi (2):
      openvswitch: fix flow actions reallocation
      xen: use struct_size() helper in kzalloc()

Andreas Kemnade (1):
      mfd: twl-core: Disable IRQ while suspended

Andrew Morton (1):
      mm/util.c: fix strndup_user() comment

Andrii Nakryiko (2):
      libbpf: fix btf_dedup equivalence check handling of different kinds
      selftests/bpf: add btf_dedup test for VOID equivalence check

Andy Shevchenko (1):
      HID: quirks: Drop misused kernel-doc annotation

Aneesh Kumar K.V (1):
      mm/huge_memory.c: fix modifying of page protection by insert_pfn_pmd(=
)

Anup Patel (2):
      RISC-V: Always compile mm/init.c with cmodel=3Dmedany and notrace
      RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area

Arnd Bergmann (5):
      HID: hid-asus: select CONFIG_POWER_SUPPLY
      include/linux/bitrev.h: fix constant bitrev
      ARM: orion: don't use using 64-bit DMA masks
      ARM: iop: don't use using 64-bit DMA masks
      ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU

Artemy Kovalyov (1):
      net/mlx5: Decrease default mr cache size

Arvind Sankar (1):
      igb: Fix WARN_ONCE on runtime suspend

Axel Lin (2):
      reset: meson-audio-arb: Fix missing .owner setting of reset_controlle=
r_dev
      hwmon: (w83773g) Select REGMAP_I2C to fix build error

Aya Levin (2):
      net/mlx5: ethtool, Fix type analysis of advertised link-mode
      net/mlx5: ethtool, Allow legacy link-modes configuration via
non-extended ptys

Baolin Wang (1):
      mfd: sc27xx: Use SoC compatible string for PMIC devices

Bart Van Assche (1):
      block: Revert v5.0 blk_mq_request_issue_directly() changes

Ben Hutchings (1):
      tools/power turbostat: Add checks for failure of fgets() and fscanf()

Bert Kenward (1):
      MAINTAINERS: net: update Solarflare maintainers

Bj=C3=B6rn T=C3=B6pel (4):
      libbpf: add xsk.h to install_headers target
      libbpf: add libelf dependency to shared library build
      i40e: move i40e_xsk_umem function
      i40e: add tracking of AF_XDP ZC state for each queue pair

Bj=C3=B8rn Mork (1):
      qmi_wwan: add Olicard 600

Borislav Petkov (1):
      cpufreq/intel_pstate: Load only on Intel hardware

Calvin Walton (2):
      tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
      tools/power turbostat: Also read package power on AMD F17h (Zen)

Carlos Menin (1):
      dt-bindings: hwmon: (adc128d818) Specify ti,mode property size

Catalin Marinas (1):
      kmemleak: powerpc: skip scanning holes in the .bss section

Chengming Gui (1):
      drm/amd/amdgpu: fix PCIe dpm feature issue (v3)

Chris Leech (1):
      vlan: conditional inclusion of FCoE hooks to match netdevice.h and bn=
x2x

Chris Wilson (2):
      drm/i915: Always backoff after a drm_modeset_lock() deadlock
      drm/i915/gvt: Fix kerneldoc typo for intel_vgpu_emulate_hotplug

Claudiu Manoil (1):
      net: mii: Fix PAUSE cap advertisement from
linkmode_adv_to_lcl_adv_t() helper

Colin Ian King (2):
      HID: uclogic: remove redudant duplicated null check on ver_ptr
      scsi: qedi: remove declaration of nvm_image from stack

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

Daniel Borkmann (2):
      bpf: fix use after free in bpf_evict_inode
      bpf, libbpf: fix quiet install_headers

Dave Rodgman (1):
      lib/lzo: fix bugs for very short or empty input

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

David Rientjes (2):
      kvm: svm: fix potential get_num_contig_pages overflow
      KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow

David S. Miller (1):
      Revert "cxgb4: Update 1.23.3.0 as the latest firmware supported."

David Summers (1):
      ARM: dts: rockchip: Fix SD card detection on rk3288-tinker

Davide Caratti (1):
      net/sched: act_sample: fix divide by zero in the traffic path

Dean Nelson (2):
      thunderx: enable page recycling for non-XDP case
      thunderx: eliminate extra calls to put_page() for pages held for recy=
cling

Dinh Nguyen (1):
      arm64: dts: stratix10: add the sysmgr-syscon property from the gmac's

Dmitry Torokhov (1):
      HID: input: add mapping for Assistant key

Dmitry V. Levin (2):
      riscv: Fix syscall_get_arguments() and syscall_set_arguments()
      csky: Fix syscall_get_arguments() and syscall_set_arguments()

Dmytro Linkin (1):
      net/mlx5e: Allow IPv4 ttl & IPv6 hop_limit rewrite for all L4 protoco=
ls

Dongli Zhang (1):
      blk-mq: do not reset plug->rq_count before the list is sorted

Douglas Anderson (3):
      ARM: dts: rockchip: Fix gpu opp node names for rk3288
      ARM: dts: rockchip: Remove #address/#size-cells from rk3288 mipi_dsi
      ARM: dts: rockchip: Remove #address/#size-cells from
rk3288-veyron gpio-keys

Dust Li (1):
      tcp: fix a potential NULL pointer dereference in tcp_sk_exit

Eddie James (1):
      hwmon: (occ) Fix power sensor indexing

Eli Britstein (1):
      net/mlx5e: Consider tunnel type for encap contexts

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Evan Quan (3):
      drm/amd/powerplay: add ECC feature bit
      drm/amd/powerplay: correct data type to avoid overflow
      drm/amd/powerplay: fix possible hang with 3+ 4K monitors

Ezequiel Garcia (1):
      arm64: dts: rockchip: add DDC bus on Rock Pi 4

Florian Fainelli (1):
      MAINTAINERS: Fix documentation file name for PHY Library

Furquan Shaikh (1):
      ACPICA: Clear status of GPEs before enabling them

Gavi Teitz (1):
      net/mlx5e: Fix error handling when refreshing TIRs

Geert Uytterhoeven (1):
      rtc: sh: Fix invalid alarm warning for non-enabled alarm

Greg Kroah-Hartman (1):
      tty: mark Siemens R3964 line discipline as BROKEN

Greg Thelen (1):
      mm: writeback: use exact memcg dirty counts

Guenter Roeck (2):
      hwmon: (ntc_thermistor) Fix temperature type reporting
      xsysace: Fix error handling in ace_setup

Haiyang Zhang (1):
      hv_netvsc: Fix unwanted wakeup after tx_disable

He, Bo (1):
      HID: debug: fix race condition with between rdesc_show() and
device removal

Heiner Kallweit (2):
      net: dsa: mv88e6xxx: fix few issues in mv88e6390x_port_set_cmode
      r8169: disable default rx interrupt coalescing on RTL8168

Helge Deller (2):
      Revert: parisc: Use F_EXTEND() macro in iosapic code
      parisc: Detect QEMU earlier in boot process

Herbert Xu (1):
      ila: Fix rhashtable walker list corruption

Hui Wang (1):
      HID: i2c-hid: Disable runtime PM on Synaptics touchpad

Huy Nguyen (3):
      net/mlx5: E-Switch, fix syndrome (0x678139) when turn on vepa
      net/mlx5e: Update xoff formula
      net/mlx5e: Update xon formula

Ilya Dryomov (1):
      dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum er=
rors

Ivan Vecera (1):
      ixgbe: fix mdio bus registration

Jacob Keller (1):
      i40e: fix i40e_ptp_adjtime when given a negative delta

Jakub Kicinski (3):
      nfp: validate the return code from dev_queue_xmit()
      nfp: disable netpoll on representors
      net: tls: prevent false connection termination with offload

James Smart (1):
      scsi: lpfc: Fix missing wakeups on abort threads

Jann Horn (2):
      signal: don't silently convert SI_USER signals to non-current pidfd
      mm: fix vm_fault_t cast in VM_FAULT_GET_HINDEX()

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation

Jeffrey Hugo (1):
      HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630

Jens Axboe (1):
      io_uring: fix double free in case of fileset regitration failure

Jesper Dangaard Brouer (2):
      bpf, doc: fix BTF docs reflow of bullet list
      xdp: fix cpumap redirect SKB creation bug

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Joe Perches (1):
      RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW)

John Pittman (1):
      null_blk: prevent crash from bad home_node value

Jonas Karlman (1):
      ARM: dts: rockchip: fix rk3288 cpu opp node reference

Julia Lawall (1):
      ARM: OMAP2+: add missing of_node_put after of_device_is_available

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

Kai-Heng Feng (1):
      HID: Increase maximum report size allowed by hid_field_extract()

Kangjie Lu (1):
      HID: logitech: check the return value of create_singlethread_workqueu=
e

Kirill Smelkov (1):
      fs: stream_open - opener for stream-like files so that read and
write can run simultaneously without deadlock

Koen De Schepper (1):
      tcp: Ensure DCTCP reacts to losses

Konstantin Khlebnikov (1):
      block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=3Dy

Konstantin Khorenko (1):
      bonding: show full hw address in sysfs for slave entries

Laurentiu Tudor (1):
      i2c: imx: don't leak the i2c adapter on error

Le Ma (1):
      drm/amdgpu: remove unnecessary rlc reset function on gfx9

Len Brown (6):
      tools/power turbostat: Restore ability to execute in topology-order
      tools/power turbostat: Cleanup CC3-skip code
      tools/power turbostat: Cleanup CNL-specific code
      tools/power turbostat: Add Icelake support
      tools/power turbostat: Add Die column
      tools/power turbostat: update version number

Leonidas P. Papadakos (1):
      arm64: dts: rockchip: fix rk3328-roc-cc gmac2io tx/rx_delay

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Linus Torvalds (2):
      pin iocb through aio.
      Linux 5.1-rc4

Liu Jian (1):
      mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer

Liubin Shu (1):
      net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()

Lorenzo Bianconi (2):
      net: thunderx: fix NULL pointer dereference in nicvf_open/nicvf_stop
      ipv6: sit: reset ip header pointer in ipip6_rcv

Louis Taylor (2):
      HID: quirks: use correct format chars in dbg_hid
      vfio/pci: use correct format characters

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in
rds_tcp_kill_sock().

Marc Orr (2):
      KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)
      KVM: x86: nVMX: fix x2APIC VTPR read intercept

Maxime Ripard (2):
      mfd: sun6i-prcm: Allow to compile with COMPILE_TEST
      dt-bindings: cpu: Fix JSON schema

Mel Gorman (1):
      mm/compaction.c: correct zone boundary handling when resetting
pageblock skip hints

Michael Kelley (2):
      scsi: storvsc: Fix calculation of sub-channel count
      scsi: storvsc: Reduce default ring buffer size to 128 Kbytes

Mike Kravetz (1):
      hugetlbfs: fix memory leak for resv_map

Mike Snitzer (1):
      dm: disable DISCARD if the underlying storage no longer supports it

Mikulas Patocka (3):
      dm integrity: change memcmp to strncmp in dm_integrity_ctr
      dm: revert 8f50e358153d ("dm: limit the max bio size as
BIO_MAX_PAGES * PAGE_SIZE")
      dm integrity: fix deadlock with overlapping I/O

Neil Armstrong (1):
      dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets

Nick Desaulniers (1):
      lib/string.c: implement a basic bcmp

Nicolas Dichtel (1):
      net/sched: fix ->get helper of the matchall cls

Nicolas Pitre (1):
      Update Nicolas Pitre's email address

Nikolay Aleksandrov (1):
      net: bridge: always clear mcast matching struct on reports and leaves

Olof Johansson (1):
      Revert "ARM: dts: nomadik: Fix polarity of SPI CS"

Omri Kahalon (1):
      net/mlx5: E-Switch, Fix esw manager vport indication for more
vport commands

Paolo Abeni (3):
      net: datagram: fix unbounded loop in __skb_try_recv_datagram()
      net: sched: introduce and use qstats read helpers
      net: sched: introduce and use qdisc tree flush/purge helpers

Paul Chaignon (2):
      bpf: remove incorrect 'verifier bug' warning
      selftests/bpf: test case for invalid call stack in dead code

Paul Hsieh (1):
      drm/amd/display: VBIOS can't be light up HDMI when restart system

Peng Hao (1):
      arm/mach-at91/pm : fix possible object reference leak

Peter Geis (2):
      arm64: dts: rockchip: fix rk3328 rgmii high tx error rate
      arm64: dts: rockchip: fix rk3328 sdmmc0 write errors

Peter Hutterer (1):
      HID: logitech: Handle 0 scroll events for the m560

Peter Ujfalusi (2):
      ARM: dts: am335x-evm: Correct the regulators for the audio codec
      ARM: dts: am335x-evmsk: Correct the regulators for the audio codec

Pieter Jansen van Vuuren (2):
      nfp: flower: replace CFI with vlan present
      nfp: flower: remove vlan CFI bit from push vlan action

Prarit Bhargava (2):
      tools/power turbostat: Do not display an error on systems
without a cpufreq driver
      tools/power turbostat: Warn on bad ACPI LPIT data

Qian Cai (1):
      mm/compaction.c: abort search if isolation fails

Randy Dunlap (1):
      sh: fix multiple function definition build errors

Rodrigo Rivas Costa (1):
      HID: steam: fix deadlock with input devices.

Roi Dayan (2):
      net/mlx5: E-Switch, Fix access to invalid memory when toggling esw mo=
des
      net/mlx5: E-Switch, Protect from invalid memory access in
offload fdb table

Ronnie Sahlberg (2):
      cifs: fix kref underflow in close_shroot()
      cifs: a smb2_validate_and_copy_iov failure does not mean the
handle is invalid.

Sabrina Dubroca (1):
      vrf: prevent adding upper devices

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Shenghui Wang (1):
      block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hct=
x

Stanislav Fomichev (6):
      selftests/bpf: fix vlan handling in flow dissector program
      net/flow_dissector: pass flow_keys->n_proto to BPF programs
      flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
      flow_dissector: allow access only to a subset of __sk_buff fields
      flow_dissector: document BPF flow dissector environment
      flow_dissector: rst'ify documentation

Stefan Assmann (1):
      i40e: fix WoL support check

Steffen Klassert (1):
      net-gro: Fix GRO flush when receiving a GSO packet.

Stephen Boyd (1):
      rtc: cros-ec: Fail suspend/resume if wake IRQ can't be configured

Stephen Suryaputra (1):
      vrf: check accept_source_route on the original netdevice

Steve French (2):
      smb3: Fix enumerating snapshots to Azure
      SMB3: Allow persistent handle timeout to be configurable on mount

Steven Rostedt (Red Hat) (3):
      ptrace: Remove maxargs from task_current_syscall()
      tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
      syscalls: Remove start and number from syscall_get_arguments() args

Steven Rostedt (VMware) (1):
      syscalls: Remove start and number from syscall_set_arguments() args

Sven Eckelmann (4):
      batman-adv: Reduce claim hash refcnt only for removed entry
      batman-adv: Reduce tt_local hash refcnt only for removed entry
      batman-adv: Reduce tt_global hash refcnt only for removed entry
      batman-adv: Fix genl notification for throughput_override

Sven Schnelle (2):
      parisc: regs_return_value() should return gpr28
      parisc: also set iaoq_b in instruction_pointer_set()

Thomas Falcon (1):
      ibmvnic: Fix completion structure initialization

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      sch_cake: Use tc_skb_protocol() helper for getting packet protocol
      sch_cake: Make sure we can write the IP header before changing DSCP b=
its

Tomer Maimon (2):
      MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
      MAINTAINERS: add maintainer and replacing reviewer ARM/NUVOTON NPCM

Tomohiro Mayama (1):
      arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Tonghao Zhang (1):
      net/mlx5e: Correctly use the namespace type when allocating pedit act=
ion

Tony Lindgren (1):
      ARM: dts: Fix dcan clkctrl clock for am3

Varun Prakash (1):
      libcxgb: fix incorrect ppmax calculation

Vishal Kulkarni (1):
      cxgb4: Update 1.23.3.0 as the latest firmware supported.

Waiman Long (1):
      psi: clarify the units used in pressure files

Wang Hai (1):
      vfio/spapr_tce: Make symbol 'tce_iommu_driver_ops' static

Wei Li (1):
      arm64: fix wrong check of on_sdei_stack in nmi context

Will Deacon (1):
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

Xi Wang (1):
      net: hns3: fix compile error

Xin Long (4):
      tipc: check bearer name with right length in tipc_nl_compat_bearer_en=
able
      tipc: check link name with right length in tipc_nl_compat_link_set
      tipc: handle the err returned from cmd header function
      sctp: initialize _pad of sockaddr_in before copying to user memory

Xiong Zhang (1):
      drm/i915/gvt: Correct the calculation of plane size

Xose Vazquez Perez (1):
      scsi: core: add new RDAC LENOVO/DE_Series device

Yan Zhao (2):
      drm/i915/gvt: do not deliver a workload if its creation fails
      drm/i915/gvt: do not let pin count of shadow mm go negative

Yonglong Liu (5):
      net: hns: Use NAPI_POLL_WEIGHT for hns driver
      net: hns: Fix probabilistic memory overwrite when HNS driver initiali=
zed
      net: hns: fix ICMP6 neighbor solicitation messages discard problem
      net: hns: Fix WARNING when remove HNS driver with SMMU enabled
      net: hns: Fix sparse: some warnings in HNS drivers

Yue Haibing (1):
      fm10k: Fix a potential NULL pointer dereference

YueHaibing (4):
      dm integrity: make dm_integrity_init and dm_integrity_exit static
      dccp: Fix memleak in __feat_register_sp
      paride/pf: Fix potential NULL pointer dereference
      paride/pcd: Fix potential NULL pointer dereference and mem leak

Yufen Yu (1):
      blk-mq: add trace block plug and unplug for multiple queues

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

xiaofeis (1):
      net: dsa: Implement flow_dissect callback for tag_qca
