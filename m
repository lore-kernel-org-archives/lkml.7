Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FBC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA77222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="CLfXJEje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfL3Ugw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:36:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51042 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfL3Ugv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:36:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so256303pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YD3ApCiVynjxwfgkOfHl8GiRTjQYPNU0W1gNk2+2jU=;
        b=CLfXJEjeetcVBBZaNfOnWrbD0OV+HU4IKCHanUt7DYsQvxE770uurz5npTdX/FXOrI
         cN25sPQPTzyBy9dCf+wokRzQHI7otT7AouDxfwdPTv+pSGAOXDqOBWAOiMsbvd6GJeI7
         UV/YNRPTCphicwmhSvxE6CKB3lpr/DflQDtUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YD3ApCiVynjxwfgkOfHl8GiRTjQYPNU0W1gNk2+2jU=;
        b=P+DFfpbdUEAr1LkcgBnTGPIlkThAaS480S9Zf94MAq38wnZ0Kt2LPhLP7ybR9wjbyl
         hXFCTd4oQujSEKTVCR0vMOedxUXnXjtQuiEYZvr157gyRpgs6bHB7CbEFOPFs+3EDhoX
         qpenQNqDHgf1o2KbTpEaNYsCeL1CvNSt2q5D9Z2wbE09nVMHZ/g0Y7fSvHl5TfNc5rZQ
         JPM4b/+l2jC4TzQGWDeFaU61X7Ov/yFmbcxLkqqFMvcKhW0tSVLZLCB8nMzyj5/Q4kqD
         hrRAs3Om9rL065XKgdDA/Is/zUyvikDo3vhneW06mndm/c5EWePLOcUXItC1rqZ1X1QL
         2PBQ==
X-Gm-Message-State: APjAAAXZuD0rkq6glz1hkYCtycsRzC+b7txC8SaRdei9v1qBLqRpBi1I
        JQWBhGLrGiFjN7MLye8lOs6Dl6pKhmN5Dg==
X-Google-Smtp-Source: APXvYqzD7oQA+CPDxb+La8YBQKvZvp0/qcT/ytJJzEEiq1mKQSnK8H0oDNSpzlMkzRHOLxuvkfypWA==
X-Received: by 2002:a17:90a:8584:: with SMTP id m4mr1239176pjn.123.1577738210251;
        Mon, 30 Dec 2019 12:36:50 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m71sm701884pje.0.2019.12.30.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:36:49 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] samples/seccomp: Zero out datastructures based on seccomp_notif_sizes
Date:   Mon, 30 Dec 2019 12:35:03 -0800
Message-Id: <20191230203503.4925-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sizes by which seccomp_notif and seccomp_notif_resp are allocated are
based on the SECCOMP_GET_NOTIF_SIZES ioctl. This allows for graceful
extension of these datastructures. If userspace zeroes out the
datastructure based on its version, and it is lagging behind the kernel's
version, it will end up sending trailing garbage. On the other hand,
if it is ahead of the kernel version, it will write extra zero space,
and potentially cause corruption.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
---
 samples/seccomp/user-trap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 3e31ec0cf4a5..20291ec6489f 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -302,10 +302,10 @@ int main(void)
 		resp = malloc(sizes.seccomp_notif_resp);
 		if (!resp)
 			goto out_req;
-		memset(resp, 0, sizeof(*resp));
+		memset(resp, 0, sizes.seccomp_notif_resp);
 
 		while (1) {
-			memset(req, 0, sizeof(*req));
+			memset(req, 0, sizes.seccomp_notif);
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
 				perror("ioctl recv");
 				goto out_resp;
-- 
2.20.1

