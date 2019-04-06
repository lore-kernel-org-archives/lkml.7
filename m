Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D01C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013C213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDFRW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:22:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbfDFRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:22:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x36HDMYU048155
        for <linux-kernel@vger.kernel.org>; Sat, 6 Apr 2019 13:22:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rpr6j8s1r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 13:22:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Sat, 6 Apr 2019 18:22:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 6 Apr 2019 18:22:50 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x36HMnag51839108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Apr 2019 17:22:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EEE95204F;
        Sat,  6 Apr 2019 17:22:49 +0000 (GMT)
Received: from localhost (unknown [9.124.219.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4297452052;
        Sat,  6 Apr 2019 17:22:49 +0000 (GMT)
Date:   Sat, 06 Apr 2019 22:52:47 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kprobes: fix compilation when KPROBE_EVENTS is enabled
 without kretpobes
To:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@stackframe.org>
Cc:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20190406155543.15353-1-svens@stackframe.org>
In-Reply-To: <20190406155543.15353-1-svens@stackframe.org>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19040617-0028-0000-0000-0000035DF835
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040617-0029-0000-0000-0000241D0E42
Message-Id: <1554570896.uirb80qggp.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-06_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904060119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle wrote:
> While implementing kprobes on PA-RISC (without kretprobes) compilation
> fails when CONFIG_KPROBE_EVENTS is enabled:

Thanks for working on that! Is there a specific reason kretprobes is not 
being enabled on parisc?

> 
> kernel/trace/trace_kprobe.o: in function `trace_kprobe_create':
> kernel/trace/trace_kprobe.c:666: undefined reference to `kprobe_on_func_entry'
> kernel/trace/trace_kprobe.o: in function `trace_kprobe_on_func_entry':
> kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
> kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
> make: *** [Makefile:1029: vmlinux] Error 1
> 
> Given the fact that these functions have no dependencies on kretprobes i think
> they should be moved out of the #ifdef CONFIG_KRETPROBES block.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)

These functions were originally added only for kretprobes, but have 
taken on newer uses since then. So, for this patch:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

However, I wonder if we should simply remove CONFIG_KRETPROBES 
altogether. All architectures supporting kprobes today also support 
kretprobes. I don't see why anyone would want to only disable 
kretprobes.


- Naveen


