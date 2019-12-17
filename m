Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7BDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FE921775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613825;
	bh=hCfYOICVQJtSmvDtFvD4zB7rBm7v96AeRD9UugTEBwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQFS+rxMg0DRiIJfk1CmZjygHw7LBnnkkfljAyty7kYiBvUmsUGsuQv6kGFsJUrhL
	 KmglxD1HSGPXDEWH4oXHmfiWCw/hcycKC8d0RvrjgeW2R2SLHeHsqzaabZ7xrPXXoL
	 I8YcugvSuobYczfh6ooyJXYJ3hqd9EG3d3b5+Ogs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfLQURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfLQUQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:16:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930572465E;
        Tue, 17 Dec 2019 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613817;
        bh=hCfYOICVQJtSmvDtFvD4zB7rBm7v96AeRD9UugTEBwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqTRl3hzxu2CE1bR8izRHptT35uhtvapgrg8NbttfHeWb67s8FXlA26nz/qPcMmjk
         JXd0S94wdQNXV+YCyHDBGb/2ON3cDlt8V/V51L/ww3dC4Crv+f+3hfPNPhlfdj2o9V
         jTosB6DUC9Ptf3IS5Xd5doLFAS2B0Oq+LtEtHjwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 19/25] gre: refetch erspan header from skb->data after pskb_may_pull()
Date:   Tue, 17 Dec 2019 21:16:18 +0100
Message-Id: <20191217200910.543887598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200903.179327435@linuxfoundation.org>
References: <20191217200903.179327435@linuxfoundation.org>
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
 


