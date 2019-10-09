Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F378C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DB21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfJILtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:49:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbfJILts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:49:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCA2ABB2A54D7503D44C;
        Wed,  9 Oct 2019 19:49:46 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 19:49:37 +0800
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     James Clark <James.Clark@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@amd.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Al Grant" <Al.Grant@arm.com>, nd <nd@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
 <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
 <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
Message-ID: <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
Date:   Wed, 9 Oct 2019 19:49:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/9 19:09, Tan Xiaojun wrote:
> On 2019/10/9 17:48, James Clark wrote:
>> Hi Xiaojun,
>>
>>> By the way, you mentioned before that you want the spe event to be in the form of "event:pp" like pebs. Is that the whole framework should be made similar to pebs? Or is it just a modification to the command format? 
>>
>> We're currently still investigating if it makes sense to modify the Perf event open syscall to use SPE when the "precise_ip" attribute is set. And then synthesize samples using the SPE data when available. This would keep the syscall interface more consistent between architectures.
>>
>> And if tools other than Perf want more precise data, they don't have to be aware of SPE or any of the implementation defined details of it. For example the 'data source' encoding can be different from one micro architecture to the next. The kernel is probably the best place to handle this.
>>
>> At the moment, every tool that wants to use the Perf syscall to get precise data on ARM would have to be aware of SPE and implement their own decoding.
>>
> 
> Hi James,
> 
> What do you mean when the user specifies "event:pp", if the SPE is available, configure and record the spe data directly via the perf event open syscall?
> (perf.data itself is the same as using -e arm_spe_0//xxx?)

I mean, for the perf record, if the user does not add ":pp" to these events, the original process is taken, and if ":pp" is added, the spe process is taken.

Xiaojun.

> 
> OK. If I have not misunderstood, I think I know how to do it.
> Thank you.
> 
>>> For the former, this may be a bit difficult. For the latter, there is currently no modification to the record part, so "-c -F, etc." is only for instructions rather than events, so it may be misunderstood by users.
>>>
>>> So I haven't figured out how to do. What do you think of this?
>>
>> I think the patch at the moment is a good start to make SPE more accessible. And the changes I mentioned above wouldn't change the fact that the raw SPE data would still be available via the SPE PMU. So I think continuing with the patch as-is for now is the best idea.
>>
> 
> Yes. I agree.
> 
> Xiaojun.
> 
>>
>> James
>>
>>
> 


