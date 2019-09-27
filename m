Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF364C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD34217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfI0NjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:39:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfI0NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:39:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RDbYCH012546
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:39:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9gk0xq5c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:39:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 27 Sep 2019 14:38:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 14:38:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RDct1I43843760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 13:38:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D58A4060;
        Fri, 27 Sep 2019 13:38:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8ECFA4067;
        Fri, 27 Sep 2019 13:38:54 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.122.211.64])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 27 Sep 2019 13:38:54 +0000 (GMT)
Date:   Fri, 27 Sep 2019 19:08:53 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tracing/probe: Test nr_args match in looking for same
 probe events
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190927055035.4c3abae9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190927055035.4c3abae9@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19092713-0008-0000-0000-0000031BAE1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092713-0009-0000-0000-00004A3A4DBA
Message-Id: <20190927131458.GA19008@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<SNIP>

> The cause was that the args array to compare between two probe events only
> looked at one of the probe events size. If the other one had a smaller
> number of args, it would read out of bounds memory.
> 

I thought trace_probe_compare_arg_type() should have caught this. But looks
like there is one case it misses. 

Currently trace_probe_compare_arg_type() is okay if the newer probe has
lesser or equal arguments than the older probe. For all other cases, it
seems to error out. In this case, we must be hitting where the newer probe
has lesser arguments than older probe.


> Fixes: fe60b0ce8e733 ("tracing/probe: Reject exactly same probe event")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_kprobe.c | 2 ++
>  kernel/trace/trace_uprobe.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 402dc3ce88d3..d2543a403f25 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -537,6 +537,8 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
> 
>  	list_for_each_entry(pos, &tpe->probes, list) {
>  		orig = container_of(pos, struct trace_kprobe, tp);
> +		if (orig->tp.nr_args != comp->tp.nr_args)
> +			continue;

This has a side-effect where the newer probe has same argument commands, we
still end up appending the probe.

Lets says we already have a probe with 2 arguments, the newer probe has only
the first argument but same fetch command, we should have erred out.
No?


>  		if (strcmp(trace_kprobe_symbol(orig),
>  			   trace_kprobe_symbol(comp)) ||
>  		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index dd884341f5c5..11bcafdc93e2 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -420,6 +420,8 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
> 
>  	list_for_each_entry(pos, &tpe->probes, list) {
>  		orig = container_of(pos, struct trace_uprobe, tp);
> +		if (orig->tp.nr_args != comp->tp.nr_args)
> +			continue;
>  		if (comp_inode != d_real_inode(orig->path.dentry) ||
>  		    comp->offset != orig->offset)
>  			continue;

How about something like this?

 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 402dc3ce88d3..a056ff240957 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -546,13 +546,13 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
 		 * trace_probe_compare_arg_type() ensured that nr_args and
 		 * each argument name and type are same. Let's compare comm.
 		 */
-		for (i = 0; i < orig->tp.nr_args; i++) {
+		for (i = 0; i < comp->tp.nr_args; i++) {
 			if (strcmp(orig->tp.args[i].comm,
 				   comp->tp.args[i].comm))
 				break;
 		}
 
-		if (i == orig->tp.nr_args)
+		if (i == comp->tp.nr_args)
 			return true;
 	}
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index dd884341f5c5..512ce55ced91 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -428,13 +428,13 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 		 * trace_probe_compare_arg_type() ensured that nr_args and
 		 * each argument name and type are same. Let's compare comm.
 		 */
-		for (i = 0; i < orig->tp.nr_args; i++) {
+		for (i = 0; i < comp->tp.nr_args; i++) {
 			if (strcmp(orig->tp.args[i].comm,
 				   comp->tp.args[i].comm))
 				break;
 		}
 
-		if (i == orig->tp.nr_args)
+		if (i == comp->tp.nr_args)
 			return true;
 	}
 

With the above changes:

 # :> kprobe_events
 # echo p:test _do_fork arg1=%gpr3 arg2=%gpr4 arg3=%gpr5 >> kprobe_events
 # cat kprobe_events 
p:kprobes/test _do_fork arg1=%gpr3 arg2=%gpr4 arg3=%gpr5


#Add with extra arguments : SHOULD FAIL
 # echo p:test _do_fork arg1=%gpr3 arg2=%gpr4 arg3=%gpr5 arg4=%gpr6>> kprobe_events
bash: echo: write error: File exists

#Add with same arguments :SHOULD FAIL
 # echo p:test _do_fork arg1=%gpr3 arg2=%gpr4 arg3=%gpr5 >> kprobe_events
bash: echo: write error: File exists
 
#Add with less events but different name arg5 instead of arg2 :SHOULD FAIL
# echo p:test _do_fork arg1=%gpr3 arg5=%gpr2 >> kprobe_events
bash: echo: write error: File exists

#Add with less events with same name but different comm : SHOULD PASS
# echo p:test _do_fork arg1=%gpr3 arg2=%gpr2 >> kprobe_events
# cat kprobe_events 
p:kprobes/test _do_fork arg1=%gpr3 arg2=%gpr4 arg3=%gpr5
p:kprobes/test _do_fork arg1=%gpr3 arg2=%gpr2


-- 
Thanks and Regards
Srikar Dronamraju

