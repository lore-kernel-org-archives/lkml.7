Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB23C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8120835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbfDRO2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:28:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389146AbfDRO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:28:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IEJ2rS040587
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:28:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxqjs1ye1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:28:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Thu, 18 Apr 2019 15:28:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Apr 2019 15:27:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3IERteW53149868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 14:27:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91AC611C06E;
        Thu, 18 Apr 2019 14:27:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C83311C058;
        Thu, 18 Apr 2019 14:27:54 +0000 (GMT)
Received: from [9.145.32.15] (unknown [9.145.32.15])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Apr 2019 14:27:54 +0000 (GMT)
Subject: Re: [PATCH] prctl_set_mm: downgrade mmap_sem to read lock
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        arunks@codeaurora.org, brgl@bgdev.pl, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, rppt@linux.ibm.com, vbabka@suse.cz
References: <20190417145548.GN5878@dhcp22.suse.cz>
 <20190418135039.19987-1-mkoutny@suse.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Thu, 18 Apr 2019 16:27:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418135039.19987-1-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041814-4275-0000-0000-000003294817
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041814-4276-0000-0000-0000383881C8
Message-Id: <27defd37-7e4e-f919-fe0c-64e1efdafdcf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/04/2019 à 15:50, Michal Koutný a écrit :
> I learnt, it's, alas, too late to drop the non PRCTL_SET_MM_MAP calls
> [1], so at least downgrade the write acquisition of mmap_sem as in the
> patch below (that should be stacked on the previous one or squashed).
> 
> Cyrill, you mentioned lock changes in [1] but the link seems empty. Is
> it supposed to be [2]? That could be an alternative to this patch after
> some refreshments and clarifications.
> 
> 
> [1] https://lore.kernel.org/lkml/20190417165632.GC3040@uranus.lan/
> [2] https://lore.kernel.org/lkml/20180507075606.870903028@gmail.com/
> 
> ========
> 
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect
> arg_start|end and env_start|end in mm_struct") we use arg_lock for
> boundaries modifications. Synchronize prctl_set_mm with this lock and
> keep mmap_sem for reading only (analogous to what we already do in
> prctl_set_mm_map).
> 
> Also, save few cycles by looking up VMA only after performing basic
> arguments validation.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/sys.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..bbce0f26d707 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2125,8 +2125,12 @@ static int prctl_set_mm(int opt, unsigned long addr,
>   
>   	error = -EINVAL;
>   
> -	down_write(&mm->mmap_sem);
> -	vma = find_vma(mm, addr);
> +	/*
> +	 * arg_lock protects concurent updates of arg boundaries, we need mmap_sem for
> +	 * a) concurrent sys_brk, b) finding VMA for addr validation.
> +	 */
> +	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>   
>   	prctl_map.start_code	= mm->start_code;
>   	prctl_map.end_code	= mm->end_code;
> @@ -2185,6 +2189,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
>   	if (error)
>   		goto out;
>   
> +	vma = find_vma(mm, addr);

Why is find_vma() called while holding the arg_lock ?

To limit the time the spinlock is held, would it be better to
    	read_lock(mmap_sem)
    	find_vma()
    	spin_lock(arg_lock)
    	..
out:
	spin_unlock()
	up_read(mmap_sem)

Not sure this would change a lot the performance anyway.

>   	switch (opt) {
>   	/*
>   	 * If command line arguments and environment
> @@ -2218,7 +2223,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
>   
>   	error = 0;
>   out:
> -	up_write(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
> +	up_read(&mm->mmap_sem);
>   	return error;
>   }
>   
> 

