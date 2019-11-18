Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EFDC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C716C2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iYv2rg6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKRL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:26:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50302 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfKRLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so16926497wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=iYv2rg6xMyVeqTyZvQbGoAIRLKQvwVNAe0Vm9uB1u8JfQhe6nA2sFkJ6p4Q7tWFWiv
         mWlAZBEOVuLs/i/804azNST3syQFrE8Nj65xmwsjwi/ITISuyJk7Shbfq57GCUezn9EC
         gKrmZxlxDEWvyvMZ/zAi1zBx70bUJzriTe7CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2c319/rjPUXp8iRV62XAcjKgiOjRbx515GvierWVkM=;
        b=AdzCnPMUm1LFra/wRTHP6rjgJgm+eK6chh8znyPt05c+AGEdZwQCpj78kMBuuChhw+
         RIaQZUEyIZbqxwYIr5xYCo3K0vb7e4V+bANm0LcWPKfkW6zR0+nMYO/8gm/BQpb36vlr
         VinEP+UV1mMhAOnkBsbO8shV09f7PQxMqwd2KPKrzViX+egYJq4auCqRmb94E6lHDbzo
         9keHPrwrJ/gNiWLCnOMJ2NUddWeaRsdmtwF0nl/hYJpAkvW5SFG24PIwFKMtbQjymHcF
         R8YYV2APvlRIPDKRTHw0536w9+fQLR/S+VmF95TYmKf22STgdxYjHN5FNI8KWOJ1ctkl
         Kdig==
X-Gm-Message-State: APjAAAXgN3LQU1vuhsX4VTXwo7Xi8bi1nr1S75mmDhmuyVI4rjsNzKbf
        LBHPhEkb/ZhhRepASnW36u+tAQ==
X-Google-Smtp-Source: APXvYqxfKkQtmuWfC8tKskIrS8mU8N0ZZJ0oQWDpcNFyAXXFlvyxchfCXA3TmHuN3zrf7/89d9COWw==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr29355989wmj.13.1574076232635;
        Mon, 18 Nov 2019 03:23:52 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:52 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 17/48] soc: fsl: qe: remove unused qe_ic_set_* functions
Date:   Mon, 18 Nov 2019 12:22:53 +0100
Message-Id: <20191118112324.22725-18-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

