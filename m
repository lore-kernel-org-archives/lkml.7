Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCBC3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F520848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005936;
	bh=KHMm0neWLyWoQiQj8vd+QVGhRlKjHrs6P4ShXL59hT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pSzg4OiHJWc+XL0cAfZInXFL3qkykynInCJTBWRj5zm6Lg8EZc9X91VX74eP4cd/U
	 ROtRYxQWc0oj4sbfPkjD0JLVv+q+ReFqde/173xvy8WZaCYyM/EahRfwjfcyLJwmOI
	 ngV4XUjmdr7QfT3E2h9CQnKaZXZ6Y0k5MiBch+eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgABW6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgABWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:15:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFA024649;
        Thu,  2 Jan 2020 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003301;
        bh=KHMm0neWLyWoQiQj8vd+QVGhRlKjHrs6P4ShXL59hT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGKxekhbSARv5WzxcjyFt5SfCOFneYAJXEaU7TkH61UGUZOjtv37dnOBoLXgSvYgF
         O5vlghkbRQMPC8YqEpPQ7K5JmryjfUO7OoPMMfvOdgLNTgej6i0bBLKd+Q71YSTO2f
         egxElNhDp4VNx3jhWw31U3NReW7zVdTU3t7Wf+V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/191] apparmor: fix unsigned len comparison with less than zero
Date:   Thu,  2 Jan 2020 23:06:26 +0100
Message-Id: <20200102215841.088282465@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 00e0590dbaec6f1bcaa36a85467d7e3497ced522 ]

The sanity check in macro update_for_len checks to see if len
is less than zero, however, len is a size_t so it can never be
less than zero, so this sanity check is a no-op.  Fix this by
making len a ssize_t so the comparison will work and add ulen
that is a size_t copy of len so that the min() macro won't
throw warnings about comparing different types.

Addresses-Coverity: ("Macro compares unsigned to 0")
Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/label.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 59f1cc2557a7..470693239e64 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1458,11 +1458,13 @@ static inline bool use_label_hname(struct aa_ns *ns, struct aa_label *label,
 /* helper macro for snprint routines */
 #define update_for_len(total, len, size, str)	\
 do {					\
+	size_t ulen = len;		\
+					\
 	AA_BUG(len < 0);		\
-	total += len;			\
-	len = min(len, size);		\
-	size -= len;			\
-	str += len;			\
+	total += ulen;			\
+	ulen = min(ulen, size);		\
+	size -= ulen;			\
+	str += ulen;			\
 } while (0)
 
 /**
@@ -1597,7 +1599,7 @@ int aa_label_snxprint(char *str, size_t size, struct aa_ns *ns,
 	struct aa_ns *prev_ns = NULL;
 	struct label_it i;
 	int count = 0, total = 0;
-	size_t len;
+	ssize_t len;
 
 	AA_BUG(!str && size != 0);
 	AA_BUG(!label);
-- 
2.20.1



