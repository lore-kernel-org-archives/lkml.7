Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C327C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369512067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHNB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:56:31 -0400
Received: from mail1.windriver.com ([147.11.146.13]:49494 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHNB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:56:31 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x7E1uRhA021188
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 13 Aug 2019 18:56:27 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 13 Aug
 2019 18:56:26 -0700
Subject: Re: [PATCH] module: Fix load failure when CONFIG_STRICT_MODULE_RWX is
 diabled
To:     Jessica Yu <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1565421720-316924-1-git-send-email-zhe.he@windriver.com>
 <20190813175912.GB24753@linux-8ccs.fritz.box>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <c7f6d08c-b1ac-2616-332a-d69156811b26@windriver.com>
Date:   Wed, 14 Aug 2019 09:56:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813175912.GB24753@linux-8ccs.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/19 1:59 AM, Jessica Yu wrote:
> +++ zhe.he@windriver.com [10/08/19 15:22 +0800]:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> When loading modules with CONFIG_ARCH_HAS_STRICT_MODULE_RWX enabled and
>> CONFIG_STRICT_MODULE_RWX disabled, the memory allocated for modules would
>> not be page-aligned and cause the following BUG during frob_text.
>>
>> ------------[ cut here ]------------
>> kernel BUG at kernel/module.c:1907!
>> Internal error: Oops - BUG: 0 [#1] ARM
>> Modules linked in:
>> CPU: 0 PID: 89 Comm: systemd-modules Not tainted 5.3.0-rc2 #1
>> Hardware name: ARM-Versatile (Device Tree Support)
>> PC is at frob_text.constprop.0+0x2c/0x40
>> LR is at load_module+0x14b4/0x1d28
>> pc : [<c0082930>]    lr : [<c0084bb0>]    psr: 20000013
>> sp : ce44fe58  ip : 00000000  fp : 00000000
>> r10: 00000000  r9 : ce44feb8  r8 : 00000000
>> r7 : 00000001  r6 : bf00032c  r5 : ce44ff40  r4 : bf000320
>> r3 : bf000400  r2 : 00000fff  r1 : 00000220  r0 : bf000000
>> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 00093177  Table: 0e4c0000  DAC: 00000051
>> Process systemd-modules (pid: 89, stack limit = 0x9fccc8dc)
>> Stack: (0xce44fe58 to 0xce450000)
>> fe40:                                                       00000000 cf1b05b8
>> fe60: 00000001 ce47cf08 bf002754 c07ae5d8 d0a2a484 bf002060 bf0004f8 00000000
>> fe80: b6d17910 c017cf1c ce47cf00 d0a29000 ce47cf00 ce44ff34 000014fc 00000000
>> fea0: 00000000 00000000 bf00025c 00000001 00000000 00000000 6e72656b 00006c65
>> fec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> fee0: 00000000 00000000 00000000 00000000 00000000 c0ac9048 7fffffff 00000000
>> ff00: b6d17910 00000005 0000017b c0009208 ce44e000 00000000 b6ebfe54 c008562c
>> ff20: 7fffffff 00000000 00000003 cefd28f8 00000001 d0a29000 000014fc 00000000
>> ff40: d0a292cb d0a29380 d0a29000 000014fc d0a29f0c d0a29d90 d0a29a60 00000520
>> ff60: 00000710 00000718 00000826 00000000 00000000 00000000 00000708 00000023
>> ff80: 00000024 0000001c 00000000 00000016 00000000 c0ac9048 0041c620 00000000
>> ffa0: 00000000 c0009000 0041c620 00000000 00000005 b6d17910 00000000 00000000
>> ffc0: 0041c620 00000000 00000000 0000017b 0041f078 00000000 004098b0 b6ebfe54
>> ffe0: bedb6bc8 bedb6bb8 b6d0f91c b6c945a0 60000010 00000005 00000000 00000000
>> [<c0082930>] (frob_text.constprop.0) from [<c0084bb0>] (load_module+0x14b4/0x1d28)
>> [<c0084bb0>] (load_module) from [<c008562c>] (sys_finit_module+0xa0/0xc4)
>> [<c008562c>] (sys_finit_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
>> Exception stack(0xce44ffa8 to 0xce44fff0)
>> ffa0:                   0041c620 00000000 00000005 b6d17910 00000000 00000000
>> ffc0: 0041c620 00000000 00000000 0000017b 0041f078 00000000 004098b0 b6ebfe54
>> ffe0: bedb6bc8 bedb6bb8 b6d0f91c b6c945a0
>> Code: e7f001f2 e5931008 e1110002 0a000001 (e7f001f2)
>> ---[ end trace e904557128d9aed5 ]---
>>
>> This patch enables page-aligned allocation when
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX is enabled.
>>
>> Fixes: 93651f80dcb6 ("modules: fix compile error if don't have strict module rwx")
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>
> Hi!
>
> I have already committed a fix for this to modules-next and plan to
> send a pull request next week.

Thanks for pointing out :)

https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/commit/?h=modules-next&id=38f054d549a869f22a02224cd276a27bf14b6171

But I'd suggest we should keep the case of "define debug_align(X) (X)" for all
the rest arches without CONFIG_HAS_STRICT_MODULE_RWX ability, which would save
people who are sensitive to system size a lot of memory when using modules,
especially for embedded systems, as this patch did. This seems the original
intention of this #ifdef... statement and still valid for now.

Zhe

>
> Thanks!
>
> Jessica
>

