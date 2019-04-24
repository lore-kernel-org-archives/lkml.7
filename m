Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095EB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfDXWLc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:11:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDXWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:11:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8C7CB14A78E32;
        Wed, 24 Apr 2019 15:11:31 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:11:29 -0700 (PDT)
Message-Id: <20190424.151129.189814637915490695.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Apr 2019 15:11:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just the usual assortment of small'ish fixes:

1) Conntrack timeout is sometimes not initialized properly, from
   Alexander Potapenko.

2) Add a reasonable range limit to tcp_min_rtt_wlen to avoid undefined
   behavior.  From ZhangXiaoxu.

3) des1 field of descriptor in stmmac driver is initialized with the
   wrong variable.  From Yue Haibing.

4) Increase mlxsw pci sw reset timeout a little bit more, from Ido
   Schimmel.

5) Match IOT2000 stmmac devices more accurately, from Su Bao Cheng.

6) Fallback refcount fix in TLS code, from Jakub Kicinski.

7) Fix max MTU check when using XDP in mlx5, from Maxim Mikityanskiy.

8) Fix recursive locking in team driver, from Hangbin Liu.

9) Fix tls_set_device_offload_Rx() deadlock, from Jakub Kicinski.

10) Don't use napi_alloc_frag() outside of softiq context of socionext
    driver, from Ilias Apalodimas.

11) MAC address increment overflow in ncsi, from Tao Ren.

12) Fix a regression in 8K/1M pool switching of RDS, from Zhu Yanjun.

13) ipv4_link_failure has to validate the headers that are actually
    there because RAW sockets can pass in arbitrary garbage, from Eric
    Dumazet.

Please pull, thanks a lot!

The following changes since commit fe5cdef29e41c8bda8cd1a11545e7c6bfe25570e:

  Merge tag 'for-linus-5.1-2' of git://github.com/cminyard/linux-ipmi (2019-04-17 10:25:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 20ff83f10f113c88d0bb74589389b05250994c16:

  ipv4: add sanity checks in ipv4_link_failure() (2019-04-24 14:40:41 -0700)

----------------------------------------------------------------
Alexander Potapenko (1):
      netfilter: conntrack: initialize ct->timeout

Amit Cohen (1):
      mlxsw: spectrum: Fix autoneg status in ethtool

Andrei Vagin (1):
      netfilter: fix nf_l4proto_log_invalid to log invalid packets

Arnd Bergmann (1):
      s390: ctcm: fix ctcm_new_device error return code

Colin Ian King (4):
      nfp: abm: fix spelling mistake "offseting" -> "offsetting"
      net: ipv6: addrlabel: fix spelling mistake "requewst" -> "request"
      firestream: fix spelling mistake "tramsitted" -> "transmitted"
      net: atheros: fix spelling mistake "underun" -> "underrun"

Corentin Labbe (2):
      dt-bindings: add an explanation for internal phy-mode
      Documentation: decnet: remove reference to CONFIG_DECNET_ROUTE_FWMARK

Dan Carpenter (1):
      netfilter: nf_tables: prevent shift wrap in nft_chain_parse_hook()

Daniel Gomez (2):
      spi: Micrel eth switch: declare missing of table
      spi: ST ST95HF NFC: declare missing of table

David S. Miller (3):
      Merge branch 'mlxsw-Few-small-fixes'
      Merge tag 'mlx5-fixes-2019-04-19' of git://git.kernel.org/.../saeed/linux
      Merge git://git.kernel.org/.../pablo/nf

Erez Alfasi (1):
      net/mlx5e: ethtool, Remove unsupported SFP EEPROM high pages query

Eric Dumazet (3):
      rxrpc: fix race condition in rxrpc_input_packet()
      net/rose: fix unbound loop in rose_loopback_timer()
      ipv4: add sanity checks in ipv4_link_failure()

Florian Westphal (6):
      selftests: netfilter: check icmp pkttoobig errors are set as related
      netfilter: conntrack: don't set related state for different outer address
      netfilter: ctnetlink: don't use conntrack/expect object addresses as id
      netfilter: nat: fix icmp id randomization
      netfilter: ebtables: CONFIG_COMPAT: drop a bogus WARN_ON
      netfilter: never get/set skb->tstamp

Hangbin Liu (1):
      team: fix possible recursive locking when add slaves

Ido Schimmel (1):
      mlxsw: pci: Reincrease PCI reset timeout

Ilias Apalodimas (1):
      net: socionext: replace napi_alloc_frag with the netdev variant on init

Jakub Kicinski (3):
      net/tls: fix refcount adjustment in fallback
      net/tls: avoid potential deadlock in tls_set_device_offload_rx()
      net/tls: don't leak IV and record seq when offload fails

Julian Anastasov (1):
      ipvs: do not schedule icmp errors from tunnels

Maxim Mikityanskiy (2):
      net/mlx5e: Fix use-after-free after xdp_return_frame
      net/mlx5e: Fix the max MTU check in case of XDP

Miaohe Lin (1):
      net: vrf: Fix operation not supported when set vrf mac

Petr Machata (1):
      mlxsw: spectrum: Put MC TCs into DWRR mode

Petr ¦tetiar (1):
      of_net: Fix residues after of_get_nvmem_mac_address removal

Po-Hsu Lin (2):
      selftests/net: correct the return value for run_netsocktests
      selftests/net: correct the return value for run_afpackettests

Su Bao Cheng (1):
      stmmac: pci: Adjust IOT2000 matching

Tao Ren (1):
      net/ncsi: handle overflow when incrementing mac address

Vinod Koul (1):
      net: stmmac: move stmmac_check_ether_addr() to driver probe

YueHaibing (1):
      net: stmmac: Use bfsize1 in ndesc_init_rx_desc

ZhangXiaoxu (1):
      ipv4: set the tcp_min_rtt_wlen range from 0 to one day

Zhu Yanjun (1):
      net: rds: exchange of 8K and 1M pool

 Documentation/devicetree/bindings/net/davinci_emac.txt      |   2 +
 Documentation/devicetree/bindings/net/ethernet.txt          |   5 +-
 Documentation/devicetree/bindings/net/macb.txt              |   4 ++
 Documentation/networking/decnet.txt                         |   2 -
 Documentation/networking/ip-sysctl.txt                      |   1 +
 drivers/atm/firestream.c                                    |   2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c                    |   4 +-
 drivers/net/ethernet/atheros/atlx/atl1.h                    |   2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c                    |   2 +-
 drivers/net/ethernet/atheros/atlx/atl2.h                    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c            |  24 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h            |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c              |   4 --
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h                |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c              |   6 +-
 drivers/net/ethernet/netronome/nfp/abm/cls.c                |   4 +-
 drivers/net/ethernet/socionext/netsec.c                     |  11 ++--
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c             |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c            |   8 ++-
 drivers/net/phy/spi_ks8995.c                                |   9 +++
 drivers/net/team/team.c                                     |   7 ++
 drivers/net/vrf.c                                           |   2 +
 drivers/nfc/st95hf/core.c                                   |   7 ++
 drivers/of/of_net.c                                         |   1 -
 drivers/s390/net/ctcm_main.c                                |   1 +
 include/linux/etherdevice.h                                 |  12 ++++
 include/net/netfilter/nf_conntrack.h                        |   2 +
 include/net/netfilter/nf_conntrack_l4proto.h                |   6 ++
 net/bridge/netfilter/ebtables.c                             |   3 +-
 net/ipv4/route.c                                            |  32 ++++++---
 net/ipv4/sysctl_net_ipv4.c                                  |   5 +-
 net/ipv6/addrlabel.c                                        |   2 +-
 net/ncsi/ncsi-rsp.c                                         |   6 +-
 net/netfilter/ipvs/ip_vs_core.c                             |   2 +-
 net/netfilter/nf_conntrack_core.c                           |  43 +++++++++++--
 net/netfilter/nf_conntrack_netlink.c                        |  34 ++++++++--
 net/netfilter/nf_conntrack_proto.c                          |   2 +-
 net/netfilter/nf_conntrack_proto_icmp.c                     |  93 ++++++++++++++++++++------
 net/netfilter/nf_conntrack_proto_icmpv6.c                   |  52 ++-------------
 net/netfilter/nf_nat_core.c                                 |  11 +++-
 net/netfilter/nf_tables_api.c                               |   2 +-
 net/netfilter/nfnetlink_log.c                               |   2 +-
 net/netfilter/nfnetlink_queue.c                             |   2 +-
 net/netfilter/xt_time.c                                     |  23 ++++---
 net/rds/ib_fmr.c                                            |  11 ++++
 net/rds/ib_rdma.c                                           |   3 -
 net/rose/rose_loopback.c                                    |  27 ++++----
 net/rxrpc/input.c                                           |  12 ++--
 net/rxrpc/local_object.c                                    |   3 +-
 net/tls/tls_device.c                                        |   4 +-
 net/tls/tls_device_fallback.c                               |  13 +++-
 net/tls/tls_main.c                                          |   5 +-
 net/tls/tls_sw.c                                            |   3 +
 tools/testing/selftests/net/run_afpackettests               |   5 ++
 tools/testing/selftests/net/run_netsocktests                |   2 +-
 tools/testing/selftests/netfilter/Makefile                  |   2 +-
 tools/testing/selftests/netfilter/conntrack_icmp_related.sh | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/netfilter/nft_nat.sh                |  36 ++++++++---
 61 files changed, 687 insertions(+), 184 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/conntrack_icmp_related.sh
