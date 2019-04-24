Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2283C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FB6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AqgIiqZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfDXUST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:18:19 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53660 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfDXUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:18:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 7AED5B09
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 20:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9qKeqgzmauyQ for <linux-kernel@vger.kernel.org>;
        Wed, 24 Apr 2019 15:18:16 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 52916A11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:18:16 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id h10so10306895iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TP5zhNjcnR0CUD4OvsVoEgn3nWrA4rw3hht+PmVdj+w=;
        b=AqgIiqZ9FeTFAJTB2FJjm9YDgMDMjpCJVq5diL3XcvQcnH6l8s570tjOQn4+yxPJBj
         CJwTrLbcCZ2SgtDEoD6qSmM73sDK0Q3p5HBA6y6uOZNND+lUuWma3wPxlHsx80Ot36Do
         9Z27mc6XXYArfsAbVS1oB+CwM3XiW7kWneAhBK+/AQhh3dFu4FjDGl5eMt+1v9KN+PXy
         EUayeGVqI8LlUi336HLVGByGt7QUWVGsrzi/izxqK0s5WXBgBCyImu4WUSE2jhFs0Ssx
         dxZ1z2xrTuSRrFxMhOBjBE/3RVg+Maz50KWYcTOUPwlUaPdYpxv8gMSiKMP6aIYcYT1X
         3M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TP5zhNjcnR0CUD4OvsVoEgn3nWrA4rw3hht+PmVdj+w=;
        b=WVIZXltC3b9AW3F+FU/paKyLvymX8BarPkZo7IVyIG74OKBr421zqzAQ/ljODPOVU/
         zI0SZFBHGGEwf9WB/HS08ccoMdLx22e9gRn6CKHbtpvL7d+LqSyTSXIsejufzvMFSWQj
         muPu9uIkeeMIltLElrE6Ut7fqmdTc7mq0E22TCCfHMwDHnczFSHy+N0x8atYchSG1KIP
         SkA440PBoWa9YUog0jme2QM3EJ+pb3b3i6lzDCAhaqaVZpYEl8DToAfIdVoX1vR9eK5a
         WryV8lTIIjlwwASBY1wrQRU8rV3A86wf8zmAStOMRwMFMkbTPYdPf0JRcbJaZVNftxFu
         FqmA==
X-Gm-Message-State: APjAAAUlU2ne68xospR28OCWbbZaShUymYRzKXhJic7yZpZWhp7U2r5V
        Xb4tZQ72TsmFERIJYJu1GRs/mHN3o3Ig2DH68zbbtfHJBvuRgW2oT9ur56qCBOmfLYveAXPMhgg
        Bt3Pb2+8rgwupPpnEEMW0AWAsacNL
X-Received: by 2002:a6b:b989:: with SMTP id j131mr8189872iof.131.1556137096035;
        Wed, 24 Apr 2019 13:18:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqUVgcpiqq4oQTw5rIo5vF0loDzlwcos5oDxhiB++4IZVZflyBA8zWahWmQAOoWHs7S292qw==
X-Received: by 2002:a6b:b989:: with SMTP id j131mr8189865iof.131.1556137095860;
        Wed, 24 Apr 2019 13:18:15 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id n15sm6747844ioa.26.2019.04.24.13.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 13:18:15 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:NETWORKING [TLS]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: tls: fix a memory leak bug
Date:   Wed, 24 Apr 2019 15:18:07 -0500
Message-Id: <1556137087-25814-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In decrypt_internal(), a memory block 'mem' is allocated through kmalloc()
to hold aead_req, sgin[], sgout[], aad, and iv. This memory block should be
freed after it is used, before this function is returned. However, if the
return value of the function invocation of tls_do_decryption() is
-EINPROGRESS, this memory block is actually not freed, which is a memory
leak bug.

To fix this issue, free the allocated block before the error code
-EINPROGRESS is returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/tls/tls_sw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index b50ced8..22445bb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1445,8 +1445,10 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 	/* Prepare and submit AEAD request */
 	err = tls_do_decryption(sk, skb, sgin, sgout, iv,
 				data_len, aead_req, async);
-	if (err == -EINPROGRESS)
+	if (err == -EINPROGRESS) {
+		kfree(mem);
 		return err;
+	}
 
 	/* Release the pages in case iov was mapped to pages */
 	for (; pages > 0; pages--)
-- 
2.7.4

