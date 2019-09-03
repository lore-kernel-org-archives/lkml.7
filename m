Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42998C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7C7215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528216;
	bh=Zl6Q1JD1N7GFogmeP7CbaHh/ulm0hljSif2nM3HtHDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMiicweP3ajCqjYvHycJo7h3uCNbHI+L4vTedkrhvX5T139EAP7hDXxmjU/ZXfoMX
	 qr1531Tn6m+WIdbjs94k3rLz/sRN7IEIt7fo3Sc0RJbc+EkhpStRml7nS+LQ2Sp3wj
	 QScj5jm1kXzUpW1AkyDGzWvm5J37b1IgmqgDyxPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfICQ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbfICQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:28:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3027215EA;
        Tue,  3 Sep 2019 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528127;
        bh=Zl6Q1JD1N7GFogmeP7CbaHh/ulm0hljSif2nM3HtHDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZqbsR+FJ7JPRT6obLmEmH8Hx2vCfIkkzYaATSfEtNRcnSKpDC/9K/oAKn5tKx1C6
         uAhPoQAqEIgyrw68BrKyVDEQkGJpf015Ni+HjoOLZa9OT6b2ti/xHPxe+GOnoPGV8F
         Xhml6sfkJCuUdyFlwJrkJtgQv593r0pnV63tbFiQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Salvatore <mike.salvatore@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 123/167] apparmor: reset pos on failure to unpack for various functions
Date:   Tue,  3 Sep 2019 12:24:35 -0400
Message-Id: <20190903162519.7136-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Salvatore <mike.salvatore@canonical.com>

[ Upstream commit 156e42996bd84eccb6acf319f19ce0cb140d00e3 ]

Each function that manipulates the aa_ext struct should reset it's "pos"
member on failure. This ensures that, on failure, no changes are made to
the state of the aa_ext struct.

There are paths were elements are optional and the error path is
used to indicate the optional element is not present. This means
instead of just aborting on error the unpack stream can become
unsynchronized on optional elements, if using one of the affected
functions.

Cc: stable@vger.kernel.org
Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_unpack.c | 40 +++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 088ea2ac85706..612f737cee836 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -223,16 +223,21 @@ static void *kvmemdup(const void *src, size_t len)
 static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
 {
 	size_t size = 0;
+	void *pos = e->pos;
 
 	if (!inbounds(e, sizeof(u16)))
-		return 0;
+		goto fail;
 	size = le16_to_cpu(get_unaligned((__le16 *) e->pos));
 	e->pos += sizeof(__le16);
 	if (!inbounds(e, size))
-		return 0;
+		goto fail;
 	*chunk = e->pos;
 	e->pos += size;
 	return size;
+
+fail:
+	e->pos = pos;
+	return 0;
 }
 
 /* unpack control byte */
@@ -294,49 +299,66 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 
 static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
 {
+	void *pos = e->pos;
+
 	if (unpack_nameX(e, AA_U32, name)) {
 		if (!inbounds(e, sizeof(u32)))
-			return 0;
+			goto fail;
 		if (data)
 			*data = le32_to_cpu(get_unaligned((__le32 *) e->pos));
 		e->pos += sizeof(u32);
 		return 1;
 	}
+
+fail:
+	e->pos = pos;
 	return 0;
 }
 
 static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
 {
+	void *pos = e->pos;
+
 	if (unpack_nameX(e, AA_U64, name)) {
 		if (!inbounds(e, sizeof(u64)))
-			return 0;
+			goto fail;
 		if (data)
 			*data = le64_to_cpu(get_unaligned((__le64 *) e->pos));
 		e->pos += sizeof(u64);
 		return 1;
 	}
+
+fail:
+	e->pos = pos;
 	return 0;
 }
 
 static size_t unpack_array(struct aa_ext *e, const char *name)
 {
+	void *pos = e->pos;
+
 	if (unpack_nameX(e, AA_ARRAY, name)) {
 		int size;
 		if (!inbounds(e, sizeof(u16)))
-			return 0;
+			goto fail;
 		size = (int)le16_to_cpu(get_unaligned((__le16 *) e->pos));
 		e->pos += sizeof(u16);
 		return size;
 	}
+
+fail:
+	e->pos = pos;
 	return 0;
 }
 
 static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
 {
+	void *pos = e->pos;
+
 	if (unpack_nameX(e, AA_BLOB, name)) {
 		u32 size;
 		if (!inbounds(e, sizeof(u32)))
-			return 0;
+			goto fail;
 		size = le32_to_cpu(get_unaligned((__le32 *) e->pos));
 		e->pos += sizeof(u32);
 		if (inbounds(e, (size_t) size)) {
@@ -345,6 +367,9 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
 			return size;
 		}
 	}
+
+fail:
+	e->pos = pos;
 	return 0;
 }
 
@@ -361,9 +386,10 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
 			if (src_str[size - 1] != 0)
 				goto fail;
 			*string = src_str;
+
+			return size;
 		}
 	}
-	return size;
 
 fail:
 	e->pos = pos;
-- 
2.20.1

