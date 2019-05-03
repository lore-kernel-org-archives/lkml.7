Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABA92075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfECSMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 14:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19665 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfECSMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED9636147C;
        Fri,  3 May 2019 18:12:18 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE6B60BFC;
        Fri,  3 May 2019 18:12:16 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: [PATCH v3 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
Date:   Fri,  3 May 2019 14:10:21 -0400
Message-Id: <1556907021-29730-3-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 03 May 2019 18:12:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a short explanation of the new PR_GET_TASK_SIZE option for the benefit
of future generations.

Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 man2/prctl.2 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 06d8e13c7..cae582726 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -49,6 +49,7 @@
 .\" 2013-01-10 Kees Cook, document PR_SET_PTRACER
 .\" 2012-02-04 Michael Kerrisk, document PR_{SET,GET}_CHILD_SUBREAPER
 .\" 2014-11-10 Dave Hansen, document PR_MPX_{EN,DIS}ABLE_MANAGEMENT
+.\" 2019-05-03 Joel Savitz, document PR_GET_TASK_SIZE
 .\"
 .\"
 .TH PRCTL 2 2019-03-06 "Linux" "Linux Programmer's Manual"
@@ -1375,6 +1376,15 @@ system call on Tru64).
 for information on versions and architectures)
 Return unaligned access control bits, in the location pointed to by
 .IR "(unsigned int\ *) arg2" .
+.TP
+.B PR_GET_TASK_SIZE
+Copy the value of TASK_SIZE to the userspace address in
+.IR "(unsigned long\ *) arg2" .
+This value represents the highest virtual address available
+to the current process. Return
+.B EFAULT
+if this operation fails.
+
 .SH RETURN VALUE
 On success,
 .BR PR_GET_DUMPABLE ,
--
2.18.1

