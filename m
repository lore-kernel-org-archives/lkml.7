Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21BC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046E121556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUwsSXv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfLLXQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:16:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47072 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfLLXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:16:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so395683pgb.13;
        Thu, 12 Dec 2019 15:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrcLTUya6tKmBDv9fbzxQOHC8CSLJLBRuOXylw/H/LQ=;
        b=OUwsSXv1ozwid6KtPLBhDJzii7BoCsvW+6+6VCvLOV2j0VWexXUXp0+6+s2V28nw5c
         +CDD1soqsV4bmZ882ggwY07tSBjH4mvBJNiWOB2mlvUN4dnbJdLEb8jx4Ng+hiOHwY7E
         ZbL2ReILkbwf/vZ9TSy2t4UDjeDw/yDRLAujIP1lsgACnGCH85Uxn1OexduP+b1FHyXS
         B8B2S1l9RGYr6chkeuTfD+ZCVCvVUe8li1b46/Ed5W0LEhkCj10AY8dGxeHEmT7nFF0O
         BeApaieC1GBETt+WJ0h/x6azsE/RuP78q6/n811NPRaMngJDQiwfdx5mFll3YHyebXhX
         wkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrcLTUya6tKmBDv9fbzxQOHC8CSLJLBRuOXylw/H/LQ=;
        b=q6dK9peOFH9IPK9v3Dbm0SPRoHGvv/fB8uQqX3g3/b30hTWSN1zQm8j5nRljbvtCKj
         pSuB3KPnZDGipn3NHgWxxvx9Kubk4EObVwqWuTqQ4az3BANtbLK7dnp1Efr+LNkuqUa2
         J2dV0eJkE9TDo6wrpSLVnZV2iuYBmXNUKPKDQGU5Nw8R6R/n2I4kjxqhGE3g77pXz86u
         zWSIaNRllxQKkRbpEOzH/DSaE5dG3Jliud9ZSDwyR5PGlFakeXCwS87lFunb7rTwVYv0
         CgApSoEtXmrHTMhe+xa1+XwAVBmX9FuRn0zLSYvZrD9btdiQAiFVYa1W2VFXs8Ml33Sm
         j1Ng==
X-Gm-Message-State: APjAAAUMbsynvLSWlcz72LGC7hImOFDOhh4kcwi5Bsu7T16fg0htvzau
        xroXacW19G45AbZxD+L7YNI=
X-Google-Smtp-Source: APXvYqxi/4Uk21EguLIChFfr3iDaBRkRE2ol/JFuqs6f26TAO/JO2iEOAe4DA0rmARfaTHkBSX7sGA==
X-Received: by 2002:a63:2063:: with SMTP id r35mr13926813pgm.120.1576192610054;
        Thu, 12 Dec 2019 15:16:50 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1072])
        by smtp.gmail.com with ESMTPSA id ev11sm9423307pjb.1.2019.12.12.15.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:16:49 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: delete no-hw-checksum from Facebook NetBMC Common dtsi
Date:   Thu, 12 Dec 2019 15:16:21 -0800
Message-Id: <20191212231622.302-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212231622.302-1-rentao.bupt@gmail.com>
References: <20191212231622.302-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Delete "no-hw-checksum" property from ast2500-facebook-netbmc-common.dtsi
because ftgmac100's checksum issue has been fixed by commit 88824e3bf29a
("net: ethernet: ftgmac100: Fix DMA coherency issue with SW checksum").

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
index 7a395ba56512..7468f102bd76 100644
--- a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
@@ -71,7 +71,6 @@
 
 &mac1 {
 	status = "okay";
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
-- 
2.17.1

