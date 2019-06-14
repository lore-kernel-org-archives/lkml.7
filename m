Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A56C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA92F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfFNMbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbfFNMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:31:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ECVd6q099187
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:31:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4bfvgdpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:31:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 14 Jun 2019 13:30:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 13:30:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5ECTxPW15139008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 12:29:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C0EBA404D;
        Fri, 14 Jun 2019 12:29:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE914A4040;
        Fri, 14 Jun 2019 12:29:57 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 14 Jun 2019 12:29:57 +0000 (GMT)
Date:   Fri, 14 Jun 2019 17:59:57 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/uprobe: Fix NULL pointer dereference in
 trace_uprobe_create()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190614074026.8045-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190614074026.8045-1-devel@etsukata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19061412-0020-0000-0000-0000034A199C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061412-0021-0000-0000-0000219D55E5
Message-Id: <20190614122957.GA16523@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Eiichi Tsukata <devel@etsukata.com> [2019-06-14 16:40:25]:

> Just like the case of commit 8b05a3a7503c ("tracing/kprobes: Fix NULL
> pointer dereference in trace_kprobe_create()"), writing an incorrectly
> formatted string to uprobe_events can trigger NULL pointer dereference.
> 
> Reporeducer:
> 
>   # echo r > /sys/kernel/debug/tracing/uprobe_events
> 
> dmesg:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 8000000079d12067 P4D 8000000079d12067 PUD 7b7ab067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 PID: 1903 Comm: bash Not tainted 5.2.0-rc3+ #15
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
>   RIP: 0010:strchr+0x0/0x30
>   Code: c0 eb 0d 84 c9 74 18 48 83 c0 01 48 39 d0 74 0f 0f b6 0c 07 3a 0c 06 74 ea 19 c0 83 c8 01 c3 31 c0 c3 0f 1f 84 00 00 00 00 00 <0f> b6 07 89 f2 40 38 f0 75 0e eb 13 0f b6 47 01 48 83 c
>   RSP: 0018:ffffb55fc0403d10 EFLAGS: 00010293
> 
>   RAX: ffff993ffb793400 RBX: 0000000000000000 RCX: ffffffffa4852625
>   RDX: 0000000000000000 RSI: 000000000000002f RDI: 0000000000000000
>   RBP: ffffb55fc0403dd0 R08: ffff993ffb793400 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: ffff993ff9cc1668 R14: 0000000000000001 R15: 0000000000000000
>   FS:  00007f30c5147700(0000) GS:ffff993ffda00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 000000007b628000 CR4: 00000000000006f0
>   Call Trace:
>    trace_uprobe_create+0xe6/0xb10
>    ? __kmalloc_track_caller+0xe6/0x1c0
>    ? __kmalloc+0xf0/0x1d0
>    ? trace_uprobe_create+0xb10/0xb10
>    create_or_delete_trace_uprobe+0x35/0x90
>    ? trace_uprobe_create+0xb10/0xb10
>    trace_run_command+0x9c/0xb0
>    trace_parse_run_command+0xf9/0x1eb
>    ? probes_open+0x80/0x80
>    __vfs_write+0x43/0x90
>    vfs_write+0x14a/0x2a0
>    ksys_write+0xa2/0x170
>    do_syscall_64+0x7f/0x200
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fixes: 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for uprobe events")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  kernel/trace/trace_uprobe.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 


Good Catch.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

