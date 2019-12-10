Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542FDC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E5B2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMseXGCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLJIPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:15:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36959 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfLJIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:15:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so8667454pfm.4;
        Tue, 10 Dec 2019 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z3QbUuDM9pE9qovJUQv76vaNeMVWJZJGqPPOIl/DJQI=;
        b=ZMseXGCEq9sa+yPcP2XWg92cr3R3iGN9k1fDhp7lI6V0LwLtB3w3Cy+jxmk649eiix
         iNFBxBOM5jKfJfLjF/3Z40j2S+MjPkWaeJIloYsrNVJE4/W5PrR3/G/3Jxb6+cN0CXfT
         x9d2UxJtneL3B7Fk9ARSMRQJqE+aPEKhx3Czn2JWuhW3KvyqR0tKSpJITG28Q2ivb74z
         V+HamfhYBarUxAGXI6BxuybqrAvBUiQoqQhwElSOEcBaNtxzvszpDoYu0aipuYkbsHVP
         N9Vr2lYojKA/lhOMH2EM22fvsZSpq7NTF4IdegHk+8+ZA8fKj9t6vDsokzrtkxoX85o9
         F2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z3QbUuDM9pE9qovJUQv76vaNeMVWJZJGqPPOIl/DJQI=;
        b=G0QHcPykocOfzMrHdFUk0g2qx3NttNXSM45lfT/MitnAmSJgFzL2aBZmW7GmhjoARJ
         59v9vPVA32w3UW+HNJGkPdeDd0g9EJoi9BTexyOHBKn7eN0wPA3Pyw5uJF7/R/dk+InY
         FMuJHZTjdYlLuQAmLnNHgaBbyyBuozO8A1Lm1oClK9xqF+CilXl8YK+EUEfP/si3KIg0
         dZ8TvU0WDxe+utoFtpcOsZcFMS4fwUc58UYD7jPL/zFqtqi1ddBCiW5gJtQLzLy0oRcx
         IJ+0cSwcVQawaGOuGf0u1DooNEueelLo0zwOSNDfENoIh53STKwg12fDMFLpHs77sJgn
         O13Q==
X-Gm-Message-State: APjAAAXc3HPdQwvcTJVXkFhjEnJjIdASwkzn32Nqo5jVHU7IvtoTGB1U
        X0efmEfnvlAk4RcGxyX8YeQ974Dr
X-Google-Smtp-Source: APXvYqz9cKrg+5oW8XT1VLh+qOPLCiLe9LUKA3h4M93l/m87W87mkm6J1JfCtWcZAaTjl9/J/ZD6SQ==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr23237968pgp.121.1575965704620;
        Tue, 10 Dec 2019 00:15:04 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:90a:7900:1572:c35d:e9db:e357])
        by smtp.gmail.com with ESMTPSA id q12sm2136741pfh.158.2019.12.10.00.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:15:04 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: refcount leak when phandle_cache entry replaced
Date:   Tue, 10 Dec 2019 02:14:53 -0600
Message-Id: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

of_find_node_by_phandle() does not do an of_node_put() of the existing
node in a phandle cache entry when that node is replaced by a new node.

Reported-by: Rob Herring <robh+dt@kernel.org>
Fixes: b8a9ac1a5b99 ("of: of_node_get()/of_node_put() nodes held in phandle cache")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Checkpatch will warn about a line over 80 characters.  Let me know
if that bothers you.

 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index db7fbc0c0893..b57a57752294 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1261,6 +1261,8 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 			if (np->phandle == handle &&
 			    !of_node_check_flag(np, OF_DETACHED)) {
 				if (phandle_cache) {
+					if (phandle_cache[masked_handle])
+						of_node_put(phandle_cache[masked_handle]);
 					/* will put when removed from cache */
 					of_node_get(np);
 					phandle_cache[masked_handle] = np;
-- 
Frank Rowand <frank.rowand@sony.com>

