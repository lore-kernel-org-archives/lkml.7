Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A1CC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F8C2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCVVoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:44:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfCVVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:44:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MLdT8X002986
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:44:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd4pyfeb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:44:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 22 Mar 2019 21:43:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 21:43:42 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MLhojT40632570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 21:43:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5F3452050;
        Fri, 22 Mar 2019 21:43:50 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.23])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 27A275204E;
        Fri, 22 Mar 2019 21:43:49 +0000 (GMT)
Date:   Fri, 22 Mar 2019 23:43:47 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 26/28] userfaultfd: wp: declare _UFFDIO_WRITEPROTECT
 conditionally
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-27-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320020642.4000-27-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032221-4275-0000-0000-0000031E3656
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032221-4276-0000-0000-0000382CC3A4
Message-Id: <20190322214346.GC9303@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=651 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:06:40AM +0800, Peter Xu wrote:
> Only declare _UFFDIO_WRITEPROTECT if the user specified
> UFFDIO_REGISTER_MODE_WP and if all the checks passed.  Then when the
> user registers regions with shmem/hugetlbfs we won't expose the new
> ioctl to them.  Even with complete anonymous memory range, we'll only
> expose the new WP ioctl bit if the register mode has MODE_WP.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/userfaultfd.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index f1f61a0278c2..7f87e9e4fb9b 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1456,14 +1456,24 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	up_write(&mm->mmap_sem);
>  	mmput(mm);
>  	if (!ret) {
> +		__u64 ioctls_out;
> +
> +		ioctls_out = basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
> +		    UFFD_API_RANGE_IOCTLS;
> +
> +		/*
> +		 * Declare the WP ioctl only if the WP mode is
> +		 * specified and all checks passed with the range
> +		 */
> +		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
> +			ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
> +
>  		/*
>  		 * Now that we scanned all vmas we can already tell
>  		 * userland which ioctls methods are guaranteed to
>  		 * succeed on this range.
>  		 */
> -		if (put_user(basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
> -			     UFFD_API_RANGE_IOCTLS,
> -			     &user_uffdio_register->ioctls))
> +		if (put_user(ioctls_out, &user_uffdio_register->ioctls))
>  			ret = -EFAULT;
>  	}
>  out:
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

