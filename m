Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8000C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F7721855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ABhSqkzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfJAJtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:49:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44584 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfJAJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:49:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x919hx45060644;
        Tue, 1 Oct 2019 09:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=QPjvS7pz5tIQQU5cF/g5uMUHXnY7G8jmZ86TF4PFwxk=;
 b=ABhSqkzjBzS9+njIAWGggtOpAULaed8C76pb2qwtInbR4d0D4jeQQs83IKqUWgjX7thH
 IkMhNfx7+b9z7nSQEOHyvmGKgYsjLuJY5Fak45e17OdWAJzIoAYh/x22lLXADsWwLT3x
 AJcQQSHr+ZeRD3TiUoQnF8HOcgCkoXmQt+y8yUyVxTxVGLygQ4TBNCCTGpBYzaF3XKaT
 WWFncl219f7rnDgtaVnNxqF/FSoVleIOLkASDXMUma1W2uyZZ3WcJa9YtvUkJhlKLc5/
 XfP19fuxIboczDc405i7OsmivKhJKNbjBuAA8igPh4+vEEZOIn/IkxsIy4qGltIazRVy mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxumq7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:47:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x919i0iA021658;
        Tue, 1 Oct 2019 09:47:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vbnqcjbhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:47:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x919l7WS019913;
        Tue, 1 Oct 2019 09:47:07 GMT
Received: from [10.191.2.232] (/10.191.2.232)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 02:47:06 -0700
Subject: Re: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV
 spinlocks
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <fdd14f28-74e9-5cf9-2f5a-09c884c55110@oracle.com>
Date:   Tue, 1 Oct 2019 17:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87eezw3lna.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/1 16:39, Vitaly Kuznetsov wrote:
> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>
>> On 2019/9/30 23:41, Vitaly Kuznetsov wrote:
>>> Zhenzhong Duan<zhenzhong.duan@oracle.com>   writes:
>>>
>>>> There are cases where a guest tries to switch spinlocks to bare metal
>>>> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
>>>> "hv_nopvspin" on HYPER_V).
>>>>
>>>> That feature is missed on KVM, add a new parameter "nopvspin" to disable
>>>> PV spinlocks for KVM guest.
>>>>
>>>> This new parameter is also intended to replace "xen_nopvspin" and
>>>> "hv_nopvspin" in the future.
>>> Any reason to not do it right now? We will probably need to have compat
>>> code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
>>> warning.
>> Sorry the description isn't clear, I'll fix it.
>>
>> I did the compat work in the other two patches.
>> [PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
>> [PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"
>>
> For some reason I got CCed only on the first one and moreover,

The three patches have different maintainers/reviewers by get_maintainer.pl, I added
"Cc: maintainers/reviewers" to each patch then git-sendemail picked them automaticly.
I meaned to not disturb maintainers with the field they aren't in charge of. It looks
I'm wrong.

So what's the correct way dealing with this? Should I send the whole patchset to all
the maintainers/reviewers related to all the patches?

> I don't see e.g PATCH3 on 'linux-hyperv' mailing list.

Thanks for point out, I'll add it.

Zhenzhong

