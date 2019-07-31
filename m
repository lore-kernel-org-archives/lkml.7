Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB1206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmIx1daq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfGaWQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:52 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:35907 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfGaWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:50 -0400
Received: by mail-ua1-f74.google.com with SMTP id r11so7252329uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=cmIx1daqZEKRBkMW2JYQfOqzUiRs2oBlgGsfJ136BcTbgFMR1CJl2NqSDVgDe896Bx
         mpbcsPT67i243WQ4vLJxFNcPA4oGZ3Cz6MDwB0lBJSVHyXdZ+LTkkVhocNH63pmKpNYi
         jzKaCCH1ri5of7nbJCrFDV2szkQzQ4/IyfgIxl0y5Pz8cdpCVYSWtX3QdnT/0R1pxHJ8
         86aVpuAguhOmGJFr5DCnDbgOLeH53KoQruXbdg8fiqbjwqEj4qIljZP/1qVz6Wc3j62q
         w8/FDQdrnu0IDQzCJ94OCBvj1zAWNGFs45jfQtd1ADYZiLLYm6kZQGlGm22DObG2SgD+
         u1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=Uhg6qMlNAg6CtLmjICrFgeex+rS2LQwSfTH+LexWF6fpQI5OG5NPs/HUr7hdx5hEqy
         yCpgF+ZwUsufWtAOnoku9yWQu3/NCr5MalJd2Ycky0++VYrof3xwqDEWB+l4IyC6UqQe
         npQnkUjMweohiDwNhBsEWI0at2f4n9YOBv1yOINoobOjhUDCDzQ3FaA7Dx79RkY44mEK
         qHGAm+zmDz7f80nHDGcNClzNpWoiDTVfTMTKI1Z8YJ7RDSuEPC0dg8S61eoBe9H5Wcsw
         fvJZIV8aHayrTnR5gZWRVQfqf7swRdKmQp751610GjgrrOpV5isYqtsbYcwFMwCKZ4FO
         PQMQ==
X-Gm-Message-State: APjAAAX2RM9vfDvc9dt+jjA0OUz3Z+J2C3EUmy8dkwiN0QfS8JEGnk/Q
        r5kNaPAW+ZnrFzB3LK8Xeu+D3BgNDRo90dIlWo6mVw==
X-Google-Smtp-Source: APXvYqwxxFBGuXs7H0AALmQP7lKFkyE/Ao0WUi2DN+KhehbfvyAwH2M8AeJB6/9kmo67vl8W4RHQYCsqQBB2qu0nAvlB4Q==
X-Received: by 2002:ab0:60b9:: with SMTP id f25mr62470698uam.111.1564611409165;
 Wed, 31 Jul 2019 15:16:49 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:57 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 875482c34154..dd06f1070d66 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -228,7 +228,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = 0;
+		ret = security_locked_down(LOCKDOWN_KEXEC);
+		if (ret)
+			goto out;
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.22.0.770.g0f2c4a37fd-goog

