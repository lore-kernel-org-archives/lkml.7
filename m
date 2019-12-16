Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC204C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAD2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iL8QrAyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLPTJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:09:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfLPTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:09:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGJ4YsT125249;
        Mon, 16 Dec 2019 19:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=e4lkN4yctMiE+LnH7uE88cepitmt28jYwzo9zdQg+s8=;
 b=iL8QrAyfeKv1kfNzB30NU84QGLhwNCKUHjINhPIjLizL87sO6OTRSUGb6Q4GrAGd6Al/
 HZqKrWarayQotdxT8UJkckD5tWVZnGezDd70BIPbboejcdXCvL9xgQxiUADl1UAnTT6/
 86QtYz5vERoIZH42w5o6eoDTtcGgvD0WUuv5l4VUqugisNYF+YC+0asDQTv02mdQiOxF
 1WJIxFOFu7YrOaIVaonlyvQrvkk8grez3ec1YaHEQfJo8Czoy1I8G03/2Y6GD2wvh+F2
 t8CjGFPcokTwF3ILva2hk5UGozV9bv8Pz6kXEwTrCSiqMzttxJhQtWWx4SmOdPj6ed8i aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wvq5u9n8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 19:09:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGJ8nOm153334;
        Mon, 16 Dec 2019 19:09:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ww98sswcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 19:09:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBGJ8xIw029274;
        Mon, 16 Dec 2019 19:08:59 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Dec 2019 11:08:59 -0800
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <20191216133711.GH30281@dhcp22.suse.cz>
 <20191216161748.tgi2oictlfqy6azi@linux-p48b>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <68d466cc-2cbd-ae49-7d89-e7476c5a9c24@oracle.com>
Date:   Mon, 16 Dec 2019 11:08:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216161748.tgi2oictlfqy6azi@linux-p48b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 8:17 AM, Davidlohr Bueso wrote:
> On Mon, 16 Dec 2019, Michal Hocko wrote:
>> I am afraid that work_struct is too large to be stuffed into the struct
>> page array (because of the lockdep part).
> 
> Yeah, this needs to be done without touching struct page.
> 
> Which is why I had done the stack allocated way in this patch, but we
> cannot wait for it to complete in irq, so that's out the window. Andi
> had suggested percpu allocated work items, but having played with the
> idea over the weekend, I don't see how we can prevent another page being
> freed on the same cpu before previous work on the same cpu is complete
> (cpu0 wants to free pageA, schedules the work, in the mean time cpu0
> wants to free pageB and workerfn for pageA still hasn't been called).
> 
>> I think that it would be just safer to make hugetlb_lock irq safe. Are
>> there any other locks that would require the same?
> 
> It would be simpler. Any performance issues that arise would probably
> be only seen in microbenchmarks, assuming we want to have full irq safety.
> If we don't need to worry about hardirq, then even better.
> 
> The subpool lock would also need to be irq safe.

I do think we need to worry about hardirq.  There are no restruictions that
put_page can not be called from hardirq context. 

I am concerned about the latency of making hugetlb_lock (and potentially
subpool lock) hardirq safe.  When these locks were introduced (before my
time) the concept of making them irq safe was not considered.  Recently,
I learned that the hugetlb_lock is held for a linear scan of ALL hugetlb
pages during a cgroup reparentling operation.  That is just too long.

If there is no viable work queue solution, then I think we would like to
restructure the hugetlb locking before a change to just make hugetlb_lock
irq safe.  The idea would be to split the scope of what is done under
hugetlb_lock.  Most of it would never be executed in irq context.  Then
have a small/limited set of functionality that really needs to be irq
safe protected by an irq safe lock.

-- 
Mike Kravetz
