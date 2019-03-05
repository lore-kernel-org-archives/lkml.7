Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C79C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266BF20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCEO37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfCEO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:29:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25EENga074191
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 09:29:57 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r1tmdgxx0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:29:57 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 5 Mar 2019 14:29:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 14:29:51 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25ETpqn16449572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 14:29:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBF0BA405B;
        Tue,  5 Mar 2019 14:29:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99816A4054;
        Tue,  5 Mar 2019 14:29:50 +0000 (GMT)
Received: from [9.152.212.90] (unknown [9.152.212.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 14:29:50 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] gcov: add Clang support
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190122233749.42220-1-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 5 Mar 2019 15:29:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190122233749.42220-1-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030514-4275-0000-0000-0000031729BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030514-4276-0000-0000-000038257D25
Message-Id: <7c7b4521-d747-d064-0506-4e3d6746877e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.2019 00:37, Tri Vo wrote:
> This patch series adds Clang supoprt for gcov.
> 
> Patch 1 refactors existing code in preparation for Clang support.
> Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
> Patch 3 updates documentation.

Thanks for the updates! I've provided suggestions for some minor
improvements in my other review e-mails.

With those changes applied, the patch set is in my opinion ready for
inclusion into the mainline kernel. My suggestion would be to re-post
the resulting version while putting Andrew Morton on CC as gcov changes
are typically integrated via his tree.

Also I've successfully re-tested this patch set version on s390 using
GCC 7.3.0 to ensure that the existing GCC support is still working.
Unfortunately I wasn't able to test the Clang version due to some
compile problems on s390 (unrelated to this patch set).

If you haven't done so, I would like to suggest to run the following
tests with the Clang gcov-kernel version that should catch problems in
some corner cases:

1. Unload a module, then use llvm-cov on the associated coverage file.

   Expectation: correct llvm-cov output including coverage of module
   exit code.

2. Unload a module, modify its source, re-compile it and load it again,
   then use llvm-cov on the associated coverage file.

   Expectation: kernel message "discarding saved data", correct llvm-cov
   output with no coverage of module exit code.

3. Unload a module, then reset all coverage data by writing to
   /sys/kernel/debug/gcov/reset.

   Expectation: all coverage files associated with the module are
   removed from debugfs.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

