Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB53C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B4721739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518717;
	bh=y6SxkjAzAzxq5nfbeRrVyDabhK6DoAJUxIAZp6O+qRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0S15Uc0GfzaMlYwLa38POqHY4iQb2td2nr7S6B9Q0PLJnLKB2t+w3dZeASiSUGCL+
	 NUpTpaL7t9GMSxM71SnypgghPfkL6y8qNSC4HBhiiXEOSbam5FjHbElP+PfVMd/dAc
	 c/rx5+kt+RnE6JTKWOwVyIeMQ1XT92bapS+GTB50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLPRv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfLPRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B2621739;
        Mon, 16 Dec 2019 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518714;
        bh=y6SxkjAzAzxq5nfbeRrVyDabhK6DoAJUxIAZp6O+qRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j960hFHJpgvjjKiw3oMJLiI/Cfp85XgK5ERe8My8SpFr5ULZhSjlxDeO45n4vkvx1
         rUw4bLgzzjqTJk9vKFl282JXJrBNAo3Ed7h4tZ/i+prTon+5LJysloAfpTcF3oarg6
         EcNU43eF1ORDhtP8W7patoGx7tZg8t3Tp4SVKxgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 037/267] dlm: fix missing idr_destroy for recover_idr
Date:   Mon, 16 Dec 2019 18:46:03 +0100
Message-Id: <20191216174853.042431666@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

[ Upstream commit 8fc6ed9a3508a0435b9270c313600799d210d319 ]

Which would leak memory for the idr internals.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lockspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 610f72ae7ad67..9c8c9a09b4a6d 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -807,6 +807,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_delete_debug_file(ls);
 
+	idr_destroy(&ls->ls_recover_idr);
 	kfree(ls->ls_recover_buf);
 
 	/*
-- 
2.20.1



