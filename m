Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73902C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4093220881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+jT2ExB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfFVAGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:06:40 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36692 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfFVAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:25 -0400
Received: by mail-pg1-f202.google.com with SMTP id s4so5008161pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o4JS6ZsbyHnt4Iukj8bZlTq9cv6XEso1+I/lLyLsbpA=;
        b=a+jT2ExBtmOGrE2RBwibGRFthL5zBOYgrJWml8uNIPt9rHxq+DfglrA0/Y5pBqU9QQ
         HpS+WH2bZYzHAFWpqgCYqmXUCwak+27QIHhABd4BbGjacaPht5GkZL4AUiYAZqiFEw4g
         OWfCM5eDm4KrIttm0QlSi2FmyQ5mMxmZMrAg0PPYAY9jtCypjRtwPzqrvztnH6gGIENN
         6gg0DvWo19xJnE3hv2pBXaws7upY4aoCIGqykeQepmFEC2MeVBjac+ouverM2jCUIr0N
         76vtr2+s7zaSAuTfMYgT3Eb5U8sq72+KctC6jCs732M5YkTFIz0QsAVT6vMlXfsS6YBn
         4DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o4JS6ZsbyHnt4Iukj8bZlTq9cv6XEso1+I/lLyLsbpA=;
        b=HeaN1ez2HgnW2g6oD09jkN4FtWScL+s8uWl4Rgu31tbKi3udnv6JCFTbfF2vRNti8t
         XP+cn4kX7I5si3YF9BCNf6p0wml264eIhEx3dsj8Rd7JaYG3tnWwfdaAEFuUGB2ti+kq
         eB6hr8LP389HVa9FD1W5d9i/mNgygPYd97rRqpTj6p7rVb6GWjmEZ3kJVi5cyltnf25I
         Fdv2z+9flvBWMF768qEMJK2Ck5LPGAczrCnoHnKQeWECw3zD2u9F2ymDIf5IhrnLeatL
         cAw01ioYfaGpc+f8B+/mNIMsTl9EVUGyQ6JiLvDVQiVW+VOsFOZhSLchFPJVBTCGZhEc
         LjgA==
X-Gm-Message-State: APjAAAUnMrbGCWecRksnFUq77nOx7vkZkyud53eUuoy8tBpcB2U5q3Kq
        iq6RGhd2al3+/u+3nPhBGlhmHPnlw+Dzp+rgvq245A==
X-Google-Smtp-Source: APXvYqw5rFft+vShj1dHsGGITKkOPUFNJ8H0xme43V9+MAij1nj1qBbMAY4uDsOV1ThNNZ0FUlZ3kOxEzhFD4poriXVZqQ==
X-Received: by 2002:a63:8c0f:: with SMTP id m15mr1862896pgd.441.1561161864327;
 Fri, 21 Jun 2019 17:04:24 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:38 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
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
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eec7e5bb2a08..27adb4312b03 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -237,7 +237,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
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
2.22.0.410.gd8fdbe21b5-goog

