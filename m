Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0FB2187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430787;
	bh=9vSRbBEIIv1Hx0RtuwuVqGa9MS4LCKjl+5pqTu4MttI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3CNf1E/SLhGb0C+ftoVfQTmfFVnuzn3N5hGzvi+eAdZW6VL97G9HV82XOQrbNurp
	 leq5cB9OgzGn7WaGtFH8ZSsTGG9862Rzbmw5POC0qcvTRbzquw/9CHdnOd6T6qqhqt
	 6nuzLjg3brmMYiK/deRs46Hh8gze4bTLFN8rMcTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgAGU7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgAGU7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91C62087F;
        Tue,  7 Jan 2020 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430778;
        bh=9vSRbBEIIv1Hx0RtuwuVqGa9MS4LCKjl+5pqTu4MttI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tI9kUoZhfN/PawD1iOL4fYM4foYQyU/k1qrCoB7uekIo4B9QTH4rTQrJKM7Nfvli
         i15t6Di3wt7xeB9K8eM+UUg7gAo5SaNapxeqdtLG8iLq0yxNWFfAUFrqmJR2PQenjb
         K1S2AW8u4VqbZBYnNXDeLbdU/Hw8lawK9dKrrojY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 093/191] selftests/seccomp: Zero out seccomp_notif
Date:   Tue,  7 Jan 2020 21:53:33 +0100
Message-Id: <20200107205337.971992034@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sargun Dhillon <sargun@sargun.me>

commit 88c13f8bd71472fbab5338b01d99122908c77e53 upstream.

The seccomp_notif structure should be zeroed out prior to calling the
SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
whether these structures were zeroed out or not, so these worked.

This patch zeroes out the seccomp_notif data structure prior to calling
the ioctl.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20191229062451.9467-1-sargun@sargun.me
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3267,6 +3267,7 @@ TEST(user_notification_signal)
 
 	close(sk_pair[1]);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	EXPECT_EQ(kill(pid, SIGUSR1), 0);
@@ -3285,6 +3286,7 @@ TEST(user_notification_signal)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), -1);
 	EXPECT_EQ(errno, ENOENT);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	resp.id = req.id;


