Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350BC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7DB21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788125;
	bh=DO155T9TYv+TyBqzz+WkFhf+n8NXB7p7oq7eXTJ/cEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZSFIFHFOgCJUME7i6qrYM8EmikvgVVD8lu3YWfHEAcJrctRX7AIdhz7zL9UATBQS9
	 zNwOeKITYtRAO4pVNi+OngBq5wP2PACxs5O5rR0dtb0kSPV/3DCx7OT9jz7MxaVTNJ
	 Xkb9lg7ULPzethtH71bJ5o1OpY99UScUDTrTbaZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfIRG2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbfIRG1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:27:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2946221906;
        Wed, 18 Sep 2019 06:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788027;
        bh=DO155T9TYv+TyBqzz+WkFhf+n8NXB7p7oq7eXTJ/cEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZKasugyQVK9E+bI/8oMBzpv1DQfoWMLAR143whR8p8HKTCGshBDVj/UJ8EYXq+XG
         UJX+6ugWAoZ13RkS4lmHgIhCdHQhe80gxQRmcqaxuTHkLcp9Cl4HpXhXGRCrEhBNWy
         6d2dUkkFIdX1FpWUN1EpA4Z+gfj2cIwxPWY0zqBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Burns <henryburns@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Jonathan Adams <jwadams@google.com>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.2 72/85] mm/z3fold.c: remove z3fold_migration trylock
Date:   Wed, 18 Sep 2019 08:19:30 +0200
Message-Id: <20190918061237.682280260@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Burns <henryburns@google.com>

commit be03074c9af25d06cf8e9ebddfcd284c0bf7f947 upstream.

z3fold_page_migrate() will never succeed because it attempts to acquire
a lock that has already been taken by migrate.c in __unmap_and_move().

  __unmap_and_move() migrate.c
    trylock_page(oldpage)
    move_to_new_page(oldpage_newpage)
      a_ops->migrate_page(oldpage, newpage)
        z3fold_page_migrate(oldpage, newpage)
          trylock_page(oldpage)

Link: http://lkml.kernel.org/r/20190710213238.91835-1-henryburns@google.com
Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
Signed-off-by: Henry Burns <henryburns@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: Vitaly Vul <vitaly.vul@sony.com>
Cc: Jonathan Adams <jwadams@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Snild Dolkow <snild@sony.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/z3fold.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1439,16 +1439,11 @@ static int z3fold_page_migrate(struct ad
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
 
-	if (!trylock_page(page))
-		return -EAGAIN;
-
 	if (!z3fold_page_trylock(zhdr)) {
-		unlock_page(page);
 		return -EAGAIN;
 	}
 	if (zhdr->mapped_count != 0) {
 		z3fold_page_unlock(zhdr);
-		unlock_page(page);
 		return -EBUSY;
 	}
 	if (work_pending(&zhdr->work)) {
@@ -1494,7 +1489,6 @@ static int z3fold_page_migrate(struct ad
 	spin_unlock(&pool->lock);
 
 	page_mapcount_reset(page);
-	unlock_page(page);
 	put_page(page);
 	return 0;
 }


