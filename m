Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1815C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD8218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253715;
	bh=577SNMcgFoCYXFhMezzsolYLHlAbOk5tOJnxMlCoILA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rImo4JsWGTgEC4pn7vxexH/ZaoHdabylwCIeSA6GgEjndqOaXQZXGjlEMoQeiUarg
	 pHUOJ9EM3Nj0RtUTgGimiqN+PFXbeLaABBKEUK4mSLVf2+NfoGfxMU2zpsaWjHQHRy
	 d0sp4AeoSTQoQDgRwG0IRvyxJ6i/6wZRv99NzaiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfCVLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfCVLVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BCE2192D;
        Fri, 22 Mar 2019 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253711;
        bh=577SNMcgFoCYXFhMezzsolYLHlAbOk5tOJnxMlCoILA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBlKi5akP3c7LSEHtuHL6rquN72uHAE3dQQho9L2HCihc9n55SO0prHqMtsRJblab
         XFWUDXTggrBSR3ARXbYT7yhN+9slESu1hdBQulw48SDp99RQOnOUf76mQQr0Cm6gVD
         zIi8BJakyNAIYiWIeasMPvNl5abRmlP3+EJsDyXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Nazarov <s-nazarov@yandex.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 048/134] net: Add __icmp_send helper.
Date:   Fri, 22 Mar 2019 12:14:21 +0100
Message-Id: <20190322111213.421511496@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nazarov Sergey <s-nazarov@yandex.ru>

[ Upstream commit 9ef6b42ad6fd7929dd1b6092cb02014e382c6a91 ]

Add __icmp_send function having ip_options struct parameter

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/icmp.h |    9 ++++++++-
 net/ipv4/icmp.c    |    7 ++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -22,6 +22,7 @@
 
 #include <net/inet_sock.h>
 #include <net/snmp.h>
+#include <net/ip.h>
 
 struct icmp_err {
   int		errno;
@@ -39,7 +40,13 @@ struct net_proto_family;
 struct sk_buff;
 struct net;
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt);
+static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+{
+	__icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
+}
+
 int icmp_rcv(struct sk_buff *skb);
 void icmp_err(struct sk_buff *skb, u32 info);
 int icmp_init(void);
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -541,7 +541,8 @@ relookup_failed:
  *			MUST reply to only the first fragment.
  */
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt)
 {
 	struct iphdr *iph;
 	int room;
@@ -655,7 +656,7 @@ void icmp_send(struct sk_buff *skb_in, i
 					  iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in))
+	if (__ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in, opt))
 		goto out_unlock;
 
 
@@ -707,7 +708,7 @@ out_free:
 	kfree(icmp_param);
 out:;
 }
-EXPORT_SYMBOL(icmp_send);
+EXPORT_SYMBOL(__icmp_send);
 
 
 static void icmp_socket_deliver(struct sk_buff *skb, u32 info)


