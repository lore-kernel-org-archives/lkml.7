Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF5C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25030208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="AEifvLg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL1Bsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 20:48:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34520 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL1Bsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:48:42 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so27120334iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 17:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NY2N4q5Dac+G88QX+oQjP46FWyhBolRVkhJcTyB0XSo=;
        b=AEifvLg1nqDmp9j2ESQm2zzI2MO5rNW2M5ASqEAimcXs9HyA9NLhkvdkmRoXpxyKEQ
         9H+w3XUhlzcfJ4qB2kS3Nxy5XW1JVEwJY+erWyk2+hsRB/DwVVMUMalmFpSpuruVqs1H
         hpNbeRboKp2kj1jJq0MCes+u5klrU7+OQo31U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NY2N4q5Dac+G88QX+oQjP46FWyhBolRVkhJcTyB0XSo=;
        b=HFjhUIcHjjd+RV8vm9P6vZiwuBAu+11RWC2pTwKvG7nbJNyLw4FEiA53zmNr4kCENS
         FRJnaix6enPYY4Ry9w/sQP92Q0Ot/I4YxczhjhZ3ZmB+N2TjAuHwnSMjggR+U3IUXD4z
         CvRcxSSoMalKuZiAW5fPmEOlirqDta3HVKvKX+FRs1Qm8pxlE2qjp/hHvsPc9b5jMOQP
         eXETXq+esBk3DE32hzEZXhU4BxgI/47UkK6RunHCCTbE7OsjTYkiN6SzCNyvG9Dstq6U
         CaVgdj8m889GDyy1ZItWvuf1ueCar2tQrqrG1jIpnMPxhn7cl+JjV5TGXzKmiAaoex2j
         zDMQ==
X-Gm-Message-State: APjAAAV7k0WbEb6ekHrJsrIwlJgggOgOVZnxyNZgqQSuqgvkp1DpH8F5
        sXJWFwDc3I9Vn3OeXqI4SJVK6/c8dEU=
X-Google-Smtp-Source: APXvYqwcPOG8gPwaOwCX82CyVx5cT0LbTQVBKS6Z2IFjbBcGslggL1KjxiZZntuVXmmryyJ0R0XBzA==
X-Received: by 2002:a02:aa11:: with SMTP id r17mr43270716jam.88.1577497721350;
        Fri, 27 Dec 2019 17:48:41 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id w11sm12061922ilh.55.2019.12.27.17.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 17:48:40 -0800 (PST)
Date:   Sat, 28 Dec 2019 01:48:39 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The seccomp_notif structure should be zeroed out prior to calling the
SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
whether these structures were zeroed out or not, so these worked.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
---
 samples/seccomp/user-trap.c                   | 2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 6d0125ca8af7..0ca8fb37cd79 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -298,7 +298,6 @@ int main(void)
 		req = malloc(sizes.seccomp_notif);
 		if (!req)
 			goto out_close;
-		memset(req, 0, sizeof(*req));
 
 		resp = malloc(sizes.seccomp_notif_resp);
 		if (!resp)
@@ -306,6 +305,7 @@ int main(void)
 		memset(resp, 0, sizeof(*resp));
 
 		while (1) {
+			memset(req, 0, sizes.seccomp_notif);
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
 				perror("ioctl recv");
 				goto out_resp;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6944b898bb53..f53f14971bff 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3278,6 +3278,7 @@ TEST(user_notification_signal)
 
 	close(sk_pair[1]);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	EXPECT_EQ(kill(pid, SIGUSR1), 0);
@@ -3296,6 +3297,7 @@ TEST(user_notification_signal)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), -1);
 	EXPECT_EQ(errno, ENOENT);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	resp.id = req.id;
-- 
2.20.1

