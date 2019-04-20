Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D9EC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D021855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfDTA0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:26:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:23640 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfDTA0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:26:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 17:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="166264017"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2019 17:26:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hHdq2-0004nP-ND; Sat, 20 Apr 2019 08:26:38 +0800
Date:   Sat, 20 Apr 2019 08:25:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: [tip:WIP.x86/alternatives 2/9] kernel/jump_label.c:387:10-11:
 WARNING: return of 0/1 in function 'jump_label_can_update_check' with return
 type bool
Message-ID: <201904200838.Ti8u2zuO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/alternatives
head:   1f30946b1a01baf22df6faf74c0a1e602bb6cac7
commit: 41bef31d0abe29b5888b33b526cacc8a30795318 [2/9] jump_label: Add the jump_label_can_update_check() helper

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



coccinelle warnings: (new ones prefixed by >>)

>> kernel/jump_label.c:387:10-11: WARNING: return of 0/1 in function 'jump_label_can_update_check' with return type bool

vim +/jump_label_can_update_check +387 kernel/jump_label.c

   376	
   377	bool jump_label_can_update_check(struct jump_entry *entry, bool init)
   378	{
   379		/*
   380		 * An entry->code of 0 indicates an entry which has been
   381		 * disabled because it was in an init text area.
   382		 */
   383		if (init || !jump_entry_is_init(entry)) {
   384			if (!kernel_text_address(jump_entry_code(entry))) {
   385				WARN_ONCE(1, "can't patch jump_label at %pS",
   386					  (void *)jump_entry_code(entry));
 > 387				return 0;
   388			}
   389			return 1;
   390		}
   391		return 0;
   392	}
   393	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
