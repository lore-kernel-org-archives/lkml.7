Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CBC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6876020733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd0h6i2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLVUpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:45:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLVUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:45:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so14593340wrn.7;
        Sun, 22 Dec 2019 12:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=jd0h6i2kPzqp6T6LyP8cM8ysm2+shc7cXOAuM0P583EbOSPuu/aOIoHWCILDa3EvhO
         /bfLtEgqBtuuyvQpKxe8jbMPlVhy1Py2ct4N59PVta9cFf0rYryWruqSXPugzs7U9/pw
         nqicxHGhXcdvJuQCk1Sbl0J72MoRQzNRyi++/lAZ+J5G47+dYdl/Ub7+JaljBd4PAEJZ
         vWzKFUdvJPdZXYuquhYTmIy98euXaa+Tw2kvyMfWVvR94S2Qm0j+DmunhntX2f1nHUkb
         8ROCPbD33xyZZIpti537bXe8fbhVTOAOBG2mHcIrPSdjD/MWBPVRbeGeyD6iFseD1Y7d
         92/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=VbkNcEMlpS8stha7Pwdl0hUTSbyiSnrudQJOTS4iYitkdR3rcMyQnp57JjAjIcdFAd
         OqjPn0oP/Ag+O11XKppYMp/DcFQT3okv5L2BACqaj9jjJ8utnTR0e7NBerM9SaJhoN58
         jOtGbbS4XDWL+FkkYVTrldJI0OzzMYh9+H27QX9EZJk8hXfXtwotQ+2rwMfghuZ7vGB6
         MutiCJrtFLldCQW5CXCpGOCrp+jdZQK80kyfX/hWtUuvvAkXzsMCZn0gvkTYdJw4nOB8
         tquZa9XOX3erCFfT+5N8SoS+/CtIj6RTQa3g7EypYsWS0B2n/eL2rWrAE+Qohq9vT4ZT
         8q7w==
X-Gm-Message-State: APjAAAXl3cKIyGcCyMTG/k6GxupDaEl9veI/LvGHC4dp47Ya2xlbsEqL
        Za2pNTFRjPKaUK58/ja0Jl8=
X-Google-Smtp-Source: APXvYqxHsz0uCUGgQ75fpHSytbGZX/9XBpN18pCVatlt9xhusC6T5ist2wBS3DMOiJnIpKvSg3GLWw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr28218873wro.301.1577047519892;
        Sun, 22 Dec 2019 12:45:19 -0800 (PST)
Received: from localhost.localdomain (p5B3F6AB6.dip0.t-ipconnect.de. [91.63.106.182])
        by smtp.gmail.com with ESMTPSA id o4sm17603792wrx.25.2019.12.22.12.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 12:45:19 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Sun, 22 Dec 2019 21:45:04 +0100
Message-Id: <20191222204507.32413-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222204507.32413-1-sravanhome@gmail.com>
References: <20191222204507.32413-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Monolithic Power System, MPS

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..5eac9d08bfa8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -605,6 +605,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mps,.*":
+    description: Monolithic Power Systems, Inc.
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.17.1

