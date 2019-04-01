Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7511920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140074;
	bh=etgDwfiNsYhYDIgxsI6f9aYMQCSCRpytxD73aRkPlCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6L2I4wwYQyKoYP4LQWIyZ1brR7vXY0R2nOfQ3EizAaX5S5yV6+ia3QdTndLF20OD
	 EsG+406e+upoQ3Lm/LaqeZ39vsRidbERlUI7NNb1randGQYju2qQapeWGbaczq+FgF
	 hkrUSQjrX/toiZ9iKNjPgVQVuFdHveIdCr1eVwHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfDARed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387794AbfDAReb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3BF20830;
        Mon,  1 Apr 2019 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140070;
        bh=etgDwfiNsYhYDIgxsI6f9aYMQCSCRpytxD73aRkPlCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fI7ii+a52sNazMennSVGihhtXW1GHiL99ALyoH2806JdvXPocPl9ZaKU87kXji4zb
         kbjc0fjgkOwKhqMBUENvftCQBl6br3RA0wE+fSqL3qAlHkYg87ACXrsR8nCL30NY+w
         WZyQ4vz5DAIzoK+6t/Mqn6/76mzTVGwkE+3qt3Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 098/131] sctp: get sctphdr by offset in sctp_compute_cksum
Date:   Mon,  1 Apr 2019 19:02:48 +0200
Message-Id: <20190401170100.124171553@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 273160ffc6b993c7c91627f5a84799c66dfe4dee ]

sctp_hdr(skb) only works when skb->transport_header is set properly.

But in Netfilter, skb->transport_header for ipv6 is not guaranteed
to be right value for sctphdr. It would cause to fail to check the
checksum for sctp packets.

So fix it by using offset, which is always right in all places.

v1->v2:
  - Fix the changelog.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/checksum.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -60,7 +60,7 @@ static inline __wsum sctp_csum_combine(_
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
-	struct sctphdr *sh = sctp_hdr(skb);
+	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
         __le32 ret, old = sh->checksum;
 	const struct skb_checksum_ops ops = {
 		.update  = sctp_csum_update,


