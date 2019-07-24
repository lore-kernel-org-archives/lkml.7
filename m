Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB009C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6F22AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997603;
	bh=bSy0U5yVi9iyH1R9tnjzF1EO7KPdJi0N7GTkYrzC4Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnAPT8slD/m8hKIsIVlUHbzGHTNtYtighE8wwv2kZ2HNfHoQf7PLslbkZBvDWgIDv
	 Gj37i3hVVbaOBdp1K6ggpN34sn77TYpjnsfHWhU6MB87kFW8w8lF1C+OePcZmRWiR+
	 pPae0JdKtD0eo4dbeaH1oFd191165AVw8jXysls8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbfGXTqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391104AbfGXTqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB70C205C9;
        Wed, 24 Jul 2019 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997598;
        bh=bSy0U5yVi9iyH1R9tnjzF1EO7KPdJi0N7GTkYrzC4Hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+FW0Vn6HkDtv6Nd//mEGpTzfxp7GGt6J9/gFL6y8JYO017/HwtRCsDDsf8EDtT36
         eYwe48lgjNxGjrJF3f5TwoRvbydIIHQrW7xzO705DRjyhg1iXm8D9t72tRudtBq42Y
         6VdBF90XkxVpuRkuC6I1Fjl6cHHBfcuGPJaK1Wrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@free.fr>,
        Serge Hallyn <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 037/371] signal/pid_namespace: Fix reboot_pid_ns to use send_sig not force_sig
Date:   Wed, 24 Jul 2019 21:16:29 +0200
Message-Id: <20190724191727.326676535@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f9070dc94542093fd516ae4ccea17ef46a4362c5 ]

The locking in force_sig_info is not prepared to deal with a task that
exits or execs (as sighand may change).  The is not a locking problem
in force_sig as force_sig is only built to handle synchronous
exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is confusing
and pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Fixes: cf3f89214ef6 ("pidns: add reboot_pid_ns() to handle the reboot syscall")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index aa6e72fb7c08..098233ebe589 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -325,7 +325,7 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 	}
 
 	read_lock(&tasklist_lock);
-	force_sig(SIGKILL, pid_ns->child_reaper);
+	send_sig(SIGKILL, pid_ns->child_reaper, 1);
 	read_unlock(&tasklist_lock);
 
 	do_exit(0);
-- 
2.20.1



