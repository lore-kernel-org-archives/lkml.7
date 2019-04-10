Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17307C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339920652
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfDJQEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:04:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbfDJQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:04:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AG0a8k073993
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:04:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsj1unh1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:04:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 17:04:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 17:03:59 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AG3wSE32899204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 16:03:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6FDD5205F;
        Wed, 10 Apr 2019 16:03:58 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 63F4252050;
        Wed, 10 Apr 2019 16:03:58 +0000 (GMT)
Date:   Wed, 10 Apr 2019 18:03:57 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
In-Reply-To: <20190408212648.2407234-10-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-10-arnd@arndb.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041016-4275-0000-0000-00000326683A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041016-4276-0000-0000-0000383585B4
Message-Id: <20190410180357.3290d24f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Apr 2019 23:26:23 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> llvm on s390 has problems with __builtin_return_address(n), with n>0,
> this results in a somewhat cryptic error message:
> 
> fatal error: error in backend: Unsupported stack frame traversal count
> 
> To work around it, use the direct return address directly. This
> is probably not ideal here, but gets things to compile and should
> only lead to inferior reporting, not to misbehavior of the generated
> code.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=41424
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/ftrace.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index 5a3c95b11952..7923c63946fb 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -13,7 +13,12 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +#ifdef CONFIG_CC_IS_CLANG
> +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> +#define ftrace_return_address(n) __builtin_return_address(0)
> +#else
>  #define ftrace_return_address(n) __builtin_return_address(n)
> +#endif
> 
>  void _mcount(void);
>  void ftrace_caller(void);

I can say I like this one. If the compiler can not do __builtin_return_address(n)
it feels wrong to just use __builtin_return_address(0).

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

