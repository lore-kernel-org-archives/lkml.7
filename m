Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C820820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gglAL7lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDDAdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:12 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:35281 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDDAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:05 -0400
Received: by mail-yb1-f201.google.com with SMTP id k188so623034yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LW7lq5jkExR1NuLSqDh6tdSVxounhx+I412qfIcDAFY=;
        b=gglAL7lOpCcj1Ipwnf90XUlgfXW0ddR995sFM/Mbq8P4ybdttBrpulbT63vc3U1+cP
         fskFmnda51fUJ0YCe6QcmmT0WwjpV6q230lV7luyLlnRRnzyev3WMyuvcm0pg4adVpUt
         arxvoqA9Pm39cp4hJpJkoS9XbToScJS7Fb5BEqYAblrK7kwV7D9oESDo4aJoQo6csbwZ
         LiPYagdCwqBoxe4hJOj1Fhf0yLyUhNsrqEsJ0IfFA9QxShzKd14vEpUEAwdtyF6MCn5x
         BGcvPfksazSZyXnXhg5tz5OFxe0t7MPPsA2moHkrvDM/cF7RYv7umKsZFKjdN7U/ZGGi
         C9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LW7lq5jkExR1NuLSqDh6tdSVxounhx+I412qfIcDAFY=;
        b=D8blhXDHJa6guvaX4+xc70WLCzB1fpvmcO/cEauH2nBLtU8u13VUGVNFX+ija+dJ2H
         akc4Zmd9tl92Xe1xyAipB2Mg/OW66j9ByOE0/pwb08Ik0SmWXDndTN24A0qe3dppYfEe
         0ufBMzU6+eoJOpXuYOdZc9qCWU8ZeDQkiU4dfN++35W30XgB+EWLg/69UTSFmHIQgfYf
         QVUNq4z579LW2qya9bqPLr2uWuy7igFSEMXczDfsarHEUcppGCHM+UvOquB4xojyw4/O
         uEkPZScmH3SQm2MytBWqHKBAmDKPItwDRlUkbl0tyDXB7yPSpiOjPaUILOtD3GGvGzdV
         zRDQ==
X-Gm-Message-State: APjAAAXa3HMlKk3OUvn98zvEhHggnro7u3BuAcesJwg+n2Q62e+86vcS
        II9DxfLvoCSxbv7WlrrF8foBn8DEoYXZcKEU8Nzdlg==
X-Google-Smtp-Source: APXvYqwqLCY0WArjOuQ81BErQhQQHmt2wI/EzoMxlwlgQFhYITLEdUZw3j7qVYEpaLie3GHt79cdyFmgLFY6krvZ8+E+0Q==
X-Received: by 2002:a25:9086:: with SMTP id t6mr543895ybl.77.1554337984697;
 Wed, 03 Apr 2019 17:33:04 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:26 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 04/27] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
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

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
---
 kernel/kexec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..57047acc9a36 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images",
+				  LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.392.gf8f6787159e-goog

