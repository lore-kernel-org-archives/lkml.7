Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CBD20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050071;
	bh=JbJqeOia4R7QHIFHKqpUuAcYzNZYojxlNLepwDpmHPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAgjRSjL6Qw3xstdZnmJ+Gk5dA/76Xhvs+6enX52ZA5HDMVEuS9SLr0SH7nfYcq2C
	 jwMZugr0MUW8+a+J0ckdBoROxlCEZ/5Fzf6jAZLhSVNIj1HDZUp2yaxSkk8/wDZq+E
	 kO/duetNWuUC3yVH/1bvqES6NwL7N2ZfBQbHlclc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfCHNBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbfCHNBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:01:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA66214AE;
        Fri,  8 Mar 2019 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050065;
        bh=JbJqeOia4R7QHIFHKqpUuAcYzNZYojxlNLepwDpmHPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac75dO+r7dhju5LsJgEGuhKVZL0KoJDigUOEnod35oF89yFARS5TZeU96X6/pSLcT
         mLiXON5TuooHQlo0JR17VPJUpSg9lSpbAgipbLWGtB1VuTYluuvNQAZu7ysnJUBOK1
         hojUeDBC4USQgwq6z6OtD9v/dM4vz+W4Qk8S3PAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Nazarov <s-nazarov@yandex.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 43/68] net: avoid use IPCB in cipso_v4_error
Date:   Fri,  8 Mar 2019 13:50:13 +0100
Message-Id: <20190308124912.820469319@linuxfoundation.org>
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

[ Upstream commit 3da1ed7ac398f34fff1694017a07054d69c5f5c5 ]

Extract IP options in cipso_v4_error and use __icmp_send.

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip.h      |    2 ++
 net/ipv4/cipso_ipv4.c |   17 +++++++++++++++--
 net/ipv4/ip_options.c |   22 +++++++++++++++++-----
 3 files changed, 34 insertions(+), 7 deletions(-)

--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -638,6 +638,8 @@ static inline int ip_options_echo(struct
 }
 
 void ip_options_fragment(struct sk_buff *skb);
+int __ip_options_compile(struct net *net, struct ip_options *opt,
+			 struct sk_buff *skb, __be32 *info);
 int ip_options_compile(struct net *net, struct ip_options *opt,
 		       struct sk_buff *skb);
 int ip_options_get(struct net *net, struct ip_options_rcu **optp,
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1736,13 +1736,26 @@ validate_return:
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+	unsigned char optbuf[sizeof(struct ip_options) + 40];
+	struct ip_options *opt = (struct ip_options *)optbuf;
+
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
 		return;
 
+	/*
+	 * We might be called above the IP layer,
+	 * so we can not use icmp_send and IPCB here.
+	 */
+
+	memset(opt, 0, sizeof(struct ip_options));
+	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
+		return;
+
 	if (gateway)
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
 	else
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
 }
 
 /**
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -251,8 +251,9 @@ static void spec_dst_fill(__be32 *spec_d
  * If opt == NULL, then skb->data should point to IP header.
  */
 
-int ip_options_compile(struct net *net,
-		       struct ip_options *opt, struct sk_buff *skb)
+int __ip_options_compile(struct net *net,
+			 struct ip_options *opt, struct sk_buff *skb,
+			 __be32 *info)
 {
 	__be32 spec_dst = htonl(INADDR_ANY);
 	unsigned char *pp_ptr = NULL;
@@ -468,11 +469,22 @@ eol:
 		return 0;
 
 error:
-	if (skb) {
-		icmp_send(skb, ICMP_PARAMETERPROB, 0, htonl((pp_ptr-iph)<<24));
-	}
+	if (info)
+		*info = htonl((pp_ptr-iph)<<24);
 	return -EINVAL;
 }
+
+int ip_options_compile(struct net *net,
+		       struct ip_options *opt, struct sk_buff *skb)
+{
+	int ret;
+	__be32 info;
+
+	ret = __ip_options_compile(net, opt, skb, &info);
+	if (ret != 0 && skb)
+		icmp_send(skb, ICMP_PARAMETERPROB, 0, info);
+	return ret;
+}
 EXPORT_SYMBOL(ip_options_compile);
 
 /*


