Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B075C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45320644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF0OvF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:51:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfF0OvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:51:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5REhr7g143624
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:51:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcxnx5403-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:51:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 15:51:02 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 15:50:59 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5REomkn33947968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 14:50:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BA92A4064;
        Thu, 27 Jun 2019 14:50:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F95A4060;
        Thu, 27 Jun 2019 14:50:57 +0000 (GMT)
Received: from localhost (unknown [9.199.59.170])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 14:50:57 +0000 (GMT)
Date:   Thu, 27 Jun 2019 20:20:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.v
        net.ibm.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19062714-0012-0000-0000-0000032D14FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062714-0013-0000-0000-00002166538D
Message-Id: <1561646984.1q83gyp5m8.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao wrote:
> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
> enable function tracing and profiling. So far, with dynamic ftrace, we
> used to only patch out the branch to _mcount(). However, mflr is
> executed by the branch unit that can only execute one per cycle on
> POWER9 and shared with branches, so it would be nice to avoid it where
> possible.
> 
> We cannot simply nop out the mflr either. When enabling function
> tracing, there can be a race if tracing is enabled when some thread was
> interrupted after executing a nop'ed out mflr. In this case, the thread
> would execute the now-patched-in branch to _mcount() without having
> executed the preceding mflr.
> 
> To solve this, we now enable function tracing in 2 steps: patch in the
> mflr instruction, use 'smp_call_function(isync);
> synchronize_rcu_tasks()' to ensure all existing threads make progress,
> and then patch in the branch to _mcount(). We override
> ftrace_replace_code() with a powerpc64 variant for this purpose.
> 
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/trace/ftrace.c | 258 ++++++++++++++++++++++++++---
>  1 file changed, 236 insertions(+), 22 deletions(-)
> 

I missed adding a comment here to explain the changes. As discussed in 
the previous series, I think we are ok with this patch from a CMODX 
perspective. For smp_call_function(), I decided to have it included in 
this patch since we know that we need it here for sure. I am not 
entirely sure we want to do that in patch_instruction() since ftrace 
doesn't seem to need it elsewhere. As Nick Piggin pointed out, we may 
want to have users of patch_instruction() (kprobes) add the necessary 
synchronization.


Thanks,
Naveen


