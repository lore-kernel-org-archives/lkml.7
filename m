Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E15C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943E2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MSFLQ2u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEIQHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:07:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:07:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49G41Lh084886;
        Thu, 9 May 2019 16:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=I6PRi0pOdbF1qRia4hyU8vB77984ia94C6lSX8nieBc=;
 b=MSFLQ2u1Jstz6EwPfaAn6k+Fs505zTzWCXVV7J67bbgMpgX2CNHS7Y9PJ6hA4vwDtfKz
 olX1oXmJ06oiPZ4TgLfJUyNliMfVg7nlvocWNAdq8fSKyBaDnbJGr2W1ZhCK4qxzsiMW
 S6OY3IS14npuzACKI9AG20RsokMuWhdbrwAXSn21K1Ef9hWNn8f8xKlvafsdPkwczcjE
 K22rBr3zok1fkiyBspvK38+RRRFZlDRsQL3qYY85BvPTMIc+xHCTv+/TNas6RWoknKrM
 CgGx7w+cqvvPMk0t+/TL2olpidfcB7QI3ldMe+9ZNL/VR8UycS1CPlG1Xr/M+pEzgZzc iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bgbytj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 16:07:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49G75tS107307;
        Thu, 9 May 2019 16:07:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2scpy5rqht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 16:07:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49G7D1Q017003;
        Thu, 9 May 2019 16:07:13 GMT
Received: from oracle.com (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 09:07:12 -0700
From:   Larry Bassel <larry.bassel@oracle.com>
To:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     Larry Bassel <larry.bassel@oracle.com>
Subject: [PATCH, RFC 0/2] Share PMDs for FS/DAX on x86
Date:   Thu,  9 May 2019 09:05:31 -0700
Message-Id: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=601
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090092
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=625 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements sharing of page table entries pointing
to 2MiB pages (PMDs) for FS/DAX on x86.

Only shared mmapings of files (i.e. neither private mmapings nor
anonymous pages) are eligible for PMD sharing.

Due to the characteristics of DAX, this code is simpler and
less intrusive than the general case would be.

In our use case (high end Oracle database using DAX/XFS/PMEM/2MiB
pages) there would be significant memory savings.

A future system might have 6 TiB of PMEM on it and
there might be 10000 processes each mapping all of this 6 TiB.
Here the savings would be approximately
(6 TiB / 2 MiB) * 8 bytes (page table size) * 10000 = 240 GiB
(and these page tables themselves would be in non-PMEM (ordinary RAM)).

There would also be a reduction in page faults because in
some cases the page fault has already been satisfied and
the page table entry has been filled in (and so the processes
after the first would not take a fault).

The code for detecting whether PMDs can be shared and
the implementation of sharing and unsharing is based
on, but somewhat different than that in mm/hugetlb.c,
though some of the code from this file could be reused and
thus was made non-static.

Larry Bassel (2):
  Add config option to enable FS/DAX PMD sharing.
  Implement sharing/unsharing of PMDs for FS/DAX.

 arch/x86/Kconfig        |   3 ++
 include/linux/hugetlb.h |   4 ++
 mm/huge_memory.c        |  32 ++++++++++++++
 mm/hugetlb.c            |  21 ++++++++--
 mm/memory.c             | 108 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 163 insertions(+), 5 deletions(-)

-- 
1.8.3.1

