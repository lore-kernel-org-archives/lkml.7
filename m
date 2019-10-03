Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6071921A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AsjiUbBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfJCJxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:53:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfJCJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:53:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x939n7cB003263;
        Thu, 3 Oct 2019 09:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=OGCsoYWUTAHGPkhKorSnO+N61wFEeMCh2U+hapf2L9Y=;
 b=AsjiUbBHCDlKLuYuC11WX7hHW8Az5zIEhG3Dwi19aST/2w8PkzqayVo0h4MGdH06HLs5
 33QJbmEJ4qA4XUxqkS4j+8BR2HATBHSLjN+tDY9Q+Ar72ZMndoAXNYJgEa7gJC+4Aten
 /4I7C30qUXIj/8FeZEVVRTB4vC8FvWKI1HqRWv7YgCy7rzBfS86gFkvtpjFn4qfHYdox
 Mlt0zYpiJKsDsw7m96kDsRjbOyM6iCvOHkjmLYUOUMwvdnndmynMmnrhfRxrcRklC1Kb
 5GfTUSCl/Jbqs3FalkU/BcpqQUgvvInWi6qGB0Vodq01XVMTscdKZ6k0fIZEq0WX6/W/ Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfqjp0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 09:51:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x939n1MW159306;
        Thu, 3 Oct 2019 09:51:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vcg63a19k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 09:51:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x939pCcs025867;
        Thu, 3 Oct 2019 09:51:12 GMT
Received: from [10.191.0.240] (/10.191.0.240)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 02:51:12 -0700
Subject: Re: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV
 spinlocks
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
 <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com>
 <87pnjh3i6i.fsf@vitty.brq.redhat.com>
 <aae59646-be5f-6455-a033-ed29861107ce@oracle.com>
 <87eezw3lna.fsf@vitty.brq.redhat.com>
 <fdd14f28-74e9-5cf9-2f5a-09c884c55110@oracle.com>
 <20191002164730.GA9615@linux.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <07f979cc-04b8-6901-b7b0-3e9f06655eb6@oracle.com>
Date:   Thu, 3 Oct 2019 17:51:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002164730.GA9615@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/3 0:47, Sean Christopherson wrote:
> On Tue, Oct 01, 2019 at 05:47:00PM +0800, Zhenzhong Duan wrote:
>> On 2019/10/1 16:39, Vitaly Kuznetsov wrote:
>>> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>>>
>>>> On 2019/9/30 23:41, Vitaly Kuznetsov wrote:
>>>>> Zhenzhong Duan<zhenzhong.duan@oracle.com>   writes:
>>>>>
>>>>>> There are cases where a guest tries to switch spinlocks to bare metal
>>>>>> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
>>>>>> "hv_nopvspin" on HYPER_V).
>>>>>>
>>>>>> That feature is missed on KVM, add a new parameter "nopvspin" to disable
>>>>>> PV spinlocks for KVM guest.
>>>>>>
>>>>>> This new parameter is also intended to replace "xen_nopvspin" and
>>>>>> "hv_nopvspin" in the future.
>>>>> Any reason to not do it right now? We will probably need to have compat
>>>>> code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
>>>>> warning.
>>>> Sorry the description isn't clear, I'll fix it.
>>>>
>>>> I did the compat work in the other two patches.
>>>> [PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
>>>> [PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"
>>>>
>>> For some reason I got CCed only on the first one and moreover,
>> The three patches have different maintainers/reviewers by get_maintainer.pl, I added
>> "Cc: maintainers/reviewers" to each patch then git-sendemail picked them automaticly.
>> I meaned to not disturb maintainers with the field they aren't in charge of. It looks
>> I'm wrong.
>>
>> So what's the correct way dealing with this? Should I send the whole patchset to all
>> the maintainers/reviewers related to all the patches?
> There's no one right answer to that question, folks have different
> preferences.  My general rule of thumb is to cc everyone on all patches
> unless the series is obnoxiously large *and* isolated to a specific part
> of the kernel.  The idea being that people are more likely to be annoyed
> if they can't find all patches in a relatively small series (this case)
> than they are about receiving a mail or two that they don't care about.
>
> At a minimum I would cc everyone involved on the cover letter, and cc the
> relevant mailing lists on all patches.  Sending everyone the cover letter
> provides people a quick overview of the patches they didn't receive, as
> well as a starting point if they want to find those patches.  Cc'ing the
> mailing list(s) can make it even easier to find the patches.  The cover
> letter is also a good place to explain why you didn't cc everyone on all
> patches (or vice versa).
>
> Also, the cover letter should have the shortlog and overall diffstats.
> 'git format-patch --cover-letter' will do the work for you.

Thanks for your detailed reply, I's clear to me what to do now.

Zhenzhong

