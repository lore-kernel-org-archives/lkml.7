Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C89C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8592177B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723976;
	bh=I14JMvGn+h8CLeXoQ8x+xrC4Aq82f5IUq+A2GNFj6eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeqnnjZ3z9qQR0WkE/75s+r2/grAdRMAqa9OjesTDhwS6AtxLujrIYELiXHSpryb7
	 1bGlXwvwUZFw1Qp5wmA94DYq7FjNfL7HHjc2lRFeLW9quyC2ZLTgSEQKUtfp8VxbtF
	 Y8UWDbGAdoFF/ddxS/5TC8jRB/NsqSpDh1uZisQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfF1MMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:12:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1MMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NMu/v002NyjPb7lxcrvrsfcxSTZZB6mI258wHNga6OY=; b=aDbjkwa0y8zVV2j/XVzprfc9o+
        iVaRuq3Wu42H818goT947Hqsoyt+3tlUvrTviRz6h2WaAUSb3IYtWU4AH596xlzKl9R+GpLcDQCYZ
        Jy8/lg68CctkTrJtMbjLNMut/vpAU10o2UKWtWH+vR7ipPawEyW53YwUsGLuYjz4iE0QslsWh4Rou
        UHMcxlhYG6OIs6vLhRJl4zw50VrWk/Ea1gyfij4kHJ+d7Kf49vf5Leyjl2OOhiyL6Q5h7lPJ3QKcX
        Y6XdDaqb0YgGcxoz6W1X9vgOhOCgw0X3lNlKZbU4MQkDdir6eJ9oP054xftANLBDMqGjlRRPR0XKS
        CQAYGz9g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BT-8Z; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zT-8W; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/9] docs: signal: fix a kernel-doc markup
Date:   Fri, 28 Jun 2019 09:12:25 -0300
Message-Id: <f326b29547ca1b2d64411421911d918f85b15f1d.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc parser doesn't handle expressions with %foo*.
Instead, when an asterisk should be part of a constant, it
uses an alternative notation: `foo*`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 91b789dd6e72..10a826855b59 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -349,7 +349,7 @@ void task_clear_jobctl_pending(struct task_struct *task, unsigned long mask)
  * @task has %JOBCTL_STOP_PENDING set and is participating in a group stop.
  * Group stop states are cleared and the group stop count is consumed if
  * %JOBCTL_STOP_CONSUME was set.  If the consumption completes the group
- * stop, the appropriate %SIGNAL_* flags are set.
+ * stop, the appropriate `SIGNAL_*` flags are set.
  *
  * CONTEXT:
  * Must be called with @task->sighand->siglock held.
-- 
2.21.0

