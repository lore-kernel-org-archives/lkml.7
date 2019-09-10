Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB40C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA852168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9a4A105"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405538AbfIJKD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:03:28 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41953 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405501AbfIJKD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so10349229pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGqYubR5Lthr7yxzMgwTRpMO66aeWf2qCN8tGk0FHOg=;
        b=H9a4A105QMmIT8qtxtAQb/NY2MEr1GOUe/9IKXYp1yvFWHSfAlO7CBzcQZRfYWqncZ
         ZxjG2BQdBexz3OJ4rQ18i+Tdc3DAR0KN3k1p2m17MRcZgGQGgZz5/r8Hh6ucuKYTFsIi
         fkb8CbJOBYh5MchJNUxddQmx01y0IRBgwhn9w7/i/8qNC3CBTrlV1D1ve6Q/DDPIurib
         yxPmoPvNIBTWUXkW4bGU99MVYfLii9je1nMATSauAG/U7ocCXMNyfCM+zbtllmDkLzGg
         do7yLqBRV4AxHkpxALJqAc8OwbG2kROF+aQt44aAwQhK2tgyyCAquB/tOVTRHxvF3hM2
         vuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGqYubR5Lthr7yxzMgwTRpMO66aeWf2qCN8tGk0FHOg=;
        b=Mr2FiVoZCy00Vo/VDtYeSkNIg6kLG+Txqy3LNDhM5RazJZMIwKZRKUcj5sdaGLbbSl
         5wABEPsZp/wFpyOFU1NePB2ZmOE1b1TadJXJkqnwX1mYoW659UEPDh9O+07i7WcFgyqi
         BOGnD1QYdE2jK5xfBXG8p9Mrr3tZYmuf5aYuNf1Qtr6iQQBlCsdrtlJiJHR6L7mQipS1
         cRQRf0w1R+eUMbPfXyDld1AgrM04Ne2mlw/g+8my3AkJj3jzs/2et7K7PkZzRQZmeY+m
         7cKMkfH1ca2cyeXOP+qrnWtAx3xhtZRcXEuOgJtvRf/CafoUrUZVekvZ8MNswgrq9tAd
         ImMA==
X-Gm-Message-State: APjAAAUA1/DzWXO29AnZovozZPxalPqMWwiKfrUzQnuN1yInMOMe6wFj
        J9gvn3q9vaW2YzkS83NTCDym9in/zmYxpfSo6IecNQ==
X-Google-Smtp-Source: APXvYqzM05C6SE3TotMj3/meUIyoGC4bBZZMU7jv39OiAWQEeQWjMdLKgYPvcwQT8uU2wIK6u/jlz3kmMv7mFo/bmMBTvg==
X-Received: by 2002:a65:6850:: with SMTP id q16mr27663278pgt.423.1568109805751;
 Tue, 10 Sep 2019 03:03:25 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:17 -0700
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-Id: <20190910100318.204420-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190910100318.204420-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 1/2] security: constify some arrays in lockdown LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No reason for these not to be const.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Suggested-by: David Howells <dhowells@redhat.com>
---
 security/lockdown/lockdown.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0068cec77c05..8a10b43daf74 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -16,7 +16,7 @@
 
 static enum lockdown_reason kernel_locked_down;
 
-static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
+static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
@@ -40,7 +40,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
+static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
 						 LOCKDOWN_INTEGRITY_MAX,
 						 LOCKDOWN_CONFIDENTIALITY_MAX};
 
-- 
2.23.0.162.g0b9fbb3734-goog

