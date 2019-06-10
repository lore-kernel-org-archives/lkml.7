Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF93C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D3207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGM3lu2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbfFJTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:14:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39105 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbfFJTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id n2so6216142vso.6;
        Mon, 10 Jun 2019 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWvHhq8XxQsgdEEkuwdPbUPIjaH98CArgRPaOAub3ak=;
        b=UGM3lu2qIHghbQDu1EsRRuavlODvaP07lY9tARpBwIqOVzP5rUfP+otXPvOH45AbIn
         +q2gvV+wGnZYtNE2MViSJVHRWUI6IhueGI0T5o2nLX+gtRu0Rwf3H7Ky6Gdu7OKzQJmp
         TR9OY7pSkBYQeo3qJix4w/zCPD4tfmlQFHKdEpNokvXY3s8MIgQjcNyBsMxgHuA1Krv2
         9+GYTMwk3XwFdKHF+LbNFHmTqw93AbXVxU972IouXyhmJ+1/c3vyUjn/PLC4IICaQzsR
         Brb3VMHqpYnTTyPFXbvg5yjV5/ctGZgH5oIrdlvkvZeCvWyiWF2IQBICWcH2GIbNOUA0
         +45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWvHhq8XxQsgdEEkuwdPbUPIjaH98CArgRPaOAub3ak=;
        b=tYM6DCtYFl6iYpg+1je3DzC1W20V5wEzVBcam4PO2cLFZ8uRPfONyeHgM/Rj0s7X5+
         3bFhSaBTMAwLn9ERfWrMm/li+n6fQnqAWBj60P89Wod4i1vFXaR4CL/fVOqzd8ZPb1ef
         9GgszwEax5P5pAbgMTX6aYynuWAe4c9o3cFyV8OER5ZWtstKCmVlIBznblySYBuDo83O
         y1tMDqIqD6fdYa6PSqfW9OabQG6dfwVOtP2Je/tetKAW5qY2z0uIbBAH81tD9vHEXiVu
         V83WEoGiq4I0avDEMNfO5+rbrc2rkzXMAoM0FHY8EixPpmEt/+pRsKQoKIsytTj6nLJv
         4x2A==
X-Gm-Message-State: APjAAAWuNPo9mhMmQSN59zCf7+4s9+9ECPGB9DkTmjxNbYEYjsuH7eti
        aSkWqWCE5sn1wSqoS+fmIcToO7Ikzg==
X-Google-Smtp-Source: APXvYqyp9NIqoSDj8Nbh7rQIbCBMQwTNEntUK0tr2oYE/q/t7X0iHO7hy11ayPE3I91sFc8HgJ3JFw==
X-Received: by 2002:a67:f911:: with SMTP id t17mr3355596vsq.128.1560194079062;
        Mon, 10 Jun 2019 12:14:39 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 08/12] block: Add some exports for bcachefs
Date:   Mon, 10 Jun 2019 15:14:16 -0400
Message-Id: <20190610191420.27007-9-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 716510ecd7..a67aa6e0de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -958,6 +958,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
@@ -1658,6 +1659,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 static void bio_release_pages(struct bio *bio)
 {
@@ -1731,6 +1733,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 void update_io_ticks(struct hd_struct *part, unsigned long now)
 {
-- 
2.20.1

