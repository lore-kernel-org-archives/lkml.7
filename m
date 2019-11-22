Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423120656
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419742;
	bh=AxvpmB2Sb0ryC9UrYM1Dehg4vu0x0EADb0FbcdB7REY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGtJiPZjpwHHJmXuYPxtBI830Pa9C68DAQTUuXm6YgKJRIijp1l0VwJ9agLTNcSFZ
	 oSu2BFZuHNPSh+O+364YdANE8ICuYvsnd/Bx/gXrCugnd6XQUidNGgu2zZnp9CERiX
	 BMcic9LulJqTVsXaFeRuXum6clzO1qT9kGcAGLsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfKVKtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfKVKs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F32A20637;
        Fri, 22 Nov 2019 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419736;
        bh=AxvpmB2Sb0ryC9UrYM1Dehg4vu0x0EADb0FbcdB7REY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mtv48C7EkqBoqE+SUIgypkEiJcy40+TFuovMfJ5BqIAROJF0S9r1QiYMiLE/4YTMd
         cVS4S36nJQNnOsVGdLtvgk8kG6NGq42u6e+5igoHel+PPQlEFJlxynB+owQraPo1oh
         qdI2y9W4Yhe9s4brJ/LrGcf50DvGEY4e/At/bHK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 170/222] cxgb4: Use proper enum in cxgb4_dcb_handle_fw_update
Date:   Fri, 22 Nov 2019 11:28:30 +0100
Message-Id: <20191122100914.788565461@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



