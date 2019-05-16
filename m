Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC5C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0378B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U/xGWQ3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfEPRi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:38:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47124 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfEPRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:38:29 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GHbZK0003099
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=B2SIJpPp/mlOGynEQLUWe5A/4Aq03L0X3tl4w90B9Gw=;
 b=U/xGWQ3ojU2JxIog44PXNp5LPf2/Ycypw+1r8vLEJyLqAzCnHVyC3zvrKUvVZK0XoAwZ
 DN0Y0n3NAKzNROT8Uh7Ecr++ixHJ9xnPfvBycVuQZ4gX7kxv3Xr0Nkf9WT4+yhJtCOo+
 rJF8OhLSP4zv0YuxXkQW0bS/JN7M9+GwNnU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2shc8br1pc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:38:27 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 May 2019 10:38:25 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id B087112182CE9; Thu, 16 May 2019 10:38:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, Alex Xu <alex_y_xu@yahoo.ca>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH RESEND] signal: unconditionally leave the frozen state in ptrace_stop()
Date:   Thu, 16 May 2019 10:38:21 -0700
Message-ID: <20190516173821.1498807-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=317 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160112
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Xu reported a regression in strace, caused by the introduction of
the cgroup v2 freezer. The regression can be reproduced by stracing
the following simple program:

  #include <unistd.h>

  int main() {
      write(1, "a", 1);
      return 0;
  }

An attempt to run strace ./a.out leads to the infinite loop:
  [ pre-main omitted ]
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [ repeats forever ]

The problem occurs because the traced task leaves ptrace_stop()
(and the signal handling loop) with the frozen bit set. So let's
call cgroup_leave_frozen(true) unconditionally after sleeping
in ptrace_stop().

With this patch applied, strace works as expected:
  [ pre-main omitted ]
  write(1, "a", 1)                        = 1
  exit_group(0)                           = ?
  +++ exited with 0 +++

Reported-by: Alex Xu <alex_y_xu@yahoo.ca>
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8607b11ff936..565ba14d89d5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2112,6 +2112,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		cgroup_enter_frozen();
 		freezable_schedule();
+		cgroup_leave_frozen(true);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
-- 
2.20.1

