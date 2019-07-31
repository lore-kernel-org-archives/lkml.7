Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B59C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D088E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sHCfQeB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfGaVN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:13:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGaVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:13:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VL8sxc083461;
        Wed, 31 Jul 2019 21:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nk338iTHcZ5glQ9pVoR5sv06o3zifCdSyoAmg7k51eg=;
 b=sHCfQeB7h4NMrSRZMCLP9KAHtS+eHmtI4MJM8u5wZoQngdtDpD+YvlXHN8iFnHeT7rFk
 Vu4cMWpJEMU4599m4FbPz93DAtZicMazt1OjMitmGAzPsx+tkZukXNixTTvkNA9FwchS
 kJX++LEY36kdbXBR6islJEFvKmm/HffgqNuktNXYFLpB75JmBHBTGKuNgpFahJFXuvRS
 RQA51To4x/0E9SIp4XTVd50E6iA7Lm+c6ilgidB/qBhxYizvIQF/H6qoLNLFm7HV6l3s
 DNPecn9sF5cC860u7+PS9puCPmKLriCeIbbg6o85Zd0pvpPat5WV2flmrDzeFjqG7Muz ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u0e1tyyed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 21:13:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VL7ill000805;
        Wed, 31 Jul 2019 21:13:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2u2exc4cfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 21:13:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VLDkdg017301;
        Wed, 31 Jul 2019 21:13:46 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 14:13:45 -0700
Subject: Re: [RFC PATCH 3/3] hugetlbfs: don't retry when pool page allocations
 start to fail
To:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-4-mike.kravetz@oracle.com>
 <20190725081350.GD2708@suse.de>
 <6a7f3705-9550-e22f-efa1-5e3616351df6@oracle.com>
 <d4099d77-418b-4d4b-715f-7b37347d5f8d@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b7eb72a6-65a4-4785-39ec-a995d415fae3@oracle.com>
Date:   Wed, 31 Jul 2019 14:13:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d4099d77-418b-4d4b-715f-7b37347d5f8d@suse.cz>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310212
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 6:23 AM, Vlastimil Babka wrote:
> On 7/25/19 7:15 PM, Mike Kravetz wrote:
>> On 7/25/19 1:13 AM, Mel Gorman wrote:
>>> On Wed, Jul 24, 2019 at 10:50:14AM -0700, Mike Kravetz wrote:
>>>
>>> set_max_huge_pages can fail the NODEMASK_ALLOC() alloc which you handle
>>> *but* in the event of an allocation failure this bug can silently recur.
>>> An informational message might be justified in that case in case the
>>> stall should recur with no hint as to why.
>>
>> Right.
>> Perhaps a NODEMASK_ALLOC() failure should just result in a quick exit/error.
>> If we can't allocate a node mask, it is unlikely we will be able to allocate
>> a/any huge pages.  And, the system must be extremely low on memory and there
>> are likely other bigger issues.
> 
> Agreed. But I would perhaps drop __GFP_NORETRY from the mask allocation
> as that can fail for transient conditions.

Thanks, I was unsure if adding __GFP_NORETRY would be a good idea.

-- 
Mike Kravetz
