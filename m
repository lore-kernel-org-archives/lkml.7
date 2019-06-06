Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8237C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308020673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFFIV3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:21:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfFFIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:21:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x568Idka111736
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 04:21:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sxx14usm7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:21:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Thu, 6 Jun 2019 09:21:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 09:21:22 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x568LLRj63045844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 08:21:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B92C6A405B;
        Thu,  6 Jun 2019 08:21:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B507A4054;
        Thu,  6 Jun 2019 08:21:21 +0000 (GMT)
Received: from localhost (unknown [9.122.211.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 08:21:21 +0000 (GMT)
Date:   Thu, 06 Jun 2019 13:51:20 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] Powerpc/Watchpoint: Restore nvgprs while returning from
 exception
To:     mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mahesh@linux.vnet.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        paulus@samba.org
References: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19060608-4275-0000-0000-0000033F4CA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060608-4276-0000-0000-0000384F5055
Message-Id: <1559809100.x2v1my2997.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria wrote:
> Powerpc hw triggers watchpoint before executing the instruction.
> To make trigger-after-execute behavior, kernel emulates the
> instruction. If the instruction is 'load something into non-
> volatile register', exception handler should restore emulated
> register state while returning back, otherwise there will be
> register state corruption. Ex, Adding a watchpoint on a list
> can corrput the list:
> 
>   # cat /proc/kallsyms | grep kthread_create_list
>   c00000000121c8b8 d kthread_create_list
> 
> Add watchpoint on kthread_create_list->next:
> 
>   # perf record -e mem:0xc00000000121c8c0
> 
> Run some workload such that new kthread gets invoked. Ex, I
> just logged out from console:
> 
>   list_add corruption. next->prev should be prev (c000000001214e00), \
> 	but was c00000000121c8b8. (next=c00000000121c8b8).
>   WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/0xc0
>   CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7+ #69
>   ...
>   NIP __list_add_valid+0xb4/0xc0
>   LR __list_add_valid+0xb0/0xc0
>   Call Trace:
>   __list_add_valid+0xb0/0xc0 (unreliable)
>   __kthread_create_on_node+0xe0/0x260
>   kthread_create_on_node+0x34/0x50
>   create_worker+0xe8/0x260
>   worker_thread+0x444/0x560
>   kthread+0x160/0x1a0
>   ret_from_kernel_thread+0x5c/0x70
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Awesome catch - this one has had a glorious run...
Fixes: 5aae8a5370802 ("powerpc, hw_breakpoints: Implement hw_breakpoints for 64-bit server processors")

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen


