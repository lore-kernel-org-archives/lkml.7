Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48408C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A352075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfDOFEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:04:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfDOFEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:04:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F53rYB043259
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:04:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvkftg2n4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:04:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 15 Apr 2019 06:04:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 06:04:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3F54LAc42598586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 05:04:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ADC152051;
        Mon, 15 Apr 2019 05:04:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id DA6875204E;
        Mon, 15 Apr 2019 05:04:19 +0000 (GMT)
Date:   Mon, 15 Apr 2019 08:04:18 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-4-chenzhou10@huawei.com>
 <20190410130917.GC17196@rapoport-lnx>
 <137bef2e-8726-fd8f-1cb0-7592074f7870@huawei.com>
 <20190414121058.GC20947@rapoport-lnx>
 <b5206f0c-d711-427e-256a-98b2e30c1ab0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5206f0c-d711-427e-256a-98b2e30c1ab0@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19041505-0016-0000-0000-0000026ECD39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041505-0017-0000-0000-000032CB0FBF
Message-Id: <20190415050417.GB6167@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 15, 2019 at 10:05:18AM +0800, Chen Zhou wrote:
> Hi Mike,
> 
> On 2019/4/14 20:10, Mike Rapoport wrote:
> >>
> >> solution A: 	phys_addr_t start[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> >> 		phys_addr_t end[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> >> start, end is physical addr
> >>
> >> solution B: 	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
> >> start_rgn, end_rgn is rgn index		
> >>
> >> Solution B do less remove operations and with no warning comparing to solution A.
> >> I think solution B is better, could you give some suggestions?
> >  
> > Solution B is indeed better that solution A, but I'm still worried by
> > relatively large arrays on stack and the amount of loops :(
> > 
> > The very least we could do is to call memblock_cap_memory_range() to drop
> > the memory before and after the ranges we'd like to keep.
> 
> 1. relatively large arrays
> As my said above, the start_rgn, end_rgn is rgn index, we could use unsigned char type.

Let's stick to int for now

> 2. loops
> Loops always exist, and the solution with fewer loops may be just encapsulated well.

Of course the loops are there, I just hoped we could get rid of the nested
loop and get away with single passes in all the cases.
Apparently it's not the case :(

> Thanks,
> Chen Zhou
> 

-- 
Sincerely yours,
Mike.

