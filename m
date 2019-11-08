Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5446C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D772087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gAfX6MXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKHNBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfKHNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so6123007ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmfKhQtUBCxwlUAlf/yXjWEx2pu0ns3cTlzrvt6tvNM=;
        b=gAfX6MXcCyS9wSmKQuOX63PtH+3mB0ZvFLk+HsfVO0fkTwRdc81xxQvJQVJU9YBVrT
         uHFwboBuaQ9sNhyund/PAbXdqzkDBzWxL9hbUSv/Yc48+uBV+gQmCW7yq4pUdNscImuP
         a5LmzuegAl36AEho8jO/qVT3o/altH4UBimkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmfKhQtUBCxwlUAlf/yXjWEx2pu0ns3cTlzrvt6tvNM=;
        b=Lzb//iuuvoktmaq0dgogE698AN8OCaTKd4tSb6MPwXl9PkH4x1kTvZ36fTqOB6awQq
         1RynOqlGB8+38SS0HbHWykoBNggxCDyZdgEG56FhQADjTEW9qRiGO/QLTcX0Vfz3UjQS
         91knYMLgmRbxmnrJ34gCpwUFHh+w9pVkz77/h1kH8EZr9wp3ISUbcl+PKZ6pACIjP0Zl
         bsBMoSswllBjMyR46YXfNVAE/4BbjZpFzpRnr+s8dXgS7UVSmkjX/4fTrisO9FgAEJUw
         eZwClHt1SQkVApACLIqbsSxO4ddQskOx735MfouODkA7UgVy7J1XdhLR4WyezIBYAIuG
         T50g==
X-Gm-Message-State: APjAAAVfypVQBQIzQxkYLQ8GJJ0sAxwRtClZxFLAxLiw6Ro60q9ImUQP
        SNSioWeeSS0afD4ygQaf5KCUeA==
X-Google-Smtp-Source: APXvYqyOnvka3QCNGsS/roL4SBZ+UOk5Io0Ut+yXUrbH0IyL7n1qjSafb75iZgpL08KUMMi18YRNWw==
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr6830442ljo.52.1573218109131;
        Fri, 08 Nov 2019 05:01:49 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:48 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 16/47] soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
Date:   Fri,  8 Nov 2019 14:00:52 +0100
Message-Id: <20191108130123.6839-17-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qe_ic_cascade_{low,high}_mpic functions are now used as handlers
both when the interrupt parent is mpic as well as ipic, so remove the
_mpic suffix.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 94ccbeeb1ad1..de2ca2e3a648 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -314,7 +314,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_low(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -327,7 +327,7 @@ static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-static void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_high(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -392,8 +392,8 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 		return;
 	}
 	if (qe_ic->virq_high != qe_ic->virq_low) {
-		low_handler = qe_ic_cascade_low_mpic;
-		high_handler = qe_ic_cascade_high_mpic;
+		low_handler = qe_ic_cascade_low;
+		high_handler = qe_ic_cascade_high;
 	} else {
 		low_handler = qe_ic_cascade_muxed_mpic;
 		high_handler = NULL;
-- 
2.23.0

