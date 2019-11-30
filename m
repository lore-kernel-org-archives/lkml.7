Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F4C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8B20665
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfK3I4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:56:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:48611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfK3I4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:56:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2019 00:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,260,1571727600"; 
   d="scan'208";a="292842993"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2019 00:56:02 -0800
Date:   Sat, 30 Nov 2019 17:03:16 +0800
From:   Philip Li <philip.li@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kbuild-all@lists.01.org, joe@perches.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        tj@kernel.org, arnd@arndb.de, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org
Subject: Re: [kbuild-all] Re: [PATCH 3/4] printk: Drop pr_warning definition
Message-ID: <20191130090316.GA5419@intel.com>
References: <20191128004752.35268-4-wangkefeng.wang@huawei.com>
 <201911281545.4mGpcG7D%lkp@intel.com>
 <20191129115347.ltzif5jstfxh3h3t@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129115347.ltzif5jstfxh3h3t@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 12:53:47PM +0100, Petr Mladek wrote:
> On Thu 2019-11-28 15:14:36, kbuild test robot wrote:
> > Hi Kefeng,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on wq/for-next]
> > [cannot apply to pmladek/for-next v5.4 next-20191127]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/part2-kill-pr_warning-from-kernel/20191128-085343
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
> > config: i386-defconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/platform/x86/eeepc-laptop.c: In function 'eeepc_rfkill_hotplug':
> > >> drivers/platform/x86/eeepc-laptop.c:581:3: error: implicit declaration of function 'pr_warning'; did you mean 'acpi_warning'? [-Werror=implicit-function-declaration]
> >       pr_warning("Unable to find port\n");
> >       ^~~~~~~~~~
> >       acpi_warning
> >    cc1: some warnings being treated as errors
> 
> [...]
> 
> These are false positives. These pr_warning() calls have already been
> removed in mainline via a pull request from printk.git.
thanks, we will check this to improve.

> 
> Best Regards.
> Petr
> 
> 
> tj/wq.git for-next branch is outdated.
> This branch is outdated. The 
Thanks for the info Petr, we will look into this to resolve the out of
dated base. In this case, do you have any recommended base to use?

> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
