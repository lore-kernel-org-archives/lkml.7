Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92381CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6585A222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408041AbfJRMwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:52:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55480 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbfJRMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:39 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ICqZ26003195
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:52:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vq0ha83k6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:52:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 18 Oct 2019 13:52:31 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 13:52:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ICqQ5i42795446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 12:52:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78AC311C066;
        Fri, 18 Oct 2019 12:52:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E936F11C050;
        Fri, 18 Oct 2019 12:52:23 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.85.73.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 18 Oct 2019 12:52:23 +0000 (GMT)
Date:   Fri, 18 Oct 2019 18:22:23 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 5/5] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
 <20191017164223.2762148-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191017164223.2762148-6-songliubraving@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19101812-0016-0000-0000-000002B948EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101812-0017-0000-0000-0000331A7696
Message-Id: <20191018104349.GB29201@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Song Liu <songliubraving@fb.com> [2019-10-17 09:42:22]:

> Attaching uprobe to text section in THP splits the PMD mapped page table
> into PTE mapped entries. On uprobe detach, we would like to regroup PMD
> mapped page table entry to regain performance benefit of THP.
> 
> However, the regroup is broken For perf_event based trace_uprobe. This is
> because perf_event based trace_uprobe calls uprobe_unregister twice on
> close: first in TRACE_REG_PERF_CLOSE, then in TRACE_REG_PERF_UNREGISTER.
> The second call will split the PMD mapped page table entry, which is not
> the desired behavior.
> 
> Fix this by only use FOLL_SPLIT_PMD for uprobe register case.
> 
> Add a WARN() to confirm uprobe unregister never work on huge pages, and
> abort the operation when this WARN() triggers.
> 
> Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

>  kernel/events/uprobes.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 94d38a39d72e..c74761004ee5 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -474,14 +474,17 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	int ret, is_register, ref_ctr_updated = 0;
>  	bool orig_page_huge = false;
> +	unsigned int gup_flags = FOLL_FORCE;
> 
>  	is_register = is_swbp_insn(&opcode);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
> 
>  retry:
> +	if (is_register)
> +		gup_flags |= FOLL_SPLIT_PMD;
>  	/* Read the page with vaddr into memory */
> -	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> -			FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL);
> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
> +				    &old_page, &vma, NULL);
>  	if (ret <= 0)
>  		return ret;
> 
> @@ -489,6 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
> 
> +	if (WARN(!is_register && PageCompound(old_page),
> +		 "uprobe unregister should never work on compound page\n")) {
> +		ret = -EINVAL;
> +		goto put_old;
> +	}
> +
>  	/* We are going to replace instruction, update ref_ctr. */
>  	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
>  		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
> -- 
> 2.17.1
> 

-- 
Thanks and Regards
Srikar Dronamraju

