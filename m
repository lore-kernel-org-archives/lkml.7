Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E25C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83645214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407204AbfHISz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:55:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407111AbfHISz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:55:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79IrX3d090368
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 14:55:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9dc42hky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:55:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Fri, 9 Aug 2019 19:55:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 19:55:52 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79Itp3c36438156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 18:55:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F27AE52054;
        Fri,  9 Aug 2019 18:55:50 +0000 (GMT)
Received: from [9.102.2.183] (unknown [9.102.2.183])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 32F6E52052;
        Fri,  9 Aug 2019 18:55:49 +0000 (GMT)
Subject: Re: [PATCH v8 1/7] powerpc/mce: Schedule work from irq_work
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
References: <20190807145700.25599-1-santosh@fossix.org>
 <20190807145700.25599-2-santosh@fossix.org>
From:   Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date:   Sat, 10 Aug 2019 00:25:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807145700.25599-2-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080918-0020-0000-0000-0000035DCFC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080918-0021-0000-0000-000021B2D870
Message-Id: <bbfb2cf0-50ae-3170-976b-adb6cd2d9f82@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 8:26 PM, Santosh Sivaraj wrote:
> schedule_work() cannot be called from MCE exception context as MCE can
> interrupt even in interrupt disabled context.
> 
> fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/kernel/mce.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index b18df633eae9..0ab6fa7cbbbb 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -144,7 +144,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
>  		if (phys_addr != ULONG_MAX) {
>  			mce->u.ue_error.physical_address_provided = true;
>  			mce->u.ue_error.physical_address = phys_addr;
> -			machine_check_ue_event(mce);
>  		}
>  	}
>  	return;
> @@ -275,8 +274,7 @@ static void machine_process_ue_event(struct work_struct *work)
>  	}
>  }
>  /*
> - * process pending MCE event from the mce event queue. This function will be
> - * called during syscall exit.
> + * process pending MCE event from the mce event queue.
>   */
>  static void machine_check_process_queued_event(struct irq_work *work)
>  {
> @@ -292,6 +290,10 @@ static void machine_check_process_queued_event(struct irq_work *work)
>  	while (__this_cpu_read(mce_queue_count) > 0) {
>  		index = __this_cpu_read(mce_queue_count) - 1;
>  		evt = this_cpu_ptr(&mce_event_queue[index]);
> +
> +		if (evt->error_type == MCE_ERROR_TYPE_UE)
> +			machine_check_ue_event(evt);

This will work only for the event that are queued by mce handler, others
will get ignored. I think you should introduce a separate irq work queue
for schedule_work().

Thanks,
-Mahesh.

