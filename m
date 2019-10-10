Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF370C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D23208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RaceGKx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbfJJDnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:43:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57684 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfJJDnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:43:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A3UUDJ109985;
        Thu, 10 Oct 2019 03:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HO5gknIWrU/TJVkoz7zGDVv7k5pnSkpz5KDAVR0I5b0=;
 b=RaceGKx+R/h+zvJs6LbkqfdtySSN5FhnkeOS6lRjuGARBLSZRzzoJx1/+zH42WBAGjHv
 UkbmXJ8HXapD7O4ZXIcvDBsNaamGWzKT24g0Ckx2KjbJHu7Uq2jmgrTed3+wlKaQbASl
 990/K5X3FrQS7D7bORZyTGsByeVUnhc4arT6wFZUXpbjHcID2NoWZHlGMtDUIISHGDvq
 4UYMOACBPOC6d3gjAxj/aUM4nEaewTV+4HU8+sq5d2iAlMh7yHDB5k61/Y8AB/iOGY/U
 Eo93NSyoDBbVa907tr5G5NB+FsN6UDsCUkq0x+3cPcTLXnDuJehcOmWuP+6A9IVzYaiQ Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektrr62w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 03:42:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A3TFJe137563;
        Thu, 10 Oct 2019 03:42:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vhhsnu08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 03:42:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A3gnoN011627;
        Thu, 10 Oct 2019 03:42:49 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 20:42:49 -0700
Subject: Re: [PATCH -next] userfaultfd: remove set but not used variable 'h'
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191009122740.70517-1-yuehaibing@huawei.com>
 <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
 <20191010012322.GB2167@richard>
 <ba62cc8f-da4d-a316-c968-80871551c863@oracle.com>
 <20191010033045.GA5927@richard>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <01601a94-5c52-7ef6-ce08-7a86ac70fab2@oracle.com>
Date:   Wed, 9 Oct 2019 20:42:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010033045.GA5927@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 8:30 PM, Wei Yang wrote:
> On Wed, Oct 09, 2019 at 07:25:18PM -0700, Mike Kravetz wrote:
>> On 10/9/19 6:23 PM, Wei Yang wrote:
>>> On Wed, Oct 09, 2019 at 05:45:57PM -0700, Mike Kravetz wrote:
>>>> On 10/9/19 5:27 AM, YueHaibing wrote:
>>>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>>>
>>>>> mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
>>>>> mm/userfaultfd.c:217:17: warning:
>>>>>  variable 'h' set but not used [-Wunused-but-set-variable]
>>>>>
>>>>> It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
>>>>> for all huge page size calculation")
>>>>>
>>>>
>>>> Thanks!  That should have been removed with the recent cleanups.
>>>>
>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>
>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>
>>> If I am correct, this is removed in a recent patch.
>>
>> I'm having a hard time figuring out what is actually in the latest mmotm
>> tree.  Andrew added a build fixup patch ab169389eb5 in linux-next which
>> adds the reference to h.  Is there a patch after that to remove the reference?
>>
> 
> I checked linux-next tree, this commit removes the reference.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=add4eaeef3766b7491d70d473c48c0b6d6ca5cb7
> 

Yes, but unless I am mistaken this adds it back,

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ab169389eb5ff9da7113a21737574edc6d22c072

-- 
Mike Kravetz
