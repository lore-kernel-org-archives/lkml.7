Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37087C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1003D21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DWaJoZNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK1O51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37878 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfK1O5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so1462988lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmgfMIRsfesacuqaAWdy4m11iy4kXtcqJGU2jE1ib94=;
        b=DWaJoZNKmVKJfjUISyttmUEuNUv/FC4di6OurSxwDjNRPf9fCoQE/A/qz2Dy66aw71
         PMyfrMM8lWNdbHve3iKOns1KyW7JmJCa85Djs2qtRkWpz9X+k2Ozb14LpmYyBYaKsLE9
         HPUmmm8ft3lQXqQmtEWC2OKlYzqlvX2OAcQXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmgfMIRsfesacuqaAWdy4m11iy4kXtcqJGU2jE1ib94=;
        b=kU+IEf7lO9pwU6aDT5KPVL0VCtyWVgWwcZhP4m4dT3K0Ek0bSZCCeBJvwfLi3TOvux
         42/TsVrXbCejPtdRScOXdGd7GCziLwKfF4yzL9F4YUg7OeYTKTF9GmnQ1/VH453+c6Oi
         8A9PeO0POoe8A+TZ6Le7F6SaYxVpGR97LSvNytrETuvtlb6ejJ1RQ/ER5c/XP52yETN+
         i03KtBS2lCF+Igx0tjkJxrxSp8kOfm4XPAnRBojJ/7xt47vgMr2JV97NNpdkzxiDAgUd
         I+V4on9gs35Eq8WMhMAuqxs33HokCDmixysQ4FTEZJXKpquCN/WEi06TzZyCwh2cuQlP
         81rA==
X-Gm-Message-State: APjAAAW2QmzoQ+ohzdqPdEEAYzfCkGViSSsSLQQlts8YLnOcP4h2pjkG
        9SbyLZSzHnod33Rpk9po9HnJWQ==
X-Google-Smtp-Source: APXvYqz+PF41ZfV2qdB0Q0B87NeIFa3uor094RTZMNig8ikkYiK55r+ga2Tn+9ewAJX6oroKuIa4Rw==
X-Received: by 2002:a2e:91d5:: with SMTP id u21mr35420576ljg.32.1574953036398;
        Thu, 28 Nov 2019 06:57:16 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:15 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 09/49] soc: fsl: qe: drop assign-only high_active in qe_ic_init
Date:   Thu, 28 Nov 2019 15:55:14 +0100
Message-Id: <20191128145554.1297-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

high_active is only assigned to but never used. Remove it.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8c874372416b..4b03060d8079 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -320,7 +320,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -366,10 +366,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		temp |= CICR_GRTB;
 
 	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
+	if (flags & QE_IC_HIGH_SIGNAL)
 		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active = 1;
-	}
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-- 
2.23.0

