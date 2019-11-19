Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895F6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D203214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141706;
	bh=H6WRcRF4jr5TKpnkFhGUjOIpidjg4AoHJXVq/R2DmTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=En1CKdGmSFJGJJemF1iJHenXDn63rq7GVml0IJHlc02t75OgZN29I/6ecDF52CFuT
	 z76VRfX9z804MWIS3hqf3WqGhPd/XSbJtFu7XkWbcrmiuk/gCJjw7zP6EgH4Oih+mr
	 iv990DdSM9a8ZThNPrsCXdIY9qArCeRT/amxw+Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfKSFfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfKSFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A23C208C3;
        Tue, 19 Nov 2019 05:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141695;
        bh=H6WRcRF4jr5TKpnkFhGUjOIpidjg4AoHJXVq/R2DmTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZNU0lDlIf23rBGOQWZ88bNMQqAtozIgV7oJNiRTcYpWl+mQNg0SWA9Z2dLh2L5CF
         MlEF9Pkta3R1W6TLr0ktF9pJbyHZ5mrlNOy1n3XmVzA09XG4TdrMvse0Sd5+uLe8BL
         0MwqpnI54Cq1A+UXkkSobbWgB6nIq3AGUJaEvVwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 249/422] samples/bpf: fix a compilation failure
Date:   Tue, 19 Nov 2019 06:17:26 +0100
Message-Id: <20191119051415.125922532@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 534e0e52bc23de588e81b5a6f75e10c8c4b189fc ]

samples/bpf build failed with the following errors:

  $ make samples/bpf/
  ...
  HOSTCC  samples/bpf/sockex3_user.o
  /data/users/yhs/work/net-next/samples/bpf/sockex3_user.c:16:8: error: redefinition of ‘struct bpf_flow_keys’
   struct bpf_flow_keys {
          ^
  In file included from /data/users/yhs/work/net-next/samples/bpf/sockex3_user.c:4:0:
  ./usr/include/linux/bpf.h:2338:9: note: originally defined here
    struct bpf_flow_keys *flow_keys;
           ^
  make[3]: *** [samples/bpf/sockex3_user.o] Error 1

Commit d58e468b1112d ("flow_dissector: implements flow dissector BPF hook")
introduced struct bpf_flow_keys in include/uapi/linux/bpf.h and hence
caused the naming conflict with samples/bpf/sockex3_user.c.

The fix is to rename struct bpf_flow_keys in samples/bpf/sockex3_user.c
to flow_keys to avoid the conflict.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/sockex3_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index 5ba3ae9d180ba..22f74d0e14934 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -13,7 +13,7 @@
 #define PARSE_IP_PROG_FD (prog_fd[0])
 #define PROG_ARRAY_FD (map_fd[0])
 
-struct bpf_flow_keys {
+struct flow_keys {
 	__be32 src;
 	__be32 dst;
 	union {
@@ -64,7 +64,7 @@ int main(int argc, char **argv)
 	(void) f;
 
 	for (i = 0; i < 5; i++) {
-		struct bpf_flow_keys key = {}, next_key;
+		struct flow_keys key = {}, next_key;
 		struct pair value;
 
 		sleep(1);
-- 
2.20.1



