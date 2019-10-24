Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711ECCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4031021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N47NOAqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfJXU20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:28:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45708 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfJXU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:28:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so132720oti.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KysFzCyCbt68rgdhcTAXFckqnl9oeL9f+lH7yDmTZls=;
        b=N47NOAqx8rrDt9qoCU5UdnHTUtTrLtXHylMK6lUDje83HChvSmV8vO6Ks36SnZcvei
         g7WwIqc9CuBXtpHaswhmhdafpWiWcZ7ZfTLqyLtpIeiUPjzrDFxVA9QmJi8DUjq5X+Yb
         EmBmNGKY8DErUlBHRg7Wz/baoKihujPnzfs+RSDNRipTl2UVgIPmon6SwaUnzAJtwwmX
         1wf8TJNAjb0rzZALQVskFEi4yANySj1qi2/uFBBY4QAuOkWFNJYaE0JV0SQCUH2CgkK9
         guanW2vXYBX7zQYwRDPgCLfhiYLhHTVccSCxNbyxgqd3Y3qu2j67JPScel0miwVUax5i
         oblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KysFzCyCbt68rgdhcTAXFckqnl9oeL9f+lH7yDmTZls=;
        b=L05vrmu/JAsSb2s/juDNzczp4HrTihCTC7dtPmkvdw4S+u37Pc9HThpAoh47VMK9ff
         qnmVE3CETgPZn5PcCmg/c8QWqTZ2oG6g1NeSaf6WXG7bHG5gS6yueuu7ZNadhNLdfsdq
         ZDvK3Rdc5iQHf1I2Qoy18JQts71o4beulUpuvGyHTEpJ5gb6IIzQDn5yyzh3FfkDWyaT
         sTUZi6k4xYM3qEaB9QyRozar+8GmnaLCSJFxdsMQdk/nRw03MLxXo30aHeWggNgbOfOj
         Fh7qpMdVvvscJ7mRazUVZNImmIjDfAJij+a3nufui51/EUWFcREdfsbgpXUApprZ+o3C
         BpnQ==
X-Gm-Message-State: APjAAAUfa9XzvFDoM9dQlMzjVlu1rPaiY4u9RDfcZy25El/RA6o1RRo2
        FhZPB1+OVxmptcjn/iBvuGY=
X-Google-Smtp-Source: APXvYqxd/Sg0RqJm/x1OkLzHXUE9zdsuT53cXiG9gAPHJRKTgzfFCRu6o9SPuvDT7vUXP3nmSOdwOw==
X-Received: by 2002:a9d:3dca:: with SMTP id l68mr9689115otc.269.1571948904809;
        Thu, 24 Oct 2019 13:28:24 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id p184sm1101963oia.11.2019.10.24.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:28:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dm raid: Remove unnecessary negation of a shift in raid10_format_to_md_layout
Date:   Thu, 24 Oct 2019 13:28:03 -0700
Message-Id: <20191024202803.47613-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang + -Wtautological-constant-compare:

 drivers/md/dm-raid.c:619:8: warning: converting the result of '<<' to a
 boolean always evaluates to true [-Wtautological-constant-compare]
                 r = !RAID10_OFFSET;
                      ^
 drivers/md/dm-raid.c:517:28: note: expanded from macro 'RAID10_OFFSET'
 #define RAID10_OFFSET                   (1 << 16) /* stripes with data
 copies area adjacent on devices */
                                           ^
 1 warning generated.

Negating a non-zero number will always make it zero, which is the
default value of r in this function so this statement is unnecessary;
remove it so that clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/753
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/md/dm-raid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index b0aa595e4375..13fabc6779e5 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -616,7 +616,6 @@ static int raid10_format_to_md_layout(struct raid_set *rs,
 
 	} else if (algorithm == ALGORITHM_RAID10_FAR) {
 		f = copies;
-		r = !RAID10_OFFSET;
 		if (!test_bit(__CTR_FLAG_RAID10_USE_NEAR_SETS, &rs->ctr_flags))
 			r |= RAID10_USE_FAR_SETS;
 
-- 
2.24.0.rc1

