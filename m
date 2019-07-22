Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88998C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962F21993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="DIJf1MDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfGVJgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:36:15 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:41724 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfGVJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:36:14 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9F3E62E0DE0;
        Mon, 22 Jul 2019 12:36:11 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id j01G7HEpSm-aB5ajCCf;
        Mon, 22 Jul 2019 12:36:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563788171; bh=lwrou0ge1fASn3VFBYr42gXUSv9B+Mk8b6WwMg4i5lM=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=DIJf1MDRS9k2nQaZ1DgVQQtOdHcWYktPONyBemWBggu9EEvRAg6Ds8yKgaBx5Dv6W
         sGFFBF2U1e2JvDzUAUEP/9sFGmg5kQO55TsEkZv26H6df3OseRxvm+jBfIpXKmXZ3k
         kC14yyhFJf0AahFHsm9tMubKphNZg5HHcbYzOwtU=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AdNDBXcM8x-aBAq2o3D;
        Mon, 22 Jul 2019 12:36:11 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] mm/filemap: rewrite mapping_needs_writeback in less
 fancy manner
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 22 Jul 2019 12:36:10 +0300
Message-ID: <156378817069.1087.1302816672037672488.stgit@buzz>
In-Reply-To: <156378816804.1087.8607636317907921438.stgit@buzz>
References: <156378816804.1087.8607636317907921438.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This actually checks that writeback is needed or in progress.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d9572593e5c7..29f503ffd70b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -618,10 +618,13 @@ int filemap_fdatawait_keep_errors(struct address_space *mapping)
 }
 EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 
+/* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-	return (!dax_mapping(mapping) && mapping->nrpages) ||
-	    (dax_mapping(mapping) && mapping->nrexceptional);
+	if (dax_mapping(mapping))
+		return mapping->nrexceptional;
+
+	return mapping->nrpages;
 }
 
 int filemap_write_and_wait(struct address_space *mapping)

