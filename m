Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968EB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371411;
	bh=mOxxpGB/oDd0cH0mmpuJKpZv7IMSYaE70omrEujUuis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqsOvfmMzYTrOaereMBkK+nJfMav+rg3EcrnpV6zByqrSJ6PXHJN342hewcTI16EC
	 /HABYMk6v5iI6lk62vOdL3Eyc0vAwjESIH8UfpaYlLb0oPYPAua0hDT0m1ypjFqDwo
	 H53RfgvdP+PK3I57Fdyrnv+O7xblIXrdHLQiL3D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfFXKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbfFXKQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:16:46 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B74A2146E;
        Mon, 24 Jun 2019 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371406;
        bh=mOxxpGB/oDd0cH0mmpuJKpZv7IMSYaE70omrEujUuis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHL+c0vRRFrJ2IFm9MOYFj866JDTw9TR54euwaZAYEJEK+a9iv2Kj3nzsW2Z+yzbE
         sPSGuHYFKNqBje0iL48/gu+uQlpnLFLr/SGrkAPwrEVr848CB4rjIWJ3cf6TFfZ4dL
         ovmpSWBCpAsh6VWSskgruCMsKRF3YyFHCIFZMh6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 091/121] ovl: fix bogus -Wmaybe-unitialized warning
Date:   Mon, 24 Jun 2019 17:57:03 +0800
Message-Id: <20190624092325.446437178@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1dac6f5b0ed2601be21bb4e27a44b0c3e667b7f4 ]

gcc gets a bit confused by the logic in ovl_setup_trap() and
can't figure out whether the local 'trap' variable in the caller
was initialized or not:

fs/overlayfs/super.c: In function 'ovl_fill_super':
fs/overlayfs/super.c:1333:4: error: 'trap' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    iput(trap);
    ^~~~~~~~~~
fs/overlayfs/super.c:1312:17: note: 'trap' was declared here

Reword slightly to make it easier for the compiler to understand.

Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index fa5060f59b88..9780617c69ee 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -996,8 +996,8 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
 	int err;
 
 	trap = ovl_get_trap_inode(sb, dir);
-	err = PTR_ERR(trap);
-	if (IS_ERR(trap)) {
+	err = PTR_ERR_OR_ZERO(trap);
+	if (err) {
 		if (err == -ELOOP)
 			pr_err("overlayfs: conflicting %s path\n", name);
 		return err;
-- 
2.20.1



