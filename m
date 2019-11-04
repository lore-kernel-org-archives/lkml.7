Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CACA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9682221744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKDIDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:03:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfKDIDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:03:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69F5219BFFA34341D38C;
        Mon,  4 Nov 2019 16:03:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 16:03:28 +0800
Subject: Re: [PATCH 3/3] Revert "f2fs: use kvmalloc, if kmalloc is failed"
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20191101095324.9902-3-yuchao0@huawei.com>
 <201911022233.zTMqGPBr%lkp@intel.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <28541e80-9f5e-44a0-7590-d95f9f398663@huawei.com>
Date:   Mon, 4 Nov 2019 16:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201911022233.zTMqGPBr%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the report, I've fixed this.

Thanks,

On 2019/11/2 22:17, kbuild test robot wrote:
> Hi Chao,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on f2fs/dev-test]
> [cannot apply to v5.4-rc5 next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-clean-up-check-condition-for-writting-beyond-EOF/20191102-212408
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
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
>    fs/f2fs/super.c: In function 'destroy_device_list':
>>> fs/f2fs/super.c:1055:17: error: 'struct f2fs_dev_info' has no member named 'blkz_type'; did you mean 'blkz_seq'?
>       kfree(FDEV(i).blkz_type);
>                     ^~~~~~~~~
>                     blkz_seq
> 
> vim +1055 fs/f2fs/super.c
> 
>   1047	
>   1048	static void destroy_device_list(struct f2fs_sb_info *sbi)
>   1049	{
>   1050		int i;
>   1051	
>   1052		for (i = 0; i < sbi->s_ndevs; i++) {
>   1053			blkdev_put(FDEV(i).bdev, FMODE_EXCL);
>   1054	#ifdef CONFIG_BLK_DEV_ZONED
>> 1055			kfree(FDEV(i).blkz_type);
>   1056	#endif
>   1057		}
>   1058		kfree(sbi->devs);
>   1059	}
>   1060	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
