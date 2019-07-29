Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71491C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389B12070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431075;
	bh=oASsB072sO8Vktt5avwqFjlABXb9tIqM172ZMFlph3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGvYDxXW5OUhZ8mXM4WsBJ2G6P9bRPy+glHS+bzFwM7aJWUBLba003N51ztFgquOQ
	 4TgBQxXUp3PP4ZWOGY0oNGA+9ViMdLA3zgMgPocE/aPY3Mtxkz+Z8StT4RHzC86dqg
	 WvEEC/9rj1dAsDkjYfIiEleLf7cNh0Qs/vtaNjdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfG2Tdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbfG2Tdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6446E2171F;
        Mon, 29 Jul 2019 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428812;
        bh=oASsB072sO8Vktt5avwqFjlABXb9tIqM172ZMFlph3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5figC83G0Yqr2PE8oGtydGXS9uEm646ihK7UT/AnAbUQGCM22MJQgVRecaHB5vkr
         XrvYrHizvXZ5+Smof4p7hgl/nniD4ILDaGdSyCQ2tyCJsaobsTbIvru3QE4ssTYuXA
         /CZNkKMSKWQIfPYknGGxADOqgXXHvk/0/FtbelBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 195/293] macsec: fix checksumming after decryption
Date:   Mon, 29 Jul 2019 21:21:26 +0200
Message-Id: <20190729190839.404725751@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Steinmetz <ast@domdv.de>

[ Upstream commit 7d8b16b9facb0dd81d1469808dd9a575fa1d525a ]

Fix checksumming after decryption.

Signed-off-by: Andreas Steinmetz <ast@domdv.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -865,6 +865,7 @@ static void macsec_reset_skb(struct sk_b
 
 static void macsec_finalize_skb(struct sk_buff *skb, u8 icv_len, u8 hdr_len)
 {
+	skb->ip_summed = CHECKSUM_NONE;
 	memmove(skb->data + hdr_len, skb->data, 2 * ETH_ALEN);
 	skb_pull(skb, hdr_len);
 	pskb_trim_unique(skb, skb->len - icv_len);


