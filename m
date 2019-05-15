Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B8CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C1F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919087;
	bh=l4qCbCUfAKIx9IdszqCc6HCPvo6RyGsWhdupjLim59c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNFAwYo8HbYieHMdTGZTPc4vqLw6Ah39tDu186bH9sxpAYLrXeDB6WOG5ulauGybc
	 xdkqjOEzk3hdS1TNareX2LAs3WpwityG5WPZ5TRgjqyCqjkdX9JkFR8DYic068ESUq
	 PQY2pTdI3447qflaPC1YRSve86IA7qfvFtSDxfno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfEOLSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfEOLSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:18:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F58B21848;
        Wed, 15 May 2019 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919079;
        bh=l4qCbCUfAKIx9IdszqCc6HCPvo6RyGsWhdupjLim59c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL5eDbj2ucQpTcCw0uFKRggZ49z30vlNzFdKUtQl7aYDNRE4q4321zbSaun4J4NgI
         d8Hjhp4mHD8uZC4xqJav76w30Q46YgjaFkSTTXw5bXEWXyBwPfBx7isJ96UhZIw7tc
         gKTsUiBvVmE8omUS8SZqXPhVBeVU9tLYzzYpp5MU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 005/115] kernfs: fix barrier usage in __kernfs_new_node()
Date:   Wed, 15 May 2019 12:54:45 +0200
Message-Id: <20190515090659.610201644@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
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
@@ -649,11 +649,10 @@ static struct kernfs_node *__kernfs_new_
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
 


