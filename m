Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ADCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2421473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDHN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:28:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbfDHN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:28:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38DQIpS091620
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 09:28:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rr72m0e4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:28:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 8 Apr 2019 14:28:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 14:28:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x38DSOsA33816624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 13:28:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF0FCAE04D;
        Mon,  8 Apr 2019 13:28:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CB96AE051;
        Mon,  8 Apr 2019 13:28:24 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Apr 2019 13:28:24 +0000 (GMT)
Date:   Mon, 8 Apr 2019 15:28:23 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Silence compiler warning when compiling without
 CONFIG_PGSTE
References: <20190407125509.6380-1-thuth@redhat.com>
 <0e63589f-190f-d3a4-b373-4188dfe54e26@redhat.com>
 <84da6d4e-9b85-1c3b-4f48-bdb19ac7f650@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84da6d4e-9b85-1c3b-4f48-bdb19ac7f650@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19040813-0008-0000-0000-000002D7883D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040813-0009-0000-0000-00002243A41C
Message-Id: <20190408132823.GA13200@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=724 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:36:32PM +0200, Thomas Huth wrote:
> On 08/04/2019 09.09, David Hildenbrand wrote:
> > On 07.04.19 14:55, Thomas Huth wrote:
> >> If CONFIG_PGSTE is not set (e.g. when compiling without KVM), GCC complains:
> >>
> >>   CC      arch/s390/mm/pgtable.o
> >> arch/s390/mm/pgtable.c:413:15: warning: ‘pmd_alloc_map’ defined but not
> >>  used [-Wunused-function]
> >>  static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
> >>                ^~~~~~~~~~~~~
> >>
> >> Wrap the function with "#ifdef CONFIG_PGSTE" to silence the warning.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  arch/s390/mm/pgtable.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> >> index 8485d6dc2754..9ebd01219812 100644
> >> --- a/arch/s390/mm/pgtable.c
> >> +++ b/arch/s390/mm/pgtable.c
> >> @@ -410,6 +410,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
> >>  	return old;
> >>  }
> >>  
> >> +#ifdef CONFIG_PGSTE
> >>  static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
> >>  {
> >>  	pgd_t *pgd;
> >> @@ -427,6 +428,7 @@ static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
> >>  	pmd = pmd_alloc(mm, pud, addr);
> >>  	return pmd;
> >>  }
> >> +#endif
> >>  
> > 
> > We could also move the function down to the functions where it is used
> 
> Yeah, I thought about that, too. Both have advantages:
> 
> - If we keep the code here, "git blame" shows a nicer history of these
>   lines
> - If we move the code, we need less #ifdefs
> 
> I'll leave the decision to the maintainers... Martin, Heiko?

Applied without changes. Thanks!

