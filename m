Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDCC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073F52145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqoOcBxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbfIEVPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:15:36 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39983 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391791AbfIEVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:36 -0400
Received: by mail-pf1-f202.google.com with SMTP id v15so2801474pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5OIWaQS8XUylUqWEOLvRcQ6wvtAGUWcmHb4qQooXQU4=;
        b=sqoOcBxZdlqGDWySWP2Y/co94HGedfimwCSXcJFCDa2CSHTgUIbVs4Pv6YfiqW989D
         qwxLXD2E6ccpMCJrXFqhjsQ8KvKmii4DOcdayDCxOPHgZnS3MYlw7VykblxC7tziuiWg
         TGPazBMqwY4jU9+ikaAjXWzQA567E4smuiqVvfBzdgaMlJPhw+KkxBjnb4RpotPIP0yv
         4To4Fb74sAf5hCcy3mrBjhnNGk5/27rRSbZnG99BZMVY57d6quzmuw/KdICvu3J8iC9a
         ndMLLbyFrE67/RIXYeSI2gDac9o0MrmV7qytiMO9xmjTphHOMt5lwQ4Jjd8n6/kFiDV6
         qRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5OIWaQS8XUylUqWEOLvRcQ6wvtAGUWcmHb4qQooXQU4=;
        b=BKxGwImCyS3oVlF7B2xb+6AM7QU9186yLgiI/g1bSZn/fv7b1Bk1mGSjh4OCViwWhp
         6nI2J/MHIN1Vpr4b77ooeCj4Exzisn8azcqHi5BYZa5oBeGSN3BMc7OT2qMYXXH60mBv
         VAIKEYW9PZqh8Kc/2edpArPobICFgpMi2EMUrSC8GqRtyhHO4Bch6o6TwzSktyDq6mfF
         2mNoo+175QV1QbyL4hpMO+qGfzW27ZIaVH95YT22sh8fKRAaje/FItygTFPvhjRXDTL9
         kxEDf+ayw61P7h4uc3PLx3v0P+Zm2Usum+zVrS8Q1Y+XVfahbDMNsyhBvj3BmcZqZ8P5
         Mq0w==
X-Gm-Message-State: APjAAAVNeXmWA+g6Jz93X8bfmjNcEucR9r1APdrvZSaKKv4llZf+0jqy
        1UKo9i1mLy45ZvwmMjtKAsqrkVB2FRmPUMHZpB8=
X-Google-Smtp-Source: APXvYqwZtsOP4oeCbgdcEYz4SC/6uGacnOnUYdFPlg0VekmO8GAS2KcyDuLyw3ItW3lkQRTZoimV43SVKTXC9aSch7E=
X-Received: by 2002:a63:2252:: with SMTP id t18mr5065062pgm.5.1567718135010;
 Thu, 05 Sep 2019 14:15:35 -0700 (PDT)
Date:   Thu,  5 Sep 2019 14:15:28 -0700
Message-Id: <20190905211528.97828-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] kcm: use BPF_PROG_RUN
From:   Sami Tolvanen <samitolvanen@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tom Herbert <tom@herbertland.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of invoking struct bpf_prog::bpf_func directly, use the
BPF_PROG_RUN macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 5dbc0c48f8cb..f350c613bd7d 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -379,7 +379,7 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct kcm_psock *psock = container_of(strp, struct kcm_psock, strp);
 	struct bpf_prog *prog = psock->bpf_prog;
 
-	return (*prog->bpf_func)(skb, prog->insnsi);
+	return BPF_PROG_RUN(prog, skb);
 }
 
 static int kcm_read_sock_done(struct strparser *strp, int err)
-- 
2.23.0.187.g17f5b7556c-goog

