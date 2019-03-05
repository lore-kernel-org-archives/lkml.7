Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F95C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFBB2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCEN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:58:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727751AbfCEN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:58:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25DnSVq137405
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 08:58:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r1sc23gqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 08:58:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 5 Mar 2019 13:58:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 13:57:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25Dvt6m47644682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 13:57:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7B78A4068;
        Tue,  5 Mar 2019 13:57:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42BF0A405F;
        Tue,  5 Mar 2019 13:57:55 +0000 (GMT)
Received: from [9.152.212.90] (unknown [9.152.212.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 13:57:55 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] gcov: Clang support
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Daniel Mentz <danielmentz@google.com>,
        Petri Gynther <pgynther@google.com>
References: <20190122233749.42220-1-trong@android.com>
 <20190122233749.42220-3-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 5 Mar 2019 14:57:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190122233749.42220-3-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030513-0028-0000-0000-000003503060
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030513-0029-0000-0000-0000240E9A4E
Message-Id: <faa5a621-1f21-3136-58e7-9215c4f4d079@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.2019 00:37, Tri Vo wrote:
> From: Greg Hackmann <ghackmann@android.com>
> 
> LLVM uses profiling data that's deliberately similar to GCC, but has a very
> different way of exporting that data.  LLVM calls llvm_gcov_init() once per
> module, and provides a couple of callbacks that we can use to ask for more
> data.
> 
> We care about the "writeout" callback, which in turn calls back into
> compiler-rt/this module to dump all the gathered coverage data to disk:
> 
>    llvm_gcda_start_file()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      [... repeats for each function ...]
>    llvm_gcda_summary_info()
>    llvm_gcda_end_file()
> 
> This design is much more stateless and unstructured than gcc's, and is
> intended to run at process exit.  This forces us to keep some local state
> about which module we're dealing with at the moment.  On the other hand, it
> also means we don't depend as much on how LLVM represents profiling data
> internally.
> 
> See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
> details on how this works, particularly GCOVProfiler::emitProfileArcs(),
> GCOVProfiler::insertCounterWriteout(), and GCOVProfiler::insertFlush().
> 
> Co-authored-by: Nick Desaulniers <ndesaulniers@google.com>
> Co-authored-by: Tri Vo <trong@android.com>
> Signed-off-by: Greg Hackmann <ghackmann@android.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Trilok Soni <tsoni@quicinc.com>
> Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
> Tested-by: Tri Vo <trong@android.com>
> Tested-by: Daniel Mentz <danielmentz@google.com>
> Tested-by: Petri Gynther <pgynther@google.com>
> ---
>  kernel/gcov/Kconfig  |   3 +-
>  kernel/gcov/Makefile |   1 +
>  kernel/gcov/clang.c  | 555 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 558 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/gcov/clang.c
> 

[...]

> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> new file mode 100644
> index 000000000000..f9acdee3d578
> --- /dev/null
> +++ b/kernel/gcov/clang.c
> @@ -0,0 +1,555 @@

[...]

> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/printk.h>
> +#include <linux/ratelimit.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include "gcov.h"
> +
> +#define GCOV_TAG_FUNCTION_LENGTH	3

This define seems to be unused and should be removed.

[...]

> +/**
> + * gcov_info_unlink - unlink/remove profiling data set from the list
> + * @prev: previous profiling data set
> + * @info: profiling data set
> + */
> +void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
> +{
> +	if (info)
> +		list_del(&info->head);

The if-clause can be removed since @info is always non-NULL.

[...]

> +static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> +{
> +	size_t cv_size; /* counter values size */
> +

This empty line should be removed.

[...]

Rest looks good! With these minor changes applied:

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

