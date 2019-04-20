Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4548C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C01208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfDTIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:08:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:9275 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfDTIIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:08:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Apr 2019 01:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,373,1549958400"; 
   d="scan'208";a="317480909"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2019 01:08:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hHl35-00039X-6b; Sat, 20 Apr 2019 16:08:35 +0800
Date:   Sat, 20 Apr 2019 16:08:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: [tip:WIP.x86/alternatives 7/9] arch/x86/kernel/alternative.c:896:42:
 sparse: Using plain integer as NULL pointer
Message-ID: <201904201602.4E4b6oEg%lkp@intel.com>
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
commit: 76ec759ad71c1fa0c4b327367e82b2650109a22f [7/9] x86/alternative: Batch of patch operations
reproduce:
        # apt-get install sparse
        git checkout 76ec759ad71c1fa0c4b327367e82b2650109a22f
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/alternative.c:896:42: sparse: Using plain integer as NULL pointer

vim +896 arch/x86/kernel/alternative.c

   836	
   837	/**
   838	 * text_poke_bp() -- update instructions on live kernel on SMP
   839	 * @addr:	address to patch
   840	 * @opcode:	opcode of new instruction
   841	 * @len:	length to copy
   842	 * @handler:	address to jump to when the temporary breakpoint is hit
   843	 *
   844	 * Modify multi-byte instruction by using int3 breakpoint on SMP.
   845	 * We completely avoid stop_machine() here, and achieve the
   846	 * synchronization using int3 breakpoint.
   847	 *
   848	 * The way it is done:
   849	 *	- add a int3 trap to the address that will be patched
   850	 *	- sync cores
   851	 *	- update all but the first byte of the patched range
   852	 *	- sync cores
   853	 *	- replace the first byte (int3) by the first byte of
   854	 *	  replacing opcode
   855	 *	- sync cores
   856	 */
   857	void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
   858	{
   859		unsigned char int3 = 0xcc;
   860	
   861		lockdep_assert_held(&text_mutex);
   862	
   863		bp_int3_handler = handler;
   864		bp_int3_addr = (u8 *)addr + sizeof(int3);
   865	
   866		bp_patching_in_progress = true;
   867		/*
   868		 * Corresponding read barrier in int3 notifier for making sure the
   869		 * in_progress and handler are correctly ordered wrt. patching.
   870		 */
   871		smp_wmb();
   872	
   873		text_poke_bp_set_handler(addr, handler, int3);
   874	
   875		on_each_cpu(do_sync_core, NULL, 1);
   876	
   877		if (len - sizeof(int3) > 0) {
   878			patch_all_but_first_byte(addr, opcode, len, int3);
   879			/*
   880			 * According to Intel, this core syncing is very likely
   881			 * not necessary and we'd be safe even without it. But
   882			 * better safe than sorry (plus there's not only Intel).
   883			 */
   884			on_each_cpu(do_sync_core, NULL, 1);
   885		}
   886	
   887		patch_first_byte(addr, opcode, int3);
   888	
   889		on_each_cpu(do_sync_core, NULL, 1);
   890		/*
   891		 * sync_core() implies an smp_mb() and orders this store against
   892		 * the writing of the new instruction.
   893		 */
   894		bp_patching_in_progress = false;
   895	
 > 896		bp_int3_handler = bp_int3_addr = 0;
   897		return addr;
   898	}
   899	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
