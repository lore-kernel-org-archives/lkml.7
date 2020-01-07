Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52DC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF72080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432334;
	bh=F6tGxNJCT5nA0qQtWVbRfcpU9HYNtp2tw3U7qotbFXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jzywnKk1q6idBEtwPqyJ1uzvXG8t5vjhroGMiNWLuOcaERN2ySsIdOMKbzS39UW+a
	 YW1iITmPO8coezwFeObkAVAx9Zoz27g8P9gIk2XMy9sYmVeFwO55kdt8gaF/mR9555
	 lZkewPRNzDTy1OQkCobsbJ9RF+RRGIdJUDVbQJJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgAGU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgAGU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38B92087F;
        Tue,  7 Jan 2020 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430783;
        bh=F6tGxNJCT5nA0qQtWVbRfcpU9HYNtp2tw3U7qotbFXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5gKCdAvHyJ1I4WL9nEtNr6vKnd1cMEuBKS11rH8MUILa8EioaFS2gyScxhHAw1KA
         koL/KDeaJi8Lm3hEk7irYrmGp9D1I2CilwsmLl2fmjwzmpHsmk4ioVF32SOrfnGGSu
         yAH2OlG/2m9q1oxHzO9tI4fnBkDImhxHd0SZ7a84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 095/191] samples/seccomp: Zero out members based on seccomp_notif_sizes
Date:   Tue,  7 Jan 2020 21:53:35 +0100
Message-Id: <20200107205338.077706994@linuxfoundation.org>
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

commit 771b894f2f3dfedc2ba5561731fffa0e39b1bbb6 upstream.

The sizes by which seccomp_notif and seccomp_notif_resp are allocated are
based on the SECCOMP_GET_NOTIF_SIZES ioctl. This allows for graceful
extension of these datastructures. If userspace zeroes out the
datastructure based on its version, and it is lagging behind the kernel's
version, it will end up sending trailing garbage. On the other hand,
if it is ahead of the kernel version, it will write extra zero space,
and potentially cause corruption.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Tycho Andersen <tycho@tycho.ws>
Link: https://lore.kernel.org/r/20191230203503.4925-1-sargun@sargun.me
Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 samples/seccomp/user-trap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -298,14 +298,14 @@ int main(void)
 		req = malloc(sizes.seccomp_notif);
 		if (!req)
 			goto out_close;
-		memset(req, 0, sizeof(*req));
 
 		resp = malloc(sizes.seccomp_notif_resp);
 		if (!resp)
 			goto out_req;
-		memset(resp, 0, sizeof(*resp));
+		memset(resp, 0, sizes.seccomp_notif_resp);
 
 		while (1) {
+			memset(req, 0, sizes.seccomp_notif);
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
 				perror("ioctl recv");
 				goto out_resp;


