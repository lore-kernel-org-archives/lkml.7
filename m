Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73056C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA221582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522128;
	bh=nMJBTNqfc6009iVO2daAnnAIfdD07+2dKXOtxebiMQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwEv6XewewF3uAQNb11j8niiCiXAHcIQx4lDxCTgoHbdJp+NL6Pv2xe+VP9TtE4r7
	 1zfSHj4iZKePyO7YIucI6IyjRlnVkPfuP38gSTZtza9W0b3hnasV6VOMenXl1ykoM8
	 mzfe6Sfiss9du4/3vLjiZ1CfapXzpF8EjKEAmUOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfLPSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfLPRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12A6206D3;
        Mon, 16 Dec 2019 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518840;
        bh=nMJBTNqfc6009iVO2daAnnAIfdD07+2dKXOtxebiMQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ci6HvfdK2pCliNUvQ9JlyZxFSYaSgIaJjEcgGXgGMBzOZhmKINtiICUixHqnNA3Rt
         UNniNkpNlbbHZIkIu9IU67IqbNdekksdqQC9JEZOUjcJu4ei/ChJW4kC8D1BCmO59s
         f3wbcfte8e2L+bAj1b8Baa7W9j7bonkc1NYmTo9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 088/267] net/x25: fix called/calling length calculation in x25_parse_address_block
Date:   Mon, 16 Dec 2019 18:46:54 +0100
Message-Id: <20191216174857.864004482@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit d449ba3d581ed29f751a59792fdc775572c66904 ]

The length of the called and calling address was not calculated
correctly (BCD encoding).

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 1b830a6ee3ff6..6e7ad4c6f83c8 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -100,7 +100,7 @@ int x25_parse_address_block(struct sk_buff *skb,
 	}
 
 	len = *skb->data;
-	needed = 1 + (len >> 4) + (len & 0x0f);
+	needed = 1 + ((len >> 4) + (len & 0x0f) + 1) / 2;
 
 	if (!pskb_may_pull(skb, needed)) {
 		/* packet is too short to hold the addresses it claims
-- 
2.20.1



