Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72136C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2520848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfEQHGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:06:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727386AbfEQHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:06:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4H6wCHN108484
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:06:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shqvp93b6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:06:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 17 May 2019 08:06:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 08:06:30 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4H76TJm48955522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 07:06:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E94A3A4067;
        Fri, 17 May 2019 07:06:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86C3AA4054;
        Fri, 17 May 2019 07:06:28 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.144.159])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 07:06:28 +0000 (GMT)
Date:   Fri, 17 May 2019 09:06:26 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH] s390: add unreachable() to dump_fault_info() to fix
 -Wmaybe-uninitialized
In-Reply-To: <20190517064922.22743-1-yamada.masahiro@socionext.com>
References: <20190517064922.22743-1-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051707-0028-0000-0000-0000036EA350
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051707-0029-0000-0000-0000242E40EB
Message-Id: <20190517090626.3c707d77@mschwideX1>
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

On Fri, 17 May 2019 15:49:22 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> When CONFIG_OPTIMIZE_INLINING is enabled for s390, I see this warning:
> 
> arch/s390/mm/fault.c:127:15: warning: 'asce' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   switch (asce & _ASCE_TYPE_MASK) {
> arch/s390/mm/fault.c:177:16: note: 'asce' was declared here
>   unsigned long asce;
>                 ^~~~
> 
> If get_fault_type() is not inlined, the compiler cannot deduce that
> all the possible paths in the 'switch' statement are covered.
> 
> Of course, we could mark get_fault_type() as __always_inline to get
> back the original behavior, but I do not think it sensible to force
> inlining just for the purpose of suppressing the warning. Since this
> is just a matter of warning, I want to keep as much room for compiler
> optimization as possible.
> 
> I added unreachable() to teach the compiler that the 'default' label
> is unreachable.
> 
> I got rid of the 'inline' marker. Even without the 'inline' hint,
> the compiler inlines functions based on its inlining heuristic.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Added to our internal tree and I will add it to s390/linux soon. Thanks.

> ---
> 
>  arch/s390/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index c220399ae196..91ce03fd0c84 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -85,7 +85,7 @@ static inline int notify_page_fault(struct pt_regs *regs)
>   * Find out which address space caused the exception.
>   * Access register mode is impossible, ignore space == 3.
>   */
> -static inline enum fault_type get_fault_type(struct pt_regs *regs)
> +static enum fault_type get_fault_type(struct pt_regs *regs)
>  {
>  	unsigned long trans_exc_code;
> 
> @@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
>  		asce = S390_lowcore.kernel_asce;
>  		pr_cont("kernel ");
>  		break;
> +	default:
> +		unreachable();
>  	}
>  	pr_cont("ASCE.\n");
>  	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

