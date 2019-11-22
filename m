Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD27C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1241D20731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403291;
	bh=uVmrMTReuiw8qke0Vz4udyQimZmWzBpfxFe56+DKeUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0yMahXmiRKuuCKtYTLD77FvgzvpLkeBSI3VBcbDkylc7tjKts4WyhHtpIdzMR+cS
	 UxnrG2yy/JypDfIUVqRNruSiy3hdUnI5OG5at64jTKz7r1ub/b1CqJRLiOCNurYI2h
	 NJ3mxH+xTvGRKCRKQ7wld41mzyCp8/ucqwOd+iQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfKVGOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfKVGN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773A02068F;
        Fri, 22 Nov 2019 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403238;
        bh=uVmrMTReuiw8qke0Vz4udyQimZmWzBpfxFe56+DKeUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJdbDakrhSAxyjZ6SxEv7snewkEFWRcsZQUAyNsy3iXEIInpz1IKxjf1ydW8XU8zO
         8oHlfBr58gHmNE0RdbJmMGRQKCJ5SnJwVDCBc04gD8QwX8VxwKwhsgNs/ewmLUO5mj
         82xuiEZ7gsbLK1bxZbZqQDy4g2MNIaWkwLzC6tOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 50/68] tipc: fix a missing check of genlmsg_put
Date:   Fri, 22 Nov 2019 01:12:43 -0500
Message-Id: <20191122061301.4947-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 46273cf7e009231d2b6bc10a926e82b8928a9fb2 ]

genlmsg_put could fail. The fix inserts a check of its return value, and
if it fails, returns -EMSGSIZE.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/netlink_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index d2bf92e711505..4f6fbd2f29add 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -926,6 +926,8 @@ static int tipc_nl_compat_publ_dump(struct tipc_nl_compat_msg *msg, u32 sock)
 
 	hdr = genlmsg_put(args, 0, 0, &tipc_genl_family, NLM_F_MULTI,
 			  TIPC_NL_PUBL_GET);
+	if (!hdr)
+		return -EMSGSIZE;
 
 	nest = nla_nest_start(args, TIPC_NLA_SOCK);
 	if (!nest) {
-- 
2.20.1

