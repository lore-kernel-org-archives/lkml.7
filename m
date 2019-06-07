Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9EDC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2365208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFGDSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:18:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbfFGDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:18:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5737P6Q018103
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 23:17:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sybst8ke5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:17:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 7 Jun 2019 04:17:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 04:17:54 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x573HrZP43909258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 03:17:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4505AA4051;
        Fri,  7 Jun 2019 03:17:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0BCFA404D;
        Fri,  7 Jun 2019 03:17:49 +0000 (GMT)
Received: from [9.199.59.123] (unknown [9.199.59.123])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 03:17:49 +0000 (GMT)
Subject: Re: [PATCH] Powerpc/Watchpoint: Restore nvgprs while returning from
 exception
To:     Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, mahesh@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
 <80cfc8d7327d3bb744ea1f7e2843943a998d48de.camel@neuling.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 7 Jun 2019 08:47:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <80cfc8d7327d3bb744ea1f7e2843943a998d48de.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060703-0020-0000-0000-00000347E8B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060703-0021-0000-0000-0000219AFFBF
Message-Id: <b6f6e2c7-f193-1721-de59-1e36127ceac1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/19 6:20 AM, Michael Neuling wrote:
> On Thu, 2019-06-06 at 12:59 +0530, Ravi Bangoria wrote:
>> Powerpc hw triggers watchpoint before executing the instruction.
>> To make trigger-after-execute behavior, kernel emulates the
>> instruction. If the instruction is 'load something into non-
>> volatile register', exception handler should restore emulated
>> register state while returning back, otherwise there will be
>> register state corruption. Ex, Adding a watchpoint on a list
>> can corrput the list:
>>
>>   # cat /proc/kallsyms | grep kthread_create_list
>>   c00000000121c8b8 d kthread_create_list
>>
>> Add watchpoint on kthread_create_list->next:
>>
>>   # perf record -e mem:0xc00000000121c8c0
>>
>> Run some workload such that new kthread gets invoked. Ex, I
>> just logged out from console:
>>
>>   list_add corruption. next->prev should be prev (c000000001214e00), \
>> 	but was c00000000121c8b8. (next=c00000000121c8b8).
>>   WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/0xc0
>>   CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7+ #69
>>   ...
>>   NIP __list_add_valid+0xb4/0xc0
>>   LR __list_add_valid+0xb0/0xc0
>>   Call Trace:
>>   __list_add_valid+0xb0/0xc0 (unreliable)
>>   __kthread_create_on_node+0xe0/0x260
>>   kthread_create_on_node+0x34/0x50
>>   create_worker+0xe8/0x260
>>   worker_thread+0x444/0x560
>>   kthread+0x160/0x1a0
>>   ret_from_kernel_thread+0x5c/0x70
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> How long has this been around? Should we be CCing stable?

"bl .save_nvgprs" was added in the commit 5aae8a5370802 ("powerpc, hw_breakpoints:
Implement hw_breakpoints for 64-bit server processors"), which was merged in
v2.6.36.

