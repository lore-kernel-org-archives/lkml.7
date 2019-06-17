Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B14208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq8DdlBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfFQPu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:50:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43746 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfFQPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:50:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so4248031plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQ6QeGRRwWpLQqcLyIgK5BRWjkN7YKs7Jyn+T3KU9nA=;
        b=Fq8DdlBrF03jhPDYG0pss5OnBdYYhk3qiKfxgrtoJKAZ0OhtMQpnKTRQo85CMOPEV1
         YokavXCe5BEJad2n3xc3F1yBy6ADyyNZD2hM/YbKBbwc0sTEFV0inhchm8/k3CU79N2g
         bv2kw7CF8Iry5oYKahMVIriaEd6sETYdlsbRjtHs4JRGwFQzcUjLayrAcrf8IVFfC90d
         4bK7yOxZ1aDhayshz7uyA0yoLHnBqBg1APmjeCNjJ1KE5+EyFXQAtjTt0RosoFvXZmr1
         Ui2RLFNd8GiYoR6eEpj79QAAz1rs9hybUg//Nv5R4RSpXQ5DSqR4xCCl9ewCk4fba5GB
         KnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQ6QeGRRwWpLQqcLyIgK5BRWjkN7YKs7Jyn+T3KU9nA=;
        b=ekuU+3c0oji5Nq1JqgN+XKLngqFpDu5/zG6XIq2o+HY4pbvFE7f9zubHzFNq28Xaso
         bfOxxX/sboJzE0nIvJDfQeE/vqH+HaWk1lcPXbAGBXjNYRWPRMRLr6v03a82lEw8mt+E
         yqYx0IyXxrMXmNJa3LsEiI2RG9G5jfoSMZwNj37qfzW++QFIB6pUdxQfDXpfWT6VW/su
         fuouDhwELG3fAlbN8n7nWobznpk6tzLBGvCqrzuLuc8AulCEOIhQTmj3EtkBOcj38Gwb
         jiQPEMhvsmwyG1VxfZPiWfrP6qpduDzB05ve8ah3DlRk4/nSdXfsC58NKFb6+I1jgVOp
         14wA==
X-Gm-Message-State: APjAAAUVjjxU+vjtgp0cR9CuQ09ATneoEBXNUabAAFaHsnqqnm6kgzHy
        8VPMIMmp61D98c34377PAYUD
X-Google-Smtp-Source: APXvYqx0N7SKT7isauDwfe9f+VsvEdgvY9+gJTbRIvT8GbAMvhmKnl3qZ6FpjSaVY5WIbppfQps1nA==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr28861348plo.1.1560786654595;
        Mon, 17 Jun 2019 08:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id n2sm11023603pff.104.2019.06.17.08.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:50:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Mon, 17 Jun 2019 21:20:11 +0530
Message-Id: <20190617155011.15376-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for ATC260x PMIC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 11d6937c4688..57112194cd90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2646,6 +2646,15 @@ S:	Supported
 F:	Documentation/aoe/
 F:	drivers/block/aoe/
 
+ATC260X PMIC MFD DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+S:	Maintained
+L:	linux-actions@lists.infradead.org
+F:	Documentation/devicetree/bindings/mfd/atc260x.txt
+F:	include/linux/mfd/atc260x/*
+F:	drivers/mfd/atc260*
+F:	drivers/regulator/atc260x-regulator.c
+
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 W:	https://github.com/AlbanBedel/linux
-- 
2.17.1

