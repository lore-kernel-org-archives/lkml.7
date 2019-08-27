Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C53CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E5D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfH0O5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:57:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43150 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfH0O5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:57:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so19123551wrn.10;
        Tue, 27 Aug 2019 07:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvEPr1RejdJcArk0JuQ0BvTz3mnW7VjcSQ9A8+TvCng=;
        b=CViWfmKu0bJ+Kc73uCKualpLZLpxvKojpIvyGCYDZQo7rrJgA+QS9RJbvuJjFyAPWs
         M46uIVCWZJTLp5CyNhRGGqnA+68BQsXjlNveoLthWo74YMo/w38RxHYT3F+pwewI2Sdw
         XBQsQe1wrfAJNqmGbktnUXG0ivWaJU4/RTlRCg7Qk3ZjmgoY+g2vtBZdN/qqdS4iehpe
         vyLIxoRoVcUYpwm3/7iV3yyfmYm4VLYp4t8ab6Q78eHLihq0VgZyvsnByG8UelOkvNCM
         V9GlLBdhLHVUvAPTH+Pt6T76AEg5FBBLCsU0x45w3kdr3GV/gs/THetXpqOUmhnvBep9
         4Stw==
X-Gm-Message-State: APjAAAWwGfPZ3lHteLlpOj46v6S+S+Lu1sC7ZiaXAdXY3QnSjtxWf4e2
        x17kI1CBRNjz6Jaf5GBw+ng=
X-Google-Smtp-Source: APXvYqxzlpI575hNzrknnrku7dGrijsWDeRPrBK1DDYjyPemll2x6k+dzGsy/B3g2+ewbGR4oqUCwQ==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr30722637wrt.294.1566917856792;
        Tue, 27 Aug 2019 07:57:36 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id 16sm4347527wmx.45.2019.08.27.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 07:57:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/dtc: Simplify condition in get_node_by_path
Date:   Tue, 27 Aug 2019 17:57:27 +0300
Message-Id: <20190827145727.16791-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlen && strprefixeq check in get_node_by_path is
excessive, since strlen is checked in strprefixeq macro
internally. Thus, 'strlen(child->name) == p-path'
conjunct duplicates after macro expansion and could
be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/dtc/livetree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 0c039993953a..032df5878ccc 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -526,8 +526,7 @@ struct node *get_node_by_path(struct node *tree, const char *path)
 	p = strchr(path, '/');
 
 	for_each_child(tree, child) {
-		if (p && (strlen(child->name) == p-path) &&
-		    strprefixeq(path, p - path, child->name))
+		if (p && strprefixeq(path, p - path, child->name))
 			return get_node_by_path(child, p+1);
 		else if (!p && streq(path, child->name))
 			return child;
-- 
2.21.0

