Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7A1218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909551;
	bh=tKYdMALfSdq2ofZ+dNb1XIL+u6dpI9M9BDJsWvgL768=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYcHGIIitXJLFW1zpXKxj2BC/0LNcsGZpDMw193HK6EACq4MLYcZyYpN1jq3NDn9Y
	 nvfguLumfrC6pOg+QNZS+y24fSyIjChWRPN/0AXNVwrJsDH1/8Q8MDl8Fk653XPsO0
	 nQTbDxFzir1Y33H/VIRDtg79D2t0J838nDoaoJw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfC3Bc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732342AbfC3BcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:32:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D39218A6;
        Sat, 30 Mar 2019 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909544;
        bh=tKYdMALfSdq2ofZ+dNb1XIL+u6dpI9M9BDJsWvgL768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBW8RG/w71GuXdgl21y1gjnRXvMoRfOJTz74kZN+hjlTknvBXd1R14Q8IULygQSrr
         6I36/vo1C3WX6L5VHYH0HLCkQeKuW9NB2dsEl9aXv6Q5n2jUuhiG2wjH1j0n/gEb1x
         YfmhZ/JQoh+VD9fV3wIjIjM36rJAiNKgSiCc2VkU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 15/16] lib/div64.c: off by one in shift
Date:   Fri, 29 Mar 2019 21:31:59 -0400
Message-Id: <20190330013200.1130-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013200.1130-1-sashal@kernel.org>
References: <20190330013200.1130-1-sashal@kernel.org>
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
index 62a698a432bc..75b8521c2146 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -100,7 +100,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 		quot = div_u64_rem(dividend, divisor, &rem32);
 		*remainder = rem32;
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
@@ -138,7 +138,7 @@ u64 div64_u64(u64 dividend, u64 divisor)
 	if (high == 0) {
 		quot = div_u64(dividend, divisor);
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
-- 
2.19.1

