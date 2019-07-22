Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E0C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2277218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfGVMaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:30:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbfGVMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:30:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCRV1T137433
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:30:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twc9qtv92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:30:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 22 Jul 2019 13:30:15 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 13:30:13 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MCTueb31719888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 12:29:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7719EA406B;
        Mon, 22 Jul 2019 12:30:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A229A4065;
        Mon, 22 Jul 2019 12:30:11 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Jul 2019 12:30:11 +0000 (GMT)
Date:   Mon, 22 Jul 2019 14:30:09 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: use __u{16,32,64} instead of uint{16,32,64}_t in
 uapi header
References: <20190721142008.30093-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721142008.30093-1-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19072212-0028-0000-0000-00000386CF00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072212-0029-0000-0000-0000244702E1
Message-Id: <20190722123009.GA5864@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:20:08PM +0900, Masahiro Yamada wrote:
> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> make sure they can be included from user-space.
> 
> Currently, zcrypt.h is excluded from the test coverage. To make it
> join the compile-test, we need to fix the build errors attached below.
> 
> For a case like this, we decided to use __u{8,16,32,64} variable types
> in this discussion:
> 
>   https://lkml.org/lkml/2019/6/5/18
...
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/include/uapi/asm/zcrypt.h | 35 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Applied, thanks!

I also added the patch below:

From b312d5e2244f635f83cbf19b850e26c1c443f465 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 22 Jul 2019 14:16:46 +0200
Subject: [PATCH 2/2] kbuild: enable arch/s390/include/uapi/asm/zcrypt.h for
 uapi header test

Masahiro Yamada changed the zcrypt.h header file to use __u{16,32,64}
instead of uint{16,32,64}_t with ("s390: use __u{16,32,64} instead of
uint{16,32,64}_t in uapi header").

This makes all s390 header files pass - remove zcrypt.h from the blacklist.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 usr/include/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index aa316d99e035..1fb6abe29b2f 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -101,10 +101,6 @@ ifeq ($(SRCARCH),riscv)
 header-test- += linux/bpf_perf_event.h
 endif
 
-ifeq ($(SRCARCH),s390)
-header-test- += asm/zcrypt.h
-endif
-
 ifeq ($(SRCARCH),sparc)
 header-test- += asm/stat.h
 header-test- += asm/uctx.h
-- 
2.17.1

