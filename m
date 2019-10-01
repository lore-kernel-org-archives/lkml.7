Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4826C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D6D20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZrDDgQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfJAAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:38:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJAAi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:38:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x910TTPe027361;
        Tue, 1 Oct 2019 00:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=an4qCn0lo1ONNRru8fvD6bTdRSkLm7X31qWqshOz5iE=;
 b=iZrDDgQq6Qf2betTNeLaM2uQNWpbpLwezSTLTDku8owqpZjAXbc/Zyq7fFyz8vU61yr+
 3jW26spVdX6Ag8zhzW6yDjhuDb6NBBAHBRvEINIAWV7ps2otD6lBKNCiJfyzMHTzJ5cG
 QpEGf4SCWgRXMc3iv+ZwFJZHO+GutBfgPmYNtYrnYZUcxd/pQDqusvpSN73n/2gg0nGQ
 a8KgW/5Z5Bd2VAL1HXQl6m5kPJ5SjatYzRC35Umu7mNi6saasgzeZxUVmSpyBE6jNt/z
 jfm/IorKE+b4v5WL1MaU8bGeaIdyWbpYENGrGiDS+9m+Le/Sr+nBUgEOZy4cNDtVnicT ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v9xxujj6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 00:37:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x910SwGc040779;
        Tue, 1 Oct 2019 00:37:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vbqcyw423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 00:37:12 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x910b5J5008743;
        Tue, 1 Oct 2019 00:37:08 GMT
Received: from [10.191.5.100] (/10.191.5.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 17:37:05 -0700
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
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <aae59646-be5f-6455-a033-ed29861107ce@oracle.com>
Date:   Tue, 1 Oct 2019 08:36:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pnjh3i6i.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/30 23:41, Vitaly Kuznetsov wrote:
> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>
>> There are cases where a guest tries to switch spinlocks to bare metal
>> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
>> "hv_nopvspin" on HYPER_V).
>>
>> That feature is missed on KVM, add a new parameter "nopvspin" to disable
>> PV spinlocks for KVM guest.
>>
>> This new parameter is also intended to replace "xen_nopvspin" and
>> "hv_nopvspin" in the future.
> Any reason to not do it right now? We will probably need to have compat
> code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
> warning.

Sorry the description isn't clear, I'll fix it.

I did the compat work in the other two patches.
[PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
[PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"

>
>> The global variable pvspin isn't defined as __initdata as it's used at
>> runtime by XEN guest.
>>
>> Refactor the print stuff with pr_* which is preferred.
> Please do it in a separate patch.

Ok, I'll do that in v2. Thanks for review.

Zhenzhong

