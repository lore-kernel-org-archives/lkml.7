Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72096C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A62146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613451;
	bh=hCfYOICVQJtSmvDtFvD4zB7rBm7v96AeRD9UugTEBwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CbXsfxBsxOGCGO4b2KGUJaWymR6WTHSl7YkdQIyCDQkr29jbbY4x4YQ+VF4re6Gml
	 4oFIRTR8diFgvzxBEaVGxITGqaH1e4VlSc0pCr2/xOtvfg9+UKw+LkxJylVkHyo94j
	 7EntK8z8kp+pXv32e4DGPRE9zgecuN/didjZfTdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfLQUKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfLQUKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:10:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1A42146E;
        Tue, 17 Dec 2019 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613444;
        bh=hCfYOICVQJtSmvDtFvD4zB7rBm7v96AeRD9UugTEBwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8FoP6htbN91EvgdrxPsnH2ixn84KzCAr0lsQcZw4180UuG1wMqYg4iHdrQqKdELs
         kN9TwMaG2wLGSDhnifAAGhvt5hlqIrQLKMueysGVh0jTyiFeGQ8p4X0rqyo5Fwnz48
         /1428ADn9fw2rmAeTVrTWMu1KLczDJe8h7Pb26sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 23/37] gre: refetch erspan header from skb->data after pskb_may_pull()
Date:   Tue, 17 Dec 2019 21:09:44 +0100
Message-Id: <20191217200729.075022800@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 0e4940928c26527ce8f97237fef4c8a91cd34207 ]

After pskb_may_pull() we should always refetch the header
pointers from the skb->data in case it got reallocated.

In gre_parse_header(), the erspan header is still fetched
from the 'options' pointer which is fetched before
pskb_may_pull().

Found this during code review of a KMSAN bug report.

Fixes: cb73ee40b1b3 ("net: ip_gre: use erspan key field for tunnel lookup")
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Acked-by: William Tu <u9012063@gmail.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/gre_demux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -127,7 +127,7 @@ int gre_parse_header(struct sk_buff *skb
 		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr)))
 			return -EINVAL;
 
-		ershdr = (struct erspan_base_hdr *)options;
+		ershdr = (struct erspan_base_hdr *)(skb->data + nhs + hdr_len);
 		tpi->key = cpu_to_be32(get_session_id(ershdr));
 	}
 


