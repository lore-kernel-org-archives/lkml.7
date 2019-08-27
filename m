Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DEDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BBF206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892914;
	bh=Bmw78oSogBHQLfgSUraUOxCmqO6IB2RkUbvaOhQYRMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JY/scVfjiTxov1W/XAMhXGLwRpqT/b6pW9TCiDMFKrtMXfX419jTxTp/uynAsdItJ
	 3km/yDi7mBudDYkSCzJMUDgJ1qbQREHdFBGIpvrjcdzDjo9HvTaUUH+7XXJKlBqVlF
	 e/LWcLhUTAE7fDIkzXGDGRXLg/MJcauYB6c2wOYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfH0IBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfH0IBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:01:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596E2206BA;
        Tue, 27 Aug 2019 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892900;
        bh=Bmw78oSogBHQLfgSUraUOxCmqO6IB2RkUbvaOhQYRMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3W30cjZCPa+SA2CJQ/v2jPNixL/8i0EHal9hDLehr2hEOU90mOUeT4StZts8wM/U
         sb4SHLK9zMBrNuGHCpExjUSPvNKWqCHSApAwKqos4IXGMzsJSZd/kBn5ailT/j7Seq
         Amb8EgYL2HCD6u6l9+n0tTTXk3/TRKOUi2sxkLaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 016/162] libbpf: sanitize VAR to conservative 1-byte INT
Date:   Tue, 27 Aug 2019 09:49:04 +0200
Message-Id: <20190827072738.902407844@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1d4126c4e1190d2f7d3f388552f9bd17ae0c64fc ]

If VAR in non-sanitized BTF was size less than 4, converting such VAR
into an INT with size=4 will cause BTF validation failure due to
violationg of STRUCT (into which DATASEC was converted) member size.
Fix by conservatively using size=1.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3865a5d272514..77e14d9954796 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1044,8 +1044,13 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj)
 		if (!has_datasec && kind == BTF_KIND_VAR) {
 			/* replace VAR with INT */
 			t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
-			t->size = sizeof(int);
-			*(int *)(t+1) = BTF_INT_ENC(0, 0, 32);
+			/*
+			 * using size = 1 is the safest choice, 4 will be too
+			 * big and cause kernel BTF validation failure if
+			 * original variable took less than 4 bytes
+			 */
+			t->size = 1;
+			*(int *)(t+1) = BTF_INT_ENC(0, 0, 8);
 		} else if (!has_datasec && kind == BTF_KIND_DATASEC) {
 			/* replace DATASEC with STRUCT */
 			struct btf_var_secinfo *v = (void *)(t + 1);
-- 
2.20.1



