Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD2721670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625258;
	bh=sSz3YWg6ZqSDJ7IxTSRpTLrK3Rw0qZCXM/y7vDBgX5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HxbGUQKrPezF4VEFMxTQiiUjfM+xdA63tteCPpmkq6Im2MvNJGdKCPBXL2SYnWXPl
	 NQ4jzzFai7hbToOYbmN+fZjjj1z3pUByMWyvChxlEcT7Mv0JT1Q/fz5aNa8FcYdHch
	 VsSBDoyMILSQyvztNRQ1tmAkgW2ej5c+/GdDRh+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbfD3LyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731171AbfD3LuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:50:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37272054F;
        Tue, 30 Apr 2019 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625017;
        bh=sSz3YWg6ZqSDJ7IxTSRpTLrK3Rw0qZCXM/y7vDBgX5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpsWQKf7F58Zl+03V7UEi0XwRql2moih51uhV6m3AgRiOvVVv4/TqFTZrQdOxVyaK
         ClSTwGxWr+zBi4J7e9FLCtu0OSh0bUV+5MM1Z3PklXnPXZeV3t0DKESe6Fqzu+iDL7
         9wiZ31o6Hn1TW9geGLBuEMnHeIOy1wtnvSBwev6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+de00a87b8644a582ae79@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 60/89] tipc: check link name with right length in tipc_nl_compat_link_set
Date:   Tue, 30 Apr 2019 13:38:51 +0200
Message-Id: <20190430113612.502268974@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit 8c63bf9ab4be8b83bd8c34aacfd2f1d2c8901c8a upstream.

A similar issue as fixed by Patch "tipc: check bearer name with right
length in tipc_nl_compat_bearer_enable" was also found by syzbot in
tipc_nl_compat_link_set().

The length to check with should be 'TLV_GET_DATA_LEN(msg->req) -
offsetof(struct tipc_link_config, name)'.

Reported-by: syzbot+de00a87b8644a582ae79@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -777,7 +777,12 @@ static int tipc_nl_compat_link_set(struc
 
 	lc = (struct tipc_link_config *)TLV_DATA(msg->req);
 
-	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_LINK_NAME);
+	len = TLV_GET_DATA_LEN(msg->req);
+	len -= offsetof(struct tipc_link_config, name);
+	if (len <= 0)
+		return -EINVAL;
+
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(lc->name, len))
 		return -EINVAL;
 


