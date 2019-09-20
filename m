Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BCAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3277B217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPABTck2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407290AbfIUAAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:00:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407171AbfIUAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:00:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KNxZAW106774;
        Fri, 20 Sep 2019 23:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=LhSuuZ1O24KLtZephMP5Prb2ILpveTttTiJkt7TPQqQ=;
 b=YPABTck2vDSA96rwpZ0JL7JjbUlwlEqcAH5A3bKBPr0zXIo+kAq+Vzrbdy7eBfGsS4RG
 CfEzIQmeDvPLBlFrwb6prBRRpC9IA9KKaUS/IQOVA4j4hDHunu8AB7zA1OLne+eDFRyE
 +pLoaW4/uvEJXuSkvtIN9jjDmC6NtYkpsfSh+TNslkTCDeF2LQz8/U98XhGvS34X3n9X
 hm5P6+58VtuNytyHjpFvXKpvXP0C17bhU+TKdSVRSrBkYySKN32l4UdbePVepIQFaj/5
 mNGwq7KQ7IlUviPKknnGAY/7nzI6J3Nm3ezft75WhzXgaEtdtyS7f86HpmE9sGwSLCM1 ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v3vb555cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 23:59:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KNwhX7125912;
        Fri, 20 Sep 2019 23:59:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v51vr3pva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 23:59:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8KNxXd9006426;
        Fri, 20 Sep 2019 23:59:33 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Sep 2019 16:59:33 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [RFC]Sample module for Kernel access to Ftrace instances.
Date:   Fri, 20 Sep 2019 16:59:25 -0700
Message-Id: <1569023966-23004-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909200203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=882 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909200203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] tracing: Sample module to demonstrate kernel access to Ftrace

Hi,

This patch is for a sample module to demonstrate the use of APIs that 
were introduced/exported in order to access Ftrace instances from within the kernel.

Please Note: This module is dependent on -
- commit: f45d122 tracing: Kernel access to Ftrace instances
- Patches pending review: https://lore.kernel.org/lkml/1565805327-579-1-git-send-email-divya.indi@oracle.com/

The sample module creates/lookup a trace array called sample-instance on module load time. 
We then start a kernel thread(simple-thread) to -
1) Enable tracing for event "sample_event" to buffer associated with the trace array - "sample-instance".
2) Start a timer that will disable tracing to this buffer after 5 sec. (Tracing disabled after 5 sec ie at count=4)
3) Write to the buffer using trace_array_printk()
4) Stop the kernel thread and destroy the buffer during module unload.

A sample output for the same -

# tracer: nop
#
# entries-in-buffer/entries-written: 16/16   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
 sample-instance-26797 [003] .... 955180.489833: simple_thread: trace_array_printk: count=0
 sample-instance-26797 [003] .... 955180.489836: sample_event: count value=0 at jiffies=5249940864
 sample-instance-26797 [003] .... 955181.513722: simple_thread: trace_array_printk: count=1
 sample-instance-26797 [003] .... 955181.513724: sample_event: count value=1 at jiffies=5249941888
 sample-instance-26797 [003] .... 955182.537629: simple_thread: trace_array_printk: count=2
 sample-instance-26797 [003] .... 955182.537631: sample_event: count value=2 at jiffies=5249942912
 sample-instance-26797 [003] .... 955183.561516: simple_thread: trace_array_printk: count=3
 sample-instance-26797 [003] .... 955183.561518: sample_event: count value=3 at jiffies=5249943936
 sample-instance-26797 [003] .... 955184.585423: simple_thread: trace_array_printk: count=4
 sample-instance-26797 [003] .... 955184.585427: sample_event: count value=4 at jiffies=5249944960
 sample-instance-26797 [003] .... 955185.609344: simple_thread: trace_array_printk: count=5
 sample-instance-26797 [003] .... 955186.633241: simple_thread: trace_array_printk: count=6
 sample-instance-26797 [003] .... 955187.657157: simple_thread: trace_array_printk: count=7
 sample-instance-26797 [003] .... 955188.681039: simple_thread: trace_array_printk: count=8
 sample-instance-26797 [003] .... 955189.704937: simple_thread: trace_array_printk: count=9
 sample-instance-26797 [003] .... 955190.728840: simple_thread: trace_array_printk: count=10

Let me know if you have any questions.

Thanks,
Divya
