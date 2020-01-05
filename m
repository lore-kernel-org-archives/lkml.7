Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CAC33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D8821582
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 17:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAERgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 12:36:14 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:47242 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAERgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 12:36:14 -0500
Received: from localhost.localdomain ([92.140.214.230])
        by mwinf5d49 with ME
        id mhc8210054ypjRG03hc8a8; Sun, 05 Jan 2020 18:36:11 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 05 Jan 2020 18:36:11 +0100
X-ME-IP: 92.140.214.230
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net
Cc:     osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] gtp: simplify error handling code in 'gtp_encap_enable()'
Date:   Sun,  5 Jan 2020 18:36:07 +0100
Message-Id: <20200105173607.5456-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'gtp_encap_disable_sock(sk)' handles the case where sk is NULL, so there
is no need to test it before calling the function.

This saves a few line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/gtp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ecfe26215935..1499b4a37758 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -849,8 +849,7 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 
 		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
 		if (IS_ERR(sk1u)) {
-			if (sk0)
-				gtp_encap_disable_sock(sk0);
+			gtp_encap_disable_sock(sk0);
 			return PTR_ERR(sk1u);
 		}
 	}
@@ -858,10 +857,8 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 	if (data[IFLA_GTP_ROLE]) {
 		role = nla_get_u32(data[IFLA_GTP_ROLE]);
 		if (role > GTP_ROLE_SGSN) {
-			if (sk0)
-				gtp_encap_disable_sock(sk0);
-			if (sk1u)
-				gtp_encap_disable_sock(sk1u);
+			gtp_encap_disable_sock(sk0);
+			gtp_encap_disable_sock(sk1u);
 			return -EINVAL;
 		}
 	}
-- 
2.20.1

