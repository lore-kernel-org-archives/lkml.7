Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA5321019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCNBII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:08:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCNBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:08:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B56A14D44B2E;
        Wed, 13 Mar 2019 18:08:06 -0700 (PDT)
Date:   Wed, 13 Mar 2019 18:08:04 -0700 (PDT)
Message-Id: <20190313.180804.1057329630088536833.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Mar 2019 18:08:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


More fixes in the queue:

1) Netfilter nat can erroneously register the device notifier twice, fix
   from Florian Westphal.

2) Use after free in nf_tables, from Pablo Neira Ayuso.

3) Parallel update of steering rule fix in mlx5 river, from Eli
   Britstein.

4) RX processing panic in lan743x, fix from Bryan Whitehead.

5) Use before initialization of TCP_SKB_CB, fix from Christoph Paasch.

6) Fix locking in SRIOV mode of mlx4 driver, from Jack Morgenstein.

7) Fix TX stalls in lan743x due to mis handling of interrupt ACKing
   modes, from Bryan Whitehead.

8) Fix infoleak  in l2tp_ip6_recvmsg(), from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 2a5ff07a0eb945f291e361aa6f6becca8340ba46:

  gro_cells: make sure device is up in gro_cells_receive() (2019-03-10 11:07:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 9417d81f4f8adfe20a12dd1fadf73a618cbd945d:

  pptp: dst_release sk_dst_cache in pptp_sock_destruct (2019-03-13 14:22:49 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      y2038: fix socket.h header inclusion

Bryan Whitehead (2):
      lan743x: Fix RX Kernel Panic
      lan743x: Fix TX Stall Issue

Christoph Paasch (1):
      tcp: Don't access TCP_SKB_CB before initializing it

David S. Miller (4):
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mlx5-fixes-2019-03-11' of git://git.kernel.org/.../saeed/linux
      Merge branch 'mlxsw-Various-fixes'
      Merge branch 'mlx4-fixes'

Eli Britstein (4):
      net/mlx5: Fix multiple updates of steering rules in parallel
      net/mlx5: Add modify FTE helper function
      net/mlx5: Add a locked flag to node removal functions
      net/mlx5: Consolidate update FTE for all removal changes

Eric Dumazet (2):
      net/x25: reset state in x25_connect()
      l2tp: fix infoleak in l2tp_ip6_recvmsg()

Feras Daoud (1):
      net/mlx5e: IPoIB, Fix RX checksum statistics update

Florian Fainelli (1):
      MAINTAINERS: GENET & SYSTEMPORT: Add internal Broadcom list

Florian Westphal (2):
      netfilter: nat: don't register device notifier twice
      netfilter: nf_tables: return immediately on empty commit

Jack Morgenstein (3):
      net/mlx4_core: Fix reset flow when in command polling mode
      net/mlx4_core: Fix locking in SRIOV mode when switching between events and polling
      net/mlx4_core: Fix qp mtt size calculation

Jiri Pirko (1):
      mlxsw: minimal: Initialize base_mac

Kangjie Lu (11):
      net: liquidio: fix a NULL pointer dereference
      net: lio_core: fix two NULL pointer dereferences
      net: thunder: fix a potential NULL pointer dereference
      net: qlge: fix a potential NULL pointer dereference
      net: rocker: fix a potential NULL pointer dereference
      isdn: hfcpci: fix potential NULL pointer dereference
      net: qlogic: fix a potential NULL pointer dereference
      net: fujitsu: fix a potential NULL pointer dereference
      net: 8390: fix potential NULL pointer dereferences
      net: sh_eth: fix a missing check of of_get_phy_mode
      net: dwmac-sun8i: fix a missing check of of_get_phy_mode

Miaohe Lin (1):
      net: sit: fix UBSAN Undefined behaviour in check_6rd

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix set double-free in abort path
      netfilter: nf_tables: bogus EBUSY when deleting set after flush
      netfilter: nf_tables: use-after-free in dynamic operations

Roi Dayan (2):
      net/mlx5e: Properly get the PF number phys port name ndo
      net/mlx5: Remove redundant lag function to get pf num

Tariq Toukan (1):
      net/mlx5e: Fix access to non-existing receive queue

Tonghao Zhang (2):
      net/mlx5: Avoid panic when setting vport mac, getting vport config
      net/mlx5: Avoid panic when setting vport rate

Vadim Pasternak (1):
      mlxsw: core: Prevent duplication during QSFP module initialization

Vakul Garg (1):
      net/tls: Inform user space about send buffer availability

Xin Long (1):
      pptp: dst_release sk_dst_cache in pptp_sock_destruct

Zhike Wang (1):
      net_sched: return correct value for *notify* functions

xiaofeis (1):
      Documentation: devicetree: add a new optional property for port mac address

 Documentation/devicetree/bindings/net/dsa/dsa.txt     |   5 +++
 MAINTAINERS                                           |   2 +
 arch/alpha/include/uapi/asm/socket.h                  |   2 +-
 arch/mips/include/uapi/asm/socket.h                   |   2 +-
 arch/parisc/include/uapi/asm/socket.h                 |   2 +-
 arch/sparc/include/uapi/asm/socket.h                  |   2 +-
 drivers/isdn/hardware/mISDN/hfcpci.c                  |   9 +++++
 drivers/net/ethernet/8390/pcnet_cs.c                  |  10 +++++
 drivers/net/ethernet/cavium/liquidio/lio_core.c       |  10 +++++
 drivers/net/ethernet/cavium/liquidio/lio_main.c       |   5 +++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c      |   6 +++
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c             |   5 +++
 drivers/net/ethernet/mellanox/mlx4/cmd.c              |   9 +++++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |   6 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c  |   3 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c      |  13 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c       |  11 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c     |  17 ++++++---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c     | 161 +++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h     |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag.c         |  21 -----------
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 -
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c    |  21 ++++++-----
 drivers/net/ethernet/mellanox/mlxsw/minimal.c         |  18 +++++++++
 drivers/net/ethernet/microchip/lan743x_main.c         |  55 +++++++++++++++++-----------
 drivers/net/ethernet/qlogic/qla3xxx.c                 |   6 +++
 drivers/net/ethernet/qlogic/qlge/qlge_main.c          |   5 +++
 drivers/net/ethernet/renesas/sh_eth.c                 |   6 ++-
 drivers/net/ethernet/rocker/rocker_main.c             |   5 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     |   5 ++-
 drivers/net/ppp/pptp.c                                |   1 +
 include/net/netfilter/nf_tables.h                     |  12 ++++--
 include/uapi/asm-generic/socket.h                     |   2 +-
 net/ipv4/tcp_ipv4.c                                   |   9 +----
 net/ipv6/sit.c                                        |   5 ++-
 net/l2tp/l2tp_ip6.c                                   |   4 +-
 net/netfilter/nf_nat_masquerade.c                     |  35 ++++++++++--------
 net/netfilter/nf_tables_api.c                         |  54 +++++++++++++++++++++++----
 net/netfilter/nft_dynset.c                            |  13 +++++--
 net/netfilter/nft_lookup.c                            |  13 +++++--
 net/netfilter/nft_objref.c                            |  13 +++++--
 net/sched/cls_api.c                                   |  32 +++++++++++-----
 net/sched/sch_api.c                                   |  15 ++++++--
 net/tls/tls_device.c                                  |   3 --
 net/tls/tls_main.c                                    |   3 +-
 net/x25/af_x25.c                                      |   1 +
 46 files changed, 427 insertions(+), 213 deletions(-)
