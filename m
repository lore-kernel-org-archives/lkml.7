Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4264214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291522;
	bh=eV3PbvjLl3DGU5fR4PX4TovSHb4ij9q3qFSsigX1QVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRYz8V0zDObPKCm5ePxvTzmXWezO9CRZUjG8LeQpfSB0ePf+jzA0oH/Gbk1vXcYKZ
	 FyDhNiiS2+GUC3kRYMDHHxFhRVzNjxHzLf0eCW3tu4M4iHe+hBkV11mDwYrSPnsCZK
	 GF88QWGPmJktkM69U5xeFl9Tc+wqYq5VyH4w6Aic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405569AbfHHTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405530AbfHHTLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:11:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48ED4208C3;
        Thu,  8 Aug 2019 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291501;
        bh=eV3PbvjLl3DGU5fR4PX4TovSHb4ij9q3qFSsigX1QVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZII+bhBrN+QVBICrsFYzMTH9LnArXgLGDWJ/rh1ABdspVthHqZA0ijKte/7LhdvW
         VpFp8gugOyFPQrOYp5rZOkgjbaVAfnHYV5UlnlV5kZgC6YSBiVBPzRZztcGHYaRRUF
         MtJ0rArUs3X0uy/MA5ysMsJ406IxpiMsILYOapgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 31/33] cgroup: css_task_iter_skip()d iterators must be advanced before accessed
Date:   Thu,  8 Aug 2019 21:05:38 +0200
Message-Id: <20190808190455.214999172@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
References: <20190808190453.582417307@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit cee0c33c546a93957a52ae9ab6bebadbee765ec5 upstream.

b636fd38dc40 ("cgroup: Implement css_task_iter_skip()") introduced
css_task_iter_skip() which is used to fix task iterations skipping
dying threadgroup leaders with live threads.  Skipping is implemented
as a subportion of full advancing but css_task_iter_next() forgot to
fully advance a skipped iterator before determining the next task to
visit causing it to return invalid task pointers.

Fix it by making css_task_iter_next() fully advance the iterator if it
has been skipped since the previous iteration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: syzbot
Link: http://lkml.kernel.org/r/00000000000097025d058a7fd785@google.com
Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cgroup/cgroup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4197,6 +4197,10 @@ struct task_struct *css_task_iter_next(s
 
 	spin_lock_irq(&css_set_lock);
 
+	/* @it may be half-advanced by skips, finish advancing */
+	if (it->flags & CSS_TASK_ITER_SKIPPED)
+		css_task_iter_advance(it);
+
 	if (it->task_pos) {
 		it->cur_task = list_entry(it->task_pos, struct task_struct,
 					  cg_list);


