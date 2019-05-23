Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD235C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FD12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639578;
	bh=njsC8n90n/Z/6nJoHRNDj+F2HxIz3+0tFEfPFcd6L6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qzkv1mTaTUSrCi/v9tZ+GxMyJ5NHiz6zufsVc6HKiICHoetH7dc78zYGgjvgVMg7
	 oMsbnwUyDuA3gbYTHtL6PVT6nf6/w41DAwzpRrjE9MR++rZP0aZL0sE8FD9DvrYDwD
	 x/JwTAaFC/VSuf3N9Yi505f/mtXIHzgzu6uUCyNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfEWT0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbfEWT0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892A920868;
        Thu, 23 May 2019 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639573;
        bh=njsC8n90n/Z/6nJoHRNDj+F2HxIz3+0tFEfPFcd6L6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCXrniPtxTtDT4JLhztHkPuBpkNPFpRHcTfGsh98y4L1qVWi/EEG+6KXhF9YFb35j
         d7TBGqqgXQ1IkNZG+I/K7IsyhHetrDCyezamWIf3iY9CKrPwrmd8T31z7TK7IxxsK3
         UIu33nSngTp85l5o2Nreay3Pr5+iQF0NzyvpAxQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 015/122] mlxsw: core: Prevent reading unsupported slave address from SFP EEPROM
Date:   Thu, 23 May 2019 21:05:37 +0200
Message-Id: <20190523181706.933832080@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit f1436c8036fa3632b2ee78841cf5184b7ef0ad87 ]

Prevent reading unsupported slave address from SFP EEPROM by testing
Diagnostic Monitoring Type byte in EEPROM. Read only page zero of
EEPROM, in case this byte is zero.

If some SFP transceiver does not support Digital Optical Monitoring
(DOM), reading SFP EEPROM slave address 0x51 could return an error.
Availability of DOM support is verified by reading from zero page
Diagnostic Monitoring Type byte describing how diagnostic monitoring is
implemented by transceiver. If bit 6 of this byte is set, it indicates
that digital diagnostic monitoring has been implemented. Otherwise it is
not and transceiver could fail to reply to transaction for slave address
0x51 [1010001X (A2h)], which is used to access measurements page.

Such issue has been observed when reading cable MCP2M00-xxxx,
MCP7F00-xxxx, and few others.

Fixes: 2ea109039cd3 ("mlxsw: spectrum: Add support for access cable info via ethtool")
Fixes: 4400081b631a ("mlxsw: spectrum: Fix EEPROM access in case of SFP/SFP+")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/err.h>
+#include <linux/sfp.h>
 
 #include "core.h"
 #include "core_env.h"
@@ -162,7 +163,7 @@ int mlxsw_env_get_module_info(struct mlx
 {
 	u8 module_info[MLXSW_REG_MCIA_EEPROM_MODULE_INFO_SIZE];
 	u16 offset = MLXSW_REG_MCIA_EEPROM_MODULE_INFO_SIZE;
-	u8 module_rev_id, module_id;
+	u8 module_rev_id, module_id, diag_mon;
 	unsigned int read_size;
 	int err;
 
@@ -195,8 +196,21 @@ int mlxsw_env_get_module_info(struct mlx
 		}
 		break;
 	case MLXSW_REG_MCIA_EEPROM_MODULE_INFO_ID_SFP:
+		/* Verify if transceiver provides diagnostic monitoring page */
+		err = mlxsw_env_query_module_eeprom(mlxsw_core, module,
+						    SFP_DIAGMON, 1, &diag_mon,
+						    &read_size);
+		if (err)
+			return err;
+
+		if (read_size < 1)
+			return -EIO;
+
 		modinfo->type       = ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		if (diag_mon)
+			modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		else
+			modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN / 2;
 		break;
 	default:
 		return -EINVAL;


