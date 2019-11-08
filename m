Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86116C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54837222C6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240070;
	bh=+f5fV1K5SfaR6N41ceXQ6zF7T0/XN+l1jzOcTOiNBzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7eGQ7zO8GsaQ00iU4ur/CHK53461XR1T8pmVx7iJbx67V15Ik1a4zT578bHSmZcq
	 vwrU4PYoT/NDKASZZ7jTgdo8T5XcjDyb3jmpN2c6DOzpUBXYgioRhSw0cObx8L32qw
	 w+78g3dLFpTOQOXloAwQfcw1HGFtxOVlSAwF3S9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbfKHTHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390951AbfKHTHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE792196F;
        Fri,  8 Nov 2019 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240058;
        bh=+f5fV1K5SfaR6N41ceXQ6zF7T0/XN+l1jzOcTOiNBzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tcc3Wxj/8N8OPmshwW5hEujXctSpTLizCwfFrfJJMQ7BchLHjbmZ8+COwDQO2tsrA
         0Y/8NVBu6/C311Ciu/ZX5n74MSyjztdKU2W9aaZ86Q7G5lWxam4aaD22O21XGDfBaj
         e4ey7PJ1TRa7m2g+6Giq7bRtGldekKGKuGBXWYfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 032/140] ASoC: simple_card_utils.h: Fix potential multiple redefinition error
Date:   Fri,  8 Nov 2019 19:49:20 +0100
Message-Id: <20191108174906.376128216@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit af6219590b541418d3192e9bfa03989834ca0e78 ]

asoc_simple_debug_info and asoc_simple_debug_dai must be static
otherwise we might a compilation error if the compiler decides
not to inline the given function.

Fixes: 0580dde59438686d ("ASoC: simple-card-utils: add asoc_simple_debug_info()")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20191009153615.32105-3-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/simple_card_utils.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 985a5f583de4c..31f76b6abf712 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -135,9 +135,9 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			       struct link_info *li);
 
 #ifdef DEBUG
-inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
-				  char *name,
-				  struct asoc_simple_dai *dai)
+static inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
+					 char *name,
+					 struct asoc_simple_dai *dai)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 
@@ -167,7 +167,7 @@ inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
 		dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));
 }
 
-inline void asoc_simple_debug_info(struct asoc_simple_priv *priv)
+static inline void asoc_simple_debug_info(struct asoc_simple_priv *priv)
 {
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device *dev = simple_priv_to_dev(priv);
-- 
2.20.1



