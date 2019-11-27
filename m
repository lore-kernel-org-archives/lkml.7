Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8671C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7176821739
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889740;
	bh=fplUeAm3cYMRQPtLwx2S5Y4Mzzno+mFsrYPL27frXLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXn+3+49Zizvot3VLjjMg9N/OLRHMGnFw5X9P10aigd9MMjRaTR6A8N3tWuc3YO8o
	 ZZe2OEPjtjKr8c3r9kaL8NHTsLVjnwK8oxVdXmuLnNAHZcEbfgByz3MPVeq7almJX1
	 6Otj1STPCoGuO2WPk0p6+cK4Hwlxw4LLGynwew+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfK0VGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfK0VGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:06:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0332086A;
        Wed, 27 Nov 2019 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888763;
        bh=fplUeAm3cYMRQPtLwx2S5Y4Mzzno+mFsrYPL27frXLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P16GRtQWt0NaKtxQaeHt0rZS82qu/6PF7oB80+NfwtjWAMwvGZMJtYUx7u+q4/gxH
         XsIxnVRj0KGEEtu1k8ePUjpe+mssXaZHk85p+dahnFZxcixTkelVeKuaR0MWoBT56J
         yKQc2iJhKs3N4PYAAAMzHwAR8TTc2yHL2US9BSTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Pittman <jpittman@redhat.com>,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.19 260/306] md/raid10: prevent access of uninitialized resync_pages offset
Date:   Wed, 27 Nov 2019 21:31:50 +0100
Message-Id: <20191127203133.828677762@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pittman <jpittman@redhat.com>

commit 45422b704db392a6d79d07ee3e3670b11048bd53 upstream.

Due to unneeded multiplication in the out_free_pages portion of
r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
possible to access a resync_pages offset that has not been
initialized.  This access translates into a crash of the system
within resync_free_pages() while passing a bad pointer to
put_page().  Remove the multiplication, preventing access to the
uninitialized area.

Fixes: f0250618361db ("md: raid10: don't use bio's vec table to manage resync pages")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: John Pittman <jpittman@redhat.com>
Suggested-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -229,7 +229,7 @@ static void * r10buf_pool_alloc(gfp_t gf
 
 out_free_pages:
 	while (--j >= 0)
-		resync_free_pages(&rps[j * 2]);
+		resync_free_pages(&rps[j]);
 
 	j = 0;
 out_free_bio:


