Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D61C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKlleygv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCFX7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:38 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49127 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCFX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:36 -0500
Received: by mail-vk1-f202.google.com with SMTP id j1so7389151vkj.15
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KKKYFBHbBMb9DlNvNVTDrUs10yWe2S8P/IItgj6dN2A=;
        b=uKlleygvjUMu0CZK8wWnXDD7l1l67NNJNeOSKFJK+V2wTAcUjiyenGRE5P2wrxne9Q
         02bgm5U3OFFXfiJkN4XhPpSZ2KHfwRe1bHljwcmMSOCdBOTS+Fyzi1QjvcS7aOSeFeNt
         apxcV8clriCVsbuz5ETKf8LBktpAwVGPsVMSqxm2HY+oPFHStshNNS613RV/o2jPnu9z
         c8XxFhxGCuZvOEewoCz8/vUIYzwqutWSk0UTbjcUkAGNSOQRdF+I1+Pbf5zz+rq93PUw
         fFefZg3+vEBOuNlXvEazOUuWVraHPbtFiOQNjEKh3i5qnICTeGZGbY/QSN5V7/1oIHO+
         nYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KKKYFBHbBMb9DlNvNVTDrUs10yWe2S8P/IItgj6dN2A=;
        b=Q2lmfpcWQV7O3t00QFOafN8zV/xAQ9Zr4nKMYq6BPvorkzU2Y50cveNr7ZFrUGSrGh
         lGKXnM7p9yJH+jaQSdjQGTqe79kbXreSqOIuLvBc2eB18Z6yKm2+WAHlrZuOJFKunaNW
         yRl8ZNUS4MoYum0jwFTP2RV5DzrsWh7vV9SWUa3VAIfF6ocfiN+asi+wn7WWWftIS1QR
         zchZyvr/Sp7biBKpgWsd2Ps7qg3QSh0ilhvmMszxvCk+IfALnkKsxJj7Ih9/Ab0hDWEB
         dRgEqCjokQbUDsyLNjH/nsMBFewggTAu4d+xsr4dlyPeVWSXDZTSYmsQkjNG/sJtVzuC
         4MZw==
X-Gm-Message-State: APjAAAU4aEEYfWwNtYkgcxHUDlgaf4iHkgFfZBlWMqVgqe2cAl5Ri4D2
        6A8GNyozQtanfrOlUYDCbWjxsVTuZgYru90+CnMkkg==
X-Google-Smtp-Source: APXvYqxpqAYiGWAFMmW1jxOfnE9F1x72ycLS3u1FKaUh5FvX2m7smCfePhhUH5HjIkm3CpPAZH4XwpHEknNnPBPNr/mzHQ==
X-Received: by 2002:ab0:6455:: with SMTP id j21mr6864734uap.11.1551916775048;
 Wed, 06 Mar 2019 15:59:35 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:51 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 05/27] kexec_load: Disable at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..8ea0ce31271f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.352.gf09ad66450-goog

