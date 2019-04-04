Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44391C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FB821741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368935;
	bh=a/JGQVFdqgKpOc2M0Y+4lK4Y02OxFlj5/F4KhxTUIYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nl8m6HHkLnAeKc3wux9uEag3M7U7ghmL2mpgA655hpQdyV9x/0cTvZXPDey+uDpK2
	 Q1pTr6ZY7L4NJPmTs5yX2WzMwnqr/gOGLsxtsCkGf83AikZ/GajyZIOGQwoI8129zC
	 22Jlo7CvzgbdmliIdw/7I1POSr5Ju8CI9cssKDd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfDDJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbfDDJIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD0521741;
        Thu,  4 Apr 2019 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368925;
        bh=a/JGQVFdqgKpOc2M0Y+4lK4Y02OxFlj5/F4KhxTUIYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAxC0cdPszQBiLoUnXzJmeewstWmR8Ta0vE4yZ+zqoHVe+UYVRs44foD804Lv7qGw
         WE//Cou1eqbaPSqE/S8/dt6zrHHPk1mULVfEL9r/LQcgU7U7SLzAua71pbl6YLNVah
         9ngqiVpyJg5jjk8Dk7SE1+rbC6aUCzVAtb/iyVRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 016/246] include/linux/relay.h: fix percpu annotation in struct rchan
Date:   Thu,  4 Apr 2019 10:45:16 +0200
Message-Id: <20190404084619.746071768@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 62461ac2e5b6520b6d65fc6d7d7b4b8df4b848d8 ]

The percpu member of this structure is declared as:
	struct ... ** __percpu member;
So its type is:
	__percpu pointer to pointer to struct ...

But looking at how it's used, its type should be:
	pointer to __percpu pointer to struct ...
and it should thus be declared as:
	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of this
structures.

This silents a few Sparse's warnings like:
	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

Link: http://lkml.kernel.org/r/20190118144902.79065-1-luc.vanoostenryck@gmail.com
Fixes: 017c59c042d01 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jens Axboe <axboe@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/relay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e1bdf01a86e2..c759f96e39c1 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -66,7 +66,7 @@ struct rchan
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
-	struct rchan_buf ** __percpu buf; /* per-cpu channel buffers */
+	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
 	struct dentry *parent;		/* parent dentry passed to open */
-- 
2.19.1



