Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCRQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:35:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57661 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCRQft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:35:49 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEVFi-1hGPtR490s-00FxTQ; Mon, 18 Mar 2019 17:35:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vadim Pasternak <vadimp@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mlxsw: core: mlxsw: core: avoid -Wint-in-bool-context warning
Date:   Mon, 18 Mar 2019 17:35:11 +0100
Message-Id: <20190318163536.2171073-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c1w42up200TKqjRrYRKgUK7VltNjESreqJ1xLouMC+e16xKdPCL
 kfeA8SlqwOU88vSFl5dNJq4clnmkRFZCBr/LcNxvuYdsJrGMQBWksMR4zaDMB37X0WJhsxW
 /72pf9IcvEK+7gCsQ9MIQyVHRZDYEnhf2CP0BpWAu5pnzLoW+ChIeOrdzrZ/x5Cx9l6IAAS
 TeJg8YtVI0W8aF49P6TTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+fZ6XtPWBuU=:ameA70zY4LCt+vQyVQtj0v
 VRLcDD9U1/wppek0CFKSdWV5q0Jx2ofEdjPhG3+XiDWzQ3Dk3T9Tb0M1Dh374ezoook18X7Pk
 i7Y0yER4BvDNSzeq5o48o1g08g3AVzJ9jfFBjNOC6FmjArMpbdp92d7fSXls7GBv1ckH/sM3L
 sOCvx8SL8+oOisPrEpZrY1cpNSyi4emzJHsjJNUOf9zqMCctn1bE2Gc0F1sqTwyVxAPgii0oC
 mj9k9s8/la+Evp8IPXiFR+ydiLJc4eKz7bvJC0lXMRG64NMbPNNL7yJtr6ix3bNW8NDyZ+uRl
 fyox+DudUvi965aiETANVYDfli+v84Nl4DaCQbRiY1wFoS8rm4UlHAdOXfweWt3yNd8m/mrXA
 2WnFRfq/I0wNeQ8ZduE75rQ2eeWXg5HIqJzlai+M4waTpj2snocuGT0A/IllLuFrxPUaJnOHS
 7NCwbENz2J0Xx0nadfrdHpzP6nh0/PUbUmL+lbBrOUeJSNJNJLC7BFF1ozsPw9huS15EkbjqH
 5GBvaeOFevscbi0HT3K2bCe9QeJv2c73yyeCg4MzFRL3MG86zm2x7/P6laX2kUCIsnggDTwh5
 H/40T9lsHCOwVUzGVLQtzArXEla/Zgw/heddlsy8pMJQP7MsHmAUYg5KKwN7/8D7ANuv9fvCw
 RDNxekrlcGtSmPhuAw9NbmSasQMLiVabH546ibC3N2MV2lbx6SD0Dzq3bYDYun5CJd2oh/ubS
 pZ0kfCNZuiSw3PzGTARCQrpRBbCpJ61bnVD1YA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recently added function in mlxsw triggers a harmless compiler warning:

In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:17,
                 from drivers/net/ethernet/mellanox/mlxsw/core_env.c:7:
drivers/net/ethernet/mellanox/mlxsw/core_env.c: In function 'mlxsw_env_module_temp_thresholds_get':
drivers/net/ethernet/mellanox/mlxsw/reg.h:8015:45: error: '*' in boolean context, suggest '&&' instead [-Werror=int-in-bool-context]
 #define MLXSW_REG_MTMP_TEMP_TO_MC(val) (val * 125)
                                        ~~~~~^~~~~~
drivers/net/ethernet/mellanox/mlxsw/core_env.c:116:8: note: in expansion of macro 'MLXSW_REG_MTMP_TEMP_TO_MC'
   if (!MLXSW_REG_MTMP_TEMP_TO_MC(module_temp)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~

The warning is normally disabled, but it would be nice to enable
it to find real bugs, and there are no other known instances at
the moment.

Replace the negation with a zero-comparison, which also matches
the comment above it.

Fixes: d93c19a1d95c ("mlxsw: core: Add API for QSFP module temperature thresholds reading")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 7a15e932ed2f..c1c1965d7acc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -113,7 +113,7 @@ int mlxsw_env_module_temp_thresholds_get(struct mlxsw_core *core, int module,
 		return 0;
 	default:
 		/* Do not consider thresholds for zero temperature. */
-		if (!MLXSW_REG_MTMP_TEMP_TO_MC(module_temp)) {
+		if (MLXSW_REG_MTMP_TEMP_TO_MC(module_temp) == 0) {
 			*temp = 0;
 			return 0;
 		}
-- 
2.20.0

