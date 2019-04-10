Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA75C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE8C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKL7Oqmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDJE4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:56:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43013 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfDJE4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:56:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so627555oig.10;
        Tue, 09 Apr 2019 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e1oTTTbc8Zv5PaumEJe83CUhLMR8cAa6lx+83BabJWQ=;
        b=aKL7OqmdustUnBl9kUtURscCkBvoCrWRdc8x2tyxT5TrymdcsmclyIT00RtdIewAnw
         FXNYsY93/Tzrf2tTnSsU4lVNSaf4HCIFzsg+NkdZU+0ldG1/HHgYvz9nEIw5LgMCpMhX
         pzwsPgjq0zBLVL95vDOf/CUxRWmg0q7j7+y23zzcMfiCbovaIkcY3Awwag76saoHSuAj
         0IPWfOMO3zQaDryffSbe1wcPUF3/4DHhcvC/fMBlshCfYcdUI84WRXvqEQxCNrYkWhtT
         oOKYLaQq0TJuA+4an39M0gZHe7Oz6Jgsp/FTNFSTjkaRSQijVRrVJAwLfLnv6UEJIbvv
         DMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e1oTTTbc8Zv5PaumEJe83CUhLMR8cAa6lx+83BabJWQ=;
        b=tPIcLmterHme31xX2GqH9VFwK9tzEf6gkW61w1DQGESjSjVwO1Nr+Jz9HRIRY5tdMk
         cn/FQGJ+J5aLS3O5JRj9wgH4qF+SSv48P39FrkM8JHfBNS8r21LFTed89KMuAPLnGE/V
         9c/TSINsV4opBovqB8uTZVkv8Y+oS9lzXlR52dwoN2myjcbTyg/lp8h/Wzn+PgR4xD93
         TER5BRLShsQiR8+sEehCQ2mTgxVDEDsv/dgG2nUnVcJylO6+0SGdwDn/Cva4IQRcUU5r
         wtr5O+nBMMNKXmvXK8dfRexGZaHD1KQoLCJzdr/3QeQ3L0WAS/3xcIc+HZWPcP+tweyT
         +GLg==
X-Gm-Message-State: APjAAAXy52b/iBub2R+5zjXNQ7h1mbs8QzjEdb3gJzPz3w58uLx1p3sW
        V/fq1Jvaz8JRoGBz1oSzTKiziVJSaCg=
X-Google-Smtp-Source: APXvYqwJOFI2a/3wI+Pp/d8ue1/D7R27iyUr8ARbiQuf390JvnoNg6QdTWpAAIssbhuEUmev6QEdew==
X-Received: by 2002:aca:f3c6:: with SMTP id r189mr1254718oih.53.1554872209690;
        Tue, 09 Apr 2019 21:56:49 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:e870:a9aa:1c0f:9617])
        by smtp.gmail.com with ESMTPSA id x89sm16495321ota.30.2019.04.09.21.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:56:48 -0700 (PDT)
From:   Andy Gross <andygro@gmail.com>
X-Google-Original-From: Andy Gross <agross@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH] MAINTAINERS: Update email for Qualcomm SoC maintainer
Date:   Tue,  9 Apr 2019 23:56:44 -0500
Message-Id: <1554872204-9026-1-git-send-email-agross@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the email for Andy Gross to agross@kernel.org.

Signed-off-by: Andy Gross <agross@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..cf39fb06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1984,7 +1984,7 @@ W:	http://www.armlinux.org.uk/
 S:	Maintained
 
 ARM/QUALCOMM SUPPORT
-M:	Andy Gross <andy.gross@linaro.org>
+M:	Andy Gross <agross@kernel.org>
 M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.7.4

