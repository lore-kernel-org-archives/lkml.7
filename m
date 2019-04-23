Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7198217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9EV0qHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfDWQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:40:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:40:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3NGXbfI042863;
        Tue, 23 Apr 2019 16:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OnmDEa4Vll+ER2XRN/87fZSs2s5ZyAbUlD8n6HCiMw8=;
 b=Z9EV0qHlZqVonQ+IibNlvzC8SfWpFIDQmk3Ix+qMsGNUBpraB2Fm957y7GLWq0Ez/E9D
 oqRookWBvmfmUZeJ7AX1DuCIYfBL2r9r4qX9ejVZ8oH/QJ4eJVOV8XRVup6N5yrg2o+B
 RLGZiKdvg88dXkgBgQJHvfd14Y0Dx1Sl3gt3r+tjsbQCP9yMCJ1KyWt1ItxbJiYA3UcF
 vDuDfYjdzosjJiWnkYj+idj5SygvAnS1b2kfeFNGYxI2ew9Cl+adWizRAt/1KCKkku1d
 itgeLkA11m7QQ2D5288Xdaulxt86kLbi1Ya02aE5hTY27qBQ1tHIpCXmbljBxu60XAXN 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ryrxcwn2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 16:39:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3NGchkw116076;
        Tue, 23 Apr 2019 16:39:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2s0dwec9dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 16:39:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3NGdn4o023727;
        Tue, 23 Apr 2019 16:39:49 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Apr 2019 09:39:49 -0700
Subject: Re: [Question] Should direct reclaim time be bounded?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
Date:   Tue, 23 Apr 2019 09:39:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423071953.GC25106@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904230113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904230113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 12:19 AM, Michal Hocko wrote:
> On Mon 22-04-19 21:07:28, Mike Kravetz wrote:
>> In our distro kernel, I am thinking about making allocations try "less hard"
>> on nodes where we start to see failures.  less hard == NORETRY/NORECLAIM.
>> I was going to try something like this on an upstream kernel when I noticed
>> that it seems like direct reclaim may never end/exit.  It 'may' exit, but I
>> instrumented __alloc_pages_slowpath() and saw it take well over an hour
>> before I 'tricked' it into exiting.
>>
>> [ 5916.248341] hpage_slow_alloc: jiffies 5295742  tries 2   node 0 success
>> [ 5916.249271]                   reclaim 5295741  compact 1
> 
> This is unexpected though. What does tries mean? Number of reclaim
> attempts? If yes could you enable tracing to see what takes so long in
> the reclaim path?

tries is the number of times we pass the 'retry:' label in
__alloc_pages_slowpath.  In this specific case, I am pretty sure all that
time is in one call to __alloc_pages_direct_reclaim.  My 'trick' to make this
succeed was to "echo 0 > nr_hugepages" in another shell.

>> This is where it stalled after "echo 4096 > nr_hugepages" on a little VM
>> with 8GB total memory.
>>
>> I have not started looking at the direct reclaim code to see exactly where
>> we may be stuck, or trying really hard.  My question is, "Is this expected
>> or should direct reclaim be somewhat bounded?"  With __alloc_pages_slowpath
>> getting 'stuck' in direct reclaim, the documented behavior for huge page
>> allocation is not going to happen.
> 
> Well, our "how hard to try for hugetlb pages" is quite arbitrary. We
> used to rety as long as at least order worth of pages have been
> reclaimed but that didn't make any sense since the lumpy reclaim was
> gone.

Yes, that is what I am seeing in our older distro kernel and I can at least
deal with that.

>       So the semantic has change to reclaim&compact as long as there is
> some progress. From what I understad above it seems that you are not
> thrashing and calling reclaim again and again but rather one reclaim
> round takes ages.

Correct

> That being said, I do not think __GFP_RETRY_MAYFAIL is wrong here. It
> looks like there is something wrong in the reclaim going on.

Ok, I will start digging into that.  Just wanted to make sure before I got
into it too deep.

BTW - This is very easy to reproduce.  Just try to allocate more huge pages
than will fit into memory.  I see this 'reclaim taking forever' behavior on
v5.1-rc5-mmotm-2019-04-19-14-53.  Looks like it was there in v5.0 as well.
-- 
Mike Kravetz
