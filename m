Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC2C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B2120449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811587;
	bh=2gKEp1sdKEAeZm6GB/BYbziVeiU8R9/8+F7dhe6csOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggMOgM8zoX3TlAw1ZI1CQboirItmPCNdLtuidrPkSnBg4ZWAOfAobDSQkhIBpEwu7
	 YG7bGxVL153ljM8lYklj5AAxUF1euWzw/KWIhr2TTGtfgUl82k5Z0wNNSC8vX9JZfC
	 TCxfWtnPw0LYMXGQJgSmqkFT8ZnUz6Xfi5zyNBqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfEBP3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfEBP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:29:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF7D20B7C;
        Thu,  2 May 2019 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810969;
        bh=2gKEp1sdKEAeZm6GB/BYbziVeiU8R9/8+F7dhe6csOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOksPB/ZemnYmMbCUJHmIcEGlcWYVrC732eRk2eUN2I8Kv5jCCMar0wAsUjG43Izh
         Wqx0FPa27HX/xS1GRsl+ocqA/mqVmx+ZRCSyBuKjJ1jK7zAJNxefCesiiequI4c9R/
         PDFEOCO6HleNhqWaMRvNUH/0gU20F7GyUU/Ebzew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 025/101] netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
Date:   Thu,  2 May 2019 17:20:27 +0200
Message-Id: <20190502143341.459702817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d1fa381033eb718df5c602f64b6e88676138dfc6 ]

With NETFILTER_XT_TARGET_TEE=y and IP6_NF_IPTABLES=m, we get a link
error when referencing the NF_DUP_IPV6 module:

net/netfilter/xt_TEE.o: In function `tee_tg6':
xt_TEE.c:(.text+0x14): undefined reference to `nf_dup_ipv6'

The problem here is the 'select NF_DUP_IPV6 if IP6_NF_IPTABLES'
that forces NF_DUP_IPV6 to be =m as well rather than setting it
to =y as was intended here. Adding a soft dependency on
IP6_NF_IPTABLES avoids that broken configuration.

Fixes: 5d400a4933e8 ("netfilter: Kconfig: Change select IPv6 dependencies")
Cc: Máté Eckl <ecklm94@gmail.com>
Cc: Taehee Yoo <ap420073@gmail.com>
Link: https://patchwork.ozlabs.org/patch/999498/
Link: https://lore.kernel.org/patchwork/patch/960062/
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/netfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index beb3a69ce1d4..0f0e5806bf77 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -995,6 +995,7 @@ config NETFILTER_XT_TARGET_TEE
 	depends on NETFILTER_ADVANCED
 	depends on IPV6 || IPV6=n
 	depends on !NF_CONNTRACK || NF_CONNTRACK
+	depends on IP6_NF_IPTABLES || !IP6_NF_IPTABLES
 	select NF_DUP_IPV4
 	select NF_DUP_IPV6 if IP6_NF_IPTABLES
 	---help---
-- 
2.19.1



