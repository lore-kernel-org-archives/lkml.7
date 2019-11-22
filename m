Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A75220718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421116;
	bh=/kUxBZofQMik3Dzfcnk3DamI5JTvSzhgcjGK39WSwNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QV+UkeIItdQHcM7obVlesA4NPS8qyt9Sd+//PsrggIM0NCFLbPC8/E9gajSN7cwgr
	 tzzWYz3MtaCmMZNVbmCCoCBveDChmhlGFkH5ddqqVF55MoAeS9fFOcos6BnyyQdR58
	 mbFBxmZyp+xLOF+wIRrQ9egqzMRm1fmv8X6c4e8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfKVK6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbfKVK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:58:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1916520679;
        Fri, 22 Nov 2019 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420324;
        bh=/kUxBZofQMik3Dzfcnk3DamI5JTvSzhgcjGK39WSwNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSgJVgtbDKkRjvces4Wyqv4V23LVi1CVmSdpr5YTULQqW5ad4vEZRJghSQKFqZ8gC
         7zENd/yJvUexIClcziIWdcdfAWXb3sj0w3hWu+zvIS8bFz9cVYVmDQTKzSywuaGmiE
         i6lvt5qxyQZ+6h4a3uEPh5Hfx40bMTKFGvUlsyFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/220] cxgb4: Use proper enum in IEEE_FAUX_SYNC
Date:   Fri, 22 Nov 2019 11:27:11 +0100
Message-Id: <20191122100916.877422284@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 258b6d141878530ba1f8fc44db683822389de914 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:390:4: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                        IEEE_FAUX_SYNC(dev, dcb);
                        ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h:70:10: note: expanded
from macro 'IEEE_FAUX_SYNC'
                                            CXGB4_DCB_STATE_FW_ALLSYNCED);
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the equivalent value of the expected type to silence Clang while
resulting in no functional change.

CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
index 02040b99c78a0..484ee82900903 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
@@ -67,7 +67,7 @@
 	do { \
 		if ((__dcb)->dcb_version == FW_PORT_DCB_VER_IEEE) \
 			cxgb4_dcb_state_fsm((__dev), \
-					    CXGB4_DCB_STATE_FW_ALLSYNCED); \
+					    CXGB4_DCB_INPUT_FW_ALLSYNCED); \
 	} while (0)
 
 /* States we can be in for a port's Data Center Bridging.
-- 
2.20.1



