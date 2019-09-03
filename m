Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79165C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E89422DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567503107;
	bh=OuxczD1cwLARoHA3BcMlTJhE6FZTxEZZWTo8Lvh6y/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nF7+c+oeWc8XD3LIg3+j8XLpVmsSnqqs73tSPJN6uXxXNOyuyTSOzddZVbn5Uc5Nx
	 3gDf5AzkZsnulE3jNozcHnrIubRVGFiExKPzGkgrCIhEaYARD9Pc35bp2MtwtzY5Xm
	 Z+L1T0elTsT7jnZ6H/562CTqV1faGWbPtZdIRvrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfICJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICJbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:31:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F9922CF8;
        Tue,  3 Sep 2019 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567503105;
        bh=OuxczD1cwLARoHA3BcMlTJhE6FZTxEZZWTo8Lvh6y/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FSgOydon/RdFrmOBXdz5DGbSh51KuAG939FWT9y8rulr7ChAzcg86Yht72WkOggDn
         0o9VADtXy/0V8H1ylxqy+XcHWTGdojJmKbFvOz9nULkNpY5EjyUy9yQ5En7qqv0JBG
         XZ4CsJ7WdKdNFsuOsOThEPWACLokUw4hei6WjFt0=
Date:   Tue, 3 Sep 2019 18:31:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] kprobes: Prohibit probing on BUG() and WARN()
 address
Message-Id: <20190903183140.9727fd5b4cc5c90cdd018096@kernel.org>
In-Reply-To: <201909022327.IrP9O0nh%lkp@intel.com>
References: <156742236963.18000.1855866569667433247.stgit@devnote2>
        <201909022327.IrP9O0nh%lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, for sparc64 and ppc64, we have to check the CONFIG_GENERIC_BUG...

On Mon, 2 Sep 2019 23:48:41 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190902]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/kprobes-Prohibit-probing-on-BUG-and-WARN-address/20190902-211736
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/kprobes.c: In function 'check_kprobe_address_safe':
> >> kernel/kprobes.c:1518:6: error: implicit declaration of function 'find_bug'; did you mean 'find_vma'? [-Werror=implicit-function-declaration]
>          find_bug(p->addr)) {
>          ^~~~~~~~
>          find_vma
>    cc1: some warnings being treated as errors
> 
> vim +1518 kernel/kprobes.c
> 
>   1502	
>   1503	static int check_kprobe_address_safe(struct kprobe *p,
>   1504					     struct module **probed_mod)
>   1505	{
>   1506		int ret;
>   1507	
>   1508		ret = arch_check_ftrace_location(p);
>   1509		if (ret)
>   1510			return ret;
>   1511		jump_label_lock();
>   1512		preempt_disable();
>   1513	
>   1514		/* Ensure it is not in reserved area nor out of text */
>   1515		if (!kernel_text_address((unsigned long) p->addr) ||
>   1516		    within_kprobe_blacklist((unsigned long) p->addr) ||
>   1517		    jump_label_text_reserved(p->addr, p->addr) ||
> > 1518		    find_bug(p->addr)) {
>   1519			ret = -EINVAL;
>   1520			goto out;
>   1521		}
>   1522	
>   1523		/* Check if are we probing a module */
>   1524		*probed_mod = __module_text_address((unsigned long) p->addr);
>   1525		if (*probed_mod) {
>   1526			/*
>   1527			 * We must hold a refcount of the probed module while updating
>   1528			 * its code to prohibit unexpected unloading.
>   1529			 */
>   1530			if (unlikely(!try_module_get(*probed_mod))) {
>   1531				ret = -ENOENT;
>   1532				goto out;
>   1533			}
>   1534	
>   1535			/*
>   1536			 * If the module freed .init.text, we couldn't insert
>   1537			 * kprobes in there.
>   1538			 */
>   1539			if (within_module_init((unsigned long)p->addr, *probed_mod) &&
>   1540			    (*probed_mod)->state != MODULE_STATE_COMING) {
>   1541				module_put(*probed_mod);
>   1542				*probed_mod = NULL;
>   1543				ret = -ENOENT;
>   1544			}
>   1545		}
>   1546	out:
>   1547		preempt_enable();
>   1548		jump_label_unlock();
>   1549	
>   1550		return ret;
>   1551	}
>   1552	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Masami Hiramatsu <mhiramat@kernel.org>
