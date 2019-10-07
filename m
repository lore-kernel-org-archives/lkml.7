Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A9C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322EC20835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOdxOZ32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfJGWRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:17:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:17:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97MEP1n121984;
        Mon, 7 Oct 2019 22:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=24wnltpbsNiSThDHipt5aPeUqzFk/94/Ub8cB2WcU3I=;
 b=cOdxOZ32xX614k7xA+i0Ri2RSrfLJldIjb3ipoLtkDxP7KU+Tiqpjy1G2SNzD2oPF2wL
 2PIYbZyPrWn0FgrOGnHx/X9E+7C45Ls1jk+BiapyHyj46pN0ntsxVkk2rNtTN7upnofY
 UVgbM5EwSqeSxzu3zvmMAyqTRvZInTCe17w2dSgzbGlZ6YTl/yvLMU90cweeAZQbdozf
 l11k1bEwTfPllmlJuhsrzuNnH9t9YeinKoYyur/4YbIyXDtCtnca8rHIQFXvnRsT9iQl
 bimdKQSXd+1DZDG4FgyUEY/55l+K8BGNK6RflwphF7oosdWetQc/Do7vMCsRo/JCm00J Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejku9rc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 22:17:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97MDncm095674;
        Mon, 7 Oct 2019 22:15:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vg1yurgs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 22:15:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97MFXYF031629;
        Mon, 7 Oct 2019 22:15:33 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 15:15:33 -0700
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
 <d7752ddf-ccdc-9ff4-ab9f-529c2cd7f041@suse.cz>
 <alpine.DEB.2.21.1910031243050.88296@chino.kir.corp.google.com>
 <20191004092808.GC9578@dhcp22.suse.cz>
 <alpine.DEB.2.21.1910041058330.16371@chino.kir.corp.google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3c220179-09cc-569f-8cfa-8e2ab5212faa@oracle.com>
Date:   Mon, 7 Oct 2019 15:15:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910041058330.16371@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 11:02 AM, David Rientjes wrote:
> On Fri, 4 Oct 2019, Michal Hocko wrote:
> 
>> Requesting the userspace to drop _all_ page cache in order allocate a
>> number of hugetlb pages or any other affected __GFP_RETRY_MAYFAIL
>> requests is simply not reasonable IMHO.
> 
> It can be used as a fallback when writing to nr_hugepages and the amount 
> allocated did not match expectation.  Again, I'll defer all of this to 
> Mike when he returns: he expressed his preference, I suggested an 
> alternative to consider, and he can make the decision to ack or nack this 
> patch because he has a better understanding of that expectation from users 
> who use hugetlb pages.

I believe these modifications to commit b39d0ee2632d are absolutely necessary
to maintain expected hugetlbfs functionality.  Michal's simple test in the
rewritten commit message shows the type of regressions that I expect some
hugetlbfs users to experience.  The expectation today is that the kernel will
try hard to allocate the requested number of hugetlb pages.  These pages are
often used for very long running processes.  Therefore, the tradeoff of more
reclaim (and compaction) activity up front to create the pages is generally
acceptable.

My apologies if the 'testing' I did in [1] was taken as an endorsement of
b39d0ee2632d working well with hugetlbfs.  It was a limited test that I knew
did not cover all cases.  Therefore, I suggested that if b39d0ee2632d went
forward there should be an exception for __GFP_RETRY_MAYFAIL requests.

[1] https://lkml.kernel.org/r/3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com
-- 
Mike Kravetz
