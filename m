Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ACC20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfEQFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 01:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727520AbfEQFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 01:36:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4H5aSsI092637
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:36:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shpua8b4j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:36:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <vaibhav@linux.ibm.com>;
        Fri, 17 May 2019 06:36:24 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 06:36:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4H5aKFS60227814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 05:36:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50139AE04D;
        Fri, 17 May 2019 05:36:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0245EAE055;
        Fri, 17 May 2019 05:36:17 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.195.228])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 17 May 2019 05:36:16 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 17 May 2019 11:06:16 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] dax: Fix last_page check in __bdev_dax_supported()
In-Reply-To: <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
References: <20190516055422.16939-1-vaibhav@linux.ibm.com> <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
Date:   Fri, 17 May 2019 11:06:16 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19051705-0012-0000-0000-0000031C9AD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051705-0013-0000-0000-000021553EC5
Message-Id: <87bm01mylr.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, May 15, 2019 at 10:55 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> Presently __bdev_dax_supported() checks if first sector of last
>> page ( last_page ) on the block device is aligned to page
>> boundary. However the code to compute 'last_page' assumes that there
>> are 8 sectors/page assuming a 4K page-size.
>>
>> This assumption breaks on architectures which use a different page
>> size specifically PPC64 where page-size == 64K. Hence a warning is
>> seen while trying to mount a xfs/ext4 file-system with dax enabled:
>>
>> $ sudo mount -o dax /dev/pmem0 /mnt/pmem
>> XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
>> XFS (pmem0): DAX unsupported by block device. Turning off DAX.
>>
>> The patch fixes this issue by updating calculation of 'last_var' to
>> take into account number-of-sectors/page instead of assuming it to be
>> '8'.
>
> Yes, I noticed this too and fixed it up in a wider change that also
> allows device-mapper to validate each component device. Does this
> patch work for you?
>
> https://lore.kernel.org/lkml/155789172402.748145.11853718580748830476.stgit@dwillia2-desk3.amr.corp.intel.com/

Thanks Dan, I tested your patch and not seeing the issue anymore.

So, please ignore this patch.

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

