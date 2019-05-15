Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680CCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5362053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920124;
	bh=vVfQY6gZu/OlDcM6tuuouwA74XHWGJMpGlcOZoThUis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HgrbOtSqQOGqtiajS5zKAzT8aV9uCw11qShidXbYgzWIFNnXfNHnsVUo8N2XG7xv3
	 TszBn8Ns+9mC2VvhHw6NxcD5hcGTUcv6uCeCuiU7u/bsj7s15b14/SXfuTMufAl8wJ
	 L3qbzU69JbAVwZjit8mXxNwOXFdNWSINNQo8cSuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfEOLde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733198AbfEOLda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BBB216F4;
        Wed, 15 May 2019 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920010;
        bh=vVfQY6gZu/OlDcM6tuuouwA74XHWGJMpGlcOZoThUis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvINDw37tx838gtZKpa3rYKoh1xan3FjVdd4plSWha+WqSV9jWrSPkTtbhb24JCXt
         wdtGoOZhUquLYRhC6qKx73IfIolwExKQSKt7CsKo2peBOzT97AuAc8AQ4J62NnMmTj
         tKkdOj2xrC/Q5cFXE+QJd1CjX756ZXHpvRvNsIE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5.1 08/46] kernfs: fix barrier usage in __kernfs_new_node()
Date:   Wed, 15 May 2019 12:56:32 +0200
Message-Id: <20190515090620.977136874@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

commit 998267900cee901c5d1dfa029a6304d00acbc29f upstream.

smp_mb__before_atomic() can not be applied to atomic_set().  Remove the
barrier and rely on RELEASE synchronization.

Fixes: ba16b2846a8c6 ("kernfs: add an API to get kernfs node from inode number")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/dir.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -650,11 +650,10 @@ static struct kernfs_node *__kernfs_new_
 	kn->id.generation = gen;
 
 	/*
-	 * set ino first. This barrier is paired with atomic_inc_not_zero in
+	 * set ino first. This RELEASE is paired with atomic_inc_not_zero in
 	 * kernfs_find_and_get_node_by_ino
 	 */
-	smp_mb__before_atomic();
-	atomic_set(&kn->count, 1);
+	atomic_set_release(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 


