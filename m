Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902D9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F180208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfFSM46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:56:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:56:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Md6dH-1iCdyW161r-00aBCA; Wed, 19 Jun 2019 14:56:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Vijay Khemka <vijaykhemka@fb.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: fix probe error handling
Date:   Wed, 19 Jun 2019 14:56:23 +0200
Message-Id: <20190619125636.1109665-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZJwSOzQMuPpHsrU/+qvC0BE/4HBT6tcQ0i6nWWwdFMZI7Lp37LT
 EhDuHwiX9TgKYWtK3bytwlf9alSchNSd3HIu3+i2ShJqPpZF0IycKFhDZRLr5nSzcurUU8s
 TTlggu2/kKjAzmi0JMsgLMKJmUrck9PseSduRgPAZEBfkRhQNKngF+cstswdqnsCwYfUOtC
 DYfjeGhgOkWZQRKdeV1CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LGDpA5YzoUY=:XTDjw9epM4xTzibkdByj5K
 GhIoK1yF82OWjpMeOzQgnmeVnkx98/kU1pZTERJCdJi9xsYO1rzx9v4BHyw5hNVXMy/hoCMmg
 R8ZUvFbo6ALJY8qcu7O5sAM029mTaKymbN4tbNjRxpFH09r/9tst6rkT/62mTG1X0CaIHbqI3
 3NDJMvWo9oGLsuysv9X4bzP9Ohdb1IPgcYF81bZjPJ5Jlvk7UR9kul0VZwkrWf0PoT+2fe4aH
 MJlMnX3rtqs4jmF0+rRuDvyuBggJN48PVLtQxln1U5D2RIpZ6Jab4MFQDQV7qEsJQDgreu4DZ
 yYsPkVE4zRFFgpoaHazeuL0hCbVHIuMe3osHNpKwDMmQV8PosE9SLcSWhVhM8PB7DqE1urHWI
 SeUA6A9vR3ajuhrYaJ9R/ggQqrQT/MwGZrOgQeoey0A8bRDrGMtRF9sJWkJzVs6lR+LBZ/Qd4
 Fh42eJZWNZYEmS3P1g8BeedER3edpIzzMXbxCpf/UMTBgviowSsQJs7shQ/ziyd09yYR/tfun
 NuC+QPCKou2F9BahTgQTYa+LcqCyJPLax11e2Y4nfwrpWDSSbqzbA2bqqatWpKGYyvZOG0pJM
 YFfWa4oPOTxWvC+bVAjlmbmiRPXRbMGMKEBSUKU+GMW/9c5sWM81NlPtEdifftrsH1Wuyv9bv
 lJREE0KyXnqutSAdXz7DjuUmD/K9lGRQXfkts2x5y1NJ0jP3hWiVyFq05qQ/fhd2egAL4DpIm
 RZkS4jUol5xwipOEO5zrS9SItLbZ3JG+d4LH5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns that a mising "flash" phandle node leads to undefined
behavior later:

drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The device cannot work without this node, so just error out here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 239520bb207e..81109d22af6a 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -212,6 +212,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(dev->of_node, "flash", 0);
 	if (!node) {
 		dev_dbg(dev, "Didn't find host pnor flash node\n");
+		return -ENXIO;
 	} else {
 		rc = of_address_to_resource(node, 1, &resm);
 		of_node_put(node);
-- 
2.20.0

