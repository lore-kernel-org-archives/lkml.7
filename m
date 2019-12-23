Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870CFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443942053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="R8Chr9Rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWXB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:01:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34799 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:01:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so15145846qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b6qFBScMW7J1JMRCMNteR+igi+eB8saFS/Q1o6L3hTA=;
        b=R8Chr9RvRlkXoEwkB57LQRzaLpvDk6VI0RbesuFVxwxsPpctZ2LeFpSmXRoV+nJXn4
         /jT4W0AWZZoamrZOQbEL0t7zV94d3OKX6aCrz8a9EIpEbtvcKQbaMyLC1pWT/syHRThX
         WuT34ZsOC4X+01vuKNf8TFyLXbAHmYxRqbnav9gWRD/Lxlet5kqWzhAO25zsqnia7JtR
         XBxZFwtXpH4PBGwQfvm6zxe3zS2SWiDh+PkXQxdk2CO68tRfaciF7FY5fKBXEQs5OY2s
         0xk6Bc1i85Ql6z3GqJ3f9udhvOuV9X1Qw3HHh77en065+YhlKeRXz0iwzKdPICJ7ubTQ
         m1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=b6qFBScMW7J1JMRCMNteR+igi+eB8saFS/Q1o6L3hTA=;
        b=pf0uPnPqQWmcGMZKwbUWVnk7gHWYYcqDIrOVSyYESPHtCSTdgkTbSECjNcN0FdVjVX
         Y3iRBdEc7A1dAK20PdP0roNvd5fY0qyzaAY0/P20iBHImdTg5QOL9OtHH8j7iHWfZWZX
         /Z3KbQ7UE9r8XLbbI4QNmUk/OYDJNDCy9tNugyxzht670t8SCp5igFyU2mQ5KITf2q91
         WNanq4BGfj1aldf5CWtKustk2qkLd2Zo9IZRtl22yFZYPEZRliqsBZFk8Cxrq2WZISmy
         1HtMVfIljBq7H2zYmFzD1nspEJbHUKoZpnGFdW3Yezypd6/1lU7A9wKWdPd9Fm5eAxK2
         pYow==
X-Gm-Message-State: APjAAAXU4E2waU4Hoy9fUgaoP/jCzo6qWYpTSdVNfZUHNsnBVxwneY7J
        KK2k4Yc14O5ltymv7kM80nEzfSAISA==
X-Google-Smtp-Source: APXvYqxpybu9dJ2oLRv/3fyivbuAtcDv1LXxVn36fwBO4BiXc/tJRqMj1RejKeL39f2lQy3dDxWwpQ==
X-Received: by 2002:a37:6287:: with SMTP id w129mr28077455qkb.381.1577142085038;
        Mon, 23 Dec 2019 15:01:25 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id r44sm6841563qta.26.2019.12.23.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 15:01:24 -0800 (PST)
Subject: [PATCH] selinux: ensure the policy has been loaded before reading the
 sidtab stats
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>, linux-kernel@vger.kernel.org,
        lkp@lists.01.org
Date:   Mon, 23 Dec 2019 18:01:23 -0500
Message-ID: <157714208320.505827.13006028554511851520.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check to make sure we have loaded a policy before we query the
sidtab's hash stats.  Failure to do so could result in a kernel
panic/oops due to a dereferenced NULL pointer.

Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 743b85ede4ef..c9e38f1ede02 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1286,6 +1286,12 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 {
 	int rc;
 
+	if (!state->initialized) {
+		pr_err("SELinux: %s:  called before initial load_policy\n",
+		       __func__);
+		return -EINVAL;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 	rc = sidtab_hash_stats(state->ss->sidtab, page);
 	read_unlock(&state->ss->policy_rwlock);

