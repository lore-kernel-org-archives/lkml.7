Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC9320659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLCIVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:21:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:11099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfLCIVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:21:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 00:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="412096123"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 00:21:17 -0800
Subject: Re: [efi] 1c5fecb612: WARNING:at_kernel/iomem.c:#memremap
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191201155238.GR18573@shao2-debian>
 <CAKv+Gu8MO_85Fa0y7YZ0iEgxrXbfR5-1e37FbiByzP8LrohcYA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <51a225fa-6775-ed3f-22ff-4c88de6f6db4@intel.com>
Date:   Tue, 3 Dec 2019 16:20:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8MO_85Fa0y7YZ0iEgxrXbfR5-1e37FbiByzP8LrohcYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/19 5:41 PM, Ard Biesheuvel wrote:
> On Sun, 1 Dec 2019 at 16:53, kernel test robot <rong.a.chen@intel.com> wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 1c5fecb61255aa12a16c4c06335ab68979865914 ("efi: Export Runtime Configuration Interface table to sysfs")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: rcutorture
>> with following parameters:
>>
>>          runtime: 300s
>>          test: default
>>          torture_type: tasks
>>
>> test-description: rcutorture is rcutorture kernel module load/unload test.
>> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +------------------------------------------------+------------+------------+
>> |                                                | 5828efb95b | 1c5fecb612 |
>> +------------------------------------------------+------------+------------+
>> | boot_successes                                 | 0          | 0          |
>> | boot_failures                                  | 4          | 4          |
>> | Kernel_panic-not_syncing:No_working_init_found | 4          | 4          |
>> | WARNING:at_kernel/iomem.c:#memremap            | 0          | 4          |
>> | EIP:memremap                                   | 0          | 4          |
>> +------------------------------------------------+------------+------------+
>>
> I don't understand this result. Doesn't it say the number of failures
> is the same, but it just fails in a different place? Is there a
> working config that breaks due to that commit?

Hi Ard,

The results means all boot are failed, parent commit fails at 
"Kernel_panic-not_syncing:No_working_init_found"
which may causes by the wrong test environment, but the commit 
"1c5fecb612" introduced a new error:
"WARNING:at_kernel/iomem.c:#memremap".

We prepared the reproduce steps and config file in report mail: 
https://lore.kernel.org/lkml/20191201155238.GR18573@shao2-debian/

Best Regards,
Rong Chen

>
>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> [   27.829857] WARNING: CPU: 0 PID: 1 at kernel/iomem.c:82 memremap+0x62/0x148
>> [   27.832571] Modules linked in:
>> [   27.833528] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.3.0-rc1-00004-g1c5fecb61255a #2
>> [   27.836364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   27.838876] EIP: memremap+0x62/0x148
>> [   27.840028] Code: 89 c7 83 f8 02 75 2a 80 3d bb 47 c8 c1 00 0f 85 bd 00 00 00 c6 05 bb 47 c8 c1 01 53 8d 45 ec 50 68 78 3c a5 c1 e8 f2 ff f1 ff <0f> 0b e9 9d 00 00 00 31 c0 f7 c6 01 00 00 00 74 65 85 ff 74 0f 89
>> [   27.845798] EAX: 0000003f EBX: 0000001e ECX: 00000000 EDX: 30706000
>> [   27.847665] ESI: 00000001 EDI: 00000002 EBP: e9e03f0c ESP: e9e03ee4
>> [   27.849523] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010282
>> [   27.851616] CR0: 80050033 CR2: 08056130 CR3: 01db5000 CR4: 000406b0
>> [   27.853465] Call Trace:
>> [   27.853896]  ? kobject_add+0x5b/0x66
>> [   27.854502]  ? map_properties+0x425/0x425
>> [   27.855171]  efi_rci2_sysfs_init+0x1f/0x1e2
>> [   27.855873]  ? map_properties+0x425/0x425
>> [   27.856545]  do_one_initcall+0xa0/0x1cb
>> [   27.857187]  ? parse_args+0xa3/0x28b
>> [   27.857823]  ? trace_initcall_level+0x53/0x6e
>> [   27.858548]  kernel_init_freeable+0x102/0x190
>> [   27.859300]  ? rest_init+0xee/0xee
>> [   27.859887]  kernel_init+0xd/0xdf
>> [   27.860443]  ret_from_fork+0x1e/0x28
>> [   27.861144] ---[ end trace c5c6f0b028e1905c ]---
>>
>>
>> To reproduce:
>>
>>          # build kernel
>>          cd linux
>>          cp config-5.3.0-rc1-00004-g1c5fecb61255a .config
>>          make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> Rong Chen
>>

