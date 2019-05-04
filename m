Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB4C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632842084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FEEmpF/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEDSke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33663 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfEDSie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so7885421ljc.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1RXqMd3oM130PbV6/2cqI1sCTRLP7lSwTZjKdujSbk=;
        b=FEEmpF/uTHtOxKNBHDa9xmhPxLUFRXtpFHeLfT8aZS8IA+WE7hA5EQolSTMGYOzZ8i
         KXXsasRzJ30hky/IR69UYrMDyfOAeqgGJYK1f4wfCSYLiQH7fptaqtRQFZdUUxSIxjOh
         SLet2L2RNpVWNDAIk820Q2nAwJCa4yUTZAFu698u1hHVLyRiFEcT1mUNffPngEnNE/4w
         /i+ZmqoeO6zHEeTySUNx+9A/OKTYt0HyMShYo7dfLWS/SQlOqpReKNhYjxHQLVz2gIyR
         ghabmVcWp+0lKgSEBBD6Dvzkd08VkN6jkpLqRtL25SG0NEw+jIOjCaegImJQy1AkL4wp
         x3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1RXqMd3oM130PbV6/2cqI1sCTRLP7lSwTZjKdujSbk=;
        b=SWXimJRt5qtSBB7dr8IP0XI9Ci0hgwa9M+JjRNgao9shlin5B73XsF1qy6UfC3AZyU
         pDldU3uixJ3wkfdivXDd+x5VHhrgqEhIbvmjlDWSxZL198hgNz0zHm6CulAwGI2zsoMC
         oaOSyYZgTpvdeTSlQbwq+UkMp66i9287zRwZgmYEy9ZUI57Ax7PFvtuHwjMiNqJ+PfDf
         nzNDRAC8qGCYmll/AP7qfsX1762EqtbUs3DM30NBuHumyjjm9fhIlEseZIfsafeeI/tb
         oQdN6RLcKWVlV0coCND0gnepFZsoAw5h8oEHHd4lAV9DByxOWFqwZ5xhrLj2gMO6F6//
         vqiA==
X-Gm-Message-State: APjAAAUAPB/bTNLFV/xmT4/5TzKpfK3hzK7hqJchdLGGKr2iZo1JAN02
        fCybWXdkTSAeM88KqEZCqz/1Yw==
X-Google-Smtp-Source: APXvYqzAGtz1e6NHcfOW3QFIjfUSjblMN7qBzMhZVPiuh13K/e16wvS3V99lAsgGVs7f7829hjXZHQ==
X-Received: by 2002:a2e:7308:: with SMTP id o8mr8295216ljc.171.1556995112270;
        Sat, 04 May 2019 11:38:32 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:31 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/26] lightnvm: pblk: fix race during put line
Date:   Sat,  4 May 2019 20:37:51 +0200
Message-Id: <20190504183811.18725-7-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

In the pblk_put_line_back function, a race condition with
__pblk_map_invalidate can make a line not part of any lists.

Fix gc_list by resetting it to null fixes the above issue.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index ea9f392a395e..e23b1923b773 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -64,19 +64,23 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list;
 
+	spin_lock(&l_mg->gc_lock);
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_CLOSED;
 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
+
+	/* We need to reset gc_group in order to ensure that
+	 * pblk_line_gc_list will return proper move_list
+	 * since right now current line is not on any of the
+	 * gc lists.
+	 */
+	line->gc_group = PBLK_LINEGC_NONE;
 	move_list = pblk_line_gc_list(pblk, line);
 	spin_unlock(&line->lock);
-
-	if (move_list) {
-		spin_lock(&l_mg->gc_lock);
-		list_add_tail(&line->list, move_list);
-		spin_unlock(&l_mg->gc_lock);
-	}
+	list_add_tail(&line->list, move_list);
+	spin_unlock(&l_mg->gc_lock);
 }
 
 static void pblk_gc_line_ws(struct work_struct *work)
-- 
2.19.1

