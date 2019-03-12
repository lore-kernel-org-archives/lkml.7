Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3EE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411080;
	bh=+dyc4u5Pjrtp+lyKuVmITt3heCrD5IxHy+IyFSg5zTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjUS5jOsx08prduadwLiy/6ysb3bzMnqLRVRayXQHkPMzMhKkc9jnE1RlhZbffKJT
	 xHyNcaTiVe+d1HOeZNCWa532t75eBZ7ybvEhu6XM8EIBLnsU6xqLi5khDqoFzomps8
	 eY1O0uhXaDwfXAMsV1HxJPA5nsSvtP9tl4k1xm0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfCLRR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfCLRRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:07 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADAF206DF;
        Tue, 12 Mar 2019 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411027;
        bh=+dyc4u5Pjrtp+lyKuVmITt3heCrD5IxHy+IyFSg5zTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKcQa1Um9QsKbF9onaniBfjnvJjcyQAjmYZhI2++vu21J9z2rxjvzAE2f24Fl2HLl
         xo/YQxEun41rH+ZpDMgv6BmuJZc2DpizKvkXMzFmn3DtZvOKruzByQsRzU2HBQacrB
         rHfVHxt18gmrrU/9PvXgVXF7Jo4KB711jjStsTb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Syms <mark.syms@citrix.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.14 129/135] gfs2: Fix missed wakeups in find_insert_glock
Date:   Tue, 12 Mar 2019 10:09:36 -0700
Message-Id: <20190312170353.028376705@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 605b0487f0bc1ae9963bf52ece0f5c8055186f81 upstream.

Mark Syms has reported seeing tasks that are stuck waiting in
find_insert_glock.  It turns out that struct lm_lockname contains four padding
bytes on 64-bit architectures that function glock_waitqueue doesn't skip when
hashing the glock name.  As a result, we can end up waking up the wrong
waitqueue, and the waiting tasks may be stuck forever.

Fix that by using ht_parms.key_len instead of sizeof(struct lm_lockname) for
the key length.

Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/glock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -107,7 +107,7 @@ static int glock_wake_function(wait_queu
 
 static wait_queue_head_t *glock_waitqueue(struct lm_lockname *name)
 {
-	u32 hash = jhash2((u32 *)name, sizeof(*name) / 4, 0);
+	u32 hash = jhash2((u32 *)name, ht_parms.key_len / 4, 0);
 
 	return glock_wait_table + hash_32(hash, GLOCK_WAIT_TABLE_BITS);
 }


