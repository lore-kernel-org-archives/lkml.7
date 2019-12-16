Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A58C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A655206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518947;
	bh=o7mz2GbpHNAPTYnC0rsE4XIb0xZ5GVQkEYmAaShdV7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BalaUrRGLzw5hXlKi7f4Cu6XS/oT4U2YlxEZOTVt7iKrp7Cm6Hss7FtlGDo7lX4Pd
	 YPzkDot1+wHbqiGq45jNIS3IXv74tgn+XUqH5pQpDlpl0W9C/6ah8yD55688aeV5H9
	 MPeNFw1eoY5Q9h0VrieCcWUCgCkxy2WaQYgbZzJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLPRzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfLPRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:55:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44E821582;
        Mon, 16 Dec 2019 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518942;
        bh=o7mz2GbpHNAPTYnC0rsE4XIb0xZ5GVQkEYmAaShdV7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIPXOuhsw740enB24m3rL+wMsDf8X1mfscBK8Aw6/q5YYt7r4eIU2rzq0wM0uyh0/
         NsbiJf/8cBDfG5dJuVSlHbQI/M8amxcD49Vie2maEn176Z42veqk2CFSmZwS1PYMAx
         1X6tDzE3tvq4Y+VKc44HYHo645ZwYBOmIZW4up2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/267] pstore/ram: Avoid NULL deref in ftrace merging failure path
Date:   Mon, 16 Dec 2019 18:47:09 +0100
Message-Id: <20191216174902.355644036@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 8665569e97dd52920713b95675409648986b5b0d ]

Given corruption in the ftrace records, it might be possible to allocate
tmp_prz without assigning prz to it, but still marking it as needing to
be freed, which would cause at least a NULL dereference.

smatch warnings:
fs/pstore/ram.c:340 ramoops_pstore_read() error: we previously assumed 'prz' could be null (see line 255)

https://lists.01.org/pipermail/kbuild-all/2018-December/055528.html

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 2fbea82bbb89 ("pstore: Merge per-CPU ftrace records into one")
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 40bfc6c583749..1e675be10926d 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -297,6 +297,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					  GFP_KERNEL);
 			if (!tmp_prz)
 				return -ENOMEM;
+			prz = tmp_prz;
 			free_prz = true;
 
 			while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
@@ -319,7 +320,6 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					goto out;
 			}
 			record->id = 0;
-			prz = tmp_prz;
 		}
 	}
 
-- 
2.20.1



