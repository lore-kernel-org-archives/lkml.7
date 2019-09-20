Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DF7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A6208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfITP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:59:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfITP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:59:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KFldr2115419;
        Fri, 20 Sep 2019 11:58:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v510s2apx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 11:58:53 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8KFlmF2116337;
        Fri, 20 Sep 2019 11:58:53 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v510s2aph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 11:58:53 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8KFqQ3W019892;
        Fri, 20 Sep 2019 15:58:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2v3vbutx4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 15:58:52 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8KFwqOu54198602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 15:58:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4CB112063;
        Fri, 20 Sep 2019 15:58:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99611112062;
        Fri, 20 Sep 2019 15:58:48 +0000 (GMT)
Received: from [9.199.44.128] (unknown [9.199.44.128])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Sep 2019 15:58:48 +0000 (GMT)
Subject: Re: [PATCH 3/3] mm:fix gup_pud_range
To:     Qiujun Huang <hqjagain@gmail.com>, akpm@linux-foundation.org
Cc:     ira.weiny@intel.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, jhubbard@nvidia.com, keith.busch@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <2b9d2a82-ad48-f493-b53e-b34de28980c7@linux.ibm.com>
Date:   Fri, 20 Sep 2019 21:28:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909200144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 9:21 PM, Qiujun Huang wrote:
> __get_user_pages_fast try to walk the page table but the
> hugepage pte is replace by hwpoison swap entry by mca path.
> ...


Can you describe this in more details. I guess you are facing the issue 
with respect PUD level PTE entry that got updated by hwpoison as a swap 
entry. Since we don't specifically check for pud_present(), we walk the 
page table with wrong values and that results in corruption?


> [15798.177437] mce: Uncorrected hardware memory error in
> 				user-access at 224f1761c0
> [15798.180171] MCE 0x224f176: Killing pal_main:6784 due to
> 				hardware memory corruption
> [15798.180176] MCE 0x224f176: Killing qemu-system-x86:167336
> 				due to hardware memory corruption
> ...
> [15798.180206] BUG: unable to handle kernel
> [15798.180226] paging request at ffff891200003000
> [15798.180236] IP: [<ffffffff8106edae>] gup_pud_range+
> 				0x13e/0x1e0
> ...
> 
> We need to skip the hwpoison entry in gup_pud_range.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>   mm/gup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98f13ab..6157ed9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>   		next = pud_addr_end(addr, end);
>   		if (pud_none(pud))
>   			return 0;
> +		if (unlikely(!pud_present(pud)))
> +			return 0;


You should be able to remove that if (pud_none(pud)) check and just keep 
the pud_present() check?

>   		if (unlikely(pud_huge(pud))) {
>   			if (!gup_huge_pud(pud, pudp, addr, next, flags,
>   					  pages, nr))
> 

