Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85532166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922784;
	bh=Omne4r+s1g/2qzaYihCg5sc49UBqUWfWids8nK21U2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cWlge6hQ4fE6n0X8ZW12zzvWofIqVSDRVizEM3HxS+3TcWY/YfyPV7oX7cQSd9s56
	 3/QehR+Afg9rIhJjPWPq7Fxs9Q1nHN0+jse5Bb6YJ3AOFr5+azTJoZ0eEz4h1uvn1D
	 vaapJuumBo7zMAjknAtQpp2om1dIzBFo7rilb5FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfEOMTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfEOLAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:00:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C35C2084F;
        Wed, 15 May 2019 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918029;
        bh=Omne4r+s1g/2qzaYihCg5sc49UBqUWfWids8nK21U2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb9+HrRJMg0oekM9SB32C+1ZIaFCn1ezEdMB45HoRRl4TfR3cNpq0dEh0pNIM705D
         3N0OhLVjrbq7JxoBjLh7wtpPn+q1uBN9pwc1nhZnoBaF5Nz7YyCuUToQ9Tv3o0fZUG
         rtv2VtPQbk6gwCSfyEsFg4uKyJxsrU6+DoZ62bdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>, marc.zyngier@arm.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 58/86] genirq: Prevent use-after-free and work list corruption
Date:   Wed, 15 May 2019 12:55:35 +0200
Message-Id: <20190515090653.859366861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 59c39840f5abf4a71e1810a8da71aaccd6c17d26 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/manage.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -307,8 +307,10 @@ irq_set_affinity_notifier(unsigned int i
 	desc->affinity_notify = notify;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	if (old_notify)
+	if (old_notify) {
+		cancel_work_sync(&old_notify->work);
 		kref_put(&old_notify->kref, old_notify->release);
+	}
 
 	return 0;
 }


