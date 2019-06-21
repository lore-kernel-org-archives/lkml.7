Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601AFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399322084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAl+pb5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFUBUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:19 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50913 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfFUBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:16 -0400
Received: by mail-pl1-f202.google.com with SMTP id 71so2653718pld.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JqSAbEGn1HiZP7c6GcuMsV6mwVA+ao3NtmgYDy/YB50=;
        b=uAl+pb5UgR8qbNWvTqgNyUdGrjYg0S8BfztU1IaK3wSoovw9zlPCjs+fxR/Zldidjt
         wn9jEjHX6zhp2cY/ATrv0Ui2iFYIO/84hN6Y9U0zSrxpdUGNw4l6ofnhy4DW6H1w1REh
         e7xaSuXohECGbWYKz7+urb02nPjB4dMxHHraE2pgWMJeOrKlP6Brq6ZYzgnti8M6knOD
         M5dofE5spcg4W1bE+A2c24KQml7+KGHeAK64yt51wq5qc77KvrpFdOMYA4aIUfufBhW/
         VF40DkSCXitcpI+sAdK9CQdmQyjHL8QEx8o56v+XmnMnicC0CjNjNkw0OspKK1lBtU/2
         MRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JqSAbEGn1HiZP7c6GcuMsV6mwVA+ao3NtmgYDy/YB50=;
        b=nRT9cI1qSUSE6OADpPit18E2iSxMQX58uvgwwoyWaIgG1bRD1g87/QciWbP4w60RRt
         jK9XmgVruXF0rSPcjvcdCFR/VGNviqBRaAxqGZOkRjaSV/V2/6Yi3cPax3ZJ3STM6XAI
         LxQwLOpYjNq3G2Nf3tU8TaW3pyLhzuGxpzGRywePmuMDKsqxfgEi+1tQ0JlnB9nc39G7
         czOuYM5Q3heMEPCDicSdDgKaRU4uzjDgDlFOQ6zAbzgfx9sbmaI1RENE9Q1ZWtMYxlht
         JbsNRKI5ApslgAi/yuhrRMsCy3Sdw095edHTjQy3xbQ9uZmLP53n8ljg34LseYAC1e8w
         fevg==
X-Gm-Message-State: APjAAAX0nyEVZLxzduT/oc0SgEFeF2TTb+Y7mkESX7KecBTBBXQRqs23
        IPg90YktgO1v9HIOMH7Q2/jI8Qe5wkXtTmEoTa5gTA==
X-Google-Smtp-Source: APXvYqwT26wVJK6nFrq7e+H8nLKZxTkGEC6Cm+2MlyXrmHTpSaeB1v4qyUV96R/qlEsGT6gqXZ46YMXwlQeXlC7AVr9xzw==
X-Received: by 2002:a65:5006:: with SMTP id f6mr10257389pgo.402.1561080015411;
 Thu, 20 Jun 2019 18:20:15 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:22 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 11/30] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
---
 kernel/power/user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..8a8d7f1c8fbb 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -24,6 +24,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/security.h>
 
 #include <linux/uaccess.h>
 
@@ -52,6 +53,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (security_is_locked_down(LOCKDOWN_HIBERNATION))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.22.0.410.gd8fdbe21b5-goog

