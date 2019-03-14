Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CB321019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCNKh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:37:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:3335 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfCNKhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:37:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 03:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="328559692"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Mar 2019 03:37:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h4Njo-0005Dh-2Y; Thu, 14 Mar 2019 18:37:24 +0800
Date:   Thu, 14 Mar 2019 18:37:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/ipv4/netfilter/ipt_CLUSTERIP.c:513 clusterip_tg_check() error:
 potential null dereference 'config'.  (clusterip_config_init returns null)
Message-ID: <201903141804.SyujYY4l%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fa3d493f7a573b4e4e2538486e912093a0161c1b
commit: 5a86d68bcf02f2d1e9a5897dd482079fd5f75e7f netfilter: ipt_CLUSTERIP: fix deadlock in netns exit routine
date:   3 months ago

New smatch warnings:
net/ipv4/netfilter/ipt_CLUSTERIP.c:513 clusterip_tg_check() error: potential null dereference 'config'.  (clusterip_config_init returns null)

Old smatch warnings:
net/ipv4/netfilter/ipt_CLUSTERIP.c:134 clusterip_config_entry_put() warn: inconsistent returns 'spin_lock:&cn->lock'.
  Locked on:   line 134
  Unlocked on: line 132

vim +/config +513 net/ipv4/netfilter/ipt_CLUSTERIP.c

   456	
   457	static int clusterip_tg_check(const struct xt_tgchk_param *par)
   458	{
   459		struct ipt_clusterip_tgt_info *cipinfo = par->targinfo;
   460		const struct ipt_entry *e = par->entryinfo;
   461		struct clusterip_config *config;
   462		int ret, i;
   463	
   464		if (par->nft_compat) {
   465			pr_err("cannot use CLUSTERIP target from nftables compat\n");
   466			return -EOPNOTSUPP;
   467		}
   468	
   469		if (cipinfo->hash_mode != CLUSTERIP_HASHMODE_SIP &&
   470		    cipinfo->hash_mode != CLUSTERIP_HASHMODE_SIP_SPT &&
   471		    cipinfo->hash_mode != CLUSTERIP_HASHMODE_SIP_SPT_DPT) {
   472			pr_info("unknown mode %u\n", cipinfo->hash_mode);
   473			return -EINVAL;
   474	
   475		}
   476		if (e->ip.dmsk.s_addr != htonl(0xffffffff) ||
   477		    e->ip.dst.s_addr == 0) {
   478			pr_info("Please specify destination IP\n");
   479			return -EINVAL;
   480		}
   481		if (cipinfo->num_local_nodes > ARRAY_SIZE(cipinfo->local_nodes)) {
   482			pr_info("bad num_local_nodes %u\n", cipinfo->num_local_nodes);
   483			return -EINVAL;
   484		}
   485		for (i = 0; i < cipinfo->num_local_nodes; i++) {
   486			if (cipinfo->local_nodes[i] - 1 >=
   487			    sizeof(config->local_nodes) * 8) {
   488				pr_info("bad local_nodes[%d] %u\n",
   489					i, cipinfo->local_nodes[i]);
   490				return -EINVAL;
   491			}
   492		}
   493	
   494		config = clusterip_config_find_get(par->net, e->ip.dst.s_addr, 1);
   495		if (!config) {
   496			if (!(cipinfo->flags & CLUSTERIP_FLAG_NEW)) {
   497				pr_info("no config found for %pI4, need 'new'\n",
   498					&e->ip.dst.s_addr);
   499				return -EINVAL;
   500			} else {
   501				config = clusterip_config_init(par->net, cipinfo,
   502							       e->ip.dst.s_addr,
   503							       e->ip.iniface);
   504				if (IS_ERR(config))
   505					return PTR_ERR(config);
   506			}
   507		}
   508	
   509		ret = nf_ct_netns_get(par->net, par->family);
   510		if (ret < 0) {
   511			pr_info("cannot load conntrack support for proto=%u\n",
   512				par->family);
 > 513			clusterip_config_entry_put(config);
   514			clusterip_config_put(config);
   515			return ret;
   516		}
   517	
   518		if (!par->net->xt.clusterip_deprecated_warning) {
   519			pr_info("ipt_CLUSTERIP is deprecated and it will removed soon, "
   520				"use xt_cluster instead\n");
   521			par->net->xt.clusterip_deprecated_warning = true;
   522		}
   523	
   524		cipinfo->config = config;
   525		return ret;
   526	}
   527	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
