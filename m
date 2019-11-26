Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78F020722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MiwPrVHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfKZMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:22:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKZMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:22:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQCIx9a124963;
        Tue, 26 Nov 2019 12:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=NTQIxt40LXfPQACIce5FWudimuSPwGtXy3yV8KLOGjQ=;
 b=MiwPrVHWn/rErJvfdi9x6MuStdUbsbeOq4GkmuccGxSZU5dmh967RQTzI0nT8PEZbazK
 43dmaymnDA/45ZqxxGInsqfjNyQwm8djmPjirEXS7vM29+a8unEoeO4OlQwXinVw5c7H
 HnmODH4bm5jFm3i4h4oocdsvTk7PocwAsbwxFtbQV2yb0EzwrwBbqh7P6cOgLWJ5maka
 oWg/x63AofLPDPauGL/iEJDUlWPSbN3YpuWwXcpTC/vIB/VqRgCHJJfRMO3fc+6EdqWP
 /P1PyrTv9Y3BSv6g+U9dOYLRvwIrAu5bVA5MGW1Pv42zLP7R62PBIa2mE/E3MqOv4YuZ sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wev6u6es0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:21:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8Vxd017105;
        Tue, 26 Nov 2019 12:19:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wh0rbe47x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:19:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAQCJffZ006109;
        Tue, 26 Nov 2019 12:19:42 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 04:19:41 -0800
Date:   Tue, 26 Nov 2019 15:19:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] Silence an uninitialized variable warning
Message-ID: <20191126121934.kuolgbm55dirfbay@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that "ret" could be uninitialized if we don't enter the
loop.  I don't know if that's possible, but it's nicer to return a
literal zero instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/trace_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 73140d80dd46..63528f458826 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -286,7 +286,7 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		offset += sizeof(unsigned long);
 	}
 
-	return ret;
+	return 0;
 }
 
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
-- 
2.11.0

