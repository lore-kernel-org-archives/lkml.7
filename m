Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712DEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4669A24682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781399;
	bh=pE3GXZEB3vX75So1AzQKHyqp1Ek/HBfofw59UGeGrDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yCkNtWuM/ogsdbqcF61tE4uv/3ylooTfqelr5O16xKo+ZBQEz//AxNLNRUeXq0/wh
	 0C6oKYbbeKSvX77tJkbSb3p816EccVBuDU4+rqS/xF0F3/rFvzORSTkUU2UAcSc5M5
	 MblRdxUaIJl8VDw1uH+d+ODug/UaoaXWZgxFppfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfLSSt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfLSSt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9C224672;
        Thu, 19 Dec 2019 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781395;
        bh=pE3GXZEB3vX75So1AzQKHyqp1Ek/HBfofw59UGeGrDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBFvKtifLF/6UxNtO05c5gLNX1GfgZwgNy2jtFqb4jW7XzRq4Q5QPEYYXNniuqQeA
         Qk5pW68U/RMGGTPDl2NlHjowFltAst+73kEgY4vdcUg6oimN3pHIO2vgBY0lDZfILr
         kRJC2o//P+zHiUYONNs2uIQwXRLXrAu7WNO9qJRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Qian Cai <cai@lca.pw>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.9 171/199] workqueue: Fix missing kfree(rescuer) in destroy_workqueue()
Date:   Thu, 19 Dec 2019 19:34:13 +0100
Message-Id: <20191219183224.972835729@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit 8efe1223d73c218ce7e8b2e0e9aadb974b582d7f upstream.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Qian Cai <cai@lca.pw>
Fixes: def98c84b6cd ("workqueue: Fix spurious sanity check failures in destroy_workqueue()")
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/workqueue.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4057,6 +4057,7 @@ void destroy_workqueue(struct workqueue_
 
 		/* rescuer will empty maydays list before exiting */
 		kthread_stop(rescuer->task);
+		kfree(rescuer);
 	}
 
 	/* sanity checks */


