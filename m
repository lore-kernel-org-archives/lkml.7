Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA2EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DFD2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428069;
	bh=whVgiUWxByz3UDSxKvA60d0HPLOmjktW30Qs3hRuMIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOGDY0sRk1m0m2nHRXsZI9nFADbCmAfLJ1dJ1mqbZC0gX9vALaQinZ+z9oCNTpoTz
	 baz6b7l/fR/g/TvP3pdMtB36hGSfxX4HPVHjphWLAnka5sde2MbTJSlq6rIHyOOWWi
	 n0wFJbK9JND/wnh/MuVkMCGigSrqaR/t1O/nsYd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfEISy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfEISyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637A1204FD;
        Thu,  9 May 2019 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428061;
        bh=whVgiUWxByz3UDSxKvA60d0HPLOmjktW30Qs3hRuMIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfx81zuKi2FhhufEzYMC3/8ejkP3KuJp6BCBhOPtfeNyZJ4Cwj2jJXGnQiR7bmaN+
         A9PVTkpl7Z0vIrBfal9MlkMfX0kLXqCuep0qAUpkMKFERmIJt/94nXP85bqUyCvWip
         lGPCAq8QgQ7v76qmdCgLe8DKBMJNiPB+T9WOiHZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>, marc.zyngier@arm.com
Subject: [PATCH 5.1 12/30] genirq: Prevent use-after-free and work list corruption
Date:   Thu,  9 May 2019 20:42:44 +0200
Message-Id: <20190509181253.320625162@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasad Sodagudi <psodagud@codeaurora.org>

commit 59c39840f5abf4a71e1810a8da71aaccd6c17d26 upstream.

When irq_set_affinity_notifier() replaces the notifier, then the
reference count on the old notifier is dropped which causes it to be
freed. But nothing ensures that the old notifier is not longer queued
in the work list. If it is queued this results in a use after free and
possibly in work list corruption.

Ensure that the work is canceled before the reference is dropped.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: marc.zyngier@arm.com
Link: https://lkml.kernel.org/r/1553439424-6529-1-git-send-email-psodagud@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -357,8 +357,10 @@ irq_set_affinity_notifier(unsigned int i
 	desc->affinity_notify = notify;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	if (old_notify)
+	if (old_notify) {
+		cancel_work_sync(&old_notify->work);
 		kref_put(&old_notify->kref, old_notify->release);
+	}
 
 	return 0;
 }


