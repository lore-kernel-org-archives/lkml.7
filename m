Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4472192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138340;
	bh=VvjjKs/iG+ZAMpvXj8liykJfi7sELcewc5sC3K9xtNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KCIZrARFmctV5DliR9y5N732+xd8RbriKinbjNz8oskA9/W8c/kD+zIi5hh0UenoR
	 /Mq7NYgH/MbU52OBIPndklVDYpgBUiIcpxmj/kUBx7CdbAZ1mVwMmuu/gV45OeScHD
	 mowgLWV/4n+MrQfLDN6Les0SJW6DAxAMVWEMYWSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfDARFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642F72192B;
        Mon,  1 Apr 2019 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138336;
        bh=VvjjKs/iG+ZAMpvXj8liykJfi7sELcewc5sC3K9xtNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znft6oIJxiVOdE2qkNdOhOTpVUMVTlveK+stxiWXhzBEoM/kfilef1kFYgfcg6IyX
         ZXoYzTrnzpT+uwGN1awT2Q3zCbcASm5Swv1nS6Pv2CRhMIZvdo/NyDDaPuH06oQCMo
         nWGRafRHGT8iVcNXGZkgRpLesq2zzrsFcqEOhJQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 035/146] ila: Fix rhashtable walker list corruption
Date:   Mon,  1 Apr 2019 19:00:47 +0200
Message-Id: <20190401170051.476704193@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit b5f9bd15b88563b55a99ed588416881367a0ce5f ]

ila_xlat_nl_cmd_flush uses rhashtable walkers allocated from the
stack but it never frees them.  This corrupts the walker list of
the hash table.

This patch fixes it.

Reported-by: syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com
Fixes: b6e71bdebb12 ("ila: Flush netlink command to clear xlat...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ila/ila_xlat.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -420,6 +420,7 @@ int ila_xlat_nl_cmd_flush(struct sk_buff
 
 done:
 	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 	return ret;
 }
 


