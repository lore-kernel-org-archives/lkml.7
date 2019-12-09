Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869F2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIQkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:40:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfLIQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:40:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GMKjp108748;
        Mon, 9 Dec 2019 11:40:02 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrth045uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Dec 2019 11:40:02 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB9GRtRP020060;
        Mon, 9 Dec 2019 16:40:01 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 2wr3q698kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Dec 2019 16:40:01 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB9Gdv1n46727472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 16:39:57 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E6E6E050;
        Mon,  9 Dec 2019 16:39:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E65476E04C;
        Mon,  9 Dec 2019 16:39:55 +0000 (GMT)
Received: from [9.152.97.3] (unknown [9.152.97.3])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon,  9 Dec 2019 16:39:55 +0000 (GMT)
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
To:     dsterba@suse.cz
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <20191127121423.GQ2734@suse.cz>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a8dc0941-ee2d-6df7-cb32-c6af26bdc54c@linux.ibm.com>
Date:   Mon, 9 Dec 2019 17:39:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127121423.GQ2734@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 suspectscore=3 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=996
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 27.11.2019 13:14, David Sterba wrote:
> On Tue, Nov 26, 2019 at 10:52:49AM -0500, Josef Bacik wrote:
>> On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
>>> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
>>> hardware compression is rather limited in terms of performance. Increasing
>>> the buffer size to 4 pages would bring significant benefit for s390
>>> hardware compression (up to 60% better performance compared to the
>>> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
>>> consumption due to order 2 allocations.
>>>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>
>> We may have to make these allocations under memory pressure in the IO context,
>> order 2 allocations here is going to be not awesome.  If you really want it then
>> you need to at least be able to fall back to single page if you fail to get the
>> allocation.  Thanks,
> 
> The allocation is only for the workspace and it does not happen on the
> IO path for each call. There's the pool and if
> 
> btrfs_get_workspace
>   alloc_workspace
> 
> fails, then there's fallback path to wait for an existing workspace to
> be free.
> 
> The order 2 allocation can put more pressure on the allocator though so
> it's possible to have effects in some corner cases, but not in general.
> I don't think the single page fallback code is needed.
> 
> And of course evaluation of the effects of the larger zlib buffer should
> be done, it could improve compression but probably at the cost of cpu
> time. Also decompression of blocks created on new code (4 pages) must
> work on the old code (1 page).
Regarding 'improve compression but probably at the cost of cpu' ... what would be 
the proper way to evaluate this effect?
As for backward compatibility, I do not see side effects of using larger buffers. 
Data in the compressed state might differ indeed, but it will sill conform to zlib
standard and thus can be decompressed.

BTW, I have sent around V2 of the patch set. I would appreciate if you take a look 
as well.
> 
Thanks,
Mikhail
