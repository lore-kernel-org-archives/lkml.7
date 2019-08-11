Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CCC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F842084D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565556450;
	bh=yfUV9RIEXq+1rR/LdR1V5ORgm2FJchTsssL4zW3PH0k=;
	h=From:Date:Subject:To:List-ID:From;
	b=htMMme3Ih7EhDE+Mu48irwam/TpSBK4kMLoaKBO+7zDA6qMSLskAM8Ty3AwaDNA9M
	 ErJjAGFn+7xroD+n4siv0Yt9+NgN8GRpGSCKruP3KCPgVh1ESeCgeUSThaveoeEiQq
	 MEy9qCmezXsUAYbcPdCcCK8LDFQAW1NNs2XWQ76c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfHKUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:47:29 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34311 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHKUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:47:28 -0400
Received: by mail-lf1-f53.google.com with SMTP id b29so65704552lfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=49107qMRiY5XfLUcCCfVi4eY1QkW6jSvVFoVWzsg82A=;
        b=fxV4elnVr69cyOuFA3MqiYXttrvpHZmC8DzjdmxVIxk/ziVwb5m1UTGWOvqauUcK4T
         ToczkwDKySVl9YgO78y1Rib/L7vXEaFcuy03Aeixwv7DhwVzS/GseuoxSCqgUqFj5kpD
         yxnSucCCiB1xbYE3unklgqRNOFA1nmBfnDYIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=49107qMRiY5XfLUcCCfVi4eY1QkW6jSvVFoVWzsg82A=;
        b=r5UPcb8cjf+I7wKKBgcIu+uMgZV34RQB3W4A3WX5+bcyqBuBZypt+hHUVWql4tML/I
         x/GZBhrHniYh4Nga7T415lF0qW8pBwUdYHCtcf0n8dGx4hlC+41QupDcPKXHp4tPG82Y
         GFk1dH+47Eemq3PVPDHRn7OKuuvz7vnRtaiY3RF6eLKZN50NtlJ/ChG+2Ju3Tvps9VZu
         /YhM9AdZ7wJDPXhO3Mpecd0QPEGhYui9L92XxiGURYN0HAzTFj0Q3jz2L12bUezcz9Zn
         /XlvaEH1uzUeDM1HtM8v75yL7AAktcgDltAN1iZAAG9CcLK5ic+OUWCGkzanFn9b2HIh
         5MBQ==
X-Gm-Message-State: APjAAAWWqOr05Y2p9yxKpRgNi+wfz3LiS24yshUloZNa0bZLeYA/hTx8
        33m1wt6A1pDsn6TcbS3VCJ6jR6PEn3M=
X-Google-Smtp-Source: APXvYqx6OEw97TI4c0z9rckbU1HzT1l/5+nhEWNh/iXT2/ZyKAO8DVd7x+7Xsfumvu0jBf6EbVsTew==
X-Received: by 2002:ac2:4562:: with SMTP id k2mr18012959lfm.82.1565556443386;
        Sun, 11 Aug 2019 13:47:23 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e23sm4479778lfn.43.2019.08.11.13.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:47:22 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 15so4806827ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 13:47:22 -0700 (PDT)
X-Received: by 2002:a2e:8842:: with SMTP id z2mr4377023ljj.72.1565556441967;
 Sun, 11 Aug 2019 13:47:21 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Aug 2019 13:47:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWJ7Dv9yZBZpxWd1zcAMwokjt7c8YOp-FOf1PXDKGrmQ@mail.gmail.com>
Message-ID: <CAHk-=whWJ7Dv9yZBZpxWd1zcAMwokjt7c8YOp-FOf1PXDKGrmQ@mail.gmail.com>
Subject: Linux 5.3-rc4
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I mentioned last week that rc3 was unusually small.

Well, we fixed that. The small size of rc3 was clearly just because of
pull request timing patterns, and rc4 is back up to normal size and
then some.

Part of it is networking - rc3 didn't have any net updates, and rc4
does. But it's not just that, I think we just happened to have several
things that shifted to this past week instead of having made it into
rc3.

It is worth nothing that while this rc is the largest rc4 (at least in
number of commits) that we've had in a couple of years, it's not
really outrageously so - it really is just larger than usual by about
the same amount that rc3 was smaller than usual.

So I'm not worried, I'm just pointing out a random and somewhat unusual pat=
tern.

Outside of the networking changes that came in this week, there's a
little bit of everything - drivers being most of it as usual (sound,
gpu, hid, pinctrl, usb, misc - in addition to the networking drivers,
of course). But we also have the usual arch updates (x86, arm64,
s390), various tooling updates (selftests and perf), documentation,
and filesystems fixes (gfs2, nfs). And fall-through comment updates
(although the current discussion is about hopefully fairly soon
turning the comments into actual statement attributes, which is the
modern non-lint way of doing it).

The rc isn't so big that you can't just scroll through the shortlog
below to get a feel for the kind of details we have. Nothing looks
particularly scary, although the swapgs speculation thing made the
news, I guess.

                    Linus

---

Aaron Armstrong Skomra (1):
      HID: wacom: fix bit shift for Cintiq Companion 2

Adham Abozaeid (1):
      staging: wilc1000: flush the workqueue before deinit the host

Adrian Hunter (1):
      perf db-export: Fix thread__exec_comm()

Aleksa Sarai (1):
      kselftest: save-and-restore errno to allow for %m formatting

Alex Deucher (1):
      Revert "drm/amdkfd: New IOCTL to allocate queue GWS"

Alexandru Elisei (1):
      KVM: arm/arm64: vgic: Reevaluate level sensitive interrupts on enable

Alexis Bauvin (1):
      tun: mark small packets as owned by the tap sock

Anders Roxell (3):
      arm64: KVM: regmap: Fix unexpected switch fall-through
      KVM: arm: vgic-v3: Mark expected switch fall-through
      arm64: KVM: hyp: debug-sr: Mark expected switch fall-through

Andrea Arcangeli (1):
      kernfs: fix memleak in kernel_ops_readdir()

Andreas Gruenbacher (1):
      gfs2: gfs2_walk_metadata fix

Andreas Schwab (1):
      net: phy: mscc: initialize stats array

Andrew Jeffery (1):
      pinctrl: aspeed-g5: Delay acquisition of regmaps

Andrii Nakryiko (3):
      libbpf: fix SIGSEGV when BTF loading fails, but .BTF.ext exists
      libbpf: sanitize VAR to conservative 1-byte INT
      libbpf: silence GCC8 warning about string truncation

Andy Shevchenko (1):
      net: thunderx: Use fwnode_get_mac_address()

Ariel Levkovich (1):
      net/mlx5e: Prevent encap flow counter update async to user query

Arnaldo Carvalho de Melo (3):
      libbpf: Fix endianness macro usage for some compilers
      libbpf: Avoid designated initializers for unnamed union members
      perf annotate: Fix printing of unaugmented disassembled
instructions from BPF

Arnaud Patard (1):
      drivers/net/ethernet/marvell/mvmdio.c: Fix non OF case

Arnd Bergmann (4):
      Input: applespi - select CRC16 module
      ovs: datapath: hide clang frame-overflow warnings
      iio: adc: gyroadc: fix uninitialized return code
      compat_ioctl: pppoe: fix PPPOEIOCSFWD handling

Arseny Solokha (1):
      net: phylink: don't start and stop SGMII PHYs in SFP modules twice

Atish Patra (2):
      RISC-V: Remove per cpu clocksource
      dt-bindings: Update the riscv,isa string description

Axel Lin (1):
      regulator: lp87565: Fix probe failure for "ti,lp87565"

Aya Levin (1):
      net/mlx5e: Fix matching of speed to PRM link modes

Baolin Wang (1):
      mmc: sdhci-sprd: Fix the incorrect soft reset operation when
runtime resuming

Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: handle fbdev changes through drm-misc tree

Ben Segal (2):
      habanalabs: fix F/W download in BE architecture
      habanalabs: fix host memory polling in BE architecture

Bob Ham (1):
      net: usb: qmi_wwan: Add the BroadMobi BM818 card

Brian Norris (3):
      mac80211: don't WARN on short WMM parameters from AP
      driver core: platform: return -ENXIO for missing GpioInt
      mwifiex: fix 802.11n/WPA detection

Catherine Sullivan (1):
      gve: Fix case where desc_cnt and data_cnt can get out of sync

Cezary Rojewski (1):
      MAINTAINERS: Update Intel ASoC drivers maintainers

Charles Keepax (1):
      ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks

Chen-Yu Tsai (1):
      net: ethernet: sun4i-emac: Support phy-handle property for finding PH=
Ys

Cheng-Yi Chiang (1):
      ASoC: rockchip: Fix mono capture

Chris Packham (1):
      fsl/fman: Remove comment referring to non-existent function

Christophe JAILLET (5):
      staging: unisys: visornic: Update the description of 'poll_for_irq()'
      ASoC: Intel: Fix some acpi vs apci typo in somme comments
      net: ethernet: et131x: Use GFP_KERNEL instead of GFP_ATOMIC when
allocating tx_ring->tcb_ring
      net: ag71xx: Use GFP_KERNEL instead of GFP_ATOMIC in 'ag71xx_rings_in=
it()'
      net: cxgb3_main: Fix a resource leak in a error path in 'init_one()'

Chuhong Yuan (1):
      drm/modes: Fix unterminated strncpy

Claudiu Manoil (1):
      ocelot: Cancel delayed work before wq destruction

Colin Ian King (4):
      rocker: fix memory leaks of fib_work on two error return paths
      iwlwifi: mvm: fix comparison of u32 variable with less than zero
      mlxsw: spectrum_ptp: fix duplicated check on orig_egr_types
      drm/vmwgfx: fix memory leak when too many retries have occurred

Coly Li (1):
      bcache: Revert "bcache: use sysfs_match_string() instead of
__sysfs_match_string()"

Cong Wang (2):
      netrom: hold sock when setting skb->destructor
      ife: error out when nla attributes are empty

Dan Williams (1):
      mm/memremap: Fix reuse of pgmap instances with internal references

David Ahern (1):
      ipv6: Fix unbalanced rcu locking in rt6_update_exception_stamp_rt

David Howells (2):
      rxrpc: Fix potential deadlock
      rxrpc: Fix the lack of notification when sendmsg() fails on a DATA pa=
cket

David S. Miller (1):
      Revert "net: hns: fix LED configuration for marvell phy"

Denis Kirjanov (2):
      net: usb: pegasus: fix improper read if get_registers() fail
      be2net: disable bh with spin_lock in be_process_mcc

Dexuan Cui (1):
      hv_sock: Fix hang when a connection is closed

Dietmar Eggemann (1):
      sched/deadline: Fix double accounting of rq/running bw in push & pull

Dmitry Osipenko (1):
      drm/tegra: Fix gpiod_get_from_of_node() regression

Dmitry Torokhov (2):
      Input: elantech - annotate fall-through case in elantech_use_host_not=
ify()
      Input: synaptics - enable RMI mode for HP Spectre X360

Dmytro Linkin (1):
      net: sched: use temporary variable for actions indexes

Douglas Anderson (2):
      kgdboc: disable the console lock when in kgdb
      drm/rockchip: Suspend DP late

Edward Srouji (1):
      net/mlx5: Fix modify_cq_in alignment

Emmanuel Grumbach (8):
      iwlwifi: mvm: prepare the ground for more RSS notifications
      iwlwifi: mvm: add a new RSS sync notification for NSSN sync
      iwlwiif: mvm: refactor iwl_mvm_notify_rx_queue
      iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queue=
s
      iwlwifi: mvm: fix frame drop from the reordering buffer
      iwlwifi: don't unmap as page memory that was mapped as single
      iwlwifi: mvm: fix an out-of-bound access
      iwlwifi: mvm: fix a use-after-free bug in iwl_mvm_tx_tso_segment

Enric Balletbo i Serra (1):
      SoC: rockchip: rockchip_max98090: Enable MICBIAS for headset
keypress detection

Enrico Weigelt (1):
      net: sctp: drop unneeded likely() call around IS_ERR()

Eric Dumazet (2):
      bpf: fix access to skb_shared_info->gso_segs
      selftests/bpf: add another gso_segs access

Evan Quan (1):
      drm/amd/powerplay: correct navi10 vcn powergate

Filipe La=C3=ADns (3):
      HID: logitech-dj: rename "gaming" receiver to "lightspeed"
      HID: logitech-hidpp: add USB PID for a few more supported mice
      HID: logitech-dj: add the Powerplay receiver

Florian Westphal (1):
      netfilter: ebtables: also count base chain policies

Frode Isaksen (1):
      net: stmmac: Use netif_tx_napi_add() for TX polling function

Gary R Hook (3):
      crypto: ccp - Fix oops by properly managing allocated structures
      crypto: ccp - Add support for valid authsize values less than 16
      crypto: ccp - Ignore tag length when decrypting GCM ciphertext

Gavin Li (1):
      usb: usbfs: fix double-free of usb memory upon submiturb error

Geert Uytterhoeven (9):
      net: mediatek: Drop unneeded dependency on NET_VENDOR_MEDIATEK
      net: 8390: Fix manufacturer name in Kconfig help text
      net: amd: Spelling s/case/cause/
      net: apple: Fix manufacturer name in Kconfig help text
      net: broadcom: Fix manufacturer name in Kconfig help text
      net: ixp4xx: Spelling s/XSacle/XScale/
      net: nixge: Spelling s/Instrument/Instruments/
      net: packetengines: Fix manufacturer spelling and capitalization
      net: samsung: Spelling s/case/cause/

Greg KH (1):
      KVM: no need to check return value of debugfs_create functions

Greg Kroah-Hartman (1):
      Revert "kernfs: fix memleak in kernel_ops_readdir()"

Gregory Greenman (4):
      iwlwifi: mvm: add a wrapper around rs_tx_status to handle locks
      iwlwifi: mvm: send LQ command always ASYNC
      iwlwifi: mvm: replace RS mutex with a spin_lock
      iwlwifi: mvm: fix possible out-of-bounds read when accessing lq_info

Guenter Roeck (3):
      usb: typec: tcpm: Add NULL check before dereferencing config
      usb: typec: tcpm: Ignore unsupported/unknown alternate mode requests
      hwmon: (nct7802) Fix wrong detection of in4 presence

Gustavo A. R. Silva (34):
      arcnet: com90xx: Mark expected switch fall-throughs
      arcnet: com90io: Mark expected switch fall-throughs
      arcnet: arc-rimi: Mark expected switch fall-throughs
      arcnet: com20020-isa: Mark expected switch fall-throughs
      net/af_iucv: mark expected switch fall-throughs
      net: ehea: Mark expected switch fall-through
      net: spider_net: Mark expected switch fall-through
      net: wan: sdla: Mark expected switch fall-through
      net: hamradio: baycom_epp: Mark expected switch fall-through
      net: smc911x: Mark expected switch fall-through
      MIPS: OProfile: Mark expected switch fall-throughs
      atm: iphase: Fix Spectre v1 vulnerability
      MIPS: BCM63XX: Mark expected switch fall-through
      ata: rb532_cf: Fix unused variable warning in rb532_pata_driver_probe
      Input: applespi - use struct_size() helper
      x86/ptrace: Mark expected switch fall-through
      x86: mtrr: cyrix: Mark expected switch fall-through
      ARM/hw_breakpoint: Mark expected switch fall-throughs
      ARM: tegra: Mark expected switch fall-through
      ARM: alignment: Mark expected switch fall-throughs
      ARM: OMAP: dma: Mark expected switch fall-throughs
      mfd: db8500-prcmu: Mark expected switch fall-throughs
      mfd: omap-usb-host: Mark expected switch fall-throughs
      ARM: signal: Mark expected switch fall-through
      watchdog: Mark expected switch fall-throughs
      watchdog: scx200_wdt: Mark expected switch fall-through
      watchdog: wdt977: Mark expected switch fall-through
      crypto: ux500/crypt: Mark expected switch fall-throughs
      s390/net: Mark expected switch fall-throughs
      watchdog: riowd: Mark expected switch fall-through
      video: fbdev: omapfb_main: Mark expected switch fall-throughs
      pcmcia: db1xxx_ss: Mark expected switch fall-throughs
      scsi: fas216: Mark expected switch fall-throughs
      ARM: ep93xx: Mark expected switch fall-through

Gwendal Grignou (1):
      iio: cros_ec_accel_legacy: Fix incorrect channel setting

Haishuang Yan (3):
      ip6_gre: reload ipv6h in prepare_ip6gre_xmit_ipv6
      ipip: validate header length in ipip_tunnel_xmit
      ip6_tunnel: fix possible use-after-free on xmit

Han Xu (1):
      spi: spi-fsl-qspi: change i.MX7D RX FIFO size

Hans Verkuil (1):
      media: vivid: fix missing cec adapter name

Hans de Goede (3):
      ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook
      HID: logitech-dj: Really fix return value of
logi_dj_recv_query_hidpp_devices
      pwm: Fallback to the static lookup-list when acpi_pwm_get fails

He Zhe (3):
      block: aoe: Fix kernel crash due to atomic sleep when exiting
      perf ftrace: Fix failure to set cpumask when only one cpu is present
      perf cpumap: Fix writing to illegal memory in handling cpumap mask

Heikki Krogerus (1):
      usb: typec: ucsi: ccg: Fix uninitilized symbol error

Heiko Carstens (1):
      s390/vdso: map vdso also for statically linked binaries

Heiner Kallweit (3):
      Revert ("r8169: remove 1000/Half from supported modes")
      r8169: don't use MSI before RTL8168d
      net: phy: fix race in genphy_update_link

Hillf Danton (2):
      HID: hiddev: avoid opening a disconnected device
      HID: hiddev: do cleanup in failure of opening a device

Hubert Feurstein (3):
      net: phy: fixed_phy: print gpio error only if gpio node is present
      net: dsa: mv88e6xxx: use link-down-define instead of plain value
      net: dsa: mv88e6xxx: drop adjust_link to enabled phylink

Ian Rogers (1):
      perf tools: Fix include paths in ui directory

Ido Schimmel (3):
      selftests: forwarding: gre_multipath: Enable IPv4 forwarding
      selftests: forwarding: gre_multipath: Fix flower filters
      drop_monitor: Add missing uAPI file to MAINTAINERS file

Ihab Zhaika (1):
      iwlwifi: add 3 new IDs for the 9000 series (iwl9260_2ac_160_cfg)

Iker Perez del Palomar Sustatxa (1):
      hwmon: (lm75) Fixup tmp75b clr_mask

Ilya Leoshkevich (2):
      selftests/bpf: fix sendmsg6_prog on s390
      bpf: fix narrower loads on s390

Ilya Maximets (1):
      libbpf: fix using uninitialized ioctl results

Ilya Trukhanov (1):
      HID: Add 044f:b320 ThrustMaster, Inc. 2 in 1 DT

Istv=C3=A1n V=C3=A1radi (1):
      HID: quirks: Set the INCREMENT_USAGE_ON_DUPLICATE quirk on Saitek X52

Ivan Bornyakov (1):
      staging: gasket: apex: fix copy-paste typo

Jakub Kicinski (12):
      net/tls: don't arm strparser immediately in tls_set_sw_offload()
      net/tls: don't call tls_sk_proto_close for hw record offload
      selftests/tls: add a test for ULP but no keys
      selftests/tls: test error codes around TLS ULP installation
      selftests/tls: add a bidirectional test
      selftests/tls: close the socket with open record
      selftests/tls: add shutdown tests
      net/tls: add myself as a co-maintainer
      selftests/net: add missing gitignores (ipv6_flowlabel)
      selftests/tls: fix TLS tests with CONFIG_TLS=3Dn
      net/tls: partially revert fix transition through disconnect with clos=
e
      selftests/tls: add a litmus test for the socket reuse through shutdow=
n

Jan Kara (1):
      bdev: Fixup error handling in blkdev_get()

Jan Sebastian G=C3=B6tte (1):
      Staging: fbtft: Fix GPIO handling

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Tiger Lake

Jean Delvare (1):
      nvmem: Use the same permissions for eeprom as for nvmem

Jean-Baptiste Maneyrol (1):
      iio: imu: mpu6050: add missing available scan masks

Jens Axboe (3):
      block: fix O_DIRECT error handling for bio fragments
      libata: have ata_scsi_rw_xlat() fail invalid passthrough requests
      libata: add SG safety checks in SFF pio transfers

Jernej Skrabec (2):
      regulator: axp20x: fix DCDCA and DCDCD for AXP806
      regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

Jesper Dangaard Brouer (5):
      MAINTAINERS: Remove mailing-list entry for XDP (eXpress Data Path)
      bpf: fix XDP vlan selftests test_xdp_vlan.sh
      selftests/bpf: add wrapper scripts for test_xdp_vlan.sh
      selftests/bpf: reduce time to execute test_xdp_vlan.sh
      net: fix bpf_xdp_adjust_head regression for generic-XDP

Jia He (1):
      arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on arm64

Jia-Ju Bai (5):
      isdn: mISDN: hfcsusb: Fix possible null-pointer dereferences in
start_isoc_chain()
      net: rds: Fix possible null-pointer dereferences in
rds_rdma_cm_event_handler_cmn()
      mac80211_hwsim: Fix possible null-pointer dereferences in
hwsim_dump_radio_nl()
      net: sched: Fix a possible null-pointer dereference in dequeue_func()
      net: phy: phy_led_triggers: Fix a possible null-pointer
dereference in phy_led_trigger_change_speed()

Jiangfeng Xiao (3):
      net: hisilicon: make hip04_tx_reclaim non-reentrant
      net: hisilicon: fix hip04-xmit never return TX_BUSY
      net: hisilicon: Fix dma_map_single failed on arm64

Jin Yao (1):
      perf pmu-events: Fix missing "cpu_clk_unhalted.core" event

Jiri Olsa (1):
      perf bench numa: Fix cpu0 binding

Jiri Pirko (2):
      net: fix ifindex collision during namespace removal
      mlxsw: spectrum: Fix error path in mlxsw_sp_module_init()

Joakim Zhang (1):
      can: flexcan: fix stop mode acknowledgment

Joe Lawrence (1):
      selftests/livepatch: push and pop dynamic debug config

Joe Perches (3):
      ASoC: rt1308: Remove executable attribute from source files
      iio: adc: max9611: Fix misuse of GENMASK macro
      Makefile: Convert -Wimplicit-fallthrough=3D3 to just
-Wimplicit-fallthrough for clang

Johan Hovold (1):
      NFC: nfcmrvl: fix gpio-handling regression

Johannes Berg (3):
      Revert "mac80211: set NETIF_F_LLTX when using intermediate tx queues"
      iwlwifi: mvm: disable TX-AMSDU on older NICs
      iwlwifi: fix locking in delayed GTK setting

John Fastabend (7):
      net/tls: remove close callback sock unlock/lock around TX work flush
      net/tls: remove sock unlock/lock around strp_done()
      net/tls: fix transition through disconnect with close
      bpf: sockmap, sock_map_delete needs to use xchg
      bpf: sockmap, synchronize_rcu before free'ing map
      bpf: sockmap, only create entry if ulp is not already enabled
      bpf: sockmap/tls, close can race with map free

Jon Maloy (1):
      tipc: fix unitilized skb list crash

Jose Abreu (7):
      net: stmmac: RX Descriptors need to be clean before setting buffers
      net: stmmac: Use kcalloc() instead of kmalloc_array()
      net: stmmac: Do not cut down 1G modes
      net: stmmac: Sync RX Buffer upon allocation
      net: stmmac: xgmac: Fix XGMAC selftests
      net: stmmac: Fix issues when number of Queues >=3D 4
      net: stmmac: tc: Do not return a fragment entry

Josh Poimboeuf (5):
      x86/speculation: Prepare entry code for Spectre v1 swapgs mitigations
      x86/speculation: Enable Spectre v1 swapgs mitigations
      x86/entry/64: Use JMP instead of JMPQ
      Documentation: Add swapgs description to the Spectre v1 documentation
      drm/i915: Remove redundant user_access_end() from
__copy_from_user() error path

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix rename concurrency with listing

Juliana Rodrigueiro (1):
      isdn: hfcsusb: Fix mISDN driver crash caused by transfer buffer
on the stack

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: remove misleading error trace from IRQ thread

Kai-Heng Feng (1):
      Input: elantech - enable SMBus on new (2018+) systems

Kevin Hao (2):
      mmc: cavium: Set the correct dma max segment size for mmc_host
      mmc: cavium: Add the missing dma unmap when the dma has finished.

Kevin Lo (1):
      r8152: fix typo in register name

Kevin Wang (1):
      drm/amd/powerplay: honor hw limit on fetching metrics data for navi10

Kirill Marinushkin (1):
      ASoC: Relocate my e-mail to .com domain zone

Kuninori Morimoto (3):
      ASoC: simple_card_utils.h: care NULL dai at asoc_simple_debug_dai()
      ASoC: simple-card-utils: care no Platform for DPCM
      ASoC: audio-graph-card: add missing const at graph_get_dai_id()

Leon Romanovsky (1):
      lib/dim: Fix -Wunused-const-variable warnings

Li Jun (2):
      usb: typec: tcpm: free log buf memory when remove debug file
      usb: typec: tcpm: remove tcpm dir if no children

Likun Gao (1):
      drm/amdgpu: pin the csb buffer on hw init for gfx v8

Linus Torvalds (1):
      Linux 5.3-rc4

Linus Walleij (1):
      spi: gpio: Add SPI_MASTER_GPIO_SS flag

Logan Gunthorpe (1):
      NTB/msi: remove incorrect MODULE defines

Lubomir Rintel (1):
      spi: pxa2xx: Balance runtime PM enable/disable on error

Luca Coelho (2):
      iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version < 41
      iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT support

Lukas Wunner (1):
      spi: bcm2835: Fix 3-wire mode if DMA is enabled

Maarten ter Huurne (1):
      IIO: Ingenic JZ47xx: Set clock divider on probe

Manikanta Pubbisetty (1):
      {nl,mac}80211: fix interface combinations on crypto controlled device=
s

Maor Gottlieb (1):
      net/mlx5: Add missing RDMA_RX capabilities

Marc Zyngier (3):
      KVM: arm/arm64: Sync ICH_VMCR_EL2 back when about to block
      KVM: arm64: Don't write junk to sysregs on reset
      KVM: arm: Don't write junk to CP15 registers on reset

Marcus Cooper (1):
      ASoC: sun4i-i2s: Incorrect SR and WSS computation

Marek Ol=C5=A1=C3=A1k (1):
      Revert "drm/amdgpu: fix transform feedback GDS hang on gfx10 (v2)"

Mark Brown (1):
      ASoC: max98373: Remove executable bits

Mark Zhang (1):
      net/mlx5: Use reversed order when unregister devices

Martin Blumenstingl (1):
      net: stmmac: manage errors returned by of_get_mac_address()

Masahiro Yamada (6):
      ASoC: SOF: use __u32 instead of uint32_t in uapi headers
      netfilter: add include guard to xt_connlabel.h
      kbuild: revive single target %.ko
      kbuild: fix false-positive need-builtin calculation
      kbuild: generate modules.order only in directories visited by obj-y/m
      kbuild: show hint if subdir-y/m is used to visit module Makefile

Masanari Iida (1):
      perf tools: Fix a typo in a variable name in the Documentation Makefi=
le

Mathias Nyman (1):
      xhci: Fix NULL pointer dereference at endpoint zero reset.

Matt Coffin (1):
      drm/amd/powerplay: Allow changing of fan_control in smu_v11_0

Matteo Croce (3):
      mvpp2: refactor MTU change code
      mvpp2: refactor the HW checksum setup
      mvpp2: fix panic on module removal

Mauro Carvalho Chehab (1):
      docs: generic-counter.rst: fix broken references for ABI file

Mauro Rossi (1):
      iwlwifi: dbg_ini: fix compile time assert build errors

Maxime Chevallier (1):
      net: mvpp2: Don't check for 3 consecutive Idle frames for 10G links

Michael Ellerman (1):
      Revert "powerpc: slightly improve cache helpers"

Michal Kalderon (1):
      qed: RDMA - Fix the hw_ver returned in device attributes

Mika Westerberg (1):
      Revert "PCI: Add missing link delays required by the PCIe spec"

Mikulas Patocka (1):
      loop: set PF_MEMALLOC_NOIO for the worker thread

Ming Lei (1):
      genirq/affinity: Create affinity mask for single vector

Mordechay Goodstein (1):
      iwlwifi: mvm: avoid races in rate init and rate perform

Moritz Fischer (1):
      MAINTAINERS: Move linux-fpga tree to new location

Muchun Song (1):
      driver core: Fix use-after-free and double free on glue directory

Naresh Kamboju (1):
      selftests: kvm: Adding config fragments

Navid Emamdoost (2):
      st21nfca_connectivity_event_received: null check the allocation
      st_nci_hci_connectivity_event_received: null check the allocation

Nick Desaulniers (2):
      x86/purgatory: Do not use __builtin_memcpy and __builtin_memset
      x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS

Nicolas Saenz Julienne (1):
      HID: input: fix a4tech horizontal wheel custom usage

Nikita Yushchenko (1):
      can: rcar_canfd: fix possible IRQ storm on high load

Nikolas Nyby (1):
      Input: applespi - fix trivial typo in struct description

Nikolay Aleksandrov (3):
      net: bridge: delete local fdb on device init failure
      net: bridge: mcast: don't delete permanent entries when fast
leave is enabled
      net: bridge: move default pvid init/deinit to NETDEV_REGISTER/UNREGIS=
TER

Nishka Dasgupta (4):
      net: dsa: mv88e6xxx: chip: Add of_node_put() before return
      net: dsa: sja1105: sja1105_main: Add of_node_put()
      regulator: of: Add of_node_put() before return in function
      net: dsa: qca8k: Add of_node_put() in qca8k_setup_mdio_bus()

Oliver Neukum (6):
      Input: usbtouchscreen - initialize PM mutex before using it
      Input: kbtab - sanity check for endpoint type
      HID: holtek: test for sanity of intfdata
      Input: iforce - add sanity checks
      Revert "USB: rio500: simplify locking"
      usb: iowarrior: fix deadlock on disconnect

Palmer Dabbelt (1):
      RISC-V: Remove udivdi3

Paolo Bonzini (3):
      KVM: remove kvm_arch_has_vcpu_debugfs()
      x86: kvm: remove useless calls to kvm_para_available
      kvm: remove unnecessary PageReserved check

Paolo Valente (3):
      block, bfq: reset last_completed_rq_bfqq if the pointed queue is free=
d
      block, bfq: move update of waker and woken list to queue freeing
      block, bfq: handle NULL return value by bfq_init_rq()

Paul Bolle (1):
      gigaset: stop maintaining seperately

Paul Burton (2):
      MIPS: Annotate fall-through in kvm/emulate.c
      MIPS: Annotate fall-through in Cavium Octeon code

Paul Walmsley (3):
      riscv: delay: use do_div() instead of __udivdi3()
      dt-bindings: riscv: remove obsolete cpus.txt
      dt-bindings: riscv: fix the schema compatible string for the
HiFive Unleashed board

Pavel Machek (1):
      net/ipv4: cleanup error condition testing

Pavel Shilovsky (2):
      SMB3: Fix deadlock in validate negotiate hits reconnect
      SMB3: Fix potential memory leak when processing compound chain

Peter Ujfalusi (2):
      ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s master mode
      ASoC: ti: davinci-mcasp: Correct slot_width posed constraint

Peter Zijlstra (1):
      sched/psi: Reduce psimon FIFO priority

Petr Machata (2):
      mlxsw: spectrum_ptp: Increase parsing depth when PTP is enabled
      mlxsw: spectrum_buffers: Further reduce pool size on Spectrum-2

Phil Reid (2):v5.3-rc3..v5.3-rc4
      Staging: fbtft: Fix probing of gpio descriptor
      Staging: fbtft: Fix reset assertion when using gpio descriptor

Phil Sutter (2):
      netfilter: nf_tables: Make nft_meta expression more robust
      netfilter: nft_meta_bridge: Eliminate 'out' label

Qian Cai (2):
      net/socket: fix GCC8+ Wpacked-not-aligned warnings
      net/mlx5e: always initialize frag->last_in_page

Rasmus Villemoes (1):
      can: dev: call netif_carrier_off() in register_candev()

Ren=C3=A9 van Dorst (1):
      net: phylink: Fix flow control for fixed-link

Ricard Wanderlof (1):
      ASoC: Fail card instantiation if DAI format setup fails

Rob Herring (1):
      spi: dt-bindings: spi-controller: remove unnecessary 'maxItems:
1' from reg

Roderick Colenbrander (1):
      HID: sony: Fix race condition between rumble and device remove.

Roman Mashak (2):
      net sched: update vlan action for batched events operations
      tc-testing: updated vlan action tests with batch create/delete

Ronald Tschal=C3=A4r (1):
      Input: applespi - fix warnings detected by sparse

Sebastian Parschauer (1):
      HID: Add quirk for HP X1200 PIXART OEM mouse

Sebastien Tisserant (1):
      SMB3: Kernel oops mounting a encryptData share with CONFIG_DEBUG_VIRT=
UAL

Shahar S Matityahu (2):
      iwlwifi: dbg_ini: move iwl_dbg_tlv_load_bin out of debug override ifd=
ef
      iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shengjiu Wang (1):
      ASoC: cs42xx8: Fix MFREQ selection issue for async mode

Shuming Fan (1):
      ASoC: rt1011: fix DC calibration offset not applying

Stanislav Lisovskiy (1):
      drm/i915: Fix wrong escape clock divisor init for GLK

Stefano Brivio (2):
      netfilter: ipset: Actually allow destination MAC address for
hash:ip,mac sets too
      netfilter: ipset: Copy the right MAC address in bitmap:ip,mac
and hash:ip,mac sets

Stephan Gerhold (1):
      ASoC: qcom: apq8016_sbc: Fix oops with multiple DAI links

Stephane Grosjean (1):
      can: peak_usb: fix potential double kfree_skb()

Steve French (3):
      cifs: fix rmmod regression in cifs.ko caused by force_sig changes
      smb3: send CAP_DFS capability during session setup
      smb3: update TODO list of missing features

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix incorrect UL checksum offload logic

Sudarsana Reddy Kalluru (1):
      bnx2x: Disable multi-cos feature.

Suren Baghdasaryan (1):
      sched/psi: Do not require setsched permission from the trigger creato=
r

Suzuki K Poulose (2):
      coresight: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute
      usb: yurex: Fix use-after-free in yurex_delete

Takashi Iwai (3):
      sky2: Disable MSI on ASUS P6T
      ALSA: hda - Don't override global PCM hw info flag
      ALSA: hda - Workaround for crackled sound on AMD controller (1022:145=
7)

Taras Kondratiuk (1):
      tipc: compat: allow tipc commands without arguments

Tariq Toukan (4):
      net/mlx5e: Fix wrong max num channels indication
      net/mlx5e: kTLS, Call WARN_ONCE on netdev mismatch
      nfp: tls: rename tls packet counters
      Documentation: TLS: fix stat counters description

Tetsuo Handa (1):
      staging: android: ion: Bail out upon SIGKILL when allocating memory.

Thi=C3=A9baud Weksteen (1):
      usb: setup authorized_default attributes using usb_bus_notify

Thomas Bogendoerfer (1):
      MIPS: kernel: only use i8253 clocksource with periodic clockevent

Thomas Falcon (1):
      bonding: Force slave speed check after link state recovery for 802.3a=
d

Thomas Gleixner (1):
      x86/speculation/swapgs: Exclude ATOMs from speculation through SWAPGS

Thomas Huth (1):
      KVM: selftests: Update gitignore file for latest changes

Thomas Richter (2):
      perf record: Fix module size on s390
      perf annotate: Fix s390 gap between kernel end and module start

Thong Thai (2):
      drm/amd/amdgpu/vcn_v2_0: Mark RB commands as KMD commands
      drm/amd/amdgpu/vcn_v2_0: Move VCN 2.0 specific dec ring test to vcn_v=
2_0

Tomas Bortoli (2):
      can: peak_usb: pcan_usb_fd: Fix info-leaks to USB devices
      can: peak_usb: pcan_usb_pro: Fix info-leaks to USB devices

Trond Myklebust (12):
      NFSv4: Fix a credential refcount leak in nfs41_check_delegation_state=
id
      NFSv4: Fix delegation state recovery
      NFSv4: Print an error in the syslog when state is marked as irrecover=
able
      NFSv4: When recovering state fails with EAGAIN, retry the same recove=
ry
      NFSv4: Report the error from nfs4_select_rw_stateid()
      NFSv4.1: Fix open stateid recovery
      NFSv4.1: Only reap expired delegations
      NFSv4: Check the return value of update_open_stateid()
      NFSv4: Fix a potential sleep while atomic in nfs4_do_reclaim()
      NFSv4: Fix an Oops in nfs4_do_setattr
      NFS: Fix regression whereby fscache errors are appearing on 'nofsc' m=
ounts
      NFSv4: Ensure state recovery handles ETIMEDOUT correctly

Tzung-Bi Shih (1):
      ASoC: max98357a: use mdelay for sdmode-delay

Ursula Braun (2):
      net/smc: do not schedule tx_work in SMC_CLOSED state
      net/smc: avoid fallback in case of non-blocking connect

Valdis Kletnieks (1):
      x86/lib/cpu: Address missing prototypes warning

Vasily Gorbik (8):
      s390/protvirt: avoid memory sharing for diag 308 set/store
      s390/mm: fix dump_pagetables top level page table walking
      s390/setup: adjust start_code of init_mm to _text
      s390/unwind: remove stack recursion warning
      s390/head64: cleanup unused labels
      s390: put _stext and _etext into .text section
      kbuild: add OBJSIZE variable for the size tool
      s390/build: use size command to perform empty .bss check

Vijendar Mukunda (2):
      ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver
      ASoC: amd: acp3x: use dma address for acp3x dma driver

Vivek Goyal (1):
      dax: dax_layout_busy_page() should not unmap cow pages

Vlad Buslov (2):
      net: sched: police: allow accessing police->params with rtnl
      net: sched: sample: allow accessing psample_group with rtnl

Vladimir Kondratiev (1):
      mips: fix cacheinfo

Vladimir Oltean (5):
      net: dsa: sja1105: Fix broken learning with vlan_filtering disabled
      net: dsa: sja1105: Use the LOCKEDS bit for SJA1105 E/T as well
      net: dsa: sja1105: Really fix panic on unregistering PTP clock
      net: dsa: sja1105: Fix memory leak on meta state machine normal path
      net: dsa: sja1105: Fix memory leak on meta state machine error path

Wang Xiayang (3):
      can: sja1000: force the string buffer NULL-terminated
      can: peak_usb: force the string buffer NULL-terminated
      net/ethernet/qlogic/qed: force the string buffer NULL-terminated

Wanpeng Li (3):
      KVM: LAPIC: Don't need to wakeup vCPU twice afer timer fire
      KVM: Check preempted_in_kernel for involuntary preemption
      KVM: Fix leak vCPU's VMCS value into other pCPU

Wei Yongjun (1):
      drm/i915: fix possible memory leak in intel_hdcp_auth_downstream()

Weitao Hou (1):
      can: mcp251x: add error check when wq alloc failed

Wen Yang (7):
      ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()
      ASoC: simple-card: fix an use-after-free in simple_for_each_link()
      ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm(=
)
      ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()
      ASoC: samsung: odroid: fix an use-after-free issue for codec
      ASoC: samsung: odroid: fix a double-free issue for cpu_dai
      can: flexcan: fix an use-after-free in flexcan_setup_stop_mode()

Wenwen Wang (6):
      netfilter: ebtables: fix a memory leak bug in compat
      ASoC: dapm: fix a memory leak bug
      ALSA: usb-audio: fix a memory leak bug
      ALSA: hiface: fix multiple memory leak bugs
      sound: fix a memory leak bug
      ALSA: firewire: fix a memory leak bug

Yamin Friedman (1):
      linux/dim: Fix overflow in dim calculation

Yonglong Liu (1):
      net: hns: fix LED configuration for marvell phy

Yoshihiro Shimoda (1):
      usb: host: xhci-rcar: Fix timeout in xhci_suspend()

YueHaibing (5):
      can: gw: Fix error path of cgw_module_init
      pinctrl: aspeed: Make aspeed_pinmux_ips static
      enetc: Fix build error without PHYLIB
      Input: applespi - add dependency on LEDS_CLASS
      enetc: Select PHYLIB while CONFIG_FSL_ENETC_VF is set

Zenghui Yu (2):
      KVM: arm/arm64: Introduce kvm_pmu_vcpu_init() to setup PMU counter in=
dex
      KVM: arm64: Update kvm_arm_exception_class and esr_class_str for new =
EC

fengchunguo (1):
      ASoC: max98373: add 88200 and 96000 sampling rate support

xiaofeis (1):
      net: dsa: qca8k: enable port flow control
