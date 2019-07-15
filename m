Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6311C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E3220868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200157;
	bh=mY7D8/gCTrXjHI3QyCz3C15Z32xtPG47mtQJi4xlVH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EbAfHZvnmgYyHbNv0rSl2cRrthw6UbDOWtElh9Ay+Jz0f72F7rniXJO4uf9VvjiK
	 GdvqPkW2ITA3jxIB0LuAmClLnmHESfHY4rlu4KgyGRt1ccAgD+WTxbXcx5SY7+HpMe
	 1ToPz20TpO6an8X03rZyxVBq1l91Ku/XyQ0bJN0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbfGOOP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389609AbfGOOPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:15:55 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CB620651;
        Mon, 15 Jul 2019 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200154;
        bh=mY7D8/gCTrXjHI3QyCz3C15Z32xtPG47mtQJi4xlVH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpyanCDRbdL0TuSvBVOw9UhU6rJORrHX7fd+0AMLEVchlllGEn+yZQFpNhfywXdpI
         3xb4FkJczLNF+oyVguKVhlHbBG/iZH/ChTrz81i6iGRKczUwwuWqmG+BW4gCiQNXud
         DJQZJSfJKFkg8S/BhbtsT/iQfQsG3jeqCUP+4WFE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 196/219] libbpf: fix GCC8 warning for strncpy
Date:   Mon, 15 Jul 2019 10:03:17 -0400
Message-Id: <20190715140341.6443-196-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit cdfc7f888c2a355b01308e97c6df108f1c2b64e8 ]

GCC8 started emitting warning about using strncpy with number of bytes
exactly equal destination size, which is generally unsafe, as can lead
to non-zero terminated string being copied. Use IFNAMSIZ - 1 as number
of bytes to ensure name is always zero-terminated.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index af5f310ecca1..1fe0e1eec738 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -336,7 +336,8 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 
 	channels.cmd = ETHTOOL_GCHANNELS;
 	ifr.ifr_data = (void *)&channels;
-	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ);
+	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ - 1);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	err = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (err && errno != EOPNOTSUPP) {
 		ret = -errno;
-- 
2.20.1

