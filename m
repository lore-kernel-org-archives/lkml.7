Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C1C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F23216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfI3K3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:29:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729094AbfI3K3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:29:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UACVXn068477
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:29:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbdj9fgtf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:29:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 30 Sep 2019 11:29:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 11:29:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UAT08i38797500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 10:29:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EFCC11C05C;
        Mon, 30 Sep 2019 10:29:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF9711C052;
        Mon, 30 Sep 2019 10:28:58 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.193.110.254])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 30 Sep 2019 10:28:58 +0000 (GMT)
Date:   Mon, 30 Sep 2019 15:58:57 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] tracing/probe: Fix to check the difference of nr_args
 before adding probe
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
 <156966474783.3478.13217501608215769150.stgit@devnote2>
 <20190928171158.4b72ab55@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190928171158.4b72ab55@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19093010-0012-0000-0000-0000035203B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093010-0013-0000-0000-0000218CA558
Message-Id: <20190930064347.GB19008@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt <rostedt@goodmis.org> [2019-09-28 17:11:58]:

> On Sat, 28 Sep 2019 02:59:08 -0700
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix to check the difference of nr_args before adding probe
> > on existing probes. This also may set the error log index
> > bigger than the number of command parameters. In that case
> > it sets the error position is next to the last parameter.
> > 
> > Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> I modified the change log a bit, below is the patch I plan on submitting.
> 
> You OK with this?
> 
> -- Steve
> 
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Sat, 28 Sep 2019 05:53:29 -0400
> Subject: [PATCH] tracing/probe: Fix to check the difference of nr_args before
>  adding probe
> 
> Steven reported that a test triggered:
> 
> ==================================================================
>  BUG: KASAN: slab-out-of-bounds in trace_kprobe_create+0xa9e/0xe40
>  Read of size 8 at addr ffff8880c4f25a48 by task ftracetest/4798
> 
>  CPU: 2 PID: 4798 Comm: ftracetest Not tainted 5.3.0-rc6-test+ #30
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  Call Trace:
>   dump_stack+0x7c/0xc0
>   ? trace_kprobe_create+0xa9e/0xe40
>   print_address_description+0x6c/0x332
>   ? trace_kprobe_create+0xa9e/0xe40
>   ? trace_kprobe_create+0xa9e/0xe40
>   __kasan_report.cold.6+0x1a/0x3b
>   ? trace_kprobe_create+0xa9e/0xe40
>   kasan_report+0xe/0x12
>   trace_kprobe_create+0xa9e/0xe40
>   ? print_kprobe_event+0x280/0x280
>   ? match_held_lock+0x1b/0x240
>   ? find_held_lock+0xac/0xd0
>   ? fs_reclaim_release.part.112+0x5/0x20
>   ? lock_downgrade+0x350/0x350
>   ? kasan_unpoison_shadow+0x30/0x40
>   ? __kasan_kmalloc.constprop.6+0xc1/0xd0
>   ? trace_kprobe_create+0xe40/0xe40
>   ? trace_kprobe_create+0xe40/0xe40
>   create_or_delete_trace_kprobe+0x2e/0x60
>   trace_run_command+0xc3/0xe0
>   ? trace_panic_handler+0x20/0x20
>   ? kasan_unpoison_shadow+0x30/0x40
>   trace_parse_run_command+0xdc/0x163
>   vfs_write+0xe1/0x240
>   ksys_write+0xba/0x150
>   ? __ia32_sys_read+0x50/0x50
>   ? tracer_hardirqs_on+0x61/0x180
>   ? trace_hardirqs_off_caller+0x43/0x110
>   ? mark_held_locks+0x29/0xa0
>   ? do_syscall_64+0x14/0x260
>   do_syscall_64+0x68/0x260
> 
> Fix to check the difference of nr_args before adding probe
> on existing probes. This also may set the error log index
> bigger than the number of command parameters. In that case
> it sets the error position is next to the last parameter.
> 
> Link: http://lkml.kernel.org/r/156966474783.3478.13217501608215769150.stgit@devnote2
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
> Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_probe.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

-- 
Thanks and Regards
Srikar Dronamraju

