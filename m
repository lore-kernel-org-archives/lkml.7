Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68512186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfB1Bcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:32:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730234AbfB1Bcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:32:46 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2909A2B13F58822BF03;
        Thu, 28 Feb 2019 09:32:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 09:32:41 +0800
Subject: Re: [PATCH -next] appletalk: use remove_proc_subtree to simplify
 procfs code
To:     kbuild test robot <lkp@intel.com>
References: <20190227150023.28420-1-yuehaibing@huawei.com>
 <201902280710.9KQ8GgpK%fengguang.wu@intel.com>
CC:     <kbuild-all@01.org>, <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <4faff1a2-e28d-a295-a3ca-81a24df7e369@huawei.com>
Date:   Thu, 28 Feb 2019 09:32:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <201902280710.9KQ8GgpK%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/28 7:28, kbuild test robot wrote:
> Hi YueHaibing,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20190227]
> 
> url:    https://github.com/0day-ci/linux/commits/Yue-Haibing/appletalk-use-remove_proc_subtree-to-simplify-procfs-code/20190228-014856
> config: i386-randconfig-s3-02271654 (attached as .config)
> compiler: gcc-6 (Debian 6.5.0-2) 6.5.0 20181026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/init.h:5:0,
>                     from net//appletalk/atalk_proc.c:11:
>    net//appletalk/atalk_proc.c: In function 'atalk_proc_init':
>    include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>      ^
>    include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>                           ^~~~~~~~~~
>>> net//appletalk/atalk_proc.c:218:2: note: in expansion of macro 'if'
>      if (!proc_create_seq("atalk/interface", 0444, init_net.proc_net,
>      ^~
>    net//appletalk/atalk_proc.c:220:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       goto out;
>       ^~~~
>    In file included from include/linux/init.h:5:0,
>                     from net//appletalk/atalk_proc.c:11:
>    include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>      ^
>    include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>                           ^~~~~~~~~~
>    net//appletalk/atalk_proc.c:222:2: note: in expansion of macro 'if'
>      if (!proc_create_seq("atalk/route", 0444, init_net.proc_net,
>      ^~
>    net//appletalk/atalk_proc.c:224:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       goto out;
>       ^~~~
>    In file included from include/linux/init.h:5:0,
>                     from net//appletalk/atalk_proc.c:11:
>    include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>      ^
>    include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>                           ^~~~~~~~~~
>    net//appletalk/atalk_proc.c:226:2: note: in expansion of macro 'if'
>      if (!proc_create_seq("atalk/socket", 0444, init_net.proc_net,
>      ^~
>    net//appletalk/atalk_proc.c:228:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       goto out;
>       ^~~~
>    In file included from include/linux/init.h:5:0,
>                     from net//appletalk/atalk_proc.c:11:
>    include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>      ^
>    include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>                           ^~~~~~~~~~
>    net//appletalk/atalk_proc.c:230:2: note: in expansion of macro 'if'
>      if (!proc_create_seq_private("atalk/arp", 0444, init_net.proc_net,
>      ^~
>    net//appletalk/atalk_proc.c:233:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       goto out;
>       ^~~~
> 

Thanks, will fix in v2.


> vim +/if +218 net//appletalk/atalk_proc.c
> 
>    212	
>    213	int __init atalk_proc_init(void)
>    214	{
>    215		if (!proc_mkdir("atalk", init_net.proc_net))
>    216			return -ENOMEM;
>    217	
>  > 218		if (!proc_create_seq("atalk/interface", 0444, init_net.proc_net,
>    219				    &atalk_seq_interface_ops));
>    220			goto out;
>    221	
>    222		if (!proc_create_seq("atalk/route", 0444, init_net.proc_net,
>    223				    &atalk_seq_route_ops));
>    224			goto out;
>    225	
>    226		if (!proc_create_seq("atalk/socket", 0444, init_net.proc_net,
>    227				    &atalk_seq_socket_ops));
>    228			goto out;
>    229	
>    230		if (!proc_create_seq_private("atalk/arp", 0444, init_net.proc_net,
>    231					     &aarp_seq_ops,
>    232					     sizeof(struct aarp_iter_state), NULL));
>    233			goto out;
>    234	
>    235	out:
>    236		remove_proc_subtree("atalk", init_net.proc_net);
>    237		return -ENOMEM;
>    238	}
>    239	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

