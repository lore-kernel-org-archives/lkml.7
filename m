Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A473C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471BE2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0Nnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:43:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbfK0Nnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:43:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARDfY77093032;
        Wed, 27 Nov 2019 08:42:25 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2whh323tb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 08:42:25 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xARDaaeM005774;
        Wed, 27 Nov 2019 13:42:24 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 2wevd75033-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:42:24 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARDgMud50856388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 13:42:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D69FD124055;
        Wed, 27 Nov 2019 13:42:22 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCE99124054;
        Wed, 27 Nov 2019 13:42:21 +0000 (GMT)
Received: from [9.152.98.31] (unknown [9.152.98.31])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Nov 2019 13:42:21 +0000 (GMT)
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
Date:   Wed, 27 Nov 2019 14:42:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_03:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=773 malwarescore=0 mlxscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 26.11.2019 16:52, Josef Bacik wrote:
> On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
>> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
>> hardware compression is rather limited in terms of performance. Increasing
>> the buffer size to 4 pages would bring significant benefit for s390
>> hardware compression (up to 60% better performance compared to the
>> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
>> consumption due to order 2 allocations.
>>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 
> We may have to make these allocations under memory pressure in the IO context,
> order 2 allocations here is going to be not awesome.  If you really want it then
> you need to at least be able to fall back to single page if you fail to get the
> allocation.  Thanks,
> 

As far as I understand GFP_KERNEL allocations would never fail for the order <= 
PAGE_ALLOC_COSTLY_ORDER. How else can the memory pressure condition be identified
here?

> josef
> 
