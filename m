Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FABC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133E520656
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKROQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:16:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbfKROQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:16:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIE07GN132174
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:16:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way20gke5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:16:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 18 Nov 2019 14:16:26 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 14:16:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAIEFjFR37683604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 14:15:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BDBA4C04E;
        Mon, 18 Nov 2019 14:16:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9CE4C044;
        Mon, 18 Nov 2019 14:16:22 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.151])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 14:16:22 +0000 (GMT)
Subject: Re: [PATCH] perf: Fix the mlock accounting, again
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20191115160818.6480-1-alexander.shishkin@linux.intel.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 18 Nov 2019 15:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115160818.6480-1-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111814-0012-0000-0000-00000366D5EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111814-0013-0000-0000-000021A25B98
Message-Id: <341c1186-888f-3cd4-069b-4ba252f23958@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_03:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=2 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 5:08 PM, Alexander Shishkin wrote:
> Commit
> 
>   5e6c3c7b1ec2 ("perf/aux: Fix tracking of auxiliary trace buffer allocation")
> 
> tried to guess the correct combination of arithmetic operations that would
> undo the AUX buffer's mlock accounting, and failed, leaking the bottom part
> when an allocation needs to be changed partially to both user->locked_vm
> and mm->pinned_vm, eventually leaving the user with no locked bonus:
> 
> $ perf record -e intel_pt//u -m1,128 uname
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.061 MB perf.data ]
> $ perf record -e intel_pt//u -m1,128 uname
> Permission error mapping pages.
> Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
> or try again with a smaller value of -m/--mmap_pages.
> (current value: 1,128)
> 
> Fix this by subtracting both locked and pinned counts when AUX buffer is
> unmapped.
> 
> Signefdoff-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  kernel/events/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 16d80ad8d6d7..522438887206 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5664,10 +5664,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  		perf_pmu_output_stop(event);
>  
>  		/* now it's safe to free the pages */
> -		if (!rb->aux_mmap_locked)
> -			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
> -		else
> -			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
> +		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
> +		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
>  
>  		/* this has to be the last one */
>  		rb_free_aux(rb);
> 

I have tested your patch on our test suite which discovered the original issue.
Your patch works nicely, thanks for fixing this.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

