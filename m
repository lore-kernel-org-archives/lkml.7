Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EDC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2B2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdnwr/F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfLURao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:30:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36974 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:30:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so6982467pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwGMJFVnIEbpnm2WH+uQzojySZmzKwPH6jHynfQ5gTU=;
        b=Cdnwr/F7k0840xVLL61hFbTPHEpQWrT++spZEWBEafquR+bEC69/AH7XFM6D+7BG/8
         Uyw2AukfwhlPcowI+97C8sY9Yr+80bODD6WhOpXL23HkK9wBzVYp6L9bU4u5e7kuvARl
         Q+4I6cH53SBp9WhIggPCMrGs0UNrQhfGtnwczkwyVvb5Wkafn+PBmNqCMdx26yM49L9P
         aqJU9XrAedM6zc8elMh8gw6kiuaPuJUKkG5wXra/XY9wO2GksLFfTSAcTX+qjTfR/iA2
         HAB6i1JiWz0UnHNZko12WIOPtp7sQCgQm4/JbdoLM+lk6vYeyfibrDdD265yex4ADu/f
         lrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwGMJFVnIEbpnm2WH+uQzojySZmzKwPH6jHynfQ5gTU=;
        b=OZaKcMHhCdtpfvXFha1TCEdP8tDb8aWg/4w8lXnMFVJiGLSAlEmXMAS6qS8qu7sDw8
         k8Oe3Bm+aeVBot4fsWHVXdYYsTCpFfUXSDRBAuneDxVcMpwQDeQV6EYp0c4UMtX2g9rz
         9vEl/o0y1jW60a+FfJE6v101hlosreOs3DkplY6e95hG/umicgCz4YIDlM82qGyFLYR/
         ivLPnagnDr3Pzom6Jx39pEksF82Lik3cZmzK08BvKe78qwgAJI74TxE0rnwyZQx3cpyZ
         XEut4X0bRoFW1a4HW9LZWiGZkrT9HlON2WAtKivql6pW8rxzvEmUNmaTgFntIK/k9dSs
         crxg==
X-Gm-Message-State: APjAAAV4UZhwunBV2rqzRw956voA6wTXywc51rMRn7xelKbNVRLPNrDM
        1Ovvl1DEAiGBC23WKSKpQKV2UET6GiI=
X-Google-Smtp-Source: APXvYqxVubANRg/sn/KKFOWcOLHwb0T3sb/lrn9hvjDSMsGmyKqLbyrUsGDCql9gSxHwzadr/XXC8w==
X-Received: by 2002:a62:788a:: with SMTP id t132mr23270647pfc.134.1576949443682;
        Sat, 21 Dec 2019 09:30:43 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id x7sm18403751pfp.93.2019.12.21.09.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:30:43 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/4] clocksource: em_sti: fix variable declaration in em_sti_probe
Date:   Sat, 21 Dec 2019 17:30:25 +0000
Message-Id: <20191221173027.30716-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221173027.30716-1-tiny.windzz@gmail.com>
References: <20191221173027.30716-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'irq' and 'ret' are variables of the same type and there is no
need to use two lines.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/em_sti.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 086fd5d80b99..ab190dffb1ed 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,8 +279,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
-- 
2.17.1

