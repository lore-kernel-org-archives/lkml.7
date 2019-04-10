Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A9C206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbfDJQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:02:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbfDJQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:02:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AFxgJj110292
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:02:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsjf8bxh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:02:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 17:02:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 17:02:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AG2Pg630933068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 16:02:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BA0AE058;
        Wed, 10 Apr 2019 16:02:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06EC2AE055;
        Wed, 10 Apr 2019 16:02:25 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 16:02:24 +0000 (GMT)
Date:   Wed, 10 Apr 2019 18:02:24 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] s390: make chkbss work with clang
In-Reply-To: <20190408212648.2407234-11-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-11-arnd@arndb.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041016-0008-0000-0000-000002D86541
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041016-0009-0000-0000-0000224489E6
Message-Id: <20190410180224.45db1055@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Apr 2019 23:26:24 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> llvm skips an empty .bss section entirely, which makes
> the check fail with an unexpected error:
> 
> /tmp/binutils-multi-test/bin/s390x-linux-gnu-objdump: section '.bss' mentioned in a -j option, but not found in any input file
> error: arch/s390/boot/compressed/decompressor.o .bss section is not empty
> ../arch/s390/scripts/Makefile.chkbss:20: recipe for target 'arch/s390/boot/compressed/decompressor.o.chkbss' failed
> 
> Change the check so we first see if a .bss section exists
> before trying to read its size.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

