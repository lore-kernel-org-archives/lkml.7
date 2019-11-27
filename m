Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC48C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383F82184C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887930;
	bh=H0+p4fK298kw1jSTheIrFbd+g0vAAzU0oZwSoqofGG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RmFujm4REtRZjnMz4ArprApAIFWeW1X/aFdrSlFDpybZx0cVSwp3Gd0N1a2gL0pXS
	 qOo4mofWAZU3Qjm4slbyiQ2fpOb33QqghSCTUO9ssJI0zv0tqCtfztWjTztNJEqQRp
	 ODtPpjS5KGkOGAB0VYAz8biFyA1dfZ2L38y3mjT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfK0UwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfK0UwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:52:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A0821871;
        Wed, 27 Nov 2019 20:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887921;
        bh=H0+p4fK298kw1jSTheIrFbd+g0vAAzU0oZwSoqofGG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnLEhcXpcPww4kzIzFHwfW6jB0BVlfZR5vTUNrCZVfN1YuD+9kZbrF4dBAw1JIpl2
         hMS8wMeIeDXgTfQ5m5tKhZkWOgXl3ifCp7fuXrOymSp5DILYAXdFgrR7hdlpvWNuzm
         A+e7HTZL2gjtHQxMTmiCBU5ySpYdHsrW8qarek4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 147/211] dlm: fix invalid free
Date:   Wed, 27 Nov 2019 21:31:20 +0100
Message-Id: <20191127203107.914032200@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.ws>

[ Upstream commit d968b4e240cfe39d39d80483bac8bca8716fd93c ]

dlm_config_nodes() does not allocate nodes on failure, so we should not
free() nodes when it fails.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/member.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 3fda3832cf6a6..cad6d85911a80 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -680,7 +680,7 @@ int dlm_ls_start(struct dlm_ls *ls)
 
 	error = dlm_config_nodes(ls->ls_name, &nodes, &count);
 	if (error < 0)
-		goto fail;
+		goto fail_rv;
 
 	spin_lock(&ls->ls_recover_lock);
 
@@ -712,8 +712,9 @@ int dlm_ls_start(struct dlm_ls *ls)
 	return 0;
 
  fail:
-	kfree(rv);
 	kfree(nodes);
+ fail_rv:
+	kfree(rv);
 	return error;
 }
 
-- 
2.20.1



