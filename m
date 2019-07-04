Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F6C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDF520659
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="czlZdJs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfGDPMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:12:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51790 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfGDPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:12:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F8w45160027;
        Thu, 4 Jul 2019 15:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=J2yR5u6KiY8S3i26WlPbwZicZznOd9rvYFqBPqXulEc=;
 b=czlZdJs7+gd34nNHXUlV9AOB+31iyg2QSKaLzL+UpBjqj2JDSL+IWT+1BduuMXvvULbA
 vdAL5tkcJD15wwswbHYOdGRy9jY/RWfBTFsIUluDITjsGRT8Ya8cF/ZHhFZBDMLKrqej
 WGt9b0T834VZZQqGYUbCn4vmN7gQvZC/4wE75U2Cpj00aAPy58JXjRQPGjKnaVjW2kFc
 dnoVa1qktKZ0BdfucUhrddiQ1zdk9tMS9bbvI1zLRRCNAN7N96MbFCH5486f9KGq6Str
 p4NbLViO19GGZZSPirwRfrGy1yVb6e4lhj+rwkHuwzUVs8GNCZtvFImaH6ObsZrthre2 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbybw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:11:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F7kZf145457;
        Thu, 4 Jul 2019 15:11:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2th5qm3er2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:11:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x64FBkvv012480;
        Thu, 4 Jul 2019 15:11:46 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 08:11:45 -0700
Subject: Re: [Question] Should direct reclaim time be bounded?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
 <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
 <20190701085920.GB2812@suse.de>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <20190703094325.GB2737@techsingularity.net>
 <571d5557-2153-59ea-334b-8636cc1a49c9@oracle.com>
 <20190704110903.GE5620@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c801da70-1aa5-666a-615e-852100d6145e@oracle.com>
Date:   Thu, 4 Jul 2019 08:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704110903.GE5620@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=989 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/19 4:09 AM, Michal Hocko wrote:
> On Wed 03-07-19 16:54:35, Mike Kravetz wrote:
>> On 7/3/19 2:43 AM, Mel Gorman wrote:
>>> Indeed. I'm getting knocked offline shortly so I didn't give this the
>>> time it deserves but it appears that part of this problem is
>>> hugetlb-specific when one node is full and can enter into this continual
>>> loop due to __GFP_RETRY_MAYFAIL requiring both nr_reclaimed and
>>> nr_scanned to be zero.
>>
>> Yes, I am not aware of any other large order allocations consistently made
>> with __GFP_RETRY_MAYFAIL.  But, I did not look too closely.  Michal believes
>> that hugetlb pages allocations should use __GFP_RETRY_MAYFAIL.
> 
> Yes. The argument is that this is controlable by an admin and failures
> should be prevented as much as possible. I didn't get to understand
> should_continue_reclaim part of the problem but I have a strong feeling
> that __GFP_RETRY_MAYFAIL handling at that layer is not correct. What
> happens if it is simply removed and we rely only on the retry mechanism
> from the page allocator instead? Does the success rate is reduced
> considerably?

It certainly will be reduced.  I 'think' it will be hard to predict how
much it will be reduced as this will depend on the state of memory usage
and fragmentation at the time of the attempt.

I can try to measure this, but I will be a few days due to U.S. holiday.
-- 
Mike Kravetz
