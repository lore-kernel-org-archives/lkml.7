Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B25C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDEA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSpm6LzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDBUJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:09:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:09:49 -0400
X-Greylist: delayed 5297 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 16:09:48 EDT
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32K3qsN128422;
        Tue, 2 Apr 2019 20:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LIspMWHW71GFK+LqCTTdKuLzcNoQ6tcNFwVwOAg+GwY=;
 b=kSpm6LzI63RA+ddKYLtunS1jDjzDWyN9Vx499rJZkU2UEbcl7/fnNlhnnqxbQ6COh4o0
 Zc7Hfr5kMiRwazOlDJd/gGwctk6hI2xVI3IcxNuMQTURK/NYXbTs61ppH6GH55Bu6Ho+
 tw8B/i31viah7lSnOYuW2EMmMn5ukxLYEFb0jkanFGq1m6bPXR4vp9Phottgf1uiA6o6
 3u5RSns1Igs7Ldajy5ZAMtz+zKzHryiTTmQgnXDUCOpQIi8TRdlOMpEqu6bK3Kmq6udh
 /QOWvJiIhESzLUjKP3VPpFBYGNNKiDN3EBT2XRptB9avgyNqJmLVHWbIWGgjA5khpVBB ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2rj0dnkr3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:09:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32K9dEe129209;
        Tue, 2 Apr 2019 20:09:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f4q5mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:09:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x32K9YIT011039;
        Tue, 2 Apr 2019 20:09:35 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 13:09:34 -0700
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190402133415.21983-1-osalvador@suse.de>
 <20190402130153.338e59c6cfda1ed3ec882517@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <360a3016-4b35-3ec6-0716-1c2a62836f0a@oracle.com>
Date:   Tue, 2 Apr 2019 13:09:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402130153.338e59c6cfda1ed3ec882517@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020134
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 1:01 PM, Andrew Morton wrote:
> On Tue,  2 Apr 2019 15:34:15 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> 
>> NODEMASK_ALLOC is used to allocate a nodemask bitmap, ant it does it by
>> first determining whether it should be allocated in the stack or dinamically
>> depending on NODES_SHIFT.
>> Right now, it goes the dynamic path whenever the nodemask_t is above 32
>> bytes.
>>
>> Although we could bump it to a reasonable value, the largest a nodemask_t
>> can get is 128 bytes, so since __nr_hugepages_store_common is called from
>> a rather shore stack we can just get rid of the NODEMASK_ALLOC call here.
>>
>> This reduces some code churn and complexity.
> 
> It took a bit of sleuthing to figure out that this patch applies to
> Mike's "hugetlbfs: fix potential over/underflow setting node specific
> nr_hugepages".  Should they be folded together?  I'm thinking not.

No need to fold.  They are separate issues and that over/underflow patch
may already be doing too many things.

> (Also, should "hugetlbfs: fix potential over/underflow setting node
> specific nr_hugepages" have been -stableified?  I also think not, but I
> bet it happens anyway).

I don't see a great reason for sending to stable.  IIRC, nobody actually
hit this issue: it was found through code inspection.
-- 
Mike Kravetz
