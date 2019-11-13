Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8337C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4CF2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwIK7Grw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKMANk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:13:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMANk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:13:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACNXhsr125757;
        Wed, 13 Nov 2019 00:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aBjdlyqnfWPXlqSsbdv0pxkJEe24Tv2XVSgjy0c1cSA=;
 b=HwIK7GrwceEb8A8zY2CwZ40w0ulh59IDEyWSSfX9p6qUJOXWUJOYFrYPo3LvkyAPf4zw
 uut/jmVicJEdCvtG09slcYOFZcv1nEzqDkujITh4SLmUSBZUyrJgWtj33/cRkvzSj0o9
 YLlIuH1hhRBzBduqkpLd3+mTtmtVD2hf9mWYfh4bailKsO3evcUQuW1WZLCCdOynUy+M
 7RimYdbu/l+9AFkJMPp5rlHcLz5YnYBOde13GwKfpyKfL/pKa8KH5bnHyIPw37G1ziGJ
 VzpoueR4vnv5BYf6KPnXDuLL8/Ys3epDYGpPGLbUCfDDy/tdNddzxqo/OhvSUvAC23v3 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w5ndq8dxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 00:13:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACNXexW105277;
        Wed, 13 Nov 2019 00:11:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w7vbbtffr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 00:11:21 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAD0BJKR026882;
        Wed, 13 Nov 2019 00:11:19 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 00:11:18 +0000
Subject: Re: [PATCH 2/2] hugetlbfs: convert macros to static inline, fix
 sparse warning
To:     Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, kbuild@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191112194558.139389-1-mike.kravetz@oracle.com>
 <20191112194558.139389-3-mike.kravetz@oracle.com>
 <a7fddda6f3e47b6aeb5d6d6ea9ea28ec019d3d94.camel@perches.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9fcd46c5-aeda-ba08-bebe-bcd61cea13e6@oracle.com>
Date:   Tue, 12 Nov 2019 16:11:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a7fddda6f3e47b6aeb5d6d6ea9ea28ec019d3d94.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 1:13 PM, Joe Perches wrote:
> On Tue, 2019-11-12 at 11:45 -0800, Mike Kravetz wrote:
>> huge_pte_offset() produced a sparse warning due to an improper
>> return type when the kernel was built with !CONFIG_HUGETLB_PAGE.
>> Fix the bad type and also convert all the macros in this block
>> to static inline wrappers.  Two existing wrappers in this block
>> had lines in excess of 80 columns so clean those up as well.
>>
>> No functional change.
>>
>> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  include/linux/hugetlb.h | 137 +++++++++++++++++++++++++++++++++-------
>>  1 file changed, 115 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 53fc34f930d0..ef412fe0be3d 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -164,38 +164,130 @@ static inline void adjust_range_if_pmd_sharing_possible(
>>  {
>>  }
>>  
>> -#define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
>> -#define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
>> -#define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
>> +static inline long follow_hugetlb_page(struct mm_struct *mm,
>> +			struct vm_area_struct *vma, struct page **pages,
>> +			struct vm_area_struct **vmas, unsigned long *position,
>> +			unsigned long *nr_pages, long i, unsigned int flags,
>> +			int *nonblocking)
>> +{
>> +	BUG();
> 
> While this is not different from the original, perhaps this is
> also an opportunity to change the BUG()s to WARN()s.

Yes, I saw all those warnings from checkpatch.  I'll add this as a 'to do'.
There are a bunch of these in hugetlbfs code and headers.  I'd really to
take a closer look at all of these and try to do something more intelligent.

-- 
Mike Kravetz
