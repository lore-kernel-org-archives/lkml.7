Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321EA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbo+5wDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfG3RlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:41:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36266 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfG3RlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:41:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so62915724ljj.3;
        Tue, 30 Jul 2019 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYoIRB4hdud/dqLrHKUsBQqYVNNWUy/cBvAXB5JEb04=;
        b=Lbo+5wDMrbFMru7CZxX4Rxj6u+llEYRos7P+oAp3FdWciGiCRSc+LdidOYBPwROQ5P
         d3NGyKGMKa6zn+h+R/ni0bSvTxdqPt/c5W9tyWpadE7Ti1qBZV8UYRMq8t1DSWOJY8sJ
         flKn3sKJ396/TULgfMQsxs0ORuvU1ieWc4tooUHVFvqV7lOWwuxAMC5+Fl2npYFcA9q1
         oGMc+57D+T/MGcj/5hv84iJrr+Bc3a5OQOMN7OwwqkWWsBM+pvwBhQBRFi/szQBREk5C
         NmKQDpWVQEzBFaRo01YIb2zxUequp9khzbd3hipsySvqISuti/+0ninTjqIazIgWwHQS
         xsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYoIRB4hdud/dqLrHKUsBQqYVNNWUy/cBvAXB5JEb04=;
        b=dnbkPPV6FtaZ6L62jxHiptH50emkV80DpE5NMoN2jQYeJQr6BMDV7ZInE/bH03DYrI
         zEJCCDvPKXme1fFwjHFZ4qS+acK8PDO7yxOIZVum/3vjMkF6DJm7oaOU7HXdlmX7R014
         2uWVg732n+nAesBr/+rpL1STrpyYteNQUu3IVXU6N8bQ0N0O1fdJMJqfdjMPiH3ehTS1
         h0ZETxlKfQp4kp9gQE5PKOgrvyYB4r0AiNswlifATGYGGOjSI/kI2PCNTrGG0cTDACGo
         TI5q2kMP+NYLG8M+CF3NCQtpaoXpfLGuYLF6IOz8SAdXTzmQBVTDP/2ztt5j2kU3sabC
         9iSg==
X-Gm-Message-State: APjAAAVF2PbK8IeU8AJlgfQNPucZCwbSLmc9QKgRANp1gDtrZn23OvTx
        9TdGjedYfqjcMaffVg5RxCg=
X-Google-Smtp-Source: APXvYqwXtAm48fuuVXdJWivjrdfYyG/kEw+mvmixs+YOrm8bl8QlLP+RQ8jA7URpssf7Xoaf3N/KWQ==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr59141281lje.46.1564508473035;
        Tue, 30 Jul 2019 10:41:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id g5sm13721177ljj.69.2019.07.30.10.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:41:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] soc/tegra: pmc: Remove unnecessary memory barrier
Date:   Tue, 30 Jul 2019 20:40:20 +0300
Message-Id: <20190730174020.15878-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730174020.15878-1-digetx@gmail.com>
References: <20190730174020.15878-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed barrier isn't needed because the writes/reads are strictly
ordered and even if PMC had separate ports for the writes, it wouldn't
matter since the hardware logic takes into effect after triggering CPU's
power-gating and at that point all CPU accesses are guaranteed to be
completed. Hence remove the barrier to eliminate the confusion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: No changes.

v2: New patch that was added after Jon's Hunter pointing that it's better
    not to change the barrier's placement in the code. In fact the barrier
    is not needed at all.

 drivers/soc/tegra/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index aba3396b2e73..3044809f1c10 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1457,8 +1457,6 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 	do_div(ticks, USEC_PER_SEC);
 	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-	wmb();
-
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
-- 
2.22.0

