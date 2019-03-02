Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC76520836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCBJIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:08:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfCBJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:08:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12FB8145183B4;
        Sat,  2 Mar 2019 01:08:24 -0800 (PST)
Date:   Sat, 02 Mar 2019 01:08:23 -0800 (PST)
Message-Id: <20190302.010823.290132881497291675.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 02 Mar 2019 01:08:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix refcount leak in act_ipt during replace, from Davide Caratti.

2) Set task state properly in tun during blocking reads, from Timur
   Celik.

3) Leaked reference in DSA, from Wen Yang.

4) NULL deref in act_tunnel_key, from Vlad Buslov.

5) cipso_v4_erro can reference the skb IPCB in inappropriate contexts
   thus referencing garbage, from Nazarov Sergey.

6) Don't accept RTA_VIA and RTA_GATEWAY in contexts where those
   attributes make no sense.

7) Fix hung sendto in tipc, from Tung Nguyen.

8) Out-of-bounds access in netlabel, from Paul Moore.

9) Grant reference leak in xen-netback, from Igor Druzhinin.

10) Fix tx stalls with lan743x, from Bryan Whitehead.

11) Fix interrupt storm with mv88e6xxx, from Hein Kallweit.

12) Memory leak in sit on device registry failure, from Mao Wenan.

Please pull, thanks a lot!

The following changes since commit c3619a482e15d98e1d2eb6b32952e753077e7545:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2019-02-24 09:47:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 07f12b26e21ab359261bf75cfcb424fdc7daeb6d:

  net: sit: fix memory leak in sit_init_net() (2019-03-02 00:53:23 -0800)

----------------------------------------------------------------
Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix u64 statistics
      net: dsa: mv88e6xxx: Fix statistics on mv88e6161

Andy Shevchenko (2):
      net: dev: Use unsigned integer as an argument to left-shift
      enc28j60: Correct description of debug module parameter

Bryan Whitehead (1):
      lan743x: Fix TX Stall Issue

Daniel Borkmann (1):
      bpf: fix sanitation rewrite in case of non-pointers

David Ahern (4):
      ipv4: Return error for RTA_VIA attribute
      ipv6: Return error for RTA_VIA attribute
      mpls: Return error for RTA_GATEWAY attribute
      ipv4: Pass original device to ip_rcv_finish_core

David S. Miller (3):
      Merge branch 'net-fail-route'
      Merge branch 'pmtu-selftest-fixes'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (2):
      net/sched: act_ipt: fix refcount leak when replace fails
      net/sched: act_skbedit: fix refcount leak when replace fails

Dmitry Bogdanov (1):
      net: aquantia: regression on cpus with high cores: set mode with 8 queues

Eric Biggers (1):
      net: socket: set sock->sk to NULL after calling proto_ops::release()

Haiyang Zhang (1):
      hv_netvsc: Fix IP header checksum for coalesced packets

Hangbin Liu (1):
      ipv4: Add ICMPv6 support when parse route ipproto

Hauke Mehrtens (1):
      net: dsa: lantiq: Add GPHY firmware files

Heiner Kallweit (2):
      net: phy: phylink: fix uninitialized variable in phylink_get_mac_state
      net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode

Igor Druzhinin (2):
      xen-netback: fix occasional leak of grant ref mappings under memory pressure
      xen-netback: don't populate the hash cache on XenBus disconnect

Jiri Benc (1):
      geneve: correctly handle ipv6.disable module parameter

Mao Wenan (1):
      net: sit: fix memory leak in sit_init_net()

Matthias Maennich (1):
      sctp: chunk.c: correct format string for size_t in printk

Max Uvarov (1):
      net: phy: dp83867: add soft reset delay

Maxime Chevallier (1):
      net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X

Michael Chan (1):
      bnxt_en: Drop oversize TX packets to prevent errors.

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

Paolo Abeni (3):
      selftests: pmtu: disable DAD in all namespaces
      selftests: pmtu: add explicit tests for PMTU exceptions cleanup
      selftests: fixes for UDP GRO

Paul Burton (1):
      MIPS: eBPF: Fix icache flush end address

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Peng Sun (2):
      bpf: decrease usercnt if bpf_map_new_fd() fails in bpf_map_get_fd_by_id()
      bpf: drop refcount if bpf_map_new_fd() fails in map_create()

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Sheng Lan (1):
      net: netem: fix skb length BUG_ON in __skb_to_sgvec

Timur Celik (2):
      tun: fix blocking read
      tun: remove unnecessary memory barrier

Tung Nguyen (1):
      tipc: fix race condition causing hung sendto

Vlad Buslov (1):
      net: sched: act_tunnel_key: fix NULL pointer dereference during init

Wen Yang (1):
      net: dsa: fix a leaked reference by adding missing of_node_put

YueHaibing (1):
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails

 arch/mips/net/ebpf_jit.c                                            |  2 +-
 drivers/net/dsa/lantiq_gswip.c                                      |  6 +++++
 drivers/net/dsa/mv88e6xxx/chip.c                                    | 14 +++++++++--
 drivers/net/dsa/mv88e6xxx/port.c                                    |  8 +++++--
 drivers/net/dsa/mv88e6xxx/port.h                                    |  1 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c           |  3 +++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c          |  9 +++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h          |  4 ++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h | 13 +++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |  6 +++++
 drivers/net/ethernet/microchip/enc28j60.c                           |  2 +-
 drivers/net/ethernet/microchip/lan743x_main.c                       | 16 +++++++++----
 drivers/net/geneve.c                                                | 11 ++++++---
 drivers/net/hyperv/netvsc_drv.c                                     | 22 ++++++++++++++---
 drivers/net/phy/dp83867.c                                           |  3 +++
 drivers/net/phy/micrel.c                                            | 13 ++++++++++-
 drivers/net/phy/phylink.c                                           |  4 ++++
 drivers/net/tun.c                                                   |  4 ++--
 drivers/net/xen-netback/hash.c                                      |  2 ++
 drivers/net/xen-netback/interface.c                                 |  7 ++++++
 drivers/net/xen-netback/netback.c                                   | 10 ++++----
 include/linux/netdevice.h                                           |  2 +-
 include/net/icmp.h                                                  |  9 ++++++-
 include/net/ip.h                                                    |  4 +++-
 kernel/bpf/syscall.c                                                |  6 ++---
 kernel/bpf/verifier.c                                               |  3 ++-
 net/dsa/dsa2.c                                                      | 16 ++++++++-----
 net/dsa/port.c                                                      |  1 +
 net/ipv4/cipso_ipv4.c                                               | 20 +++++++++++++---
 net/ipv4/fib_frontend.c                                             |  4 ++++
 net/ipv4/icmp.c                                                     |  7 +++---
 net/ipv4/ip_input.c                                                 |  9 +++----
 net/ipv4/ip_options.c                                               | 22 +++++++++++++----
 net/ipv4/netlink.c                                                  | 17 ++++++++++----
 net/ipv4/route.c                                                    |  2 +-
 net/ipv6/route.c                                                    |  7 +++++-
 net/ipv6/sit.c                                                      |  1 +
 net/mpls/af_mpls.c                                                  |  3 +++
 net/netlabel/netlabel_kapi.c                                        |  3 ++-
 net/nfc/llcp_commands.c                                             | 20 ++++++++++++++++
 net/nfc/llcp_core.c                                                 | 24 +++++++++++++++----
 net/sched/act_ipt.c                                                 |  3 +--
 net/sched/act_skbedit.c                                             |  3 +--
 net/sched/act_tunnel_key.c                                          |  3 ++-
 net/sched/sch_netem.c                                               | 10 +++++---
 net/sctp/chunk.c                                                    |  2 +-
 net/socket.c                                                        |  1 +
 net/tipc/socket.c                                                   |  6 ++++-
 tools/testing/selftests/net/pmtu.sh                                 | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 tools/testing/selftests/net/udpgro.sh                               |  8 +++----
 tools/testing/selftests/net/udpgso_bench_rx.c                       | 42 ++++++++++++++++++++++-----------
 51 files changed, 408 insertions(+), 106 deletions(-)
