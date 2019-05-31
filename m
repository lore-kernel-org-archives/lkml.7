Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F95C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D3E2635B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEaAvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:51:15 -0400
Received: from mail1.windriver.com ([147.11.146.13]:52631 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEaAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:51:14 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x4V0owUw022099
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 30 May 2019 17:50:58 -0700 (PDT)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 30 May
 2019 17:50:58 -0700
Subject: Re: Userspace woes with 5.1.5 due to TIPC
To:     Mihai Moldovan <ionic@ionic.de>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4ad776cb-c597-da1d-7d5e-af39ded17c40@ionic.de>
 <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
 <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <3cc60b11-2b63-3bfc-2be8-569f2b0ce7cf@windriver.com>
Date:   Fri, 31 May 2019 08:41:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 4:47 AM, Mihai Moldovan wrote:
> * On 5/30/19 9:51 PM, Jon Maloy wrote:
>> Make sure the following three commits are present in TIPC *after* the offending commit:
>>
>> commit 532b0f7ece4c "tipc: fix modprobe tipc failed after switch order of device registration"
> 
> This *is* the offending commit, as far as I understand. Merely rebased in
> linux-stable, and hence having a different SHA, but mentioning the original SHA
> (i.e., 532b0f7ece4c) in its commit message.
> 
> 
>> Since that patch one was flawed it had to be reverted:
>> commit 5593530e5694  ""Revert tipc: fix modprobe tipc failed after switch order of device registration"
>>
>> It was then replaced with this one: 
>> commit 526f5b851a96 "tipc: fix modprobe tipc failed after switch order of device registration"
> 
> Okay, these two are not part of 5.1.5. I've backported them (and only these two)
> to 5.1.5 and the issue(s) seem to be gone. Definitely something that should be
> backported to/included in 5.1.6.
> 
> 
> Thanks for pointing all that out! Unfortunately I didn't add anything useful but
> noise, since you obviously already knew, that this commit was broken. I'd urge
> Greg to release a new stable version including the fixes soon, if possible,
> though, for not being able to start/use userspace browsers sounds like a pretty
> bad regression to me.
> 

Not only commit 526f5b851a96 )("tipc: fix modprobe tipc failed after
switch order of device registration") has to be reverted, but also I
found commit 7e27e8d6130c ("tipc: switch order of device registration to
fix a crash") introduced a serious regression which makes tipc internal
topology service server failed to be created.

Today I will fix it with the following approaches:
1. Revert commit 7e27e8d6130c ("tipc: switch order of device
registration to fix a crash")
2. Use another method to solve the problem that commit 7e27e8d6130c
tries to fix.

Thanks,
Ying

> 
> 
> Mihai
> 
