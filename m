Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73391C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D5720665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Vs7UBE5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfK0Ppk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:45:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20674 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbfK0Ppj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:45:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARFbTHF029788;
        Wed, 27 Nov 2019 16:44:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=PH+0zp+Gk/pAQpH9RTuZiZL+MAlTCAjAZQwfC7D6aqI=;
 b=Vs7UBE5I4O5rpcVwYrGUKRDWQxGdPIf47Mcd0/KJDX+H+vn+RLViwaT/jPq8FtSTqCjL
 WRphBgcoWjThKTaDQHu/YMQ30PktzXF13B3IFBphmO6N4AbCPOMZHyZzZ8aPhhVneCc8
 sALW650WS7wi+bW8DJzausv70wihOkfllbhNFkC3YXO+JnkPnizaREj8oydAQx9s4wGs
 ZtfSvPJmsPBJdpfUKcgugNpcKFQdInDP5pvxOzcmEfbSawelxfET7Rltoqpq5DHivlRb
 OHUTrY9XKwtYADdDaw8mSb+ApqwF1W54WXqJlFty8izTRQN0lmSB4sFTolpcAYqwGMD+ +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsckrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 16:44:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9CB6E10003A;
        Wed, 27 Nov 2019 16:44:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 510132C1164;
        Wed, 27 Nov 2019 16:44:55 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 16:44:54
 +0100
From:   Antonio Borneo <antonio.borneo@st.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Antonio Borneo <antonio.borneo@st.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable events
Date:   Wed, 27 Nov 2019 16:44:28 +0100
Message-ID: <20191127154428.191095-1-antonio.borneo@st.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_03:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tracing event class is the only instance in kernel that logs
in the trace buffer the instruction pointer as offset to _stext,
instead of logging the full pointer.
This looks like a nice optimization for 64 bits platforms, where a
32 bit offset can take less space than a full 64 bits pointer. But
the symbol _stext is incorrectly resolved as zero in the expansion
of TP_printk(), which then prints only the hex offset instead of
the name of the caller function. Plus, on arm arch the kernel
modules are loaded at address lower than _stext, causing the u32
offset arithmetics to overflow and wrap at 32 bits.
I did not identified a 64 bit arch where the modules are loaded at
offset from _stext that exceed u32 range, but I also did not
identified any constraint to feel safe with a u32 offset.

Log directly the instruction pointer instead of the offset to
_stext.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Fixes: d59158162e03 ("tracing: Add support for preempt and irq enable/disable events")
---
 include/trace/events/preemptirq.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 95fba0471e5b..d548a6aafa18 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -18,18 +18,18 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 	TP_ARGS(ip, parent_ip),
 
 	TP_STRUCT__entry(
-		__field(u32, caller_offs)
-		__field(u32, parent_offs)
+		__field(unsigned long, caller_ip)
+		__field(unsigned long, parent_ip)
 	),
 
 	TP_fast_assign(
-		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
-		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
+		__entry->caller_ip = ip;
+		__entry->parent_ip = parent_ip;
 	),
 
 	TP_printk("caller=%pS parent=%pS",
-		  (void *)((unsigned long)(_stext) + __entry->caller_offs),
-		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
+		  (void *)__entry->caller_ip,
+		  (void *)__entry->parent_ip)
 );
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.24.0

