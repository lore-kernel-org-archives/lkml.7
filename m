Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44FC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B81621739
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920718;
	bh=GrS/sfvynxkd0Z9uBnjBDVMYI0Mc/xdQEjRQgmhPX4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipNwHYODIZWfpSdx2U3xjJdE0MNad+rz19Cgl+p3/fGlGwSv9UbjBJbosJnlqvHhj
	 vYww1tIL/jMTXWed4b5Uv0TQC9wLMBwRGEjigCmP7xsxkC+T9NMXU26HWi0/0qwWVg
	 j7y28ZJ1yoPanfNWRE6qBlmxdZDCBFX/29CGP/nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfKPQLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbfKPPsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:31 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBCE8207FA;
        Sat, 16 Nov 2019 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919311;
        bh=GrS/sfvynxkd0Z9uBnjBDVMYI0Mc/xdQEjRQgmhPX4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVXBzz9QpJ16TzeBGnBTBAbD7azpFde5INVj+0yH7zps4GFPq53Tyh+CCIEImCY9X
         GqLR7JyjplCFyOlLPA0a3TKv5oit7kUFNaYbBEX+/t+1dLk2YoQWXoWdfGtnLRIkxv
         biAdyMlrYPwJroT20stVlR+5+APfSsVZMderNYng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 053/150] SUNRPC: Fix a compile warning for cmpxchg64()
Date:   Sat, 16 Nov 2019 10:45:51 -0500
Message-Id: <20191116154729.9573-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit e732f4485a150492b286f3efc06f9b34dd6b9995 ]

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_seal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 1d74d653e6c05..ad0dcb69395d7 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -63,6 +63,7 @@
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/random.h>
 #include <linux/crypto.h>
+#include <linux/atomic.h>
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
-- 
2.20.1

