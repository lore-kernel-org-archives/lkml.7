Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C890C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1538920835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCGJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:34:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:34:36 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MoNMu-1ghsoJ3rnU-00ooKz; Thu, 07 Mar 2019 10:34:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Edward Cree <ecree@solarflare.com>,
        Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ethtool: reduce stack usage with clang
Date:   Thu,  7 Mar 2019 10:33:35 +0100
Message-Id: <20190307093408.3425010-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AQpBvpTMTgac1mdMpFa68Lz1u6kxqu97sFrs8yO6CwxOrNdBXns
 i/3zDpfANmMIprACgJ+yPHpsW1CGj6Y+P4K8Y/2THNtw0KtDONsteWf0jojs3oOMcvx5i8s
 nI5JW+5Hbn4Ea7wMX2BVy1DzwRvZeQK5CR5SctNhC2DnWJPRK0AJilmHcTeOYHuouqKUX6/
 I8J6H2OUZp5oAC9i976dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vf7fJ+tdSZs=:U4l4hbGT3tBEvxywEgqRL3
 H0lqeQIac/dDlOb4IVkmaz/qQCURstV0nRmbsqBK9EXCImDiNWUXeBwyQuS7X/NgE2W37TjWU
 GRjyDtOBlnAWEw6ZkscfZLyxFUPd5GooHR+uBUhJWVwgUmsiBJGL6TsFkU4g2uowiCIdG0CgA
 W6YfVamEhxWM3i8l0qC+/euCQjfuLXbZbRe7oWP2j0ULU7tJzRCj7ISpiR98KSmHhTLGrd1ZJ
 SHbDnUB2NzaNUlFSY7uIJOrBqXTmQ8ffxWDCpHz1UTXpUvS98YICElgQ9gLBR4sfZFeteNjM4
 2oGtX/scpBfOrcosa7k51tnmosVS8WsjimG33Pg36aBR3gy5A8qGAK7Fe5M+QIE6yC/C1F3Bd
 g/pFbqlihpLppVwxf/gS6AD7NiqtC3KxcHDhrgsv4zsVat1scbCQfM5yR3aXZEr36PDP3Tvah
 +fX0kvi+fZ/WAXehyAjIlfI2i069JpiiKKxzhmBlHrZ7NDeYHgTRFJnytN9jFEaGk9dPucbAh
 /iymthgKeYQIm9rovL+hw1UvJCl9fM7biSzqsT1tkFX/jwyWRbjA31pUyafzRw5zVeosTNovq
 pyMyqjYkppHLqGPhbljHXbszv59Y9Qh5BWppDXboYv8h1DkZQixbIwywTxKOfaDeuML7fnVhW
 IWCQH6JBc5owJ/EqUsBXNX+v3MtrllcFPgv9Q7QsE5Ln7NINiz3dAo2U9F4QKFJ1b+qgJHYao
 UYDTKcOxJxBABebWw3gK2WXhcav2zp05pcknVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang inlines the dev_ethtool() more aggressively than gcc does, leading
to a larger amount of used stack space:

net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]

Marking the sub-functions that require the most stack space as
noinline_for_stack gives us reasonable behavior on all compilers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index d4918ffddda8..fcbed78172a0 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2319,9 +2319,10 @@ static int ethtool_set_tunable(struct net_device *dev, void __user *useraddr)
 	return ret;
 }
 
-static int ethtool_get_per_queue_coalesce(struct net_device *dev,
-					  void __user *useraddr,
-					  struct ethtool_per_queue_op *per_queue_opt)
+static noinline_for_stack int
+ethtool_get_per_queue_coalesce(struct net_device *dev,
+			       void __user *useraddr,
+			       struct ethtool_per_queue_op *per_queue_opt)
 {
 	u32 bit;
 	int ret;
@@ -2349,9 +2350,10 @@ static int ethtool_get_per_queue_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int ethtool_set_per_queue_coalesce(struct net_device *dev,
-					  void __user *useraddr,
-					  struct ethtool_per_queue_op *per_queue_opt)
+static noinline_for_stack int
+ethtool_set_per_queue_coalesce(struct net_device *dev,
+			       void __user *useraddr,
+			       struct ethtool_per_queue_op *per_queue_opt)
 {
 	u32 bit;
 	int i, ret = 0;
@@ -2405,7 +2407,7 @@ static int ethtool_set_per_queue_coalesce(struct net_device *dev,
 	return ret;
 }
 
-static int ethtool_set_per_queue(struct net_device *dev,
+static int noinline_for_stack ethtool_set_per_queue(struct net_device *dev,
 				 void __user *useraddr, u32 sub_cmd)
 {
 	struct ethtool_per_queue_op per_queue_opt;
@@ -2533,7 +2535,7 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
-int dev_ethtool(struct net *net, struct ifreq *ifr)
+int noinline_for_stack dev_ethtool(struct net *net, struct ifreq *ifr)
 {
 	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
 	void __user *useraddr = ifr->ifr_data;
-- 
2.20.0

