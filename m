Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0549C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5549215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355154;
	bh=VD4umiNxrZippj0WiJGqjuU8zBL40Cfzqdcof7Lh3Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smKxEru1w73I2F4RdqUXeTCnUDjKjonC2Dzy4/6nf/6jeJdKMYjRCdujLN4DbTahD
	 R1LD7p9wXhw86ZjUgJnz5STrAl48/mjAbuUO9JFrvM13qVBQt/WtJMmHONmCOR4iAE
	 7tjEp5P4Ayxs484lZmNDEXzXXNsMpQkQ7J1g2ywU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKJCqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbfKJCpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC166222BE;
        Sun, 10 Nov 2019 02:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353948;
        bh=VD4umiNxrZippj0WiJGqjuU8zBL40Cfzqdcof7Lh3Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS5je2qkyI9WiuHiYbJhNHaaVJR8FEAD2OS11yROYcuq8OVcKKD2UrEvqUd8RmMIJ
         +7wX8FKHO4MDD/JvIuOAi/a5MLQMD7sf041WwDGWDE9m4CBI0fvWCQTRbkmfdNdRt8
         dJqzJQH9InXysFaagemITp6fXFw8MK8dZaL7pt14=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 006/109] samples/bpf: fix a compilation failure
Date:   Sat,  9 Nov 2019 21:43:58 -0500
Message-Id: <20191110024541.31567-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 495ee02e2fb7c..4d75674bee35e 100644
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

