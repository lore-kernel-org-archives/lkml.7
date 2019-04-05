Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE493C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227B206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfDEBrT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:47:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56406 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDEBrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:47:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 958B81473AE54;
        Thu,  4 Apr 2019 18:47:18 -0700 (PDT)
Date:   Thu, 04 Apr 2019 18:47:18 -0700 (PDT)
Message-Id: <20190404.184718.1193600058567939028.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 18:47:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Several hash table refcount fixes in batman-adv, from Sven Eckelmann.

2) Use after free in bpf_evict_inode(), from Daniel Borkmann.

3) Fix mdio bus registration in ixgbe, from Ivan Vecera.

4) Unbounded loop in __skb_try_recv_datagram(), from Paolo Abeni.

5) ila rhashtable corruption fix from Herbert Xu.

6) Don't allow upper-devices to be added to vrf devices, from
   Sabrina Dubroca.

7) Add qmi_wwan device ID for Olicard 600, from Bjørn Mork.

8) Don't leave skb->next poisoned in __netif_receive_skb_list_ptype,
   from Alexander Lobakin.

9) Missing IDR checks in mlx5 driver, from Aditya Pakki.

10) Fix false connection termination in ktls, from Jakub Kicinski.

11) Work around some ASPM issues with r8169 by disabling rx interrupt
    coalescing on certain chips.  From Heiner Kallweit.

12) Properly use per-cpu qstat values on NOLOCK qdiscs, from Paolo
    Abeni.

13) Fully initialize sockaddr_in structures in SCTP, from Xin Long.

14) Various BPF flow dissector fixes from Stanislav Fomichev.

15) Divide by zero in act_sample, from Davide Caratti.

16) Fix bridging multicast regression introduced by rhashtable
    conversion, from Nikolay Aleksandrov.

Please pull, thanks a lot!

The following changes since commit 1a9df9e29c2afecf6e3089442d429b377279ca3c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-03-27 12:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to bbd669a868bba591ffd38b7bc75a7b361bb54b04:

  ibmvnic: Fix completion structure initialization (2019-04-04 18:36:07 -0700)

----------------------------------------------------------------
Aaro Koskinen (6):
      net: stmmac: use correct DMA buffer size in the RX descriptor
      net: stmmac: ratelimit RX error logs
      net: stmmac: don't stop NAPI processing when dropping a packet
      net: stmmac: don't overwrite discard_frame status
      net: stmmac: fix dropping of multi-descriptor RX frames
      net: stmmac: don't log oversized frames

Aditya Pakki (1):
      net: mlx5: Add a missing check on idr_find, free buf

Alexander Lobakin (1):
      net: core: netif_receive_skb_list: unlist skb before passing to pt->func

Alexei Starovoitov (2):
      Merge branch 'fix-verifier-warning'
      Merge branch 'fix-btf_dedup'

Anders Roxell (1):
      batman-adv: fix warning in function batadv_v_elp_get_throughput

Andrea Righi (1):
      openvswitch: fix flow actions reallocation

Andrii Nakryiko (2):
      libbpf: fix btf_dedup equivalence check handling of different kinds
      selftests/bpf: add btf_dedup test for VOID equivalence check

Artemy Kovalyov (1):
      net/mlx5: Decrease default mr cache size

Arvind Sankar (1):
      igb: Fix WARN_ONCE on runtime suspend

Aya Levin (2):
      net/mlx5: ethtool, Fix type analysis of advertised link-mode
      net/mlx5: ethtool, Allow legacy link-modes configuration via non-extended ptys

Bert Kenward (1):
      MAINTAINERS: net: update Solarflare maintainers

Björn Töpel (4):
      libbpf: add xsk.h to install_headers target
      libbpf: add libelf dependency to shared library build
      i40e: move i40e_xsk_umem function
      i40e: add tracking of AF_XDP ZC state for each queue pair

Bjørn Mork (1):
      qmi_wwan: add Olicard 600

Chris Leech (1):
      vlan: conditional inclusion of FCoE hooks to match netdevice.h and bnx2x

Claudiu Manoil (1):
      net: mii: Fix PAUSE cap advertisement from linkmode_adv_to_lcl_adv_t() helper

Daniel Borkmann (3):
      bpf: fix use after free in bpf_evict_inode
      bpf, libbpf: fix quiet install_headers
      Merge branch 'bpf-flow-dissector-fixes'

David S. Miller (15):
      Merge branch 'thunderx-fix-receive-buffer-page-recycling'
      Merge tag 'batadv-net-for-davem-20190328' of git://git.open-mesh.org/linux-merge
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'nfp-fix-retcode-and-disable-netpoll-on-representors'
      Revert "cxgb4: Update 1.23.3.0 as the latest firmware supported."
      Merge tag 'mlx5-fixes-2019-03-29' of git://git.kernel.org/.../saeed/linux
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'net-stmmac-fix-handling-of-oversized-frames'
      Merge branch 'tipc-a-batch-of-uninit-value-fixes-for-netlink_compat'
      Merge branch 'net-sched-fix-stats-accounting-for-child-NOLOCK-qdiscs'
      Merge branch 'nfp-flower-fix-matching-and-pushing-vlan-CFI-bit'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'net-hns-bugfixes-for-HNS-Driver'
      Merge branch 'sch_cake-fixes'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      net/sched: act_sample: fix divide by zero in the traffic path

Dean Nelson (2):
      thunderx: enable page recycling for non-XDP case
      thunderx: eliminate extra calls to put_page() for pages held for recycling

Dmytro Linkin (1):
      net/mlx5e: Allow IPv4 ttl & IPv6 hop_limit rewrite for all L4 protocols

Dust Li (1):
      tcp: fix a potential NULL pointer dereference in tcp_sk_exit

Eli Britstein (1):
      net/mlx5e: Consider tunnel type for encap contexts

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Florian Fainelli (1):
      MAINTAINERS: Fix documentation file name for PHY Library

Gavi Teitz (1):
      net/mlx5e: Fix error handling when refreshing TIRs

Haiyang Zhang (1):
      hv_netvsc: Fix unwanted wakeup after tx_disable

Heiner Kallweit (2):
      net: dsa: mv88e6xxx: fix few issues in mv88e6390x_port_set_cmode
      r8169: disable default rx interrupt coalescing on RTL8168

Herbert Xu (1):
      ila: Fix rhashtable walker list corruption

Huy Nguyen (3):
      net/mlx5: E-Switch, fix syndrome (0x678139) when turn on vepa
      net/mlx5e: Update xoff formula
      net/mlx5e: Update xon formula

Ivan Vecera (1):
      ixgbe: fix mdio bus registration

Jacob Keller (1):
      i40e: fix i40e_ptp_adjtime when given a negative delta

Jakub Kicinski (3):
      nfp: validate the return code from dev_queue_xmit()
      nfp: disable netpoll on representors
      net: tls: prevent false connection termination with offload

Jesper Dangaard Brouer (2):
      bpf, doc: fix BTF docs reflow of bullet list
      xdp: fix cpumap redirect SKB creation bug

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

Koen De Schepper (1):
      tcp: Ensure DCTCP reacts to losses

Konstantin Khorenko (1):
      bonding: show full hw address in sysfs for slave entries

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Liubin Shu (1):
      net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()

Lorenzo Bianconi (2):
      net: thunderx: fix NULL pointer dereference in nicvf_open/nicvf_stop
      ipv6: sit: reset ip header pointer in ipip6_rcv

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

Nicolas Dichtel (1):
      net/sched: fix ->get helper of the matchall cls

Nikolay Aleksandrov (1):
      net: bridge: always clear mcast matching struct on reports and leaves

Omri Kahalon (1):
      net/mlx5: E-Switch, Fix esw manager vport indication for more vport commands

Paolo Abeni (3):
      net: datagram: fix unbounded loop in __skb_try_recv_datagram()
      net: sched: introduce and use qstats read helpers
      net: sched: introduce and use qdisc tree flush/purge helpers

Paul Chaignon (2):
      bpf: remove incorrect 'verifier bug' warning
      selftests/bpf: test case for invalid call stack in dead code

Pieter Jansen van Vuuren (2):
      nfp: flower: replace CFI with vlan present
      nfp: flower: remove vlan CFI bit from push vlan action

Roi Dayan (2):
      net/mlx5: E-Switch, Fix access to invalid memory when toggling esw modes
      net/mlx5: E-Switch, Protect from invalid memory access in offload fdb table

Sabrina Dubroca (1):
      vrf: prevent adding upper devices

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

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

Stephen Suryaputra (1):
      vrf: check accept_source_route on the original netdevice

Sven Eckelmann (4):
      batman-adv: Reduce claim hash refcnt only for removed entry
      batman-adv: Reduce tt_local hash refcnt only for removed entry
      batman-adv: Reduce tt_global hash refcnt only for removed entry
      batman-adv: Fix genl notification for throughput_override

Thomas Falcon (1):
      ibmvnic: Fix completion structure initialization

Toke Høiland-Jørgensen (2):
      sch_cake: Use tc_skb_protocol() helper for getting packet protocol
      sch_cake: Make sure we can write the IP header before changing DSCP bits

Tonghao Zhang (1):
      net/mlx5e: Correctly use the namespace type when allocating pedit action

Varun Prakash (1):
      libcxgb: fix incorrect ppmax calculation

Vishal Kulkarni (1):
      cxgb4: Update 1.23.3.0 as the latest firmware supported.

Xi Wang (1):
      net: hns3: fix compile error

Xin Long (4):
      tipc: check bearer name with right length in tipc_nl_compat_bearer_enable
      tipc: check link name with right length in tipc_nl_compat_link_set
      tipc: handle the err returned from cmd header function
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yonglong Liu (5):
      net: hns: Use NAPI_POLL_WEIGHT for hns driver
      net: hns: Fix probabilistic memory overwrite when HNS driver initialized
      net: hns: fix ICMP6 neighbor solicitation messages discard problem
      net: hns: Fix WARNING when remove HNS driver with SMMU enabled
      net: hns: Fix sparse: some warnings in HNS drivers

Yue Haibing (1):
      fm10k: Fix a potential NULL pointer dereference

YueHaibing (1):
      dccp: Fix memleak in __feat_register_sp

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

xiaofeis (1):
      net: dsa: Implement flow_dissect callback for tag_qca

 Documentation/bpf/btf.rst                                       |   8 ++---
 Documentation/networking/bpf_flow_dissector.rst                 | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/networking/index.rst                              |   1 +
 MAINTAINERS                                                     |   4 +--
 drivers/net/bonding/bond_sysfs_slave.c                          |   4 ++-
 drivers/net/dsa/mv88e6xxx/port.c                                |  24 ++++++++++-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                |  20 +++++++-----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c              |  30 +++++++++---------
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c              |   9 +++++-
 drivers/net/ethernet/hisilicon/hns/hnae.c                       |   4 ++-
 drivers/net/ethernet/hisilicon/hns/hnae.h                       |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c               |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h               |   4 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c              |  53 ++++++++++++++++++++------------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h              |   2 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c              |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c               |   6 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h               |   4 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c               |   4 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h               |  12 ++++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c             |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                   |  12 +++-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile             |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile             |   2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c                       |  18 +++++------
 drivers/net/ethernet/ibm/ibmvnic.c                              |   5 +--
 drivers/net/ethernet/intel/fm10k/fm10k_main.c                   |   2 ++
 drivers/net/ethernet/intel/i40e/i40e.h                          |  16 ++--------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |  28 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                      |   5 +--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c                      |   3 ++
 drivers/net/ethernet/intel/igb/e1000_defines.h                  |   2 ++
 drivers/net/ethernet/intel/igb/igb_main.c                       |  57 +++++-----------------------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                    |  16 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c               |   3 --
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c        |  39 +++++++++++++-----------
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c             |  13 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c            |  52 ++++++++++++++++++++-----------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                 |  82 ++++++++++++++++++++++++++++++++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c               |   9 +++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c      |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c              |  14 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |  20 ------------
 drivers/net/ethernet/netronome/nfp/flower/action.c              |   3 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h                |   3 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c               |  27 ++++++++---------
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c               |   4 +--
 drivers/net/ethernet/realtek/r8169.c                            |   2 +-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h                 |  22 +++++++++-----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c              |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c            |   2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                  |  22 ++++++++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.h                      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c                 |  12 +++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |  34 ++++++++++++---------
 drivers/net/hyperv/hyperv_net.h                                 |   1 +
 drivers/net/hyperv/netvsc.c                                     |   6 ++--
 drivers/net/hyperv/netvsc_drv.c                                 |  32 ++++++++++++++++----
 drivers/net/usb/qmi_wwan.c                                      |   1 +
 drivers/net/vrf.c                                               |   1 +
 include/linux/mii.h                                             |   2 +-
 include/linux/mlx5/driver.h                                     |   2 ++
 include/net/ip.h                                                |   2 +-
 include/net/net_namespace.h                                     |   1 +
 include/net/netns/hash.h                                        |  10 ++----
 include/net/sch_generic.h                                       |  44 ++++++++++++++++++++++-----
 kernel/bpf/cpumap.c                                             |  13 ++++++--
 kernel/bpf/inode.c                                              |  32 +++++++++++---------
 kernel/bpf/verifier.c                                           |   5 +--
 net/8021q/vlan_dev.c                                            |  26 +++++++++-------
 net/batman-adv/bat_v_elp.c                                      |   6 ++--
 net/batman-adv/bridge_loop_avoidance.c                          |  16 ++++++++--
 net/batman-adv/sysfs.c                                          |   7 +++--
 net/batman-adv/translation-table.c                              |  32 +++++++++++++++-----
 net/bridge/br_multicast.c                                       |   3 ++
 net/core/datagram.c                                             |   2 +-
 net/core/dev.c                                                  |   4 ++-
 net/core/ethtool.c                                              |  46 ++++++++++++++++++----------
 net/core/filter.c                                               |  16 ++--------
 net/core/flow_dissector.c                                       |   4 ++-
 net/core/net_namespace.c                                        |   1 +
 net/core/skbuff.c                                               |   2 +-
 net/dccp/feat.c                                                 |   7 ++++-
 net/dsa/tag_qca.c                                               |  10 ++++++
 net/ipv4/ip_input.c                                             |   7 ++---
 net/ipv4/ip_options.c                                           |   4 +--
 net/ipv4/tcp_dctcp.c                                            |  36 +++++++++++-----------
 net/ipv4/tcp_ipv4.c                                             |   3 +-
 net/ipv6/ila/ila_xlat.c                                         |   1 +
 net/ipv6/ip6_output.c                                           |   4 ++-
 net/ipv6/ip6_tunnel.c                                           |   4 +--
 net/ipv6/sit.c                                                  |   4 +++
 net/kcm/kcmsock.c                                               |  16 +++++-----
 net/openvswitch/flow_netlink.c                                  |   4 +--
 net/rds/tcp.c                                                   |   2 +-
 net/sched/act_sample.c                                          |  10 ++++--
 net/sched/cls_matchall.c                                        |   5 +++
 net/sched/sch_cake.c                                            |  13 +++++++-
 net/sched/sch_cbq.c                                             |  10 +++---
 net/sched/sch_drr.c                                             |  16 +++-------
 net/sched/sch_hfsc.c                                            |  19 +++---------
 net/sched/sch_htb.c                                             |  22 ++++----------
 net/sched/sch_mq.c                                              |   2 +-
 net/sched/sch_mqprio.c                                          |   3 +-
 net/sched/sch_multiq.c                                          |  10 +++---
 net/sched/sch_prio.c                                            |  10 ++----
 net/sched/sch_qfq.c                                             |  14 ++-------
 net/sched/sch_red.c                                             |   3 +-
 net/sched/sch_sfb.c                                             |   3 +-
 net/sched/sch_taprio.c                                          |   2 +-
 net/sched/sch_tbf.c                                             |   3 +-
 net/sctp/protocol.c                                             |   1 +
 net/tipc/netlink_compat.c                                       |  24 ++++++++++++---
 net/tls/tls_sw.c                                                |   2 ++
 tools/lib/bpf/Makefile                                          |   7 +++--
 tools/lib/bpf/btf.c                                             |   3 ++
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c         |  68 +++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c                    |  19 +++++-------
 tools/testing/selftests/bpf/test_btf.c                          |  47 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/calls.c                    |  38 +++++++++++++++++++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/sample.json |  24 +++++++++++++++
 122 files changed, 1096 insertions(+), 563 deletions(-)
 create mode 100644 Documentation/networking/bpf_flow_dissector.rst
