Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CB02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfC0CKy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:10:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfC0CKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:10:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 229B212F7A9FF;
        Tue, 26 Mar 2019 19:10:52 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:10:49 -0700 (PDT)
Message-Id: <20190326.191049.35928665035979956.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 19:10:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes here and there, a couple new device IDs, as usual:

1) Fix BQL race in dpaa2-eth driver, from Ioana Ciornei.

2) Fix 64-bit division in iwlwifi, from Arnd Bergmann.

3) Fix documentation for some eBPF helpers, from Quentin Monnet.

4) Some UAPI bpf header sync with tools, also from Quentin Monnet.

5) Set descriptor ownership bit at the right time for jumbo frames
   in stmmac driver, from Aaro Koskinen.

6) Set IFF_UP properly in tun driver, from Eric Dumazet.

7) Fix load/store doubleword instruction generation in powerpc eBPF
   JIT, from Naveen N. Rao.

8) nla_nest_start() return value checks all over, from Kangjie Lu.

9) Fix asoc_id handling in SCTP after the SCTP_*_ASSOC changes this
   merge window.  From Marcelo Ricardo Leitner and Xin Long.

10) Fix memory corruption with large MTUs in stmmac, from Aaro
    Koskinen.

11) Do not use ipv4 header for ipv6 flows in TCP and DCCP, from Eric
    Dumazet.

12) Fix topology subscription cancellation in tipc, from Erik Hugne.

13) Memory leak in genetlink error path, from Yue Haibing.

14) Valid control actions properly in packet scheduler, from Davide
    Caratti.

15) Even if we get EEXIST, we still need to rehash if a shrink was
    delayed.  From Herbert Xu.

16) Fix interrupt mask handling in interrupt handler of r8169, from
    Heiner Kallweit.

17) Fix leak in ehea driver, from Wen Yang.

Please pull, thanks a lot.

The following changes since commit f261c4e529dac5608a604d3dd3ae1cd2adf23c89:

  Merge branch 'akpm' (patches from Andrew) (2019-03-14 15:10:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 8c838f53e149871561a9261ac768a9c7071b43d0:

  dpaa2-eth: fix race condition with bql frame accounting (2019-03-26 11:43:49 -0700)

----------------------------------------------------------------
Aaro Koskinen (3):
      net: stmmac: don't set own bit too early for jumbo frames
      net: stmmac: fix jumbo frame sending with non-linear skbs
      net: stmmac: fix memory corruption with large MTUs

Aditya Pakki (2):
      qlcnic: Avoid potential NULL pointer dereference
      nfc: Fix to check for kmemdup failure

Alexei Starovoitov (4):
      Merge branch 'fix-fullsock-access-after-bpf_sk_release'
      Merge branch 'fix-fwd-enum-resolution'
      Merge branch 'fix-bpf-docs'
      Merge branch 'libbpf-fixup'

Alin Nastac (1):
      netfilter: nf_conntrack_sip: remove direct dependency on IPv6

Andrii Nakryiko (3):
      libbpf: handle BTF parsing and loading properly
      btf: resolve enum fwds in btf_dedup
      selftests/bpf: add fwd enum resolution test for btf_dedup

Arnd Bergmann (6):
      iwlwifi: fix 64-bit division
      netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
      mlxsw: core: mlxsw: core: avoid -Wint-in-bool-context warning
      3c515: fix integer overflow warning
      rxrpc: avoid clang -Wuninitialized warning
      chelsio: use BUG() instead of BUG_ON(1)

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Björn Töpel (1):
      xsk: fix umem memory leak on cleanup

Christian Lamparter (4):
      dt-bindings: net: dsa: qca8k: fix example
      dt-bindings: net: dsa: qca8k: support internal mdio-bus
      net: dsa: qca8k: remove leftover phy accessors
      net: dsa: qca8k: extend slave-bus implementations

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Colin Ian King (2):
      drivers: net: atp: fix various indentation issues
      net: sis900: fix indentation issues, remove some spaces

Dan Murphy (1):
      net: phy: Add DP83825I to the DP83822 driver

Daniel Borkmann (2):
      bpf, libbpf: fix version info and add it to shared object
      bpf, libbpf: clarify bump in libbpf version info

David S. Miller (9):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'sctp-fix-ignoring-asoc_id-for-tcp-style-sockets-on-some-setsockopts'
      Merge branch 's390-qeth-fixes'
      Merge branch 'ieee802154-for-davem-2019-03-19' of git://git.kernel.org/.../sschmidt/wpan
      Merge tag 'wireless-drivers-for-davem-2019-03-19' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'ks8851-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'net-sched-validate-the-control-action-with-all-the-other-parameters'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (18):
      net/sched: prepare TC actions to properly validate the control action
      net/sched: act_bpf: validate the control action inside init()
      net/sched: act_csum: validate the control action inside init()
      net/sched: act_gact: validate the control action inside init()
      net/sched: act_ife: validate the control action inside init()
      net/sched: act_mirred: validate the control action inside init()
      net/sched: act_connmark: validate the control action inside init()
      net/sched: act_nat: validate the control action inside init()
      net/sched: act_pedit: validate the control action inside init()
      net/sched: act_police: validate the control action inside init()
      net/sched: act_sample: validate the control action inside init()
      net/sched: act_simple: validate the control action inside init()
      net/sched: act_skbedit: validate the control action inside init()
      net/sched: act_skbmod: validate the control action inside init()
      net/sched: act_tunnel_key: validate the control action inside init()
      net/sched: act_vlan: validate the control action inside init()
      net/sched: don't dereference a->goto_chain to read the chain index
      net/sched: let actions use RCU to access 'goto_chain'

Dmitry Bezrukov (1):
      net: usb: aqc111: Extend HWID table by QNAP device

Dmitry Bogdanov (1):
      net: aquantia: fix rx checksum offload for UDP/TCP over IPv6

Eric Dumazet (5):
      tun: properly test for IFF_UP
      tun: add a missing rcu_read_unlock() in error path
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow
      dccp: do not use ipv6 header for ipv4 flow

Erik Hugne (2):
      tipc: allow service ranges to be connect()'ed on RDM/DGRAM
      tipc: fix cancellation of topology subscriptions

Felix Fietkau (16):
      mt76: rewrite dma descriptor base and ring size on queue reset
      mt76: mt76x02: when setting a key, use PN from mac80211
      mt76: mt76x2: implement full device restart on watchdog reset
      mt76: mt76x02: only update the base mac address if necessary
      mt76: mt76x02: reduce false positives in ED/CCA tx blocking
      mt76: mt7603: fix tx status HT rate validation
      mt76: mt76x2: fix external LNA gain settings
      mt76: mt76x2: fix 2.4 GHz channel gain settings
      mt76: mt7603: clear ps filtering mode before releasing buffered frames
      mt76: mt7603: fix up hardware queue index for PS filtered packets
      mt76: mt7603: notify mac80211 about buffered frames in ps queue
      mt76: mt7603: clear the service period on releasing PS filtered packets
      mt76: when releasing PS frames, end the service period if no frame was found
      mt76: mt76x02: disable ED/CCA by default
      mt76: mt7603: set moredata flag when queueing ps-filtered packets
      mt76: mt7603: use the correct hweight8() function

Finn Thain (1):
      mac8390: Fix mmio access size probe

Florian Fainelli (2):
      Documentation: networking: Update netdev-FAQ regarding patches
      net: phy: Re-parent menus for MDIO bus drivers correctly

Harini Katakam (1):
      net: macb: Add null check for PCLK and HCLK

Heiner Kallweit (3):
      r8169: don't read interrupt mask register in interrupt handler
      r8169: fix cable re-plugging issue
      net: phy: don't clear BMCR in genphy_soft_reset

Herbert Xu (1):
      rhashtable: Still do rehash when we get EEXIST

Ioana Ciocoi Radulescu (1):
      dpaa2-eth: Fix possible access beyond end of array

Ioana Ciornei (1):
      dpaa2-eth: fix race condition with bql frame accounting

Jakub Kicinski (1):
      bpf: verifier: propagate liveness on all frames

Jerome Brunet (1):
      net: phy: meson-gxl: fix interrupt support

Jiri Pirko (1):
      net: devlink: skip info_get op call if it is not defined in dumpit

John Hurley (1):
      net: sched: fix cleanup NULL pointer exception in act_mirr

Jon Maloy (1):
      tipc: tipc clang warning

Julian Wiedmann (3):
      s390/qeth: don't erase configuration while probing
      s390/qeth: fix race when initializing the IP address table
      s390/qeth: be drop monitor friendly

Kalle Valo (1):
      Merge tag 'mt76-for-kvalo-2019-03-07' of https://github.com/nbd168/wireless

Kangjie Lu (8):
      net: ieee802154: fix a potential NULL pointer dereference
      net: strparser: fix a missing check for create_singlethread_workqueue
      net: openvswitch: fix a NULL pointer dereference
      net: openvswitch: fix missing checks for nla_nest_start
      net: ncsi: fix a missing check for nla_nest_start
      net: tipc: fix a missing check of nla_nest_start
      net: tipc: fix a missing check for nla_nest_start
      netfilter: ip6t_srh: fix NULL pointer dereferences

Leslie Monis (1):
      net: sched: Kconfig: update reference link for PIE

Li RongQing (1):
      ieee802154: hwsim: propagate genlmsg_reply return code

Lorenzo Bianconi (3):
      mt76: introduce q->stopped parameter
      mt76x2u: remove duplicated entry in mt76x2u_device_table
      mt76: fix schedule while atomic in mt76x02_reset_state

Lukas Wunner (6):
      net: ks8851: Dequeue RX packets explicitly
      net: ks8851: Reassert reset pin if chip ID check fails
      net: ks8851: Delay requesting IRQ until opened
      net: ks8851: Set initial carrier state to down
      net: ks8851: Fix register macro misnomers
      net: ks8851: Deduplicate register macros

Magnus Karlsson (1):
      libbpf: fix to reject unknown flags in xsk_socket__create()

Marcelo Ricardo Leitner (1):
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_DEFAULT_SEND_PARAM sockopt

Martin KaFai Lau (6):
      bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release
      bpf: Add bpf_get_listener_sock(struct bpf_sock *sk) helper
      bpf: Sync bpf.h to tools/
      bpf: Test ref release issue in bpf_tcp_sock and bpf_sk_fullsock
      bpf: Add an example for bpf_get_listener_sock
      bpf: Only print ref_obj_id for refcounted reg

Martynas Pumputis (1):
      bpf: Try harder when allocating memory for large maps

Matteo Croce (1):
      gtp: change NET_UDP_TUNNEL dependency to select

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

Pablo Neira Ayuso (4):
      netfilter: nft_set_rbtree: check for inactive element after flag mismatch
      netfilter: nf_tables: bogus EBUSY in helper removal from transaction
      netfilter: nft_redir: fix module autoload with ip4
      netfilter: nf_flowtable: remove duplicated transition in diagram

Pedro Tammela (1):
      net: add documentation to socket.c

Quentin Monnet (3):
      bpf: fix documentation for eBPF helpers
      bpf: add documentation for helpers bpf_spin_lock(), bpf_spin_unlock()
      tools: bpf: synchronise BPF UAPI header with tools

Randy Dunlap (1):
      networking: fix snmp_counter.rst Doc. Warnings

Stanislaw Gruszka (4):
      mt76x02: fix hdr pointer in write txwi for USB
      mt7601u: check chip version on probe
      mt76x02u: check chip version on probe
      mt76x02: do not enable RTS/CTS by default

Stefan Schmidt (1):
      Merge remote-tracking branch 'net/master'

Taehee Yoo (1):
      netfilter: nf_tables: add missing ->release_ops() in error path of newrule()

Tobias Klauser (1):
      doc: fix link to MSG_ZEROCOPY patchset

Toke Høiland-Jørgensen (1):
      sch_cake: Interpret fwmark parameter as a bitmask

Vinay K Nallamothu (1):
      mpls: Fix 6PE forwarding

Vladimir Oltean (1):
      net: phy: bcm54xx: Encode link speed and activity into LEDs

Wang Hai (1):
      net-sysfs: Fix memory leak in netdev_register_kobject

Wei Yongjun (1):
      mt76: fix return value check in mt76_wmac_probe()

Wen Yang (3):
      net: xilinx: fix possible object reference leak
      net: ibm: fix possible object reference leak
      net: ethernet: ti: fix possible object reference leak

Xin Long (18):
      netfilter: bridge: set skb transport_header before entering NF_INET_PRE_ROUTING
      sctp: get sctphdr by offset in sctp_compute_cksum
      sctp: not copy sctp_sock pd_lobby in sctp_copy_descendant
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_DELAYED_SACK sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_DEFAULT_SNDINFO sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_CONTEXT sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_MAX_BURST sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_AUTH_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_AUTH_ACTIVE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_AUTH_DELETE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_AUTH_DEACTIVATE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_DEFAULT_PRINFO sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_ENABLE_STREAM_RESET sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_EVENT sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_STREAM_SCHEDULER sockopt
      ipv6: make ip6_create_rt_rcu return ip6_null_entry instead of NULL
      sctp: use memdup_user instead of vmemdup_user
      tipc: change to check tipc_own_id to return in tipc_net_stop

Xu Yu (1):
      bpf: do not restore dst_reg when cur_state is freed

Yonghong Song (1):
      selftests/bpf: fix segfault of test_progs when prog loading failed

Yoshiki Komachi (1):
      af_packet: fix the tx skb protocol in raw sockets with ETH_P_ALL

YueHaibing (3):
      appletalk: Fix potential NULL pointer dereference in unregister_snap_client
      net-sysfs: call dev_hold if kobject_init_and_add success
      genetlink: Fix a memory leak on error path

Yunsheng Lin (1):
      net: hns3: fix for not calculating tx bd num correctly

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered

 Documentation/devicetree/bindings/net/dsa/qca8k.txt                 |  73 ++++++++++++++++--
 Documentation/networking/msg_zerocopy.rst                           |   2 +-
 Documentation/networking/netdev-FAQ.rst                             |  13 ++++
 Documentation/networking/nf_flowtable.txt                           |   8 +-
 Documentation/networking/snmp_counter.rst                           |  12 ++-
 arch/powerpc/include/asm/ppc-opcode.h                               |   2 +
 arch/powerpc/net/bpf_jit.h                                          |  17 ++--
 arch/powerpc/net/bpf_jit32.h                                        |   4 +
 arch/powerpc/net/bpf_jit64.h                                        |  20 +++++
 arch/powerpc/net/bpf_jit_comp64.c                                   |  12 +--
 drivers/isdn/hardware/mISDN/hfcmulti.c                              |   3 +-
 drivers/net/Kconfig                                                 |   4 +-
 drivers/net/dsa/qca8k.c                                             | 174 ++++++++++++++++++++++++++++++++++++-----
 drivers/net/dsa/qca8k.h                                             |  13 ++++
 drivers/net/ethernet/3com/3c515.c                                   |   2 +-
 drivers/net/ethernet/8390/mac8390.c                                 |  19 +++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                    |   5 +-
 drivers/net/ethernet/cadence/macb_main.c                            |  10 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c                  |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c                            |   2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                    |  15 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                     |  13 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                     |   1 -
 drivers/net/ethernet/ibm/ehea/ehea_main.c                           |   1 +
 drivers/net/ethernet/mellanox/mlxsw/core_env.c                      |   2 +-
 drivers/net/ethernet/micrel/ks8851.c                                |  42 +++++-----
 drivers/net/ethernet/micrel/ks8851.h                                |  93 +++++++++++-----------
 drivers/net/ethernet/micrel/ks8851_mll.c                            | 317 ++-------------------------------------------------------------------------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c                 |   2 +
 drivers/net/ethernet/realtek/atp.c                                  |   2 +-
 drivers/net/ethernet/realtek/r8169.c                                |   8 +-
 drivers/net/ethernet/sis/sis900.c                                   |  10 +--
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                     |  13 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                   |  14 ++--
 drivers/net/ethernet/ti/netcp_ethss.c                               |   8 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                   |   2 +
 drivers/net/ieee802154/adf7242.c                                    |   4 +
 drivers/net/ieee802154/mac802154_hwsim.c                            |   2 +-
 drivers/net/phy/Kconfig                                             |   3 +
 drivers/net/phy/broadcom.c                                          |  13 ++++
 drivers/net/phy/dp83822.c                                           |  34 ++++----
 drivers/net/phy/meson-gxl.c                                         |   6 ++
 drivers/net/phy/phy_device.c                                        |   2 +-
 drivers/net/tun.c                                                   |  16 +++-
 drivers/net/usb/aqc111.c                                            |  15 ++++
 drivers/net/usb/cdc_ether.c                                         |   8 ++
 drivers/net/vxlan.c                                                 |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c              |   4 +-
 drivers/net/wireless/mediatek/mt76/dma.c                            |   7 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c                       |  18 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h                           |   4 +
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                  |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                     |  17 +++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                     |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                    |  16 ++++
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                     |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                     |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/initvals.h                |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c                     |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02.h                        |  11 +++
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c                |  27 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c                    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                    |  67 ++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h                    |   2 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                   |  82 ++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c                    |   2 +
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c               |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c                   |  14 +++-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c                    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h                  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c                |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c                 |  21 +++++
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c                     |  30 ++++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                     |   7 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c                 |   1 -
 drivers/net/wireless/mediatek/mt76/tx.c                             |  11 ++-
 drivers/net/wireless/mediatek/mt76/usb.c                            |   6 +-
 drivers/net/wireless/mediatek/mt7601u/usb.c                         |   4 +
 drivers/s390/net/qeth_core_main.c                                   |   5 +-
 drivers/s390/net/qeth_l2_main.c                                     |   7 +-
 drivers/s390/net/qeth_l3_main.c                                     |   8 +-
 include/linux/atalk.h                                               |   2 +-
 include/linux/bpf.h                                                 |   1 -
 include/linux/bpf_verifier.h                                        |  40 ++++++++++
 include/linux/brcmphy.h                                             |  16 ++++
 include/linux/net.h                                                 |   6 ++
 include/linux/socket.h                                              |  12 +--
 include/net/act_api.h                                               |   9 ++-
 include/net/sch_generic.h                                           |   1 +
 include/net/sctp/checksum.h                                         |   2 +-
 include/net/sock.h                                                  |   6 ++
 include/net/tc_act/tc_gact.h                                        |   2 +-
 include/net/xdp_sock.h                                              |   1 -
 include/uapi/linux/bpf.h                                            | 188 +++++++++++++++++++++++++++++---------------
 kernel/bpf/syscall.c                                                |  22 ++++--
 kernel/bpf/verifier.c                                               | 154 +++++++++++++++++++++---------------
 lib/rhashtable.c                                                    |   8 +-
 net/appletalk/aarp.c                                                |  15 +++-
 net/appletalk/ddp.c                                                 |  20 +++--
 net/bridge/br_netfilter_hooks.c                                     |   1 +
 net/bridge/br_netfilter_ipv6.c                                      |   2 +
 net/core/devlink.c                                                  |   5 ++
 net/core/filter.c                                                   |  27 +++++--
 net/core/net-sysfs.c                                                |  20 +++--
 net/dccp/ipv6.c                                                     |   4 +-
 net/ipv6/netfilter/ip6t_srh.c                                       |   6 ++
 net/ipv6/route.c                                                    |  18 +++--
 net/ipv6/tcp_ipv6.c                                                 |   8 +-
 net/mpls/mpls_iptunnel.c                                            |  12 ++-
 net/ncsi/ncsi-netlink.c                                             |   4 +
 net/netfilter/Kconfig                                               |   1 +
 net/netfilter/nf_conntrack_sip.c                                    |  37 ++++-----
 net/netfilter/nf_tables_api.c                                       |   5 +-
 net/netfilter/nft_objref.c                                          |  19 ++++-
 net/netfilter/nft_redir.c                                           |   2 +-
 net/netfilter/nft_set_rbtree.c                                      |   7 +-
 net/netlink/genetlink.c                                             |   3 +-
 net/nfc/llcp_sock.c                                                 |   9 ++-
 net/openvswitch/datapath.c                                          |  12 +++
 net/packet/af_packet.c                                              |   7 +-
 net/rose/rose_subr.c                                                |  21 ++---
 net/rxrpc/output.c                                                  |  11 ++-
 net/sched/Kconfig                                                   |   3 +-
 net/sched/act_api.c                                                 | 101 ++++++++++++++----------
 net/sched/act_bpf.c                                                 |  25 ++++--
 net/sched/act_connmark.c                                            |  22 +++++-
 net/sched/act_csum.c                                                |  22 +++++-
 net/sched/act_gact.c                                                |  15 +++-
 net/sched/act_ife.c                                                 |  35 +++++----
 net/sched/act_ipt.c                                                 |  11 +--
 net/sched/act_mirred.c                                              |  25 +++++-
 net/sched/act_nat.c                                                 |  15 +++-
 net/sched/act_pedit.c                                               |  18 ++++-
 net/sched/act_police.c                                              |  13 +++-
 net/sched/act_sample.c                                              |  21 ++++-
 net/sched/act_simple.c                                              |  54 +++++++++----
 net/sched/act_skbedit.c                                             |  20 ++++-
 net/sched/act_skbmod.c                                              |  20 ++++-
 net/sched/act_tunnel_key.c                                          |  19 ++++-
 net/sched/act_vlan.c                                                |  22 +++++-
 net/sched/cls_api.c                                                 |   2 +-
 net/sched/sch_cake.c                                                |  25 +++---
 net/sctp/socket.c                                                   |  54 +++++++++++--
 net/socket.c                                                        | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 net/strparser/strparser.c                                           |   2 +
 net/tipc/group.c                                                    |   3 +
 net/tipc/net.c                                                      |   5 +-
 net/tipc/node.c                                                     |   7 +-
 net/tipc/socket.c                                                   |  22 ++++--
 net/tipc/topsrv.c                                                   |   1 +
 net/xdp/xdp_umem.c                                                  |  19 +----
 tools/include/uapi/linux/bpf.h                                      | 188 +++++++++++++++++++++++++++++---------------
 tools/lib/bpf/Makefile                                              |  42 ++++++----
 tools/lib/bpf/README.rst                                            |   1 +
 tools/lib/bpf/btf.c                                                 |  51 ++++++++----
 tools/lib/bpf/libbpf.c                                              |  13 +++-
 tools/lib/bpf/xsk.c                                                 |  15 +++-
 tools/testing/selftests/bpf/bpf_helpers.h                           |   2 +
 tools/testing/selftests/bpf/prog_tests/map_lock.c                   |   2 +-
 tools/testing/selftests/bpf/prog_tests/spinlock.c                   |   2 +-
 tools/testing/selftests/bpf/progs/test_sock_fields_kern.c           |  88 +++++++++++++++++----
 tools/testing/selftests/bpf/test_btf.c                              |  44 +++++++++++
 tools/testing/selftests/bpf/test_sock_fields.c                      | 134 +++++++++++++++++++++++++-------
 tools/testing/selftests/bpf/verifier/calls.c                        |  25 ++++++
 tools/testing/selftests/bpf/verifier/ref_tracking.c                 | 168 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/sock.c                         |   4 +-
 tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json        |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json   |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/csum.json       |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/gact.json       |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/ife.json        |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json     |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/nat.json        |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json      |  51 ++++++++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json     |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/sample.json     |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/simple.json     |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/skbedit.json    |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/skbmod.json     |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json |  25 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/vlan.json       |  25 ++++++
 182 files changed, 3121 insertions(+), 1137 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json
