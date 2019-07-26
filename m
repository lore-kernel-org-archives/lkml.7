Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DAC22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfGZSIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:08:45 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36634 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfGZSIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:08:44 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hr4e2-0005Y4-OJ; Fri, 26 Jul 2019 12:08:43 -0600
To:     kernel test robot <lkp@intel.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20190726082329.GF22106@shao2-debian>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <36d29c75-07bb-8e79-feeb-4e6dc96124df@deltatee.com>
Date:   Fri, 26 Jul 2019 12:08:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726082329.GF22106@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: lkp@01.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, lkp@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [NTB] 26b3a37b92: WARNING:at_kernel/params.c:#param_sysfs_init
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-26 2:23 a.m., kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-4.9):
> 
> commit: 26b3a37b928457ba2cd98eaf6d7b0feca5a30fa6 ("NTB: Introduce MSI library")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: locktorture
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 
> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------+------------+------------+
> |                                              | d217e07b32 | 26b3a37b92 |
> +----------------------------------------------+------------+------------+
> | boot_successes                               | 4          | 0          |
> | boot_failures                                | 0          | 4          |
> | WARNING:at_kernel/params.c:#param_sysfs_init | 0          | 4          |
> | RIP:param_sysfs_init                         | 0          | 4          |
> +----------------------------------------------+------------+------------+
> 

Oh shoot.

This confusing report is caused by me accidentally leaving the MODULE_
defines in a file that ended up not being a module. I'll send a patch ASAP.

Logan


