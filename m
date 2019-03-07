Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5809FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHiVPwWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCGASB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:18:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGASA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:18:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2704Z8n124182;
        Thu, 7 Mar 2019 00:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1SSZKMewF3WkzE1mzuK0CNh8oEr66tJRi9S895bMdCU=;
 b=jHiVPwWd3BlJYp8fneR7mB+nGICQf8Gt+VHVCBAsjGYPW2f8giLaYJgCve0Iai3Id0On
 EUGrVJOcF0WvOaSF2KkAC7hqwLlE67FcXBxR3ysYCzQTHI/jfBmH7xy5xiG1VaQaiBWr
 raSoliwOmnDSfjEZpIA7/OXYjT3yxjYg9uHCgEuS6RZo6vO/bk0B2wKGARi0foHZ8oCC
 eMygVw3J2JG0tNPZX+egVEWdDHnVxdPkFOTRR5VDhPvGm/abbMkvGOlbP5RA/9y09xWn
 Bbm7GqYw63XxPpQbi6iKFK5uqgzSNjSJKPwuhSKj4lG1PdS10ZGQ0tmy78D2I3Z4q04D Vg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qyh8uf375-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Mar 2019 00:17:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x270HdpG019570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 00:17:39 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x270HaEn008410;
        Thu, 7 Mar 2019 00:17:37 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 16:17:36 -0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
References: <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
 <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
 <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
 <20190305000402.GA4698@hori.linux.bs1.fc.nec.co.jp>
 <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
 <20190306094130.q5v7qfgbekatnmyk@d104.suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <acfbbd1d-2889-1737-d84c-03bbf0f03657@oracle.com>
Date:   Wed, 6 Mar 2019 16:17:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190306094130.q5v7qfgbekatnmyk@d104.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 1:41 AM, Oscar Salvador wrote:
> On Mon, Mar 04, 2019 at 08:15:40PM -0800, Mike Kravetz wrote:
>> In addition, the code in __nr_hugepages_store_common() which tries to
>> handle the case of not being able to allocate a node mask would likely
>> result in incorrect behavior.  Luckily, it is very unlikely we will
>> ever take this path.  If we do, simply return ENOMEM.
> 
> Hi Mike,
> 
> I still thnk that we could just get rid of the NODEMASK_ALLOC machinery
> here, it adds a needlessly complexity IMHO.
> Note that before "(5df66d306ec9: mm: fix comment for NODEMASK_ALLOC)",
> the comment about the size was wrong, showing a much bigger size that it
> actually was, and I would not be surprised if people started to add
> NODEMASK_ALLOC here and there because of that.
> 
> Actually, there was a little talk about removing NODEMASK_ALLOC altogether,
> but some further checks must be done before.

Thanks for the information.  I too saw or remembered a large byte value. :(
A quick grep doesn't reveal any configurable way to get NODE_SHIFT larger
than 10.  Of course, that could change.  So, it does seem a bit funny that
NODEMASK_ALLOC() kicks into dynamic allocation mode with NODE_SHIFT > 8.
Although, my desktop distro has NODE_SHIFT set to 10.

>> Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> But the overall change looks good to me:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.
I'm going to leave as is for now and put off removal of the dynamic allocation
for a later time.  Unless, you get around to removing NODEMASK_ALLOC
altogether. :)
-- 
Mike Kravetz
