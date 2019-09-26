Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC57C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75D8222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNlCVzVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfIZRdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:33:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43136 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfIZRdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:33:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so1331610plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ze6dgnsFX+B4l9Vm8RLshgQrCe/mG3DnIHVMMY+nOtU=;
        b=XNlCVzVWiQKFfZArzCHjHCO7m1MzDHRDalAvKpcutvDxGf2osHSFQgukxxQLNtGD4L
         7cUJLnMKKufQsc8QqVYq5Tp8RcZl6CZhkTNn+jCEGdzoDj2Uj1/rhhE/EXFSbnq0Uk4J
         0nyAqoXQiD6MOaTvRFtflMwrfSS95u2i0/2d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ze6dgnsFX+B4l9Vm8RLshgQrCe/mG3DnIHVMMY+nOtU=;
        b=RTqrQDrZnjn8+v9MTE0kv9MRtIshM2fiNMeH2BfaiOO7SQt0g6O3ebAxmdJNRR5dpt
         /L4F8BiFwNv+zpSPViqOMrGH1queiwvQX9cuvI3rKCd2Rj3SL9TWJfzERzWZIL8QRYbm
         JR9ipeWiT6N5xYjckDP9qJqS2SmfMaMmriCmgl2jbNlC9IcMigJ/m88lZdIlsgN2lI97
         NpsI2xlExKYtoeu3qmVPLHKv0M5EhNaQJVi2OM7PM/j6L6w+xnfL7mNPUp7wcrZGL8WO
         k8eYnhCR8c6L5PjYVv/sWb9glfiKjCLUlVvEUvmudW02Jp91GZ33lAXSObu7IOy2ZJcq
         qgQg==
X-Gm-Message-State: APjAAAUuBRXjcL7SK+KiU5vnNd5oW7cUDtF6hG2JiTGwtf7cH3K8Fkg4
        HLWLXUtFWsz+vYcC/A7UIYS41g==
X-Google-Smtp-Source: APXvYqw3rnCQ187tkfwIODESsmJuChWvAgw8rL6G97KNnr8Xvwe+hxcivjydhMGuKRh8iR6duqV/pQ==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr5586969plt.60.1569519231732;
        Thu, 26 Sep 2019 10:33:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm3416166pfn.128.2019.09.26.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:33:50 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:33:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [GIT PULL] treewide conversion to sizeof_member() for v5.4-rc1
Message-ID: <201909261026.6E3381876C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this mostly mechanical treewide conversion to the single and
more accurately named sizeof_member() macro for the end of v5.4-rc1. This
replaces 3 macros of the same behavior (FIELD_SIZEOF(), SIZEOF_FIELD(),
and sizeof_field()). The last patch in the series has a script in the
commit log to do the conversion, if you want to compare the results
(they remained identical today when I checked).

Thanks!

-Kees

The following changes since commit 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc:

  Merge tag 'mfd-next-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd (2019-09-23 19:37:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_member-v5.4-rc1

for you to fetch changes up to 32f8b3ead0cb8f98edc76b72ee987a259f889736:

  treewide: Use sizeof_member() macro (2019-09-24 09:55:31 -0700)

----------------------------------------------------------------
Treewide conversion to sizeof_member() for struct member size calculations

----------------------------------------------------------------
Pankaj Bharadiya (3):
      linux/stddef.h: Add sizeof_member() macro
      MIPS: OCTEON: Remove SIZEOF_FIELD() macro
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
 net/bpf/test_run.c                                 |   6 +-
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
 135 files changed, 341 insertions(+), 337 deletions(-)

-- 
Kees Cook
