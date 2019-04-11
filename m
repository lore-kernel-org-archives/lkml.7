Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE3AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EEF2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDKGYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:24:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfDKGX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:23:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B6Jbcw029700
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:23:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsy47tybb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:23:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 11 Apr 2019 07:23:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 07:23:52 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B6Npu350200590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 06:23:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1715711C052;
        Thu, 11 Apr 2019 06:23:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB62711C050;
        Thu, 11 Apr 2019 06:23:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Apr 2019 06:23:50 +0000 (GMT)
Date:   Thu, 11 Apr 2019 08:23:49 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
References: <20190410201300.3528984-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410201300.3528984-1-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19041106-4275-0000-0000-000003269BBB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041106-4276-0000-0000-00003835BA9C
Message-Id: <20190411062349.GB4126@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:12:40PM +0200, Arnd Bergmann wrote:
> llvm does does not understand -march=z9-109 and older target
> specifiers, so disable the respective Kconfig settings and
> the logic to make the boot code work on old systems when
> building with clang.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig       | 6 ++++++
>  arch/s390/boot/Makefile | 2 ++
>  2 files changed, 8 insertions(+)
...
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c844eaf24ed7..953a74d04990 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -11,6 +11,7 @@ KASAN_SANITIZE := n
>  KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
>  KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
> 
> +ifndef CONFIG_CC_IS_CLANG
>  #
>  # Use -march=z900 for als.c to be able to print an error
>  # message if the kernel is started on a machine which is too old
> @@ -25,6 +26,7 @@ CFLAGS_als.o			+= -march=z900
>  CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
>  CFLAGS_sclp_early_core.o	+= -march=z900
>  endif
> +endif

This contradicts the whole purpose of als.c - printing an error
message to the console if the kernel is compiled for a newer
architecture than it is running on (and therefore uses instructions
unknown to the current system).
If this can't be fixed/changed in clang, then it should be at least
changed to the lowest possible architecture.

