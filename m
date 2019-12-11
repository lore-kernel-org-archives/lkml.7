Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEDB24658
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077287;
	bh=457GHiPkffQMCaulmmo7ufnOW4fc4/Buml2davfuAX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1pejNtYmwX7DQ9nPGfDIYXbg1usJjs0rtdTk+q/aTlO54JEs0hhnipJLCOiP/tNf
	 O/NllPXEP6v/KS3Jw8Zb5U9AZnsl94S0g9cMyomodapIy6lVod8JVFYYbISBnAt8x1
	 bNKD8DX3pWQt71zpjoDLUVaJh8WWbe6DRgxmF+hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfLKPOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbfLKPNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0261024656;
        Wed, 11 Dec 2019 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077229;
        bh=457GHiPkffQMCaulmmo7ufnOW4fc4/Buml2davfuAX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQVEEPw+drxNQRWmmrA+lmEXgzPs2fg1LHRRPNOa6wRDSqaU2rhR1fgjP9fWCidPF
         X6tXcA0zkdrkahSmUYS9yGtJ2b/ud9Xe9XKH0oU87rr6vqq7bLWfNZFa2BC4zEM+LW
         qvAdzo3oB9o+bYDcQBtBo+xzWkk/+/32vZldpHXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 108/134] apparmor: fix unsigned len comparison with less than zero
Date:   Wed, 11 Dec 2019 10:11:24 -0500
Message-Id: <20191211151150.19073-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 59f1cc2557a73..470693239e64f 100644
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

