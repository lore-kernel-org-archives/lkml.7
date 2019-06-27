Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB2C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D072064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mxwGBgo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF0SLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:11:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59958 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0SLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:11:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RI9MIv127411;
        Thu, 27 Jun 2019 18:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=t/rruMnao2wR61MPFoLKt9zfyEZplrn1UsBge3sXHjc=;
 b=mxwGBgo6P/4M62KLP3A86hDTWZOF/CX7Ejy3CZTQKmD3ZyCo2ckpBT7qYCR4SAK7PHaq
 TtDTW6VWyO5sg1ciq25hYpWjWOQkJguDjbFkDiE9OJuJjniigy0p6vgSgcm6+1co8iJ3
 CRxjIi8xmNL/Ekzf98KaYOJLr/QI7o3pw4fJObUYVIBM5pqV2lY2eUX4KdfRpuETcpVo
 VvxoJlKqqWOU+Mg7tjZ4x1e010nheAklNM/3LNwGnzlkuJ7ryGhw0PxupqlcoFVmrgbS
 pDahFNsaHcZW3RzFinHP0R6ihqR+jfb1zdO5IkyCUPOrjSx/1Q1nvLAZi2dFu31GKXXa 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9q1tfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:09:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RI876F020980;
        Thu, 27 Jun 2019 18:09:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acddck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:09:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5RI9HMH015017;
        Thu, 27 Jun 2019 18:09:19 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 11:09:17 -0700
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1560461641.5154.19.camel@lca.pw>
 <20190614102017.GC10659@fuggles.cambridge.arm.com>
 <1560514539.5154.20.camel@lca.pw>
 <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
 <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
 <20190624093507.6m2quduiacuot3ne@willie-the-truck>
 <1561381129.5154.55.camel@lca.pw> <1561411839.5154.60.camel@lca.pw>
 <ed517a19-7804-c679-da94-279565001ca1@oracle.com>
Message-ID: <15651f16-8d30-412f-8064-41ff03f3f47d@oracle.com>
Date:   Thu, 27 Jun 2019 11:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed517a19-7804-c679-da94-279565001ca1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270208
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 2:53 PM, Mike Kravetz wrote:
> On 6/24/19 2:30 PM, Qian Cai wrote:
>> So the problem is that ipcget_public() has held the semaphore "ids->rwsem" for
>> too long seems unnecessarily and then goes to sleep sometimes due to direct
>> reclaim (other times LTP hugemmap05 [1] has hugetlb_file_setup() returns
>> -ENOMEM),
> 
> Thanks for looking into this!  I noticed that recent kernels could take a
> VERY long time trying to do high order allocations.  In my case it was trying
> to do dynamic hugetlb page allocations as well [1].  But, IMO this is more
> of a general direct reclaim/compation issue than something hugetlb specific.
> 

<snip>

>> Ideally, it seems only ipc_findkey() and newseg() in this path needs to hold the
>> semaphore to protect concurrency access, so it could just be converted to a
>> spinlock instead.
> 
> I do not have enough experience with this ipc code to comment on your proposed
> change.  But, I will look into it.
> 
> [1] https://lkml.org/lkml/2019/4/23/2

I only took a quick look at the ipc code, but there does not appear to be
a quick/easy change to make.  The issue is that shared memory creation could
take a long time.  With issue [1] above unresolved, creation of hugetlb backed
shared memory segments could take a VERY long time.

I do not believe the test failure is arm specific.  Most likely, it is just
because testing was done on a system with memory size to trigger this issue?

My plan is to focus on [1].  When that is resolved, this issue should go away.
-- 
Mike Kravetz
