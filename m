Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656BC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB182089F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOBvebTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfHDIWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 04:22:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37490 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfHDIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 04:22:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so56262025wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAXzdzaSwM+e+U2MqW+fV+EEmKPaHc+/eZTIsVQHLw0=;
        b=LOBvebTFtnKHYCIF7Of7MQ4OSIDlic+E2tTW7H09zZLsOyws6aICc98QXfRs6W9tLQ
         bz3amy+38qUquxG2wV2LgowhdBSTwy7d3M+AB+kiNTUZvKAjgde4Db24Ux5SvSh2vw7S
         cmEIfoT8MJVofA1djSdfctONVnt0brSa5c1vlbnXF7Zu97yVZ3mbu/zQkRtufXN0pmSA
         yOuvhkQ5XLRalc6GslCFNXhu72SfcU8bgQ0fQQyShjAOnl4n6unaq5V4bVXSc2ZZxi1J
         yQ0vNaQNn/Sgn/KVCkOT4Lof86qc22u9dJONcSNHYTx3DCLFRROZHiFA+wBmZ0J21fYB
         0aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAXzdzaSwM+e+U2MqW+fV+EEmKPaHc+/eZTIsVQHLw0=;
        b=ZR13SBFgjdVbfBC//JsEp1UJYicfzaDBQFmuV70Z05EiiXqRkBKarx9ZATlbaagxgn
         ReG0lRPyyLO5an4+ZukHfbCqDDr3hrn0SJIYb4BBjpl6AxuX93sxv+SUUuXuLMJxICuA
         23PuWcUt/bEvuBL89U1ia6QZwCNHhCgMsT3dUIiFTCA5MoqYFOkUqpM0PTk3AEyEW5sq
         f5lX39MqspvbqN+7s+ju6u1oHQi/ut3b1buvFCsmkdVxzTHCXqQ+fr9Ey6+/sxYnJSLv
         MGb2MQjlFgpFdVd/cxZ1bgqyKUOnRqQR1xcbWRAQHK+C3/GduxJjV304D1cYzYXdXqY7
         mLjQ==
X-Gm-Message-State: APjAAAVvnspJ/VugBCJhkc/zWjAN7ypl/PmfiG1hauMzVXNllgp/pqee
        rBxSBc3OR5oevb4wEN2aaCwd+XBd
X-Google-Smtp-Source: APXvYqx+Qqxz3BrzqJftkNhqeyD00PAYgWdUSvOIRo+pJKJFDPs09xre8bqUFy0ZqzfrSC8tg7kLnA==
X-Received: by 2002:adf:e691:: with SMTP id r17mr23828190wrm.67.1564906966490;
        Sun, 04 Aug 2019 01:22:46 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:9900:d80f:58c5:990d:c59b? (p200300EA8F289900D80F58C5990DC59B.dip0.t-ipconnect.de. [2003:ea:8f28:9900:d80f:58c5:990d:c59b])
        by smtp.googlemail.com with ESMTPSA id j16sm28927747wrp.62.2019.08.04.01.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 01:22:46 -0700 (PDT)
Subject: [PATCH 3/3] x86/irq: slightly improve do_IRQ
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Message-ID: <b803cef2-8959-985b-9d71-4abec1417600@gmail.com>
Date:   Sun, 4 Aug 2019 10:22:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's simpler and more intuitive to directly check for VECTOR_UNUSED.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 042f363a8..2f1a78c4d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -246,7 +246,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	if (IS_ERR_OR_NULL(desc)) {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
+		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
-- 
2.22.0


