Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21545217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909700;
	bh=Yv57S6M8AFqu2q8SN0uJQdADdTUO5n3ahE1W2XhhRDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keDEBapqFZgGijM7KmyQQL1zwmVwP1ihX0LCetmcQVwE0bcorJV1hg8BZpgkRle7S
	 4cM5ixgQ5NF1+Ec1qBFJyoAtdHk88HFB4irTAkEjWl7K4bLGKpMdNi4ggKD7/su4Xm
	 pRm+sOSBCaX4GF18h0tT/zYz62l40EcxgCRm/EdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfC3Be6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732201AbfC3Bb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF76218D3;
        Sat, 30 Mar 2019 01:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909517;
        bh=Yv57S6M8AFqu2q8SN0uJQdADdTUO5n3ahE1W2XhhRDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jasyPbxnT1VJ2OeU/XTADPAESZZsaotGYw3bTTt/IWqiGdw6gTQDzxk4eVUP5zNSl
         tXJgyjeJwQAbRcqjQz9VfW75AkrvubnNfqEWtqKQnFhlS/5MSI+wFRYq8h2hjZ0WY7
         LGKIX+FyYFTz8lifiCY4tTZvOWloQWB8hlZzOH88=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/21] lib/div64.c: off by one in shift
Date:   Fri, 29 Mar 2019 21:31:11 -0400
Message-Id: <20190330013112.784-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013112.784-1-sashal@kernel.org>
References: <20190330013112.784-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislaw Gruszka <sgruszka@redhat.com>

[ Upstream commit cdc94a37493135e355dfc0b0e086d84e3eadb50d ]

fls counts bits starting from 1 to 32 (returns 0 for zero argument).  If
we add 1 we shift right one bit more and loose precision from divisor,
what cause function incorect results with some numbers.

Corrected code was tested in user-space, see bugzilla:
   https://bugzilla.kernel.org/show_bug.cgi?id=202391

Link: http://lkml.kernel.org/r/1548686944-11891-1-git-send-email-sgruszka@redhat.com
Fixes: 658716d19f8f ("div64_u64(): improve precision on 32bit platforms")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Reported-by: Siarhei Volkau <lis8215@gmail.com>
Tested-by: Siarhei Volkau <lis8215@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/div64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/div64.c b/lib/div64.c
index 7f345259c32f..c1c1a4c36dd5 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -102,7 +102,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 		quot = div_u64_rem(dividend, divisor, &rem32);
 		*remainder = rem32;
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
@@ -140,7 +140,7 @@ u64 div64_u64(u64 dividend, u64 divisor)
 	if (high == 0) {
 		quot = div_u64(dividend, divisor);
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
-- 
2.19.1

