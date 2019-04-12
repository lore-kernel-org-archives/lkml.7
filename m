Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF49C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9821D2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDLODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:03:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32930 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDLOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:02:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so12161103wrp.0;
        Fri, 12 Apr 2019 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGutn05r3RCwlxSmIgzQEdijw1vqla2hH3wvCFybbtM=;
        b=WZzy/GeZtWF5oOa8G5QI+FONLPnRUWBoJxnEpThLEbk+uvbUXWtP8O2bpVpxlojNsH
         czqufv2AhUxvTOM35UN3xo7e3Jv3Tr4Den/9hmJRQbxVQSIz5PRS86PJ/PvaG6ZJzuiK
         tvUkpV8jgNqc6QOA2XHx5JiSG5HUi9b25X1PPOAYeegzSE9VejDTLO13dFSTaj1UUGaG
         dtKif66lcDB8rEhcwwN9LSV8/GnMd1OdvYDwLjQmoT6q5gcY6+LW3WRkrcsFZNV79Zwq
         PzIXmPqqUmFwbIXebrDGVs0KdYPvWyqzlXMQcR0X55N/09G8Ts+Lxe/RwflWhj1tXQuo
         +G9g==
X-Gm-Message-State: APjAAAVoBk1+Dkn5KnM/23Qnopr49L6yMHLlp6lJnWjYfD9BbnAkGDwD
        HUPojLHWD7lA4cLEtdz89w==
X-Google-Smtp-Source: APXvYqzZ/PWCCUl/f16I5V/o9PTpglxSelPI8zO1l0l3uKP5esyVA/MGe4sI+Qg8Yq39bxE7igLemw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr26139085wrn.287.1555077770728;
        Fri, 12 Apr 2019 07:02:50 -0700 (PDT)
Received: from box.eng.vmware.com ([146.247.46.5])
        by smtp.gmail.com with ESMTPSA id v184sm15883788wma.6.2019.04.12.07.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:02:50 -0700 (PDT)
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        slavomir.kaslev@gmail.com
Subject: [PATCH 1/2] splice.2: Note EAGAIN can occur when called on nonblocking file descriptors
Date:   Fri, 12 Apr 2019 17:02:46 +0300
Message-Id: <20190412140247.9897-2-kaslevs@vmware.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190412140247.9897-1-kaslevs@vmware.com>
References: <20190412140247.9897-1-kaslevs@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Slavomir Kaslev <kaslevs@vmware.com>
---
 man2/splice.2 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man2/splice.2 b/man2/splice.2
index 57988d9d6..af3fa4e74 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -155,7 +155,9 @@ is set to indicate the error.
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
 was specified in
-.IR flags ,
+.IR flags
+or one of the file descriptors had been marked as nonblocking
+.RB ( O_NONBLOCK ) ,
 and the operation would block.
 .TP
 .B EBADF
-- 
2.19.1

