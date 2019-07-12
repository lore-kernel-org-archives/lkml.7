Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40841C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8612166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934292;
	bh=hOKXLOrtNFOb/GmQlkG2DFICOr/oDnmKtqy0JV8Jau8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTGJosB0q9SzBetrDcHjXWu4H/LpcGxrclBoCvJ3DQMvU/N8cux3pHsExORRIyCJ4
	 Fc4WMuKBUxB8JI9xwa1TS4+QR81u6ZdDPGPRNJP6ae+fVet9EWRtZpF7zUmu5Ggklu
	 5vTu9i9NCr6pumONsFp3TuHW8A1mEbrze26R+jdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfGLMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfGLMYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:24:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E7121019;
        Fri, 12 Jul 2019 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934286;
        bh=hOKXLOrtNFOb/GmQlkG2DFICOr/oDnmKtqy0JV8Jau8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTkUaOQmhAchf8xbSl4n8nZxnKbOW+Pg2dDt0bOhAfb+y/d2gFqwfhfx0aJvhlzbu
         PE0AxAoeg041rlXgC1+SonKgAu/ymBTaLq9PcrTSIQcJsB68UHgNnb2ikOdxkDbTRX
         PnEXN3vcsDu+qj5DCf5GMiWu2JjtP1dFhBpC1ojY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/91] net: dsa: mv88e6xxx: fix shift of FID bits in mv88e6185_g1_vtu_loadpurge()
Date:   Fri, 12 Jul 2019 14:18:56 +0200
Message-Id: <20190712121624.511422728@linuxfoundation.org>
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

[ Upstream commit 48620e341659f6e4b978ec229f6944dabe6df709 ]

The comment is correct, but the code ends up moving the bits four
places too far, into the VTUOp field.

Fixes: 11ea809f1a74 (net: dsa: mv88e6xxx: support 256 databases)
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/global1_vtu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_vtu.c b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
index 058326924f3e..7a6667e0b9f9 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_vtu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
@@ -419,7 +419,7 @@ int mv88e6185_g1_vtu_loadpurge(struct mv88e6xxx_chip *chip,
 		 * VTU DBNum[7:4] are located in VTU Operation 11:8
 		 */
 		op |= entry->fid & 0x000f;
-		op |= (entry->fid & 0x00f0) << 8;
+		op |= (entry->fid & 0x00f0) << 4;
 	}
 
 	return mv88e6xxx_g1_vtu_op(chip, op);
-- 
2.20.1



