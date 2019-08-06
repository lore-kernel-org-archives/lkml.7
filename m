Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074D6C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBEF20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfHFDSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:18:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729170AbfHFDSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:18:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x763729e146689
        for <linux-kernel@vger.kernel.org>; Mon, 5 Aug 2019 23:18:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6xn25cyd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:18:17 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 6 Aug 2019 04:18:16 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Aug 2019 04:18:13 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x763ICYK51970380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 03:18:12 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C496BAC059;
        Tue,  6 Aug 2019 03:18:12 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E84D6AC05B;
        Tue,  6 Aug 2019 03:18:10 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.235.237])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Aug 2019 03:18:10 +0000 (GMT)
References: <20190806121519.0f8ac653@canb.auug.org.au>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: linux-next: build failure after merge of the integrity tree
In-reply-to: <20190806121519.0f8ac653@canb.auug.org.au>
Date:   Tue, 06 Aug 2019 00:18:06 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19080603-2213-0000-0000-000003B99ACD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011558; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242708; UDB=6.00655502; IPR=6.01024171;
 MB=3.00028058; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 03:18:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080603-2214-0000-0000-00005F8A2126
Message-Id: <87imrb0yoh.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the integrity tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from <command-line>:
> include/linux/module_signature.h:32:2: error: unknown type name 'u8'
>   u8 algo;  /* Public-key crypto algorithm [0] */
>   ^~
> include/linux/module_signature.h:33:2: error: unknown type name 'u8'
>   u8 hash;  /* Digest algorithm [0] */
>   ^~
> include/linux/module_signature.h:34:2: error: unknown type name 'u8'
>   u8 id_type; /* Key identifier type [PKEY_ID_PKCS7] */
>   ^~
> include/linux/module_signature.h:35:2: error: unknown type name 'u8'
>   u8 signer_len; /* Length of signer's name [0] */
>   ^~
> include/linux/module_signature.h:36:2: error: unknown type name 'u8'
>   u8 key_id_len; /* Length of key identifier [0] */
>   ^~
> include/linux/module_signature.h:37:2: error: unknown type name 'u8'
>   u8 __pad[3];
>   ^~
> include/linux/module_signature.h:38:2: error: unknown type name '__be32'
>   __be32 sig_len; /* Length of signature data */
>   ^~~~~~
> include/linux/module_signature.h:41:54: error: unknown type name 'size_t'
>  int mod_check_sig(const struct module_signature *ms, size_t file_len,
>                                                       ^~~~~~
> include/linux/module_signature.h:41:54: note: 'size_t' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
> include/linux/module_signature.h:1:1:
> +#include <stddef.h>
>  /* SPDX-License-Identifier: GPL-2.0+ */
> include/linux/module_signature.h:41:54:
>  int mod_check_sig(const struct module_signature *ms, size_t file_len,
>                                                       ^~~~~~
>
> Caused by commit
>
>   c8424e776b09 ("MODSIGN: Export module signature definitions")
>
> We now have build time checks to make sure that include files are self
> contained.
>
> I have added the following fix patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Aug 2019 12:09:36 +1000
> Subject: [PATCH] MODSIGN: make new include file self contained
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/module_signature.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> index 523617fc5b6a..7eb4b00381ac 100644
> --- a/include/linux/module_signature.h
> +++ b/include/linux/module_signature.h
> @@ -9,6 +9,8 @@
>  #ifndef _LINUX_MODULE_SIGNATURE_H
>  #define _LINUX_MODULE_SIGNATURE_H
>
> +#include <linux/types.h>
> +
>  /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
>  #define MODULE_SIG_STRING "~Module signature appended~\n"

Sorry for the trouble. I wasn't aware of that build time check.
I'll enable HEADER_TEST and KERNEL_HEADER_TEST for my next patches.

Thanks for providing the fix. Should I post a new version or can Mimi
squash the above into the original patch?

--
Thiago Jung Bauermann
IBM Linux Technology Center

