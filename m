Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390CC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B432235D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140886;
	bh=VuFC/eywt7h/O4gNzTZEFXUuvrmosZ8nF36EuyKYbEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XOsCugAmKb/UxZ+mdA3Ok5Q4/OY+8YLfKRhUGN63PJEF+P5OzmSrJ+1yjIG/ZzjlM
	 GzViq7b0pzAtJv0T1JkkPwckiuTm+jsUWqqP97G4BZvsX2vwdJYtOQ33yi2nRH/4dI
	 cRf+GyiO0VElQpMPrcFuegIS0GhjurEzifE8XkVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKSFVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfKSFVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442A52235D;
        Tue, 19 Nov 2019 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140881;
        bh=VuFC/eywt7h/O4gNzTZEFXUuvrmosZ8nF36EuyKYbEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYWvtxXhCaaJZawBt+IkFHsSO/Q5ZO6DciMK+11YJr4fbmXVRaz8bdmR8KcrsoWBt
         v6mYAS674g5j1UHZoGR92Vtt79r0uBmT9RAaL0+xI+Vpk9eIf/02hD8cC0bbrjxFOS
         0rR7DYsmij4cmf3SdilBKEwokQ9hcP410GGGYu1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: [PATCH 5.3 19/48] cgroup: freezer: call cgroup_enter_frozen() with preemption disabled in ptrace_stop()
Date:   Tue, 19 Nov 2019 06:19:39 +0100
Message-Id: <20191119051003.108253979@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

commit 937c6b27c73e02cd4114f95f5c37ba2c29fadba1 upstream.

ptrace_stop() does preempt_enable_no_resched() to avoid the preemption,
but after that cgroup_enter_frozen() does spin_lock/unlock and this adds
another preemption point.

Reported-and-tested-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, i
 		 */
 		preempt_disable();
 		read_unlock(&tasklist_lock);
-		preempt_enable_no_resched();
 		cgroup_enter_frozen();
+		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
 	} else {


