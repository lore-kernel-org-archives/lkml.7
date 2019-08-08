Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58BCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7221743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404026AbfHHQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:08:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:33801
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732662AbfHHQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:08:54 -0400
X-IronPort-AV: E=Sophos;i="5.64,362,1559512800"; 
   d="scan'208";a="315952275"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 18:08:50 +0200
Date:   Thu, 8 Aug 2019 18:08:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37: ERROR:
 invalid reference to the index variable of the iterator on line 7056 (fwd)
Message-ID: <alpine.DEB.2.21.1908081806370.2995@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is it guaranteed that the loop starting on line 7056 will eventually take
the break?  If not, line 7089 will be performing an invalid dereference of
ch.

julia

---------- Forwarded message ----------
Date: Thu, 8 Aug 2019 21:31:53 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37: ERROR: invalid
    reference to the index variable of the iterator on line 7056

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb095bff5d4b8711a81968625b3b4a235d3e477
commit: 1d8d80b4e4ff641eefa5250cba324dfa5861a9f1 i40e: Add macvlan support on i40e
date:   6 weeks ago
:::::: branch date: 15 hours ago
:::::: commit date: 6 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37: ERROR: invalid reference to the index variable of the iterator on line 7056

git remote add linus https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 1d8d80b4e4ff641eefa5250cba324dfa5861a9f1
vim +7089 drivers/net/ethernet/intel/i40e/i40e_main.c

1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7037
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7038  /**
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7039   * i40e_fwd_ring_up - bring the macvlan device up
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7040   * @vsi: the VSI we want to access
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7041   * @vdev: macvlan netdevice
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7042   * @fwd: the private fwd structure
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7043   */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7044  static int i40e_fwd_ring_up(struct i40e_vsi *vsi, struct net_device *vdev,
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7045  			    struct i40e_fwd_adapter *fwd)
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7046  {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7047  	int ret = 0, num_tc = 1,  i, aq_err;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7048  	struct i40e_channel *ch, *ch_tmp;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7049  	struct i40e_pf *pf = vsi->back;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7050  	struct i40e_hw *hw = &pf->hw;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7051
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7052  	if (list_empty(&vsi->macvlan_list))
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7053  		return -EINVAL;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7054
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7055  	/* Go through the list and find an available channel */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19 @7056  	list_for_each_entry_safe(ch, ch_tmp, &vsi->macvlan_list, list) {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7057  		if (!i40e_is_channel_macvlan(ch)) {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7058  			ch->fwd = fwd;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7059  			/* record configuration for macvlan interface in vdev */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7060  			for (i = 0; i < num_tc; i++)
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7061  				netdev_bind_sb_channel_queue(vsi->netdev, vdev,
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7062  							     i,
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7063  							     ch->num_queue_pairs,
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7064  							     ch->base_queue);
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7065  			for (i = 0; i < ch->num_queue_pairs; i++) {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7066  				struct i40e_ring *tx_ring, *rx_ring;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7067  				u16 pf_q;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7068
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7069  				pf_q = ch->base_queue + i;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7070
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7071  				/* Get to TX ring ptr */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7072  				tx_ring = vsi->tx_rings[pf_q];
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7073  				tx_ring->ch = ch;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7074
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7075  				/* Get the RX ring ptr */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7076  				rx_ring = vsi->rx_rings[pf_q];
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7077  				rx_ring->ch = ch;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7078  			}
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7079  			break;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7080  		}
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7081  	}
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7082
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7083  	/* Guarantee all rings are updated before we update the
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7084  	 * MAC address filter.
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7085  	 */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7086  	wmb();
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7087
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7088  	/* Add a mac filter */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19 @7089  	ret = i40e_add_macvlan_filter(hw, ch->seid, vdev->dev_addr, &aq_err);
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7090  	if (ret) {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7091  		/* if we cannot add the MAC rule then disable the offload */
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7092  		macvlan_release_l2fw_offload(vdev);
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7093  		for (i = 0; i < ch->num_queue_pairs; i++) {
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7094  			struct i40e_ring *rx_ring;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7095  			u16 pf_q;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7096
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7097  			pf_q = ch->base_queue + i;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7098  			rx_ring = vsi->rx_rings[pf_q];
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7099  			rx_ring->netdev = NULL;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7100  		}
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7101  		dev_info(&pf->pdev->dev,
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7102  			 "Error adding mac filter on macvlan err %s, aq_err %s\n",
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7103  			  i40e_stat_str(hw, ret),
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7104  			  i40e_aq_str(hw, aq_err));
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7105  		netdev_err(vdev, "L2fwd offload disabled to L2 filter error\n");
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7106  	}
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7107
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7108  	return ret;
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7109  }
1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7110

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
