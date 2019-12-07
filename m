Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F3C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F308206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HW5o3uSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLGTsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:48:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33338 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:48:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so5127671pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bZqoRmEJX070duKWz+AjjheDp87+bgZ1UU+knFt7L1k=;
        b=HW5o3uSM/L/qOkhQxXx54dA+ziQu8CiOReBZL8D5/rDdvG4rcDS4my+V5on+bsN9L1
         ytXNbL+kUCC50uFonLOLa/DrqKt8/82WwHELuNOFUmIOipPLKSTs9STWyCF8zwOO9cqZ
         cqStwu7nzbkbvkBmITll5C/IjNC73EXapr4zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bZqoRmEJX070duKWz+AjjheDp87+bgZ1UU+knFt7L1k=;
        b=Npsc8/zj/nvmc7RG5z2K49D0h20sTPKbPI2sK/NmCW6RIGHrH7Qr0503uEBI3ymXoX
         yOTvNUBrTzaa2ylbPB9JYAKPH4VxOx6/3ObQ0WKnFLXVqxj4ImIBzT1jhBezYLify3Y6
         Xm7ki45Nw5Ve0X245AtxujR4wiu71iAYyAzIU2cCwU93oY/oSZAN9aYOZX554Pxp8OlC
         DF9b52HdhWJ7H1/lUxgi6HTnJbaex/y2w/LPZW0RQa5ctL73UFjBdh2VXxrW34GgbK3r
         DNOpKyrdkooKlmTxfZbSPf0aezUPyOb5nY1CodB9QTM0jm1Jo6YDDda9VtxQvq4aNFUY
         r/Bg==
X-Gm-Message-State: APjAAAUAcrqI+6q/AjOBKj2RH+nZCqnz6OoOy5p/0u5YyT+744WMO2pQ
        tHDosrE4op11no2xJd8/KGN1tg==
X-Google-Smtp-Source: APXvYqzm+BSaIPHPpFt+b2m+HrgJN2jQGRDeUlr7hHXhqIFC+VR4Fz2iC4Jmp6asAUfVG3R3ARs66g==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr21605184pfb.128.1575748111337;
        Sat, 07 Dec 2019 11:48:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm18997453pgg.25.2019.12.07.11.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 11:48:30 -0800 (PST)
Date:   Sat, 7 Dec 2019 11:48:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [GIT PULL] treewide conversion to sizeof_member() for v5.5-rc1
Message-ID: <201912071144.768E249A4F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this mostly mechanical treewide conversion to the single and
more accurately named sizeof_member() macro for the end of v5.5-rc1. This
replaces 3 macros of the same behavior (FIELD_SIZEOF(), SIZEOF_FIELD(),
and sizeof_field()). The last patch in the series has a script in the
commit log to do the conversion, if you want to compare the results.
(Since v5.4-rc2, there are 4 new users of the old macros, if you care
to refresh the commit.)

I believe the concerns from your feedback on the v5.4 pull request[1]
have been addressed with an Ack from Dave Miller[2], and clarification
of the naming[3]. The series has lived in linux-next for the entire
development cycle and had only 1 trivial conflict[4].

As there are a few new users of the old macros in your tree and in
linux-next (targeting the next merge window), I will clean up those final
users during this coming development cycle and send the final old macro
removal patch[5] at that time.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20191002.132121.402975401040540710.davem@davemloft.net/
[3] https://lore.kernel.org/lkml/20190927065700.GA2215@avx2/
[4] https://lore.kernel.org/lkml/20191106160331.016b2521@canb.auug.org.au/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/sizeof_member/slow-full&id=4aa9c5de448cdb804c83f285d63a93c249ba6fa5

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_member-v5.5-rc1

for you to fetch changes up to ec2f877856e0af3889940e00b160f7f20f8d774f:

  treewide: Use sizeof_member() macro (2019-10-29 15:35:27 -0700)

----------------------------------------------------------------
treewide conversion to new sizeof_member() macro

----------------------------------------------------------------
Pankaj Bharadiya (3):
      MIPS: OCTEON: Replace SIZEOF_FIELD() macro
      linux/stddef.h: Add sizeof_member() macro
      treewide: Use sizeof_member() macro

 Documentation/process/coding-style.rst             |   2 +-
 .../translations/it_IT/process/coding-style.rst    |   2 +-
 .../translations/zh_CN/process/coding-style.rst    |   2 +-
 arch/arc/kernel/unwind.c                           |   6 +-
 arch/arm64/include/asm/processor.h                 |  10 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |   9 +-
 arch/powerpc/net/bpf_jit32.h                       |   4 +-
 arch/powerpc/net/bpf_jit_comp.c                    |  16 +--
 arch/sparc/net/bpf_jit_comp_32.c                   |   8 +-
 arch/x86/kernel/fpu/xstate.c                       |   2 +-
 block/blk-core.c                                   |   4 +-
 crypto/adiantum.c                                  |   4 +-
 crypto/essiv.c                                     |   2 +-
 drivers/firmware/efi/efi.c                         |   2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |   4 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |   2 +-
 drivers/input/keyboard/applespi.c                  |   2 +-
 drivers/md/raid5-ppl.c                             |   2 +-
 drivers/media/platform/omap3isp/isppreview.c       |  24 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   4 +-
 .../net/ethernet/cavium/liquidio/octeon_console.c  |  16 +--
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  10 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   4 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   4 +-
 drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c     |   4 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   4 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/ipsec.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |  10 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c      |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c   |   2 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +-
 .../ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   4 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   6 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |  32 ++---
 drivers/net/fjes/fjes_ethtool.c                    |   2 +-
 drivers/net/geneve.c                               |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |   2 +-
 drivers/net/usb/sierra_net.c                       |   2 +-
 drivers/net/usb/usbnet.c                           |   2 +-
 drivers/net/vxlan.c                                |   4 +-
 drivers/net/wireless/marvell/libertas/debugfs.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/util.h        |   4 +-
 drivers/s390/net/qeth_core_main.c                  |   2 +-
 drivers/s390/net/qeth_core_mpc.h                   |  10 +-
 drivers/scsi/aacraid/aachba.c                      |   4 +-
 drivers/scsi/be2iscsi/be_cmds.h                    |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   6 +-
 drivers/staging/qlge/qlge_ethtool.c                |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |   2 +-
 drivers/usb/atm/usbatm.c                           |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 fs/befs/linuxvfs.c                                 |   2 +-
 fs/crypto/keyring.c                                |   2 +-
 fs/ext2/super.c                                    |   2 +-
 fs/ext4/super.c                                    |   2 +-
 fs/freevxfs/vxfs_super.c                           |   2 +-
 fs/fuse/virtio_fs.c                                |   2 +-
 fs/orangefs/super.c                                |   2 +-
 fs/ufs/super.c                                     |   2 +-
 fs/verity/enable.c                                 |   2 +-
 include/linux/filter.h                             |  12 +-
 include/linux/kvm_host.h                           |   2 +-
 include/linux/phy_led_triggers.h                   |   2 +-
 include/linux/slab.h                               |   2 +-
 include/linux/stddef.h                             |  13 +-
 include/net/garp.h                                 |   2 +-
 include/net/ip_tunnels.h                           |   6 +-
 include/net/mrp.h                                  |   2 +-
 include/net/netfilter/nf_conntrack_helper.h        |   2 +-
 include/net/netfilter/nf_tables_core.h             |   2 +-
 include/net/sock.h                                 |   2 +-
 ipc/util.c                                         |   2 +-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/local_storage.c                         |   4 +-
 kernel/fork.c                                      |   2 +-
 kernel/signal.c                                    |  12 +-
 kernel/utsname.c                                   |   2 +-
 net/802/mrp.c                                      |   6 +-
 net/batman-adv/main.c                              |   2 +-
 net/bridge/br.c                                    |   2 +-
 net/caif/caif_socket.c                             |   2 +-
 net/core/dev.c                                     |   2 +-
 net/core/filter.c                                  | 140 ++++++++++-----------
 net/core/flow_dissector.c                          |  10 +-
 net/core/skbuff.c                                  |   2 +-
 net/core/xdp.c                                     |   4 +-
 net/dccp/proto.c                                   |   2 +-
 net/ipv4/ip_gre.c                                  |   4 +-
 net/ipv4/ip_vti.c                                  |   4 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/tcp.c                                     |   2 +-
 net/ipv6/ip6_gre.c                                 |   4 +-
 net/ipv6/raw.c                                     |   2 +-
 net/iucv/af_iucv.c                                 |   2 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nfnetlink_cthelper.c                 |   2 +-
 net/netfilter/nft_ct.c                             |  12 +-
 net/netfilter/nft_masq.c                           |   2 +-
 net/netfilter/nft_nat.c                            |   6 +-
 net/netfilter/nft_redir.c                          |   2 +-
 net/netfilter/nft_tproxy.c                         |   4 +-
 net/netfilter/xt_RATEEST.c                         |   2 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/openvswitch/datapath.c                         |   2 +-
 net/openvswitch/flow.h                             |   4 +-
 net/rxrpc/af_rxrpc.c                               |   2 +-
 net/sched/act_ct.c                                 |   4 +-
 net/sched/cls_flower.c                             |   2 +-
 net/sctp/socket.c                                  |   4 +-
 net/unix/af_unix.c                                 |   2 +-
 security/integrity/ima/ima_policy.c                |   4 +-
 sound/soc/codecs/hdmi-codec.c                      |   2 +-
 tools/testing/selftests/bpf/bpf_util.h             |   6 +-
 virt/kvm/kvm_main.c                                |   2 +-
 136 files changed, 340 insertions(+), 336 deletions(-)

-- 
Kees Cook
