Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1603C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11262171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSiuXpFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfETXwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:52:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41569 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfETXwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:52:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so7542559pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rv32jzUGZV8rgVBuTpLJ3zSmM0FZYIuyjg2yFIdNHLI=;
        b=oSiuXpFilMvpyrsw1o2mAFYvPVX3B/Rh0EEHojcpJXOLf6UVF6y49QsRk9m2Wycwv4
         44kpdHm8apnauXUKYNBHt9HxsNDZMfa642EyJ314C2eMXP00V49RkWBtL2vB8/D3UhOM
         a1hg1A6P0KdYxdmEmdsOq0hN1kXrFzmc9tY0huvpBbO8JDmryqTIy40/+a90dc9T3YuS
         Yn8PgBTcuj0dIDHpb4qFGk+g5oiBO5111ygZk6vbp/fsaqJTSYK4eF4sZWY45a+ZUq5H
         AMYNhblRTarnJddVVuDNAM214dsDWE38WJNejnSYWCCWMbt3/fbMfb7DgNfL838wKNKf
         fanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rv32jzUGZV8rgVBuTpLJ3zSmM0FZYIuyjg2yFIdNHLI=;
        b=AsGuUNARAkQ+Jw0qp0ktm1MFAqvL7tAk1IbRWO5n7mExihE7SXT+ag4v5n8pearVpm
         AlyRR3ohwVeqAHi83HdaRp88ZsKT5O0sc3FfPD0rBiW+/H7/eHmTRC1gJeSjF2ZfxqhA
         3tcXsPXL11wkQsJhHmYxMviJkao1gSKgJONdmnDEuNZmu8xsj5xX5f0Jcs9tRTsmtcfb
         eRK70Na21iYC2Pwnsw+CLUcl168ERm/BP9Ic6zUfqZPK+Y8PvbdxgMcwo/QgWQjunqPe
         SOM1oY7tfqPrACxPXk8hHFIXBJGe4KqcwgZR4yEUQdL8kI3MQk++mbooauUhBhTp3iOt
         mn3w==
X-Gm-Message-State: APjAAAXRUg5D3mEy1rOAq7Gyc2YLL4jRBzOcHZkXohsTqAg41e5p3BAk
        bKpR5Z3lTtYN5cT3huXbzH1ZDw==
X-Google-Smtp-Source: APXvYqx5ch9aWV4U6k1gQ+8/Xv5QTkWCIeMLYEaqxILZxFB5um0hi/l+30SpbTbI4nPvhtDmRFQt0g==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr21113194pgc.188.1558396319858;
        Mon, 20 May 2019 16:51:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c16sm20286865pfd.99.2019.05.20.16.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:51:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Nicholas Mc Guire <hofrat@osadl.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] net: qrtr: Fix message type of outgoing packets
Date:   Mon, 20 May 2019 16:51:56 -0700
Message-Id: <20190520235156.28902-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QRTR packets has a message type in the header, which is repeated in the
control header. For control packets we therefor copy the type from
beginning of the outgoing payload and use that as message type.

For non-control messages an endianness fix introduced in v5.2-rc1 caused the
type to be 0, rather than QRTR_TYPE_DATA, causing all messages to be dropped by
the receiver. Fix this by converting and using qrtr_type, which will remain
QRTR_TYPE_DATA for non-control messages.

Fixes: 8f5e24514cbd ("net: qrtr: use protocol endiannes variable")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/qrtr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 801872a2e7aa..05fa058bee59 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -733,8 +733,8 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	struct sock *sk = sock->sk;
 	struct qrtr_node *node;
 	struct sk_buff *skb;
-	u32 type = 0;
 	size_t plen;
+	u32 type;
 	int rc;
 
 	if (msg->msg_flags & ~(MSG_DONTWAIT))
@@ -809,9 +809,9 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 		/* control messages already require the type as 'command' */
 		skb_copy_bits(skb, 0, &qrtr_type, 4);
-		type = le32_to_cpu(qrtr_type);
 	}
 
+	type = le32_to_cpu(qrtr_type);
 	rc = enqueue_fn(node, skb, type, &ipc->us, addr);
 	if (rc >= 0)
 		rc = len;
-- 
2.18.0

