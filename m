Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847DC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861872173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563418993;
	bh=YfICFsESOvdQZDGiHscJVaj94R0uz2pITiwXWI9h5k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y47DYbhZaWXiIv7b5LqxRELajP0WyUpDAljqFBok7+3CklfLzuorv4/9J55x1+u1I
	 LvsssRVHg7vPMRAe6fg7oNTE6nGH/MtLjXGNIKpZ5sYyMm3vGtWKZfXstjCAh60JvU
	 rubd/5+qu+Zmhjs7VNIpim09CKXBEM7NwrHSphk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfGRDDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbfGRDDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:03:08 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625CA204EC;
        Thu, 18 Jul 2019 03:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563418987;
        bh=YfICFsESOvdQZDGiHscJVaj94R0uz2pITiwXWI9h5k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vovVF8gRZxIwnBrvGb05EGNmVF39Xmc50j/mMEUw/y0oHk+/yHnrSA+sq2rD9rHOC
         X2/gbHTniT4U10jkOacj6i9BwEh+nvUeN/TxadBRSa8H9KBUIVOk4UeJ6Kmi9oX+8V
         y2An+6Sm2j2i8wcIHQNH8GZQa7H/UQF0sOxLnGyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.2 16/21] s390/qdio: (re-)initialize tiqdio list entries
Date:   Thu, 18 Jul 2019 12:01:34 +0900
Message-Id: <20190718030034.929584571@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030030.456918453@linuxfoundation.org>
References: <20190718030030.456918453@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e54e4785cb5cb4896cf4285964aeef2125612fb2 upstream.

When tiqdio_remove_input_queues() removes a queue from the tiq_list as
part of qdio_shutdown(), it doesn't re-initialize the queue's list entry
and the prev/next pointers go stale.

If a subsequent qdio_establish() fails while sending the ESTABLISH cmd,
it calls qdio_shutdown() again in QDIO_IRQ_STATE_ERR state and
tiqdio_remove_input_queues() will attempt to remove the queue entry a
second time. This dereferences the stale pointers, and bad things ensue.
Fix this by re-initializing the list entry after removing it from the
list.

For good practice also initialize the list entry when the queue is first
allocated, and remove the quirky checks that papered over this omission.
Note that prior to
commit e521813468f7 ("s390/qdio: fix access to uninitialized qdio_q fields"),
these checks were bogus anyway.

setup_queues_misc() clears the whole queue struct, and thus needs to
re-init the prev/next pointers as well.

Fixes: 779e6e1c724d ("[S390] qdio: new qdio driver.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c   |    2 ++
 drivers/s390/cio/qdio_thinint.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -150,6 +150,7 @@ static int __qdio_allocate_qs(struct qdi
 			return -ENOMEM;
 		}
 		irq_ptr_qs[i] = q;
+		INIT_LIST_HEAD(&q->entry);
 	}
 	return 0;
 }
@@ -178,6 +179,7 @@ static void setup_queues_misc(struct qdi
 	q->mask = 1 << (31 - i);
 	q->nr = i;
 	q->handler = handler;
+	INIT_LIST_HEAD(&q->entry);
 }
 
 static void setup_storage_lists(struct qdio_q *q, struct qdio_irq *irq_ptr,
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -87,14 +87,14 @@ void tiqdio_remove_input_queues(struct q
 	struct qdio_q *q;
 
 	q = irq_ptr->input_qs[0];
-	/* if establish triggered an error */
-	if (!q || !q->entry.prev || !q->entry.next)
+	if (!q)
 		return;
 
 	mutex_lock(&tiq_list_lock);
 	list_del_rcu(&q->entry);
 	mutex_unlock(&tiq_list_lock);
 	synchronize_rcu();
+	INIT_LIST_HEAD(&q->entry);
 }
 
 static inline int has_multiple_inq_on_dsci(struct qdio_irq *irq_ptr)


