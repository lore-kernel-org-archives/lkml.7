Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9986C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414243;
	bh=1qfMnoDYcwbqDkqd/c83WzWuq5bNBCQi62m86kibzyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/4nbXvZWJhqVg5HJ9feQ5wtezkDhqBmVFm9H5m9YeVeH0XXQMsPLk/skGNdUPJdk
	 KhEcotvA6maXmZl8npk/pLmURteov683RzhKnsupWYnUM0fMNQJ4wod7egU80eS8Nl
	 bABrDxBPoSGbsveOMAzMRyHN2NL6Iq9u9yYo3JRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfCLSKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfCLRLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:51 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020412171F;
        Tue, 12 Mar 2019 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410711;
        bh=1qfMnoDYcwbqDkqd/c83WzWuq5bNBCQi62m86kibzyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpKhFWGHpBcd4+9TTKIqWPCSJEBPhOBfv6vI2AfM0XYlJ8V5zucHGseOHMmcDedha
         vgsc0+1tslu0wqt7mOu+CFEWCMA4D0XrC74N3RmqkPPcl9p/+aGDn2f59LXd4Saggb
         VHuBPJiGjtT3LssqcDYcBvH8f/ab4siTpUNrDMLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 016/171] ipvs: Fix signed integer overflow when setsockopt timeout
Date:   Tue, 12 Mar 2019 10:06:36 -0700
Message-Id: <20190312170349.326036954@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 53ab60baa1ac4f20b080a22c13b77b6373922fd7 ]

There is a UBSAN bug report as below:
UBSAN: Undefined behaviour in net/netfilter/ipvs/ip_vs_ctl.c:2227:21
signed integer overflow:
-2147483647 * 1000 cannot be represented in type 'int'

Reproduce program:
	#include <stdio.h>
	#include <sys/types.h>
	#include <sys/socket.h>

	#define IPPROTO_IP 0
	#define IPPROTO_RAW 255

	#define IP_VS_BASE_CTL		(64+1024+64)
	#define IP_VS_SO_SET_TIMEOUT	(IP_VS_BASE_CTL+10)

	/* The argument to IP_VS_SO_GET_TIMEOUT */
	struct ipvs_timeout_t {
		int tcp_timeout;
		int tcp_fin_timeout;
		int udp_timeout;
	};

	int main() {
		int ret = -1;
		int sockfd = -1;
		struct ipvs_timeout_t to;

		sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
		if (sockfd == -1) {
			printf("socket init error\n");
			return -1;
		}

		to.tcp_timeout = -2147483647;
		to.tcp_fin_timeout = -2147483647;
		to.udp_timeout = -2147483647;

		ret = setsockopt(sockfd,
				 IPPROTO_IP,
				 IP_VS_SO_SET_TIMEOUT,
				 (char *)(&to),
				 sizeof(to));

		printf("setsockopt return %d\n", ret);
		return ret;
	}

Return -EINVAL if the timeout value is negative or max than 'INT_MAX / HZ'.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 432141f04af3..7d6318664eb2 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2220,6 +2220,18 @@ static int ip_vs_set_timeout(struct netns_ipvs *ipvs, struct ip_vs_timeout_user
 		  u->tcp_fin_timeout,
 		  u->udp_timeout);
 
+#ifdef CONFIG_IP_VS_PROTO_TCP
+	if (u->tcp_timeout < 0 || u->tcp_timeout > (INT_MAX / HZ) ||
+	    u->tcp_fin_timeout < 0 || u->tcp_fin_timeout > (INT_MAX / HZ)) {
+		return -EINVAL;
+	}
+#endif
+
+#ifdef CONFIG_IP_VS_PROTO_UDP
+	if (u->udp_timeout < 0 || u->udp_timeout > (INT_MAX / HZ))
+		return -EINVAL;
+#endif
+
 #ifdef CONFIG_IP_VS_PROTO_TCP
 	if (u->tcp_timeout) {
 		pd = ip_vs_proto_data_get(ipvs, IPPROTO_TCP);
-- 
2.19.1



