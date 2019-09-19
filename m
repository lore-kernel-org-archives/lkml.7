Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCCC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E6C21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930794;
	bh=Qj6yfDBqKHzLQaT4wcSlVzsU+H4/+9A4VO5md+egf9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vglQ2MlUIe4s+D8dlmO1wzYdgQOKSf4omaV3ADdBl+JjHBiiGD8A45+Kz8pXis1ko
	 VL2qaiKtKlYrKoFtrNC2w9xAVZgNiMZoF9XvlmgwXJtIwd2rqReWNIbCIfPAdwg882
	 yQpzlPwxxibgRC1ptyPQzzWGNHTkh5ozaEXQxHM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405227AbfISWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405198AbfISWGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91ED21924;
        Thu, 19 Sep 2019 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930784;
        bh=Qj6yfDBqKHzLQaT4wcSlVzsU+H4/+9A4VO5md+egf9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzIWJp4GwfZ0zObqTak4gj/9+ERUcWXAlBO740fliXTIa4+/TVMxrFEqLxTpceH3L
         6KcN4w7Z+Pmdg+PnosRZrEZMa6XiibUiUptUKSa8lxCV713vIE7NCu6oZjd+Z804wS
         eZXgmkHJh7D70lJYQIpJ9umqrrjbNQSOv2HtIlt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.2 005/124] netfilter: nf_flow_table: set default timeout after successful insertion
Date:   Fri, 20 Sep 2019 00:01:33 +0200
Message-Id: <20190919214819.390675371@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 110e48725db6262f260f10727d0fb2d3d25895e4 upstream.

Set up the default timeout for this new entry otherwise the garbage
collector might quickly remove it right after the flowtable insertion.

Fixes: ac2a66665e23 ("netfilter: add generic flow table infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_flow_table_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -218,7 +218,7 @@ int flow_offload_add(struct nf_flowtable
 		return err;
 	}
 
-	flow->timeout = (u32)jiffies;
+	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(flow_offload_add);


