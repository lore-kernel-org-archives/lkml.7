Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACAF21744
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442648;
	bh=iRyyCRgD0EqQOFZg309FXaKqmjtdUMN+89A4I51NnUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCNDOXFv+JVtW9MQyHCAPrF1oJx1ZFq6Eg0XXRBnA+c3TAxiw1p+gJrAzvWArE98a
	 gsVbAVUGyzmJy1gjikDZkdPDafAGWxB7TNsldrS/gb8tmA2yhhgktx18gxM3qQgXzw
	 jF1KNYeI7z1mWowuO2uyYhx5E33A4w8SuIxBW55w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbfFMQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731141AbfFMIlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:41:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF12B2147A;
        Thu, 13 Jun 2019 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415263;
        bh=iRyyCRgD0EqQOFZg309FXaKqmjtdUMN+89A4I51NnUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyB6elRtbVxwFxY6QfbZ9ZZWtiu1Ojlq9DPF9SBG6XSgLc3LzwuajvtOplMHcHkny
         mcLV1qv8V75Q5ssAoeWd/fUDGBwN3JFfYAYzh1jlrYGXA6FLYi8L/iKYTA3+LSHR6Q
         t5s6mpiWcyaZO1xeG6JQc+9qb+nzZ44DP7c3lQyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/118] netfilter: nf_flow_table: fix netdev refcnt leak
Date:   Thu, 13 Jun 2019 10:33:20 +0200
Message-Id: <20190613075647.462575090@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 26a302afbe328ecb7507cae2035d938e6635131b ]

flow_offload_alloc() calls nf_route() to get a dst_entry. Internally,
nf_route() calls ip_route_output_key() that allocates a dst_entry and
holds it. So, a dst_entry should be released by dst_release() if
nf_route() is successful.

Otherwise, netns exit routine cannot be finished and the following
message is printed:

[  257.490952] unregister_netdevice: waiting for lo to become free. Usage count = 1

Fixes: ac2a66665e23 ("netfilter: add generic flow table infrastructure")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 436cc14cfc59..7f85af4c40ff 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -113,6 +113,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (ret < 0)
 		goto err_flow_add;
 
+	dst_release(route.tuple[!dir].dst);
 	return;
 
 err_flow_add:
-- 
2.20.1



