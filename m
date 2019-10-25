Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D1CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B45921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="J6UXGh2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440383AbfJYMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504517AbfJYMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id 139so2360094ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3SaCctQ33G0LqzlxkoZQqgVXIOLmGcZ9QAc4BskcDk=;
        b=J6UXGh2wqwAc/+LZXDTKvF+WwOwD8qwr2FNWm47poYQ8yc8qW2mTPT0FRMZguXjutf
         c8DuE0S0rSMO8D8ykEDKzSp+ZeTtkwJJx2JS6QDezvAfV+MvPc4M3VUtiDWMtzXvxVFn
         +oi5/ChWZGObNUyC4Kq+YiDjBVfDbrRcmEavk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3SaCctQ33G0LqzlxkoZQqgVXIOLmGcZ9QAc4BskcDk=;
        b=HXm97QEaiVsJukxLyIqmU44FnK5B3kGPZjUzJYZWriTCmslOAgyqOupTRwMJbJChYI
         P60LkkRbBImyqytJvYOXHzYMJ92p/QJfV2Pxx/y7fZnJ6bK4BobiE/i+6IZFSpnci6dE
         zuNP6fl3EK4iS5BE/647llzmwQAUQaUWdFXw/CqKWoTZJ5Sr5LoaIAjEOv+WCP4kWP6I
         6D5jCORxFgd1XWWOesq99vnAKCizALRtFujQGkXz+Ob4sk6c48Yi07g54Bug/OViWnX2
         jMqBlbwzx58l6S4slRbzn7RIGekQJX5VN/OAXbPJXZfkjBWvmO587Z1SYfXVzrBX46L7
         Azyw==
X-Gm-Message-State: APjAAAWsAEJyibiFBjSq4V1TqBw6eXttLjEQRkZ0PUZOBa0hV8ExKmQW
        KbBtZHpivuE3KacRv17VNmlKZg==
X-Google-Smtp-Source: APXvYqxP7naa1DeBshE45tVgmMrsPdv0NnSq2X2IndFsFfhsb895JAiwuYIede4Uh4vXem9QRAO5EQ==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr2391175ljg.82.1572007284671;
        Fri, 25 Oct 2019 05:41:24 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 17/23] soc: fsl: qe: make qe_ic_cascade_* static
Date:   Fri, 25 Oct 2019 14:40:52 +0200
Message-Id: <20191025124058.22580-18-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the references from arch/powerpc/ are gone, these are only
referenced from inside qe_ic.c, so make them static.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 +++---
 include/soc/fsl/qe/qe_ic.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 545eb67094d1..e20f1205c0df 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -402,7 +402,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void qe_ic_cascade_low(struct irq_desc *desc)
+static void qe_ic_cascade_low(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -415,7 +415,7 @@ void qe_ic_cascade_low(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-void qe_ic_cascade_high(struct irq_desc *desc)
+static void qe_ic_cascade_high(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -428,7 +428,7 @@ void qe_ic_cascade_high(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq;
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 8ec21a3bd859..43e4ce95c6a0 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -67,8 +67,4 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-void qe_ic_cascade_low(struct irq_desc *desc);
-void qe_ic_cascade_high(struct irq_desc *desc);
-void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

