Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D1EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C94C206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCJS4p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:56:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:56:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E1C81477F2CD;
        Sun, 10 Mar 2019 11:56:44 -0700 (PDT)
Date:   Sun, 10 Mar 2019 11:56:43 -0700 (PDT)
Message-Id: <20190310.115643.161837775868545540.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 11:56:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


First batch of fixes in the new merge window:

1) Double dst_cache free in act_tunnel_key, from Wenxu.

2) Avoid NULL deref in IN_DEV_MFORWARD() by failing early in
   the ip_route_input_rcu() path, from Paolo Abeni.

3) Fix appletalk compile regression, from Arnd Bergmann.

4) If SLAB objects reach the TCP sendpage method we are in serious
   trouble, so put a debugging check there.  From Vasily Averin.

5) Memory leak in hsr layer, from Mao Wenan.

6) Only test GSO type on GSO packets, from Willem de Bruijn.

7) Fix crash in xsk_diag_put_umem(), from Eric Dumazet.

8) Fix VNIC mailbox length in nfp, from Dirk van der Merwe.

9) Fix race in ipv4 route exception handling, from Xin Long.

10) Missing DMA memory barrier in hns3 driver, from Jian Shen.

11) Use after free in __tcf_chain_put(), from Vlad Buslov.

12) Handle inet_csk_reqsk_queue_add() failures, from Guillaume Nault.

13) Return value correction when ip_mc_may_pull() fails, from Eric
    Dumazet.

14) Use after free in x25_device_event(), also from Eric.

Please pull, thanks a lot!

The following changes since commit d9862cfbe2099deb83f0e9c1932c91f2d9c50464:

  Merge tag 'mips_5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2019-03-05 11:28:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 2a5ff07a0eb945f291e361aa6f6becca8340ba46:

  gro_cells: make sure device is up in gro_cells_receive() (2019-03-10 11:07:14 -0700)

----------------------------------------------------------------
Adalbert Lazãr (1):
      vsock/virtio: fix kernel panic from virtio_transport_reset_no_sock

Alan Maguire (1):
      iptunnel: NULL pointer deref for ip_md_tunnel_xmit

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Set correct interface mode for CPU/DSA ports

Arnd Bergmann (9):
      appletalk: Fix compile regression
      appletalk: Add atalk.h header files to MAINTAINERS file
      bpf: fix sysctl.c warning
      davinci_emac: always build in CONFIG_OF code
      isdn: isdnloop: fix pointer dereference bug
      peak_usb: fix clang build warning
      enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
      ethtool: reduce stack usage with clang
      vhost: silence an unused-variable warning

Björn Töpel (2):
      xsk: fix to reject invalid flags in xsk_bind
      xsk: fix to reject invalid options in Tx descriptor

Bo YU (1):
      bpf: fix warning about using plain integer as NULL

Christophe Roullier (6):
      net: ethernet: stmmac: manage Ethernet WoL for stm32mp157c.
      net: ethernet: stmmac: update to support all PHY config for stm32mp157c.
      dt-bindings: net: stmmac: add phys config properties
      net: ethernet: stmmac: add management of clk_csr property
      dt-bindings: net: stmmac: remove syscfg clock property
      ARM: dts: stm32: Add Ethernet support on stm32h7 SOC and activate it for eval and disco boards

Colin Ian King (1):
      bpf: hbm: fix spelling mistake "deault" -> "default"

Dan Carpenter (1):
      net: hns3: Fix a logical vs bitwise typo

Daniel Borkmann (1):
      bpf: fix replace_map_fd_with_map_ptr's ldimm64 second imm field

David Howells (2):
      rxrpc: Fix client call connect/disconnect race
      rxrpc: Fix client call queueing, waiting for channel

David S. Miller (3):
      Merge branch 'sctp-process-the-error-returned-from-sctp_sock_migrate'
      Merge branch 'stmmac-add-some-fixes-for-stm32'
      Merge git://git.kernel.org/.../bpf/bpf

Dirk van der Merwe (1):
      nfp: fix simple vNIC mailbox length

Eric Dumazet (7):
      xsk: fix potential crash in xsk_diag_put_umem()
      net/hsr: fix possible crash in add_timer()
      fou, fou6: avoid uninit-value in gue_err() and gue6_err()
      ip: fix ip_mc_may_pull() return value
      net/x25: fix use-after-free in x25_device_event()
      vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
      gro_cells: make sure device is up in gro_cells_receive()

Erik Hugne (1):
      tipc: fix RDM/DGRAM connect() regression

Guillaume Nault (2):
      tcp: handle inet_csk_reqsk_queue_add() failures
      net: keep refcount warning in reqsk_free()

Jakub Sitnicki (1):
      bpf: Stop the psock parser before canceling its work

Jian Shen (1):
      net: hns3: add dma_rmb() for rx description

Kangjie Lu (1):
      isdn: mISDNinfineon: fix potential NULL pointer dereference

Li RongQing (1):
      connector: fix unsafe usage of ->real_parent

Litao Jiao (1):
      vxlan: do not need BH again in vxlan_cleanup()

Mao Wenan (1):
      net: hsr: fix memory leak in hsr_dev_finalize()

Masaru Nagai (1):
      ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Matthew Whitehead (1):
      8139too : Add support for U.S. Robotics USR997901A 10/100 Cardbus NIC

Nathan Chancellor (5):
      net: atm: Use IS_ENABLED in atm_dev_ioctl
      net: stmmac: Avoid sometimes uninitialized Clang warnings
      net: atm: Add another IS_ENABLED(CONFIG_COMPAT) in atm_dev_ioctl
      net: ethernet: sun: Zero initialize class in default case in niu_add_ethtool_tcam_entry
      net: stmmac: Avoid one more sometimes uninitialized Clang warning

Nikita V. Shirokov (1):
      bpf, libbpf: fixing leak when kernel does not support btf

Paolo Abeni (1):
      ipv4/route: fail early when inet dev is missing

Pedro Tammela (1):
      net: add missing documentation in linux/skbuff.h

Peter Oskolkov (2):
      net: fix GSO in bpf_lwt_push_ip_encap
      selftests/bpf: test that GSO works in lwt_ip_encap

Shiju Jose (1):
      net: hns3: fix to stop multiple HNS reset due to the AER changes

Soheil Hassas Yeganeh (1):
      tcp: do not report TCP_CM_INQ of 0 for closed connections

Stanislav Fomichev (3):
      selftests: bpf: fix compilation with out-of-tree $(OUTPUT)
      libbpf: force fixdep compilation at the start of the build
      selftests: bpf: test_progs: initialize duration in singal_pending test

Stefano Brivio (1):
      vxlan: Fix GRO cells race condition between receive and link delete

Sudarsana Reddy Kalluru (1):
      qede: Fix internal loopback failure with jumbo mtu configuration

Vasily Averin (1):
      tcp: detecting the misuse of .sendpage for Slab objects

Vlad Buslov (2):
      net: sched: flower: insert new filter to idr after setting its mask
      net: sched: fix potential use-after-free in __tcf_chain_put()

Willem de Bruijn (1):
      bpf: only test gso type on gso packets

Xin Long (5):
      route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a race
      sctp: remove sched init from sctp_stream_init
      sctp: sctp_sock_migrate() returns error if sctp_bind_addr_dup() fails
      sctp: move up sctp_auth_init_hmacs() in sctp_endpoint_init()
      sctp: call sctp_auth_init_hmacs() in sctp_sock_migrate()

wenxu (1):
      net/sched: act_tunnel_key: Fix double free dst_cache

 Documentation/devicetree/bindings/net/stm32-dwmac.txt   |   9 +++----
 MAINTAINERS                                             |   2 ++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi                |  15 +++++++++++
 arch/arm/boot/dts/stm32h743.dtsi                        |  13 +++++++++
 arch/arm/boot/dts/stm32h743i-disco.dts                  |  17 ++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts                   |  17 ++++++++++++
 drivers/connector/cn_proc.c                             |  22 +++++++++++++---
 drivers/isdn/hardware/mISDN/mISDNinfineon.c             |   5 +++-
 drivers/isdn/isdnloop/isdnloop.c                        |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c             |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                        |  11 ++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                        |   3 +++
 drivers/net/dsa/mv88e6xxx/port.c                        |  24 +++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h                        |   4 +++
 drivers/net/ethernet/cisco/enic/enic_main.c             |   6 ++---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         |  10 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c  |   9 +++++--
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h       |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c         |   7 +++--
 drivers/net/ethernet/realtek/8139too.c                  |   1 +
 drivers/net/ethernet/renesas/ravb_main.c                |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c       | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       |   6 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   |   3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c        |   2 +-
 drivers/net/ethernet/sun/niu.c                          |   1 +
 drivers/net/ethernet/ti/davinci_emac.c                  |   4 +--
 drivers/net/vxlan.c                                     |  18 ++++++++++---
 drivers/vhost/vhost.c                                   |   2 +-
 include/linux/atalk.h                                   |  18 ++++++++++---
 include/linux/bpf-cgroup.h                              |   2 +-
 include/linux/igmp.h                                    |   2 +-
 include/linux/skbuff.h                                  |  68 ++++++++++++++++++++++++++++++++++++++++++-----
 include/net/request_sock.h                              |   1 -
 include/trace/events/rxrpc.h                            |   2 ++
 kernel/bpf/verifier.c                                   |  10 +++----
 kernel/sysctl.c                                         |   2 +-
 net/atm/resources.c                                     |  10 +++----
 net/bpf/test_run.c                                      |   2 +-
 net/core/ethtool.c                                      |  16 +++++++-----
 net/core/filter.c                                       |   8 +++---
 net/core/gro_cells.c                                    |  22 +++++++++++++---
 net/core/lwt_bpf.c                                      |   2 ++
 net/core/skmsg.c                                        |   1 +
 net/hsr/hsr_device.c                                    |  18 ++++++-------
 net/hsr/hsr_framereg.c                                  |  12 +++++++++
 net/hsr/hsr_framereg.h                                  |   1 +
 net/ipv4/fou.c                                          |   4 +--
 net/ipv4/ip_tunnel.c                                    |   9 ++++---
 net/ipv4/route.c                                        |  13 ++++++---
 net/ipv4/syncookies.c                                   |   7 ++++-
 net/ipv4/tcp.c                                          |   9 +++++++
 net/ipv4/tcp_input.c                                    |   8 +++++-
 net/ipv6/fou6.c                                         |   4 +--
 net/rxrpc/conn_client.c                                 |  24 ++++++++++++-----
 net/sched/act_tunnel_key.c                              |  22 +++++-----------
 net/sched/cls_api.c                                     |  17 +++++-------
 net/sched/cls_flower.c                                  |  43 +++++++++++++++---------------
 net/sctp/auth.c                                         |   6 -----
 net/sctp/endpointola.c                                  |  18 +++++++------
 net/sctp/socket.c                                       |  44 ++++++++++++++++++++++++-------
 net/sctp/stream.c                                       |   2 --
 net/tipc/socket.c                                       |   2 +-
 net/vmw_vsock/virtio_transport_common.c                 |  22 +++++++++++-----
 net/x25/af_x25.c                                        |   6 ++++-
 net/xdp/xsk.c                                           |   5 +++-
 net/xdp/xsk_diag.c                                      |   4 +--
 net/xdp/xsk_queue.h                                     |   4 +--
 samples/bpf/hbm.c                                       |   4 +--
 tools/lib/bpf/Makefile                                  |   3 ++-
 tools/lib/bpf/libbpf.c                                  |   2 ++
 tools/testing/selftests/bpf/Makefile                    |  33 ++++++++++++++++-------
 tools/testing/selftests/bpf/prog_tests/signal_pending.c |   2 +-
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh        |  54 ++++++++++++++++++++++++++++++++++++--
 tools/testing/selftests/bpf/verifier/ld_imm64.c         |  15 ++++++++++-
 76 files changed, 706 insertions(+), 232 deletions(-)
