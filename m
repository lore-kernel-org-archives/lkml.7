Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91116C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE4218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFQGrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:47:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfFQGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:47:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H6gkVp083900
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:47:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t63h8vh3v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:47:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 17 Jun 2019 07:47:05 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 07:46:58 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5H6kvaZ37486936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 06:46:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 869A5A405B;
        Mon, 17 Jun 2019 06:46:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED690A4064;
        Mon, 17 Jun 2019 06:46:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Jun 2019 06:46:55 +0000 (GMT)
Date:   Mon, 17 Jun 2019 09:46:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Arun KS <arunks@codeaurora.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: Trigger bug on if a section is not found in
 __section_nr
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617043635.13201-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19061706-0020-0000-0000-0000034AB4D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061706-0021-0000-0000-0000219DF855
Message-Id: <20190617064653.GA16810@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:36:27PM +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> If a memory section comes in where the physical address is greater than
> that which is managed by the kernel, this function would not trigger the
> bug and instead return a bogus section number.
> 
> This patch tracks whether the section was actually found, and triggers the
> bug if not.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  mm/sparse.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index fd13166949b5..104a79fedd00 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -105,20 +105,23 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
>  int __section_nr(struct mem_section* ms)
>  {
>  	unsigned long root_nr;
> -	struct mem_section *root = NULL;
> +	struct mem_section *found = NULL;
> +	struct mem_section *root;
> 
>  	for (root_nr = 0; root_nr < NR_SECTION_ROOTS; root_nr++) {
>  		root = __nr_to_section(root_nr * SECTIONS_PER_ROOT);
>  		if (!root)
>  			continue;
> 
> -		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
> -		     break;
> +		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT))) {
> +			found = root;
> +			break;
> +		}
>  	}
> 
> -	VM_BUG_ON(!root);
> +	VM_BUG_ON(!found);

Isn't it enough to check for root_nr == NR_SECTION_ROOTS?

> 
> -	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
> +	return (root_nr * SECTIONS_PER_ROOT) + (ms - found);

It'll still return a bogus section number with CONFIG_DEBUG_VM=n

>  }
>  #else
>  int __section_nr(struct mem_section* ms)
> -- 
> 2.21.0
> 

-- 
Sincerely yours,
Mike.

