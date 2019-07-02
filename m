Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5416CC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249E121855
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054969;
	bh=/AfKVcBQKxvp/ClT9gPRAt5eVweWMCZhajbzZzMZ1W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybMlcZdAVVXNBJbSJwiMkUBGnsdDYDtoF7cEIuWrpxUfSTtokfArQT9YfLOeo1MhA
	 JBkYD5LArkJWe+69qKWv8+hbINgP0qUAGs3/AByTgw38RcyAhgNEsAJkAmky0+AH9V
	 0uL+YMEFzseggI27bw14TK9ACPNwsRJgMmH4miJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfGBIJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfGBIJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B6E206A2;
        Tue,  2 Jul 2019 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054964;
        bh=/AfKVcBQKxvp/ClT9gPRAt5eVweWMCZhajbzZzMZ1W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+8I/8FUM2YpgTY5owb3PIeoE1EhHNNjO0y84VsAz19aUZc7SpkvSuwVPCzbwebrd
         1O0587oJdI9VwiASNkD0xTY9w3+q2+pV8C7Xokd1TFmpSzvMwdsIEAi7d+cw+spC9D
         Q58XOTPCS87CqN5CHvCtSzXR8Ku2JN3TqYw1R2B8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/43] Revert "x86/uaccess, ftrace: Fix ftrace_likely_update() vs. SMAP"
Date:   Tue,  2 Jul 2019 10:01:44 +0200
Message-Id: <20190702080124.093411638@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8190d6fbb1e9b7fa4eb41fe7aa337c46ca514e79, which was
upstream commit 4a6c91fbdef846ec7250b82f2eeeb87ac5f18cf9.

On Tue, Jun 25, 2019 at 09:39:45AM +0200, Sebastian Andrzej Siewior wrote:
>Please backport commit e74deb11931ff682b59d5b9d387f7115f689698e to
>stable _or_ revert the backport of commit 4a6c91fbdef84 ("x86/uaccess,
>ftrace: Fix ftrace_likely_update() vs. SMAP"). It uses
>user_access_{save|restore}() which has been introduced in the following
>commit.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_branch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 3ea65cdff30d..4ad967453b6f 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -205,8 +205,6 @@ void trace_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			  int expect, int is_constant)
 {
-	unsigned long flags = user_access_save();
-
 	/* A constant is always correct */
 	if (is_constant) {
 		f->constant++;
@@ -225,8 +223,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 		f->data.correct++;
 	else
 		f->data.incorrect++;
-
-	user_access_restore(flags);
 }
 EXPORT_SYMBOL(ftrace_likely_update);
 
-- 
2.20.1



