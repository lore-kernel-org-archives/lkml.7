Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1258CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39FC2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="edAgsMtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfJaQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:40:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41414 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727593AbfJaQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:40:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VGdQEa016825
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:40:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=uA5VupX70Q9cTdALEHf4YRdTh6Lejo9S9pukcNuyetA=;
 b=edAgsMtduhoHBL4X0qZdoB692edqDjR+uod4/iYH3Gcs8JXHTz2EwEt61y3BlUJWeLf3
 0xQZ8foyX5P9kSdoAZNT9ivnH+TXd0yg/RvBoK591je3IqnikCtnS1Yt3XNszrSJa0MV
 7ppENiLmNkk1/L71XvDpVedlNHocDyTX7bs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w01bw8qd6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:40:00 -0700
Received: from 2401:db00:2050:5076:face:0:7:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 09:40:00 -0700
Received: by devvm005.ftw2.facebook.com (Postfix, from userid 8731)
        id 7CACA35494B0F; Thu, 31 Oct 2019 09:39:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Chris Mason <clm@fb.com>
Smtp-Origin-Hostname: devvm005.ftw2.facebook.com
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>, <linux-audit@redhat.com>,
        Kyle McMartin <jkkm@fb.com>, <linux-kernel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] audit: set context->dummy even when audit is off
Date:   Thu, 31 Oct 2019 09:39:31 -0700
Message-ID: <20191031163931.1102669-1-clm@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910310166
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones reported that we're finding a considerable amount of dmesg
traffic from NTP time adjustments being reported through the audit
subsystem.  His original post is here:

https://lore.kernel.org/lkml/20190923155041.GA14807@codemonkey.org.uk/

The confusing part is that we're seeing this on machines that don't have
audit on.  The NTP code uses audit_dummy_context() to decide if it
should log things:

	static inline void audit_ntp_log(const struct audit_ntp_data *ad)
	{
		if (!audit_dummy_context())
			__audit_ntp_log(ad);
	}

I confirmed with perf probes that:

	context->dummy = 0
	audit_n_rules = 0
	audit_enabled = 0
	audit_ever_enabled = 1 // seems to be from journald

The box boots, journald turns audit on, some time later our
configuration management runs around and turns audit off.  This journald
feature is discussed here: https://github.com/systemd/systemd/issues/959

From what I can tell, audit_syscall_entry is responsible for setting
context->dummy, but we never get down to the test for audit_n_rules:

__audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
                           unsigned long a3, unsigned long a4)
{
        struct audit_context *context = audit_context();
        enum audit_state     state;

        if (!audit_enabled || !context)
                return;
                ^^^^^^^^^^^^^^^^^^  --- we bail here

	[ ... ]

        context->dummy = !audit_n_rules;

This leaves context->dummy at 0, which appears to be the original value
from kzalloc().

If you've gotten this far, you've read everything I know about the audit
code.  With that said, my preference is to make a single source of truth for
decisions about logging.  This commit changes __audit_syscall_entry() to
set context->dummy when audit is off.

Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Chris Mason <clm@fb.com>
---
 kernel/auditsc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..a5c82d8f9c2b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1631,8 +1631,19 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	struct audit_context *context = audit_context();
 	enum audit_state     state;
 
-	if (!audit_enabled || !context)
+	if (!context)
+		return;
+
+	if (!audit_enabled) {
+		/*
+		 * ntp clock adjustments and a few other places check for
+		 * a dummy context without checking to see if audit
+		 * is enabled.  Make sure we set context->dummy when audit
+		 * is off, otherwise they will try to log things.
+		 */
+		context->dummy = 1;
 		return;
+	}
 
 	BUG_ON(context->in_syscall || context->name_count);
 
-- 
2.17.1

