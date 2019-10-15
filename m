Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F4BECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEEC20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQPBccpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfJOTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:10:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38885 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389296AbfJOTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:10:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so217486wmi.3;
        Tue, 15 Oct 2019 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUvBerQddYmthJVayR0YUavvmPSsApA6rPHT7ry9gZM=;
        b=CQPBccpCjw/Sso/I1eghm8gDdbDrvw6bhKk463W434QzPsmH/EcDrwH5OjhZgnD85q
         T979D8d+4CXOBqNJUM+WwpZdgiD0jqvwxuJLKTDtvf14rf4EKtMZN9s76jmm+BhGN8QV
         JcolqoGCKfGCJMy4tjp7dWc3rsP2kY6Rh4hGk604EgvTKQC+I74h//Fa3MSsvwweztxD
         +zDgOwHK6PStVZPGrPh2EPP/XkHhCIOzVTnvFAi2MQG3ZtkQMeCmzjnGj7+iRIQyYK2h
         +23Ndauj8wLvqom7LpzbhcDP4Y8r4OSdIbE+c+DNKJhDUyPmt6IUMdCL48noVtMa1UA9
         jsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iUvBerQddYmthJVayR0YUavvmPSsApA6rPHT7ry9gZM=;
        b=jhteDrqmb4nuWkkQcWhQiQDmJ3t73AOtxzJzKQwgpaCZRIu30kdn5SB6mNVfsvNtkr
         9LeLbIQqHkWlWI9BiH27piEXaYeNxphmDSoJ28GPjI71M0Va4UVQ0Es9+GUmjawA0lN6
         BLXT2703NWrQaZok1ZtEuhEIMmpY+yfRmSVdtjv/D5C0HSbr5no//Tbr4eMcUGDF31ij
         0v8zvNnZr/GG/tHwV0s3V2vaZx5UOJmYfEU52C7Zf8UNKjr9FLHB43uybf32fUifR8mM
         HGSSiiJW48H8p3N7PEfyylpmdCDM6rE3IE5JUFuc2gECFiaCcuIczm7UdKeCfNCaM/MX
         FQWw==
X-Gm-Message-State: APjAAAWoEx07jN9TOXuIRieVcZnifZaEma48m4li8WMexEXA6FdgU5/W
        KJc2o3rFUlcGNGVYwN9EXGE=
X-Google-Smtp-Source: APXvYqyBlK332ZryIQ0G96MVaBD1a1pECjFocKt//rUbE5ZTMRxlSfCkSM0UjXKmzCeVAUuZhl9iGQ==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr31686wmj.2.1571166611570;
        Tue, 15 Oct 2019 12:10:11 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u26sm25089984wrd.87.2019.10.15.12.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:10:11 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] include: dt-bindings: rockchip: remove RK_FUNC defines
Date:   Tue, 15 Oct 2019 21:10:00 +0200
Message-Id: <20191015191000.2890-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191015191000.2890-1-jbx6244@gmail.com>
References: <20191015191000.2890-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines RK_FUNC_1, RK_FUNC_2, RK_FUNC_3 and RK_FUNC_4
are no longer used, so remove them to prevent
that someone start using them again.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index dc5c1c73d..2798b6c03 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -50,9 +50,5 @@
 #define RK_PD7		31
 
 #define RK_FUNC_GPIO	0
-#define RK_FUNC_1	1
-#define RK_FUNC_2	2
-#define RK_FUNC_3	3
-#define RK_FUNC_4	4
 
 #endif
-- 
2.11.0

