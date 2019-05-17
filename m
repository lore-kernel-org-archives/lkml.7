Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBDBC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6CA20833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfEQHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:07:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727386AbfEQHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:07:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4H6w7v1147047
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:07:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shpyxkk04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:07:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 17 May 2019 08:07:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 08:07:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4H77bAe48824350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 07:07:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1D552051;
        Fri, 17 May 2019 07:07:37 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.144.159])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B8E25204F;
        Fri, 17 May 2019 07:07:37 +0000 (GMT)
Date:   Fri, 17 May 2019 09:07:35 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and
 cpacf_query_func() as __always_inline
In-Reply-To: <20190517065424.24453-1-yamada.masahiro@socionext.com>
References: <20190517065424.24453-1-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051707-0012-0000-0000-0000031CA1C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051707-0013-0000-0000-0000215545F6
Message-Id: <20190517090735.6906c2fa@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 15:54:24 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> was not enough to make sure to meet the 'i' (immediate) constraint for the
> asm operands.
> 
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
> 
>   In file included from arch/s390/crypto/prng.c:29:
>   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
>   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
>     170 |  asm volatile(
>         |  ^~~
>   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> 
> Add more __always_inline to force inlining.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Added to our internal tree and I will add it to s390/linux soon. Thanks.

Do you have a Kconfig patch in the works to enable OPTIMIZE_INLINING?
Otherwise we could just add it.

> ---
> 
>  arch/s390/include/asm/cpacf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index f316de40e51b..19459dfb4295 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -177,7 +177,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>  		: "cc");
>  }
> 
> -static inline int __cpacf_check_opcode(unsigned int opcode)
> +static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>  {
>  	switch (opcode) {
>  	case CPACF_KMAC:
> @@ -217,7 +217,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
>  	return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
>  }
> 
> -static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
> +static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
>  {
>  	cpacf_mask_t mask;
> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

