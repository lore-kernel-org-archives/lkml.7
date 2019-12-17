Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11333C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D954D2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chjhR3l4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfLQSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:34:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:34:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHIO4NX077747;
        Tue, 17 Dec 2019 18:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Nb3oRT5xQ7YhNFQhNAEMUTbWOzUZaQIt06N5VoFfOHk=;
 b=chjhR3l445a4eGlY3WXhLCoJJwqMSzrK3M+2t7gtvUM4adPrRcQ8urAYx9VeC1A/beX8
 x+YwMibzDX1DODh0m1Q0oLj4+ujKY/LloDyO09yYHwWf3V9NegdijVdZT3bjKzUXo/SZ
 lMmnZhxKLuCQ2wVU4O3KVvJLkO9STUSZnkEycDxTjdOlAGMGRPkgmcSvxyHH0X3RergF
 +4CUQN1oIiyx+N5T4zDYEcHBHjBzlAggDPoPOMddV7LSY86zyPLX9uQzMja7I3Hts6DG
 Fifk2yCfgZeDxKdq0OwNWt1HX9rj6+QUTauCSwjjqj6YBWzj+vxkb/znI3FhBQpDDrvf AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wvrcr8exu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:33:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHITDYl130379;
        Tue, 17 Dec 2019 18:33:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wxm4w3pe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:33:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBHIX35B001830;
        Tue, 17 Dec 2019 18:33:03 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 10:33:03 -0800
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Michal Hocko <mhocko@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20191217012508.31495-1-longman@redhat.com>
 <20191217093143.GC31063@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e153119f-036c-7479-9f27-e8d043ee3d2f@oracle.com>
Date:   Tue, 17 Dec 2019 10:33:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217093143.GC31063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 1:31 AM, Michal Hocko wrote:
> On Mon 16-12-19 20:25:08, Waiman Long wrote:
> [...]
>> Both the hugetbl_lock and the subpool lock can be acquired in
>> free_huge_page(). One way to solve the problem is to make both locks
>> irq-safe.
> 
> Please document why we do not take this, quite natural path and instead
> we have to come up with an elaborate way instead. I believe the primary
> motivation is that some operations under those locks are quite
> expensive. Please add that to the changelog and ideally to the code as
> well. We probably want to fix those anyway and then this would be a
> temporary workaround.

We may have talked in the past about how hugetlbfs locking is not ideal.
However, there are many things in hugetlbfs that are not ideal. :(  The
thought was to avoid making changes unless they showed up as real problems.
Looks like the locking is now a real issue.

I'll start work on restructuring at least this part of the locking.  But,
let's move forward with the deferred freeing approach until that is ready.
-- 
Mike Kravetz
