Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C0C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75122073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfDQFQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:16:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:16:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BEFCA14E2064C;
        Tue, 16 Apr 2019 22:16:25 -0700 (PDT)
Date:   Tue, 16 Apr 2019 22:16:25 -0700 (PDT)
Message-Id: <20190416.221625.898048119534445238.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Apr 2019 22:16:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Handle init flow failures properly in iwlwifi driver, from Shahar S
   Matityahu.

2) mac80211 TXQs need to be unscheduled on powersave start, from
   Felix Fietkau.

3) SKB memory accounting fix in A-MDSU aggregation, from Felix
   Fietkau.

4) Increase RCU lock hold time in mlx5 FPGA code, from Saeed Mahameed.

5) Avoid checksum complete with XDP in mlx5, also from Saeed.

6) Fix netdev feature clobbering in ibmvnic driver, from Thomas
   Falcon.

7) Partial sent TLS record leak fix from Jakub Kicinski.

8) Reject zero size iova range in vhost, from Jason Wang.

9) Allow pending work to complete before clcsock release from
   Karsten Graul.

10) Fix XDP handling max MTU in thunderx, from Matteo Croce.

11) A lot of protocols look at the sa_family field of a sockaddr
    before validating it's length is large enough, from Tetsuo Handa.

12) Don't write to free'd pointer in qede ptp error path, from Colin
    Ian King.

13) Have to recompile IP options in ipv4_link_failure because it can
    be invoked from ARP, from Stephen Suryaputra.

14) Doorbell handling fixes in qed from Denis Bolotin.

15) Revert net-sysfs kobject register leak fix, it causes new
    problems.  From Wang Hai.

16) Spectre v1 fix in ATM code, from Gustavo A. R. Silva.

17) Fix put of BROPT_VLAN_STATS_PER_PORT in bridging code, from
    Nikolay Aleksandrov.

Please pull, thanks a lot!

The following changes since commit 869e3305f23dfeacdaa234717c92ccb237815d90:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-04-08 17:10:46 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to e6986423d28362aafe64d3757bbbc493f2687f8f:

  socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW (2019-04-16 21:52:22 -0700)

----------------------------------------------------------------
Alexander Wetzel (1):
      mac80211: Honor SW_CRYPTO_CONTROL for unicast keys in AP VLAN mode

Andrei Otcheretianski (1):
      mac80211: Increase MAX_MSG_LEN

Andy Duan (1):
      net: fec: manage ahb clock in runtime pm

Ard Biesheuvel (1):
      net/core: work around section mismatch warning for ptp_classifier

Arnd Bergmann (1):
      socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW

Claudiu Manoil (2):
      ocelot: Don't sleep in atomic context (irqs_disabled())
      ocelot: Clean up stats update deferred work

Colin Ian King (4):
      vxge: fix return of a free'd memblock on a failed dma mapping
      qede: fix write to free'd pointer error and double free of ptp
      bnx2x: fix spelling mistake "dicline" -> "decline"
      qed: fix spelling mistake "faspath" -> "fastpath"

David Ahern (1):
      selftests: fib_tests: Fix 'Command line is not complete' errors

David Howells (1):
      rxrpc: Trace received connection aborts

David S. Miller (10):
      Merge tag 'mac80211-for-davem-2019-04-09' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'mlxsw-Various-fixes'
      Merge branch 'ibmvnic-features'
      Merge branch 'tls-leaks'
      Merge branch 'smc-fixes'
      Merge branch 'thunderx-xdp-mtu'
      Merge branch 'rxrpc-fixes'
      Merge branch 'qed-doorbell-overflow-recovery'
      Merge tag 'mlx5-fixes-2019-04-09' of git://git.kernel.org/.../saeed/linux
      Merge tag 'wireless-drivers-for-davem-2019-04-15' of git://git.kernel.org/.../kvalo/wireless-drivers

Denis Bolotin (4):
      qed: Delete redundant doorbell recovery types
      qed: Fix the doorbell address sanity check
      qed: Fix missing DORQ attentions
      qed: Fix the DORQ's attentions handling

Dmytro Linkin (1):
      net/mlx5e: Protect against non-uplink representor for encap

Eran Ben Elisha (2):
      net/mlx5e: Skip un-needed tx recover if interface state is down
      net/mlx5e: Use fail-safe channels reopen in tx reporter recover

Eric Dumazet (4):
      dctcp: more accurate tracking of packets delivery
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()
      rtnetlink: fix rtnl_valid_stats_req() nlmsg_len check
      tcp: tcp_grow_window() needs to respect tcp_space()

Felix Fietkau (9):
      mac80211: un-schedule TXQs on powersave start
      mac80211: fix unaligned access in mesh table hash function
      mac80211: fix memory accounting with A-MSDU aggregation
      mac80211: do not call driver wake_tx_queue op during reconfig
      mac80211: rework locking for txq scheduling / airtime fairness
      mac80211: make ieee80211_schedule_txq schedule empty TXQs
      mt76: mt7603: add missing initialization for dev->ps_lock
      mt76: mt7603: fix sequence number assignment
      mt76: mt7603: send BAR after powersave wakeup

Gustavo A. R. Silva (1):
      net: atm: Fix potential Spectre v1 vulnerabilities

Hangbin Liu (1):
      team: set slave to promisc if team is already in promisc mode

Hoang Le (1):
      tipc: missing entries in name table of publications

Ido Schimmel (7):
      mlxsw: spectrum_switchdev: Add MDB entries in prepare phase
      mlxsw: core: Do not use WQ_MEM_RECLAIM for EMAD workqueue
      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw ordered workqueue
      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw workqueue
      mlxsw: spectrum_router: Do not check VRF MAC address
      selftests: mlxsw: Test VRF MAC vetoing
      mlxsw: spectrum_buffers: Add a multicast pool for Spectrum-2

Ihab Zhaika (2):
      iwlwifi: rename structs to fit the new names
      iwlwifi: add new 0x2723/0x2080 card for 22000

Ilan Peer (1):
      cfg80211: Handle WMM rules in regulatory domain intersection

Jakub Kicinski (5):
      net/tls: fix the IV leaks
      net/tls: don't leak partially sent record in device mode
      net: strparser: partially revert "strparser: Call skb_unclone conditionally"
      net/tls: fix build without CONFIG_TLS_DEVICE
      net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()

Jason Wang (1):
      vhost: reject zero size iova range

Jeffrey Altman (1):
      rxrpc: Fix detection of out of order acks

Jie Liu (1):
      tipc: set sysctl_tipc_rmem and named_timeout right range

Johannes Berg (4):
      iwlwifi: mvm: fix TX crypto on 22560+ devices
      iwlwifi: mvm: avoid possible deadlock in TX path
      iwlwifi: mvm: update offloaded rate control on changes
      mac80211_hwsim: calculate if_combination.max_interfaces

Jonathan Lemon (1):
      route: Avoid crash from dereferencing NULL rt->from

Kalle Valo (2):
      Merge tag 'iwlwifi-for-kalle-2019-03-22' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes
      Merge tag 'iwlwifi-for-kalle-2019-04-03' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes

Kangjie Lu (1):
      net/smc: fix a NULL pointer dereference

Karsten Graul (2):
      net/smc: wait for pending work before clcsock release_sock
      net/smc: fix return code from FLUSH command

Konstantin Khlebnikov (1):
      net/mlx5e: Switch to Toeplitz RSS hash by default

Lorenzo Bianconi (1):
      net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv

Luca Coelho (1):
      iwlwifi: add support for quz firmwares

Lukas Bulwahn (1):
      MAINTAINERS: normalize Woojung Huh's email address

Marc Dionne (4):
      rxrpc: Clear socket error
      rxrpc: Make rxrpc_kernel_check_life() indicate if call completed
      rxrpc: Allow errors to be returned from rxrpc_queue_packet()
      afs: Check for rxrpc call completion in wait loop

Matteo Croce (2):
      net: thunderx: raise XDP MTU to 1508
      net: thunderx: don't allow jumbo frames with XDP

Nathan Chancellor (1):
      cfg80211: Change an 'else if' into an 'else' in cfg80211_calculate_bitrate_he

Nikolay Aleksandrov (3):
      net: bridge: multicast: use rcu to access port list from br_multicast_start_querier
      net: bridge: fix per-port af_packet sockets
      net: bridge: fix netlink export of vlan_stats_per_port option

Or Gerlitz (1):
      Revert "net/mlx5e: Enable reporting checksum unnecessary also for L3 packets"

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Saeed Mahameed (5):
      net/mlx5: FPGA, tls, hold rcu read lock a bit longer
      net/mlx5: FPGA, tls, idr remove on flow delete
      net/mlx5e: XDP, Avoid checksum complete when XDP prog is loaded
      net/mlx5e: Rx, Fixup skb checksum for packets with tail padding
      net/mlx5e: Rx, Check ip headers sanity

Shahar S Matityahu (4):
      iwlwifi: add sync_nmi to trans ops
      iwlwifi: dbg_ini: in case of region dump failure set memory to 0
      iwlwifi: dbg_ini: fix bad dump size calculation
      iwlwifi: use sync nmi in case of init flow failure

Si-Wei Liu (1):
      failover: allow name change on IFF_UP slave interfaces

Stanislaw Gruszka (2):
      cfg80211: add ratelimited variants of err and warn
      mt76x02: avoid status_list.lock and sta->rate_ctrl_lock dependency

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Sunil Dutt (1):
      nl80211: Add NL80211_FLAG_CLEAR_SKB flag for other NL commands

Tetsuo Handa (9):
      net/rds: Check address length before reading address family
      mISDN: Check address length before reading address family
      sctp: Check address length before reading address family
      net: netlink: Check address length before reading groups field
      rxrpc: Check address length before reading srx_service field
      Bluetooth: Check address length before reading address field
      llc: Check address length before reading address field
      bpf: Check address length before reading address family
      udpv6: Check address length before reading address family

Thomas Falcon (2):
      ibmvnic: Enable GRO
      ibmvnic: Fix netdev feature clobbering during a reset

Tuong Lien (1):
      tipc: fix link established but not in session

Ursula Braun (2):
      net/smc: propagate file from SMC to TCP socket
      net/smc: move unhash before release of clcsock

Vijayakumar Durai (1):
      rt2x00: do not increment sequence number while re-transmitting

Wang Hai (1):
      Revert "net-sysfs: Fix memory leak in netdev_register_kobject"

YueHaibing (2):
      cfg80211: Use kmemdup in cfg80211_gen_new_ie()
      net: netrom: Fix error cleanup path of nr_proto_init

Yuya Kusakabe (1):
      net: Fix missing meta data in skb with vlan packet

 Documentation/networking/rxrpc.txt                       | 16 ++++++++-------
 MAINTAINERS                                              |  2 +-
 drivers/isdn/mISDN/socket.c                              |  4 ++--
 drivers/net/bonding/bond_main.c                          |  6 +++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c         |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c         | 22 ++++++++++++++++++--
 drivers/net/ethernet/freescale/fec_main.c                | 30 +++++++++++++++++++--------
 drivers/net/ethernet/ibm/ibmvnic.c                       | 32 ++++++++++++++++++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en.h             |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 11 +++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c      |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c     |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 21 ++++++++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c       |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h       |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c       | 61 ++++++++++++++++++++++--------------------------------
 drivers/net/ethernet/mellanox/mlxsw/core.c               |  6 +++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c   | 19 +++++++++--------
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |  2 +-
 drivers/net/ethernet/mscc/ocelot.c                       | 24 ++++++++++++++--------
 drivers/net/ethernet/neterion/vxge/vxge-config.c         |  1 +
 drivers/net/ethernet/qlogic/qed/qed.h                    |  7 +++++--
 drivers/net/ethernet/qlogic/qed/qed_dev.c                | 85 +++++++++++++++++++++++++++++++---------------------------------------------
 drivers/net/ethernet/qlogic/qed/qed_int.c                | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/net/ethernet/qlogic/qed/qed_int.h                |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed_main.c               |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c              |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c              |  7 +++----
 drivers/net/team/team.c                                  | 26 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/htt_rx.c                 |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c                    |  4 ++--
 drivers/net/wireless/ath/ath9k/xmit.c                    |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           | 30 +++++++++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 34 ++++++++-----------------------
 drivers/net/wireless/intel/iwlwifi/fw/init.c             |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h             |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           | 12 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        | 71 ++++++++++++++++++++-------------------------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c             | 43 ++++----------------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h             |  7 ++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            | 13 ++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 11 +++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c             |  2 +-
 drivers/net/wireless/mac80211_hwsim.c                    | 19 +++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7603/init.c         |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c          | 53 +++++++++++++----------------------------------
 drivers/net/wireless/mediatek/mt76/mt7603/main.c         |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h       |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c         | 14 +++++++------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h              |  1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c           | 10 ---------
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c         | 15 ++++++++------
 drivers/vhost/vhost.c                                    |  6 +++++-
 fs/afs/rxrpc.c                                           | 24 +++++++++++++++-------
 include/linux/netdevice.h                                |  3 +++
 include/net/af_rxrpc.h                                   |  4 +++-
 include/net/cfg80211.h                                   |  5 +++++
 include/net/mac80211.h                                   | 63 ++++++++++++++++++++++++++++++--------------------------
 include/net/netrom.h                                     |  2 +-
 include/net/sock.h                                       |  6 ------
 include/net/tls.h                                        |  4 +++-
 net/atm/lec.c                                            |  6 +++++-
 net/bluetooth/sco.c                                      |  4 ++--
 net/bridge/br_input.c                                    | 23 +++++++++++++--------
 net/bridge/br_multicast.c                                |  4 +++-
 net/bridge/br_netlink.c                                  |  2 +-
 net/core/dev.c                                           | 16 ++++++++++++++-
 net/core/failover.c                                      |  6 +++---
 net/core/filter.c                                        |  2 ++
 net/core/net-sysfs.c                                     | 14 +++++--------
 net/core/ptp_classifier.c                                |  7 ++++---
 net/core/rtnetlink.c                                     |  2 +-
 net/core/skbuff.c                                        | 10 ++++++++-
 net/core/sock.c                                          |  4 ++--
 net/ipv4/fou.c                                           |  4 +++-
 net/ipv4/route.c                                         | 16 ++++++++++++++-
 net/ipv4/tcp_dctcp.c                                     | 45 ++++++++++++++++------------------------
 net/ipv4/tcp_input.c                                     | 10 ++++-----
 net/ipv6/route.c                                         |  4 ++++
 net/ipv6/udp.c                                           |  2 ++
 net/llc/af_llc.c                                         |  3 +--
 net/mac80211/driver-ops.h                                |  3 +++
 net/mac80211/key.c                                       |  9 ++++----
 net/mac80211/mesh_pathtbl.c                              |  2 +-
 net/mac80211/rx.c                                        | 10 ++++++++-
 net/mac80211/trace_msg.h                                 |  7 ++++++-
 net/mac80211/tx.c                                        | 53 +++++++++++++++++++++--------------------------
 net/netlink/af_netlink.c                                 |  3 ++-
 net/netrom/af_netrom.c                                   | 76 ++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 net/netrom/nr_loopback.c                                 |  2 +-
 net/netrom/nr_route.c                                    |  2 +-
 net/netrom/sysctl_net_netrom.c                           |  5 ++++-
 net/rds/af_rds.c                                         |  3 +++
 net/rds/bind.c                                           |  2 ++
 net/rxrpc/af_rxrpc.c                                     | 17 ++++++++++------
 net/rxrpc/ar-internal.h                                  |  1 +
 net/rxrpc/conn_event.c                                   | 11 ++++++----
 net/rxrpc/input.c                                        | 18 ++++++++++------
 net/rxrpc/peer_event.c                                   |  5 +++++
 net/rxrpc/sendmsg.c                                      | 21 +++++++++++--------
 net/sctp/socket.c                                        |  3 ++-
 net/smc/af_smc.c                                         | 58 +++++++++++++++++++++++++++++++++++-----------------
 net/smc/smc_close.c                                      | 25 +++++++++++++++++++----
 net/smc/smc_close.h                                      |  1 +
 net/smc/smc_ism.c                                        |  5 +++++
 net/smc/smc_pnet.c                                       |  3 ++-
 net/strparser/strparser.c                                | 12 +++++------
 net/tipc/link.c                                          |  2 ++
 net/tipc/name_table.c                                    |  3 ++-
 net/tipc/sysctl.c                                        |  8 ++++++--
 net/tls/tls_device.c                                     | 12 ++++++++++-
 net/tls/tls_main.c                                       | 24 ++++++++++++++++++++++
 net/tls/tls_sw.c                                         | 15 +-------------
 net/wireless/nl80211.c                                   | 18 ++++++++++------
 net/wireless/reg.c                                       | 39 +++++++++++++++++++++++++++++++++++
 net/wireless/scan.c                                      |  3 +--
 net/wireless/util.c                                      |  6 ++++--
 tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh   | 20 ++++++++++++++++++
 tools/testing/selftests/net/fib_tests.sh                 | 94 ++++++++++++++++++++++++++++++++++++------------------------------------------------
 125 files changed, 1118 insertions(+), 741 deletions(-)
