Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751C9214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfB1NsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:48:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfB1NsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:48:25 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4C77444B4FA65222954;
        Thu, 28 Feb 2019 21:48:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 21:48:16 +0800
Subject: Re: [PATCH v2] appletalk: Fix use-after-free in atalk_proc_exit
To:     kbuild test robot <lkp@intel.com>
References: <20190228023033.26248-1-yuehaibing@huawei.com>
 <201902282041.nwOsNTC3%fengguang.wu@intel.com>
CC:     <kbuild-all@01.org>, <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <71ca9c2c-8723-7ec6-c2f5-394161feb888@huawei.com>
Date:   Thu, 28 Feb 2019 21:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <201902282041.nwOsNTC3%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/28 20:38, kbuild test robot wrote:
> Hi YueHaibing,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on net-next/master]
> [also build test WARNING on v5.0-rc8 next-20190228]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Yue-Haibing/appletalk-Fix-use-after-free-in-atalk_proc_exit/20190228-195802
> config: i386-randconfig-x003-201908 (attached as .config)
> compiler: gcc-8 (Debian 8.2.0-20) 8.2.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>>> WARNING: net/appletalk/appletalk.o(.init.text+0x104): Section mismatch in reference from the function init_module() to the function .exit.text:atalk_proc_exit()
>    The function __init init_module() references
>    a function __exit atalk_proc_exit().
>    This is often seen when error handling in the init function
>    uses functionality in the exit path.
>    The fix is often to remove the __exit annotation of
>    atalk_proc_exit() so it may be used outside an exit section.

Thanks, will fix it.

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

