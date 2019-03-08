Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A93C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A83120661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050068;
	bh=W8l9pptwxnh/xcrzDIFbLdV3NdBidlx71W8PS0ATdk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zlbevfGPFDJmlHsUmO0K8cYcbmQ57oe6U3HWJntF5zeq2rIGOCYaAn4e2pcyhW/l+
	 3e5FDD0MBK57U9s+thFJ3tNzLqsEH3sjoLIE8YH6HfpSWJ+Xcr4gsikk1meHf1Kd/5
	 PkQ4zKSRmexBGFVyiy55MyqJ0uYeL+u/ZUUQ3wWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfCHNBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfCHNBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:01:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BC721019;
        Fri,  8 Mar 2019 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050061;
        bh=W8l9pptwxnh/xcrzDIFbLdV3NdBidlx71W8PS0ATdk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elfyY0Gj9+vO/NAbzsBBFETAN6Or+6Hus4cSTF71PcWyMrWalxBgpjGx7K2AjyT19
         whZvjjE8gYj9X1FwDI+AqIYWiw2ramESqxw/UQhae3Sa0Bn3Ag06DqFbyOxk1sO7om
         y7ZMP9qaRVeE1o4Yc63e3sWHr5Jx38iS94LdeIYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Nazarov <s-nazarov@yandex.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 42/68] net: Add __icmp_send helper.
Date:   Fri,  8 Mar 2019 13:50:12 +0100
Message-Id: <20190308124912.775441918@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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
@@ -570,7 +570,8 @@ relookup_failed:
  *			MUST reply to only the first fragment.
  */
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt)
 {
 	struct iphdr *iph;
 	int room;
@@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, i
 					  iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
+	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
 		goto out_unlock;
 
 
@@ -742,7 +743,7 @@ out_bh_enable:
 	local_bh_enable();
 out:;
 }
-EXPORT_SYMBOL(icmp_send);
+EXPORT_SYMBOL(__icmp_send);
 
 
 static void icmp_socket_deliver(struct sk_buff *skb, u32 info)


