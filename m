Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB99C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5C216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934070;
	bh=+jbEHoRMbIXuhVgFYSzXSCUQlXLd7RQ1Ml+khcrYIA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kTIyfqFMMlxjszXih+v4zp2nCJAuc1KbipWQtzFP/11NdzQ/+DRe+xuFn1HbXt1IL
	 rm5ZfyaJ34FI3YBJiZPSoycSyYf7PDHMLBXcOCQa96t46HZhCnTlhWQJ/it+iMFnL+
	 2+3+7QNqLpHjIaYky1zGP14qM+RzaZBXNJVmVods=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfGLMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfGLMVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:21:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C63208E4;
        Fri, 12 Jul 2019 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934064;
        bh=+jbEHoRMbIXuhVgFYSzXSCUQlXLd7RQ1Ml+khcrYIA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Def7mTM/pZ6O53YPsGntGKHP+FlS3h2N/Z7qWtlSGqE7dufOTOvtEgfmlbV6jSTR5
         IOwvak5e6glYfics/DRndYc2exZNqRKavTaKvNxUuEqM9HqPVlWum2hky0DPPoGh+i
         SwV8mKvDl8KiAFTIk90Z0jfeahgkEGK15F46nY+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/91] mlxsw: spectrum: Disallow prio-tagged packets when PVID is removed
Date:   Fri, 12 Jul 2019 14:18:36 +0200
Message-Id: <20190712121623.142955586@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4b14cc313f076c37b646cee06a85f0db59cf216c ]

When PVID is removed from a bridge port, the Linux bridge drops both
untagged and prio-tagged packets. Align mlxsw with this behavior.

Fixes: 148f472da5db ("mlxsw: reg: Add the Switch Port Acceptable Frame Types register")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 6e8b619b769b..aee58b3892f2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -877,7 +877,7 @@ static inline void mlxsw_reg_spaft_pack(char *payload, u8 local_port,
 	MLXSW_REG_ZERO(spaft, payload);
 	mlxsw_reg_spaft_local_port_set(payload, local_port);
 	mlxsw_reg_spaft_allow_untagged_set(payload, allow_untagged);
-	mlxsw_reg_spaft_allow_prio_tagged_set(payload, true);
+	mlxsw_reg_spaft_allow_prio_tagged_set(payload, allow_untagged);
 	mlxsw_reg_spaft_allow_tagged_set(payload, true);
 }
 
-- 
2.20.1



