Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKLMXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:23:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbfKLMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:23:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACCELoO132483;
        Tue, 12 Nov 2019 07:23:09 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7t3nedgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 07:23:08 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACCMPLf022829;
        Tue, 12 Nov 2019 12:23:11 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 2w5n36ef95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 12:23:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACCN67P49480032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 12:23:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B2E6A04F;
        Tue, 12 Nov 2019 12:23:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AB26A054;
        Tue, 12 Nov 2019 12:23:02 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 12:23:01 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz\@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge() check
In-Reply-To: <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de> <20191017142123.24245-2-osalvador@suse.de> <20191018114832.GK5017@dhcp22.suse.cz> <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
Date:   Tue, 12 Nov 2019 17:52:58 +0530
Message-ID: <87d0dxs2ql.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:

> On Fri, Oct 18, 2019 at 01:48:32PM +0200, Michal Hocko wrote:
>> On Thu 17-10-19 16:21:08, Oscar Salvador wrote:
>> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> > 
>> > Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
>> > for hugetlb pages.
>> > 
>> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> 
>> s-o-b chain is reversed.
>> 
>> The code is a bit confusing. Doesn't this check aim for THP?
>
> No, PageHuge() is false for thp, so this if branch is just dead code.

memory_failure()
{

	if (PageTransHuge(hpage)) {
		lock_page(p);
		if (!PageAnon(p) || unlikely(split_huge_page(p))) {
			unlock_page(p);
			if (!PageAnon(p))
				pr_err("Memory failure: %#lx: non anonymous thp\n",
					pfn);
			else
				pr_err("Memory failure: %#lx: thp split failed\n",
					pfn);
			if (TestClearPageHWPoison(p))
				num_poisoned_pages_dec();
			put_hwpoison_page(p);
			return -EBUSY;
		}
		unlock_page(p);
		VM_BUG_ON_PAGE(!page_count(p), p);
		hpage = compound_head(p);
	}

}

Do we need that hpage = compund_head(p) conversion there? We should just
be able to say hpage = p, or even better after this change use p
directly instead of hpage in the code following?

-aneesh
