Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13220663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRB6MFnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCFX7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:52 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:58600 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCFX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:47 -0500
Received: by mail-it1-f201.google.com with SMTP id 9so7041275ita.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rcoY9tEENkPaxN2uc2H4A3TvvTCasWpC/2OBy6PWjj0=;
        b=JRB6MFnI6CPHKumtls+v+QBW7huDdcHgUo+9G6jnfMgtqnoDu+NHyFBZ3cUbo632t2
         PlyEn7WDWbPymbRpkF3y3nrGsSdRqjr6WuE0wI5aQpoDoJtOPImZywpluRwMVNUtzYnv
         vr8adGb/tSGxj/r/6bBGVZYEhsyms0OeDTa+7aU7+SmwYVp224csVMQWZUWLnSPI0P4K
         udeBcAK3Ti48QozUBr3XOz3jl02KsXDgn3AOjVOj03xEtm8S7aLowHKVDYj6l5OL6cLW
         rYZtqPka5Y+F/WjoAzm6m9vHA8cgp3v6by7Z5TBVbSp/uAEjvbwkH3xvVDBUX5flQAGx
         qC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rcoY9tEENkPaxN2uc2H4A3TvvTCasWpC/2OBy6PWjj0=;
        b=H0Qapa7RWsKYkd87YuYWmk7Y+htMYRxEq6VzLhBT0ILeJV7fsklNdfYJtHnkCR2Vzm
         6tkJxquEl/LwKYjbG2iJzNN80ET5RlBqzNnBseKU1/U/c9dtMlUvFDyq25G79MNRuY2V
         x6PA01JLp1QdFddRH3aOdndPETt6Gvgqx7tmjKuIWWqlFPswr9w7fHgEQUyFmpSLcMjm
         v63fB2C0ASdfr8Y34zbsFCQdlNMPQbO4gf4DDb8uuBXXv6OwKO7r+LnUkOc052HdGVfQ
         9uc/FcAmNQbmn5i7g/YMlC8m1zIxmAxv7ei1DMYDR5zcOQtmU2C+QvdCsFt1pERdytXB
         8VRg==
X-Gm-Message-State: APjAAAWjWaCWEhf/oc31hJejPzPDacE8Akc49REnzleMR5wa/yPiriZS
        njv/3fIUuVHFUiubDiQTx9RFgzTKGePu+l18juPEpg==
X-Google-Smtp-Source: APXvYqxGw8B9EHptHkokWDqZZE64N4QJSY8ps2Pub8k3OebCUGaqCst4r3RFxG/Nq8WYbm1W63x0ibE/nq1ckHdCxbwYTw==
X-Received: by 2002:a05:660c:48:: with SMTP id p8mr7384486itk.31.1551916786498;
 Wed, 06 Mar 2019 15:59:46 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:54 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 08/27] kexec_file: Restrict at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Chun-Yi Lee <jlee@suse.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..0cfe4f6f7f85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.352.gf09ad66450-goog

