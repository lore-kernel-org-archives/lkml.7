Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FEB2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrJDgzp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfFUBUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36240 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfFUBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id a5so2684626pla.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t/mH/2CAOnOWxHMVmIaOFtnDHIg0vKk910CbpA/m5hE=;
        b=ZrJDgzp2uG5EFeE4+0LjPFkV0TGUObRy4jaKbEQsMbGFlQmn6fopYXvd1LW8FCJjlf
         xqMgiWJHsarOqLc2NOHcvP5PUfYuofixZBCz9FuBma8aOFOF4vuTt5CRSL4fLm8BVxyR
         rAxZYQJ3kH92QKEWj+SInFl8VP1HMViB/TXI+hKbeI+s34xQyFt73DCMooaFgNRJb+Lg
         NWivhN7v4xaXLLeTEDkh1u5hYzRNZ3BTfnX1d1KRKBiqnCtA4L7i1elgetxINyuQwZNQ
         b8WeC3kT/TTr+6Tac8XSU9ovBR5flmyV+hwqTZ70a5EHt5+aTJNkpBM/Kf4eEWFGAw6t
         3B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t/mH/2CAOnOWxHMVmIaOFtnDHIg0vKk910CbpA/m5hE=;
        b=h6+/OQz71PRZhR5KJLWjOjaChr1E0smQcSI+7kPmRyQShZr3Mtys5aSyW7GjWFbQOS
         /i9Ih4UlxxSeGcEjx3mprVkXOoVMePLvDxTgaFLpgb6ORbXg6RPZkOcWnqQ+4TrlFAsu
         mnfrLNvuy8UPiWQMVV0KJ5Jlp2OUulrbfvreEMLoRM0VY3fMn8MU9/eRgyqRBF5aXh5g
         4xs/8dNrs7zehxml3W1ikbHUR+l0ja36IVvWu07ulKI03OS/JySn5Vm7z8Ku9ydmirVg
         KQ5JHuJTmXK1c1tROYlBILWXwmr+22P9CrKrrS9riVRHPiTSlaP/cgZlv/FyKyUPADsV
         PVzg==
X-Gm-Message-State: APjAAAVscWdQ9detyrGE9qChmcfccQsd0vmrniUBDSVEAVItoVppQJG3
        Xh20yqTmIkyLgbxAxLOecccuhUCgnG/HgJkgw8kbsw==
X-Google-Smtp-Source: APXvYqzxVqdSAIqmyaFpVNbAosUNxFCJA3loM78boAjh/0nuxooUctORb4Dj+NHACmdIFlF6J9m5m/dkrFISvkP8/LXfHg==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr15526503pgp.58.1561080010211;
 Thu, 20 Jun 2019 18:20:10 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:20 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 09/30] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
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
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..455f4fc794f3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (security_is_locked_down(LOCKDOWN_KEXEC)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.22.0.410.gd8fdbe21b5-goog

