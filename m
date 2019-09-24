Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67DE207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfIXUFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:05:10 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:16700 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbfIXUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:05:09 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OJuYap023126;
        Tue, 24 Sep 2019 20:04:44 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2v7qkdj4ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 20:04:44 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id A760F53;
        Tue, 24 Sep 2019 20:04:42 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 020674A;
        Tue, 24 Sep 2019 20:04:40 +0000 (UTC)
Date:   Tue, 24 Sep 2019 15:04:40 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH v2 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190924200440.GC8138@swahl-linux>
References: <cover.1569004922.git.steve.wahl@hpe.com>
 <51b87d62e0cade3c46a69706b9be249190abc7bd.1569004923.git.steve.wahl@hpe.com>
 <63a38733-974f-9032-1980-9a8289d72d21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a38733-974f-9032-1980-9a8289d72d21@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909240164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 02:19:46PM -0700, Dave Hansen wrote:
> On 9/23/19 11:15 AM, Steve Wahl wrote:
> >  	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
> > -	for (i = 0; i < PTRS_PER_PMD; i++) {
> > +	for (i = 0; i < pmd_index((unsigned long)_text); i++)
> > +		pmd[i] &= ~_PAGE_PRESENT;
> > +
> > +	for (; i <= pmd_index((unsigned long)_end); i++)
> >  		if (pmd[i] & _PAGE_PRESENT)
> >  			pmd[i] += load_delta;
> > -	}
> > +
> > +	for (; i < PTRS_PER_PMD; i++)
> > +		pmd[i] &= ~_PAGE_PRESENT;
> 
> This is looking a bunch better.  The broken-up loop could probably use
> some comments, or you could combine it back to a single loop like this:
> 
> 	int text_start_pmd_index = pmd_index((unsigned long)_text);
> 	int text_end_pmd_index   = pmd_index((unsigned long)_end);
> 
> 	for (i = 0; i < PTRS_PER_PMD; i++) {
> 		if ((i < text_start_pmd_index) ||
> 		    (i > text_end_pmd_index)) {
> 			/* Unmap entries not mapping the kernel image */
> 			pmd[i] &= ~_PAGE_PRESENT;
> 		} else if (pmd[i] & _PAGE_PRESENT)
>  			pmd[i] += load_delta;
> 		}
> 	}

That's funny, I wrote it very close to that way initially, and
re-wrote it broken-up loop style because I thought it better conveyed
my intention.  (Mark pages before the kernel image as invalid, fixup
the pages that are in kernel image range, mark pages after the kernel
image as invalid.)

Given that, would you feel better with A) the way I have it, B) your
rewrite, or C) with an inline comment for each part of the loop:

	pmd = fixup_pointer(level2_kernel_pgt, physaddr);

	/* invalidate pages before the kernel image */
	for (i = 0; i < pmd_index((unsigned long)_text); i++)
		pmd[i] &= ~_PAGE_PRESENT;

	/* fixup pages that are part of the kernel image */
	for (; i <= pmd_index((unsigned long)_end); i++)
		if (pmd[i] & _PAGE_PRESENT)
			pmd[i] += load_delta;

	/* invalidate pages after the kernel image */
	for (; i < PTRS_PER_PMD; i++)
		pmd[i] &= ~_PAGE_PRESENT;

> Although I'd prefer it get commented or rewritten, it's passable like
> this, so:
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks for your input!  

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
