Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6F120854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1ibSFci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfCGAA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:27 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34194 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfCGAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:24 -0500
Received: by mail-qk1-f202.google.com with SMTP id y6so11650327qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcieI5+oJsXOBRD2KKmNlRR+gsKSY7mBPeZzRy6NCSc=;
        b=O1ibSFciJav1PBiNgfW7eudRgTugTEl+TugUvK9qs+q2PFX0lyPloPkpzQwzw61I64
         Q2zx5/02BIZdytE7FQiwVUDn2df256UDJt3cpW+z1UhfXc+rC+66FD0K/p4em9inKb8J
         /XFuvm5TXkQ6iT7dbSpy6iXTYwfeRN0PYs6etedNN5+u7UuUuogetkzOVadi+RL0eXft
         opqc9XF0yWDwaofLK3Zuk8uGos6c9ZFIxHG3yQ1SW4U/+mUBQBslM9ZYHjnaB77B3jQD
         Nw0yLYzxPB66JJn3zzoVdET/cQayg7nSTwBR75/2YCgJarOi/6b98ytYorvyqE+K2ES0
         dS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcieI5+oJsXOBRD2KKmNlRR+gsKSY7mBPeZzRy6NCSc=;
        b=JU4dPmKu9yFE+w3JIZCYqSUfyTVuqSKl6PRSgJabjRpQRUNUghdtYGxsHFqaHq1nG3
         hGJLAjs1rXhag923Nuzs7hte3QH/ZADMMUIxfeoYdssxs/FIVAHa/9TrGOSag1gmM8Js
         6CW98hH4LidZSCozobGKtHnErdWCxqqXqCkdvoMxWiFhwpRU6rYJuiPPIaozQfuUst4w
         3ef1WnFfiv83oRmUULrz22egMojy9C55+vxGFc5eMrsVizb4yxKuk4p/EwqKCfxgLM2L
         2n0eL6LL1slyVP7Xk9VkC3mpbgnZHB0NEBmnzuGs3dmKbiwpTzNf3OkBmnpq6X7rt5NC
         ImoQ==
X-Gm-Message-State: APjAAAVWdnv9M+6N8jGKV0AygtLVM5yZOi86lIK01pgUEQGIuHWUaV6q
        9IW2CmCfwB1EdMEPNRgtNcz7VwfNSPsRDrnG6uSubw==
X-Google-Smtp-Source: APXvYqzsrsMnuTp4pilucBGFtnRzrjGoHO9C4n2TLsODhv9zqdR3Iv8B2UbdukqEA3eTSRrBVF3kQ1EWF724z+8y5G/9BA==
X-Received: by 2002:aed:37c4:: with SMTP id j62mr5902579qtb.19.1551916824091;
 Wed, 06 Mar 2019 16:00:24 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:08 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 22/27] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 fs/proc/kcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..d50ebfbf3dbb 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -518,6 +518,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore"))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-- 
2.21.0.352.gf09ad66450-goog

