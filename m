Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D31C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478E021934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256308;
	bh=/EQ2m3Fn6iZ+7ev5awngfsDUwWj1sdv/6k1e1dGIFnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAwD2jQTTav6qHGnxZrMDMASjWntJQQbPkD49VOitoatGe3WJ9nNECUD9QDVn7n37
	 jHSOg06j+nXUIMRdgxEGwbQbRFxrN4VZgysPJel+/1iIV5hapsgz7kZcKipNHimssw
	 QmVGlshfV7GMgsMyVtay1x1GSczcl6EoXX93Xzeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfCVMFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388017AbfCVMFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863622192D;
        Fri, 22 Mar 2019 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256305;
        bh=/EQ2m3Fn6iZ+7ev5awngfsDUwWj1sdv/6k1e1dGIFnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8D5sO4N68pr7v8FrhkeySw77Pm67KaRbJPzY4GuSnFzDUQkZ9zMjwnbEePSH7NVX
         BWiV1kipe9PBhbqHaB8d+POp0FWXqxQke4LzyO/LZCT4bzdO4MFBkCo97/GQoVHxJS
         zrWnAyNyZpXPEJyooRKol8TlYKypVli2upSPCXgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 147/280] netfilter: ipt_CLUSTERIP: fix warning unused variable cn
Date:   Fri, 22 Mar 2019 12:15:00 +0100
Message-Id: <20190322111319.646137658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anders Roxell <anders.roxell@linaro.org>

commit 206b8cc514d7ff2b79dd2d5ad939adc7c493f07a upstream.

When CONFIG_PROC_FS isn't set the variable cn isn't used.

net/ipv4/netfilter/ipt_CLUSTERIP.c: In function ‘clusterip_net_exit’:
net/ipv4/netfilter/ipt_CLUSTERIP.c:849:24: warning: unused variable ‘cn’ [-Wunused-variable]
  struct clusterip_net *cn = clusterip_pernet(net);
                        ^~

Rework so the variable 'cn' is declared inside "#ifdef CONFIG_PROC_FS".

Fixes: b12f7bad5ad3 ("netfilter: ipt_CLUSTERIP: remove wrong WARN_ON_ONCE in netns exit routine")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -846,9 +846,9 @@ static int clusterip_net_init(struct net
 
 static void clusterip_net_exit(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
 	struct clusterip_net *cn = clusterip_pernet(net);
 
-#ifdef CONFIG_PROC_FS
 	mutex_lock(&cn->mutex);
 	proc_remove(cn->procdir);
 	cn->procdir = NULL;


