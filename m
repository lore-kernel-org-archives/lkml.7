Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CCCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5951420700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384533;
	bh=lcB1mFJcKFF8tbCYE5shlRbzQ7T708HoKSgtww14kP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x2wm+nbbJ00S6cQQs+mPaZEVCHoJtT09l62hZGCzorXVYZQIRWmFlSoig9+yVohOI
	 kwd++cC6zfOmyj/LKvmNB1uT2/fCmWgri/F6/ubG9qKfKtb9u4q2YdVMRwJzdsDtpR
	 UMLPDa15ciCyAW7KNYSIc86MrjtVUVwm5M0xYsrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfJFRzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfJFRy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:54:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0F522466;
        Sun,  6 Oct 2019 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383968;
        bh=lcB1mFJcKFF8tbCYE5shlRbzQ7T708HoKSgtww14kP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgHLO9rUSmNjHgHcMYwDbplbKrycCoKgj1WxVYXgPdtriWCrgK4d2N85u0Iw6pEfb
         lXA3QanfuyXoYzDuY9OH3VscHtpdFfahr5H7xuAzcD0Kv4heGYMOk/Xm4+vNW65SCt
         2aaZsePRbk+d4z3JowGkj63VgATSuJUq591XymXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.3 161/166] dm zoned: fix invalid memory access
Date:   Sun,  6 Oct 2019 19:22:07 +0200
Message-Id: <20191006171226.412783993@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0c8e9c2d668278652af028c3cc068c65f66342f4 upstream.

Commit 75d66ffb48efb30f2dd42f041ba8b39c5b2bd115 ("dm zoned: properly
handle backing device failure") triggers a coverity warning:

---
 drivers/md/dm-zoned-target.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -134,8 +134,6 @@ static int dmz_submit_bio(struct dmz_tar
 
 	refcount_inc(&bioctx->ref);
 	generic_make_request(clone);
-	if (clone->bi_status == BLK_STS_IOERR)
-		return -EIO;
 
 	if (bio_op(bio) == REQ_OP_WRITE && dmz_is_seq(zone))
 		zone->wp_block += nr_blocks;


