Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5854C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DAE206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMSPry+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLITFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:05:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46866 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLITFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:05:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so6164738pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3tlsVBYGbbVzviApC4e4ev2YL4CetxanYMT0hBnciFg=;
        b=TMSPry+nkDSDPSsbVJG78PyKqIwE046FyTj4lf9DUg54o9F3gPx8fpbRBziw7Es26b
         Ztfzd5e0cPSZg1eirwoQbdwnAydx2Id5hsewBzOlLVL2PStZjLSaXMrwDizPT2CjBcGi
         B3x0iOzlqLbxbS4qhOR2COYT4cuFSbLvHXOqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3tlsVBYGbbVzviApC4e4ev2YL4CetxanYMT0hBnciFg=;
        b=NMwOLdId4pQ0z2QTBqWlsdAuwFx1KCvUPNOW6YyNiLjtsme6HNf9PP+v0M8BdHp7Qs
         YcVbd16Mn0K2+lH2/+dB2EOjonEp5Ahyddu6eG6uIP5D0sCR2yPK2xIhnl+Kzb8vf8WU
         nNsMpakftIET4hVMuKTl2g+WYG3LJCMZn6yCEfd78zYcoFp7utnTucwIAiAs2q2Bhtmt
         FGZTHXE4b0fS2RDHHTb3FiUrRVjzu3iygI3r5dx7puH/dc1EV/UiUw+xvS2PSaz2UvCD
         3QgxfhMYbi39+PkJVbvbfjz2aka3OfHo/eLUFNSt/8WKxz0V9n5GCiZBpXykWiI5WQXC
         HvzA==
X-Gm-Message-State: APjAAAW6ogp3KVI5+ebPiTqs3t0lXWj1eLSfKWIeY6wRUGMbBoksJW4f
        0QaPPqnKqZsXTmTKbqO9kAmHhHSUYag=
X-Google-Smtp-Source: APXvYqzvpwQ27TdzUSzid38nPoC0L2SyLmQJG3GF2KelnetdN4IYwxVjLEgceEQEMQd4mopSFfiQrw==
X-Received: by 2002:a17:90b:150:: with SMTP id em16mr569787pjb.123.1575918353341;
        Mon, 09 Dec 2019 11:05:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17sm148559pjv.6.2019.12.09.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 11:05:52 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:05:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [GIT PULL] treewide conversion to sizeof_field() for v5.5-rc2
Message-ID: <201912091054.ECCE323A6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Third time's the charm? Please pull this mostly mechanical treewide
conversion from FIELD_SIZEOF() to sizeof_field(). This avoids the
redundancy of having 2 macros (actually 3) doing the same thing, and
consolidates on sizeof_field(). While "field" is not an accurate name,
it is the common name used in the kernel, and doesn't result in any
unintended innuendo.

As there are still users of FIELD_SIZEOF() in -next, I will clean up
those during this coming development cycle and send the final old macro
removal patch at that time. (Unless you'd rather have it be "completed"
in your tree immediately?)

Thanks!

-Kees

v2: https://lore.kernel.org/lkml/201912071144.768E249A4F@keescook/
v1: https://lore.kernel.org/lkml/201909261026.6E3381876C@keescook/

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_field-v5.5-rc2

for you to fetch changes up to c593642c8be046915ca3a4a300243a68077cd207:

  treewide: Use sizeof_field() macro (2019-12-09 10:36:44 -0800)

----------------------------------------------------------------
treewide conversion from FIELD_SIZEOF() to sizeof_field()

----------------------------------------------------------------
Pankaj Bharadiya (2):
      MIPS: OCTEON: Replace SIZEOF_FIELD() macro
      treewide: Use sizeof_field() macro

 Documentation/process/coding-style.rst             |   2 +-
 .../translations/it_IT/process/coding-style.rst    |   2 +-
 .../translations/zh_CN/process/coding-style.rst    |   2 +-
 arch/arc/kernel/unwind.c                           |   6 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |   9 +-
 arch/powerpc/net/bpf_jit32.h                       |   4 +-
 arch/powerpc/net/bpf_jit_comp.c                    |  16 +--
 arch/sparc/net/bpf_jit_comp_32.c                   |   8 +-
 arch/x86/kernel/fpu/xstate.c                       |   2 +-
 block/blk-core.c                                   |   4 +-
 crypto/adiantum.c                                  |   4 +-
 crypto/essiv.c                                     |   2 +-
 drivers/firmware/efi/efi.c                         |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |   4 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |   2 +-
 drivers/md/raid5-ppl.c                             |   2 +-
 drivers/media/platform/omap3isp/isppreview.c       |  24 ++--
 drivers/media/v4l2-core/v4l2-ioctl.c               |   2 +-
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
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |  10 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c      |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c   |   2 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +-
 .../ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   2 +-
 drivers/net/ethernet/realtek/r8169_firmware.c      |   2 +-
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
 drivers/staging/wfx/data_tx.c                      |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |   2 +-
 drivers/usb/atm/usbatm.c                           |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 fs/crypto/keyring.c                                |   2 +-
 fs/verity/enable.c                                 |   2 +-
 include/linux/filter.h                             |  12 +-
 include/linux/kvm_host.h                           |   2 +-
 include/linux/phy_led_triggers.h                   |   2 +-
 include/net/garp.h                                 |   2 +-
 include/net/ip_tunnels.h                           |   6 +-
 include/net/mrp.h                                  |   2 +-
 include/net/netfilter/nf_conntrack_helper.h        |   2 +-
 include/net/netfilter/nf_tables_core.h             |   2 +-
 include/net/sock.h                                 |   2 +-
 ipc/util.c                                         |   2 +-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/local_storage.c                         |   4 +-
 net/802/mrp.c                                      |   6 +-
 net/batman-adv/main.c                              |   2 +-
 net/bpf/test_run.c                                 |   8 +-
 net/bridge/br.c                                    |   2 +-
 net/core/dev.c                                     |   2 +-
 net/core/filter.c                                  | 140 ++++++++++-----------
 net/core/flow_dissector.c                          |  10 +-
 net/core/xdp.c                                     |   4 +-
 net/dccp/proto.c                                   |   2 +-
 net/ipv4/ip_gre.c                                  |   4 +-
 net/ipv4/ip_vti.c                                  |   4 +-
 net/ipv4/tcp.c                                     |   2 +-
 net/ipv6/ip6_gre.c                                 |   4 +-
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
 net/unix/af_unix.c                                 |   2 +-
 security/integrity/ima/ima_policy.c                |   4 +-
 sound/soc/codecs/hdmi-codec.c                      |   2 +-
 116 files changed, 299 insertions(+), 306 deletions(-)

-- 
Kees Cook
