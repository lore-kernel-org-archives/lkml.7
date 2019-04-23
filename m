Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5E218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfDWRH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:07:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728832AbfDWRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:07:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NH47C5089734
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:07:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s240rrhyg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:07:54 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 18:07:52 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 18:07:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NH7lCd8126550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 17:07:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F404204F;
        Tue, 23 Apr 2019 17:07:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A39DA42041;
        Tue, 23 Apr 2019 17:07:46 +0000 (GMT)
Received: from [9.145.7.116] (unknown [9.145.7.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 17:07:46 +0000 (GMT)
Subject: Re: [PATCH] x86/mpx: fix recursive munmap() corruption
To:     Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20190401141549.3F4721FE@viggo.jf.intel.com>
 <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
 <87d0lht1c0.fsf@concordia.ellerman.id.au>
 <6718ede2-1fcb-1a8f-a116-250eef6416c7@linux.vnet.ibm.com>
 <4f43d4d4-832d-37bc-be7f-da0da735bbec@intel.com>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Tue, 23 Apr 2019 19:07:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4f43d4d4-832d-37bc-be7f-da0da735bbec@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042317-0008-0000-0000-000002DCF296
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042317-0009-0000-0000-000022494472
Message-Id: <4e1bbb14-e14f-8643-2072-17b4cdef5326@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2019 à 18:04, Dave Hansen a écrit :
> On 4/23/19 4:16 AM, Laurent Dufour wrote:
>> My only concern is the error path.
>> Calling arch_unmap() before handling any error case means that it will
>> have to be undo and there is no way to do so.
> 
> Is there a practical scenario where munmap() of the VDSO can split a
> VMA?  If the VDSO is guaranteed to be a single page, it would have to be
> a scenario where munmap() was called on a range that included the VDSO
> *and* other VMA that we failed to split.
> 
> But, the scenario would have to be that someone tried to munmap() the
> VDSO and something adjacent, the munmap() failed, and they kept on using
> the VDSO and expected the special signal and perf behavior to be maintained.

I've to admit that this should not be a common scenario, and unmapping 
the VDSO is not so common anyway.

> BTW, what keeps the VDSO from merging with an adjacent VMA?  Is it just
> the vm_ops->close that comes from special_mapping_vmops?

I'd think so.

>> I don't know what is the rational to move arch_unmap() to the beginning
>> of __do_munmap() but the error paths must be managed.
> 
> It's in the changelog:
> 
> 	https://patchwork.kernel.org/patch/10909727/
> 
> But, the tl;dr version is: x86 is recursively calling __do_unmap() (via
> arch_unmap()) in a spot where the internal rbtree data is inconsistent,
> which causes all kinds of fun.  If we move arch_unmap() to before
> __do_munmap() does any data structure manipulation, the recursive call
> doesn't get confused any more.

If only Powerpc is impacted I guess this would be fine but what about 
the other architectures?

>> There are 2 assumptions here:
>>   1. 'start' and 'end' are page aligned (this is guaranteed by __do_munmap().
>>   2. the VDSO is 1 page (this is guaranteed by the union vdso_data_store on powerpc)
> 
> Are you sure about #2?  The 'vdso64_pages' variable seems rather
> unnecessary if the VDSO is only 1 page. ;)

Hum, not so sure now ;)
I got confused, only the header is one page.
The test is working as a best effort, and don't cover the case where 
only few pages inside the VDSO are unmmapped (start > 
mm->context.vdso_base). This is not what CRIU is doing and so this was 
enough for CRIU support.

Michael, do you think there is a need to manage all the possibility 
here, since the only user is CRIU and unmapping the VDSO is not a so 
good idea for other processes ?

