Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB1C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30D222469
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610228;
	bh=AxvpmB2Sb0ryC9UrYM1Dehg4vu0x0EADb0FbcdB7REY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXiy6cs1ocxgqoiaVqmsVT0FsLlHZmLRWx7qsXJUQr48B6kzQBBJYviEnqdHYTkqH
	 0nElc0xp6MicFVI0KUqGMgfZHGIszzeL0zUil6rC+/v5ChbLSv5Xabm/O9Ggb0BqeK
	 gvyl3q/hTYkcjViPQBTRw9SiRpluyd5DhiqhMqOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfKMB5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbfKMB5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96A42247C;
        Wed, 13 Nov 2019 01:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610224;
        bh=AxvpmB2Sb0ryC9UrYM1Dehg4vu0x0EADb0FbcdB7REY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzHtAv5vwMiRz/4o6uBUpjArcJV2bkVuVDP5deO48JrAUs+KqON6f7RweECWxNu44
         TFZFeAntHgPH7Vg2AtEJ8T0g1jpKj50r4eYCSNzvxjKpU7H+FcAKuQOi81gYKzpyqp
         F7bA1cdwA8zWqU4FDDOM1fYFEQL9KUwnPVUW2cE0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 029/115] cxgb4: Use proper enum in cxgb4_dcb_handle_fw_update
Date:   Tue, 12 Nov 2019 20:54:56 -0500
Message-Id: <20191113015622.11592-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 3b0b8f0d9a259f6a428af63e7a77547325f8e081 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:303:7: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                         ? CXGB4_DCB_STATE_FW_ALLSYNCED
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:304:7: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                         : CXGB4_DCB_STATE_FW_INCOMPLETE);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

Use the equivalent value of the expected type to silence Clang while
resulting in no functional change.

CXGB4_DCB_STATE_FW_INCOMPLETE = CXGB4_DCB_INPUT_FW_INCOMPLETE = 2
CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
index 6ee2ed30626bf..306b4b3206168 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
@@ -266,8 +266,8 @@ void cxgb4_dcb_handle_fw_update(struct adapter *adap,
 		enum cxgb4_dcb_state_input input =
 			((pcmd->u.dcb.control.all_syncd_pkd &
 			  FW_PORT_CMD_ALL_SYNCD_F)
-			 ? CXGB4_DCB_STATE_FW_ALLSYNCED
-			 : CXGB4_DCB_STATE_FW_INCOMPLETE);
+			 ? CXGB4_DCB_INPUT_FW_ALLSYNCED
+			 : CXGB4_DCB_INPUT_FW_INCOMPLETE);
 
 		if (dcb->dcb_version != FW_PORT_DCB_VER_UNKNOWN) {
 			dcb_running_version = FW_PORT_CMD_DCB_VERSION_G(
-- 
2.20.1

