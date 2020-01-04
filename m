Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E4C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD1E24653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgADLtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 06:49:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:59506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgADLtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 06:49:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 03:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,394,1571727600"; 
   d="scan'208";a="369834210"
Received: from ylu28-mobl1.ccr.corp.intel.com (HELO [10.249.168.105]) ([10.249.168.105])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2020 03:49:01 -0800
Subject: Re: [IMA] 11b771ffff:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, lkp@lists.01.org
References: <20191227142335.GE2760@shao2-debian>
 <2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <e30864ab-4867-fffa-bf0c-88a5a9bb6f6e@intel.com>
Date:   Sat, 4 Jan 2020 19:49:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/2019 5:14 AM, Lakshmi Ramasubramanian wrote:
> On 12/27/19 6:23 AM, kernel test robot wrote:
>
> Hi Rong,
>
>>
>>
>> To reproduce:
>>
>>          # build kernel
>>     cd linux
>>     cp config-5.5.0-rc1-00011-g11b771ffff8fc .config
>>     make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare 
>> modules_prepare bzImage
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is 
>> attached in this email
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
>
> Thanks for reporting this issue.
>
> I built the kernel with the config you'd provided.
>
> When running lkp-tests using the command line given, I see the 
> following error and the test stops.
>
>     bin/lkp qemu -k ../linux-5.5/arch/x86/boot/bzImage job-script
>
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz 
> -N -P 
> /root/.lkp/cache/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c
>
> Failed to download 
> pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz
>
> Please let me know what I am missing.
>
> Full output of the command is given below:
>
> bin/lkp qemu -k ../linux-5.5/arch/x86/boot/bzImage job-script
>
> result_root: 
> /root/.lkp//result/kernel_selftests/kselftests-03/vm-snb/debian-x86_64-2019-11-14.cgz/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/8
> downloading initrds ...
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/debian/debian-x86_64-2019-11-14.cgz 
> -N -P /root/.lkp/cache/osimage/debian
> 408859 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz 
> -N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
> 1414 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz 
> -N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
> 1670 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz 
> -N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
> 8268 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-12-25.cgz 
> -N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
> 932372 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-0dcf36db-1_2019-12-25.cgz 
> -N -P /root/.lkp/cache/osimage/pkg/debian-x86_64-2018-04-03.cgz
> 30125 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
> https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz 
> -N -P 
> /root/.lkp/cache/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c
> Failed to download 
> pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz
>
>

Hi,

Sorry for the delay, we updated the lkp-tests code and uploaded the 
missing cgz files for this case.

Best Regards,
Rong Chen
