Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F43FCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2852067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="emxjxGI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfKAMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47026 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfKAMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id 19so1971093lft.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=emxjxGI5mzMUlIacGEHrL8HHfoh+f+nWa9gO07GOW4QyExZHgcvn5bvZdXqLZSNRzH
         T6KiKkaCIX+2BDTbqSKNnteERU86ltuF8fgmVWLPrjkyvEDzacT6ouPkXoVf+JByyKB+
         avErQjWjwN1a4qGfUl42EYAJpsK/C9Gfr08Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=edaz87Wo/uj/yiOUYg6nsFkfPt46uC1Vrp1BDAUKE9CaSHPVXX9wJxKNkpGmzu/MBc
         qouY955TMQFXvVV1eS8ikt+5rx6RbrwS3OrCI0RJhBgeUFGLLAQXLaLZBddURdWofkaz
         2NNscdrnJuYlipo+RNIGCjYT2ehV0ITKLiBWdV62Tg58YTKnAJT8IKyhGo9aqDNkuHmp
         86LVc6gSRuzpoDf4+UcaWwvVo08hpMF3k0QgtOrxGDC7e7Y3XnoPNcOJtuIHqMN4mDGR
         HpEJxbL0KrhdSJYP18iaymsrNkZa2q/aWDEj2JazvSRvOHvESZVGOD4f8YB6oIS3X2g1
         VJyg==
X-Gm-Message-State: APjAAAWxcAR5cG4mpsbBoYQE9kjTAsbl5h5I7e9gHDZMhfOgjvxII4Ml
        508bpFLIToUrOSu3Z4AsPqUWDQ==
X-Google-Smtp-Source: APXvYqyUED22wOC6qXGZRgb0XFAyo80agg4tRT/Xg6HOogBbRuVaLKjlgEcwhH7XuCsmAGV+O0vQqQ==
X-Received: by 2002:a19:4c02:: with SMTP id z2mr6812332lfa.45.1572612157070;
        Fri, 01 Nov 2019 05:42:37 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 17/36] soc: fsl: qe: remove unused qe_ic_set_* functions
Date:   Fri,  1 Nov 2019 13:41:51 +0100
Message-Id: <20191101124210.14510-18-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no current callers of these functions, and they use the
ppc-specific virq_to_hw(). So removing them gets us one step closer to
building QE support for ARM.

If the functionality is ever actually needed, the code can be dug out
of git and then adapted to work on all architectures, but for future
reference please note that I believe qe_ic_set_priority is buggy: The
"priority < 4" should be "priority <= 4", and in the else branch 24
should be replaced by 28, at least if I'm reading the data sheet right.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 94 --------------------------------------
 include/soc/fsl/qe/qe_ic.h |  4 --
 2 files changed, 98 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index de2ca2e3a648..4839dcd5c5d3 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -445,97 +445,3 @@ static int __init qe_ic_of_init(void)
 	return 0;
 }
 subsys_initcall(qe_ic_of_init);
-
-void qe_ic_set_highest_priority(unsigned int virq, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp = 0;
-
-	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
-
-	temp &= ~CICR_HP_MASK;
-	temp |= src << CICR_HP_SHIFT;
-
-	temp &= ~CICR_HPIT_MASK;
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
-}
-
-/* Set Priority level within its group, from 1 to 8 */
-int qe_ic_set_priority(unsigned int virq, unsigned int priority)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp;
-
-	if (priority > 8 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-	if (qe_ic_info[src].pri_reg == 0)
-		return -EINVAL;
-
-	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
-
-	if (priority < 4) {
-		temp &= ~(0x7 << (32 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
-	} else {
-		temp &= ~(0x7 << (24 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
-	}
-
-	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
-
-	return 0;
-}
-
-/* Set a QE priority to use high irq, only priority 1~2 can use high irq */
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp, control_reg = QEIC_CICNR, shift = 0;
-
-	if (priority > 2 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-
-	switch (qe_ic_info[src].pri_reg) {
-	case QEIC_CIPZCC:
-		shift = CICNR_ZCC1T_SHIFT;
-		break;
-	case QEIC_CIPWCC:
-		shift = CICNR_WCC1T_SHIFT;
-		break;
-	case QEIC_CIPYCC:
-		shift = CICNR_YCC1T_SHIFT;
-		break;
-	case QEIC_CIPXCC:
-		shift = CICNR_XCC1T_SHIFT;
-		break;
-	case QEIC_CIPRTA:
-		shift = CRICR_RTA1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	case QEIC_CIPRTB:
-		shift = CRICR_RTB1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	shift += (2 - priority) * 2;
-	temp = qe_ic_read(qe_ic->regs, control_reg);
-	temp &= ~(SIGNAL_MASK << shift);
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
-	qe_ic_write(qe_ic->regs, control_reg, temp);
-
-	return 0;
-}
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 43e4ce95c6a0..d47eb231519e 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -63,8 +63,4 @@ static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 { return 0; }
 #endif /* CONFIG_QUICC_ENGINE */
 
-void qe_ic_set_highest_priority(unsigned int virq, int high);
-int qe_ic_set_priority(unsigned int virq, unsigned int priority);
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

