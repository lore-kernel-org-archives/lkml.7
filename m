Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D0921774
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887725;
	bh=GrS/sfvynxkd0Z9uBnjBDVMYI0Mc/xdQEjRQgmhPX4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMqA8ngLjTmy36KuggJlJRldm/l1rcA5gNTdsSF28ywwd89FRmaJMrhC6tfM7m2BU
	 +Yqxd+Kw2npY3JMMLHqcJNW049SNYsSENl6nGkyRPg4ZCT28tOlFQVuu6BVND4rDzO
	 rXZQcylOGHKWpkOCAuVPu/FP+li6zvhsU2E3mCDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfK0Uso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbfK0Usk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:48:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C66D421826;
        Wed, 27 Nov 2019 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887720;
        bh=GrS/sfvynxkd0Z9uBnjBDVMYI0Mc/xdQEjRQgmhPX4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19BLxofx2HEww3JMEvvaaNGAFv6Q/gbJfCKeaEbu1FokpTlZGh4Qk6DgtqcsRHTTl
         XuR4aal1xKORvB2ZdMZqzDLPNjfRFrH5wG01IwDyS5OsEGjHldbPfMhTU+XuhbZOSn
         MHbC458UCq+L4YrYOljEPQMTiUaOrm1WS2MVOopU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/211] SUNRPC: Fix a compile warning for cmpxchg64()
Date:   Wed, 27 Nov 2019 21:30:01 +0100
Message-Id: <20191127203100.317621189@linuxfoundation.org>
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



