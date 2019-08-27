Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE014C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF320856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifFJaEMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfH0Xsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:48:54 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55548 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0Xsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:48:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id u24so429034plq.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YSfHst/Bl/LfQtkjdspGrz28MoFsoc+Jd1G8OfuVwCk=;
        b=ifFJaEMU210M+K60despKxp3Iezj8GmCr75ZNS/g7W/DxZtJ/BCTtBazy31NVPXlaz
         IlCkQ9B+18xp4eOvOUu8cld5QZ7PLu8c1U5cT/dHjFXfBLSg1Pz8Qc2kP8wiYtYE56Me
         WUoaTFii7vnQ6NywWuCL4ltuQQweq4a0Gj6nMhvASFq0jcKn1u2hSkoegj2rLzEoPy3k
         m9gXYmTGEZNjuiR8AZLgdnYEY43eatOode69F0b4oVyvFI4LA7kzFaw0fzolYPtkXSMK
         IVW2NgsHR5+zVEojwMS4cBzm9+IsSYYsnPQ0JSjTyb710JsivjSNxIYqHQEFlzOYjTzY
         cQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YSfHst/Bl/LfQtkjdspGrz28MoFsoc+Jd1G8OfuVwCk=;
        b=loxep7qeCjDLu08rup0O2xDAnAB0izeEvyl/NeNRS64h0STdpL2cnJUb5tP7rbRxPx
         8pxK6pFpQbISYxc2MlJeKDK8gqPEU0jFquvakbL/BkgpuUeznv1syXmoUS/VAP9TUZVr
         IvrOx/HETyH2WmRU75na9WMYkPmjC0fh4qCvjdWo5TamG9BISaoD9FCnOtdKCREmMC4T
         irl3PSqVbN6C60XukE0iBAy0wFBCg3DsIePJqDuiREAwm6yCUUxUgZAJBm6GfgwXHlu+
         p8x8GnYw2PtK3+IJtzYRkVb48htjSdpD/cBQlbOUuUuKbCc95gsw2mHkGSX1OS90B5aq
         U3CQ==
X-Gm-Message-State: APjAAAXBQxTi/IS+f0F7dWMe9VtF5VuKm3+aOp3TKr/OEegbs49pGopD
        7dXZWERdJZTDvBdTEky1IUP3YsP5itGg2yKM3iB1VA==
X-Google-Smtp-Source: APXvYqzKkVTRNR5hP07OYfwSrYSUmv1utGpt7A0BilEznNYCRj7LuiktTCRgu4IhMQfuDNVS+2oq/WXIlGThfWmUGFc/gQ==
X-Received: by 2002:a63:3148:: with SMTP id x69mr874414pgx.300.1566949732956;
 Tue, 27 Aug 2019 16:48:52 -0700 (PDT)
Date:   Tue, 27 Aug 2019 16:48:35 -0700
Message-Id: <20190827234835.234473-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v1] printk: add dummy vprintk_emit for when CONFIG_PRINTK=n
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously vprintk_emit was only defined when CONFIG_PRINTK=y, this
caused a build failure in kunit/test.c when CONFIG_PRINTK was not set.
Add a no-op dummy so that callers don't have to ifdef around this.

Note: It has been suggested that this go in through the kselftest tree
along with the KUnit patches, because KUnit depends on this. See the
second link for the discussion on this.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
Link: https://lore.kernel.org/linux-kselftest/ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com/
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/linux/printk.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1..85b7970615a9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -206,6 +206,13 @@ extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
 #else
+static inline __printf(5, 0)
+int vprintk_emit(int facility, int level,
+		 const char *dict, size_t dictlen,
+		 const char *fmt, va_list args)
+{
+	return 0;
+}
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
 {
-- 
2.23.0.187.g17f5b7556c-goog

