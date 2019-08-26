Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DD52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="I0284+Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfHZTBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45204 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfHZTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so14931423qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CccJyJOMWnqZNze84cEuacicNWkxG2JBW1Co8t/7GHg=;
        b=I0284+UkE2KRe/Q87KW/ZDOZ0NRLyZ5y2WK3GF9B8oVeaMsu4inuS3OYe5XqIF1vCo
         eSOQX+eykZNjiDXyhXVlZ3NueKf7GCab1T0/xy1AKMvaD45089SUJauoau3gT/VqvXsn
         eNv3bynIT8Q0UOTvohhzTlq3c/vJHTpou9QSboH+3la93R7QO9Id6GACC4fhqFwMwPIz
         a/U20xXR+sBysdvk2sRmuZQ8HPJLe/+5kRs8lVPycQ+vJq3Is3jFq8XDJcq6sfw510xN
         6KbSpr1vDru+n59CnWFw4rgMw55N4Xcmh/+/tcGzAYti3jEjzdjllLOni6KaNu/sfJ7I
         ZHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CccJyJOMWnqZNze84cEuacicNWkxG2JBW1Co8t/7GHg=;
        b=C0ubsE322KURB9yoknQy9194p4BocnaGQ72Rc1z1JhE9UXjBG1ySDW+VhT3lXx3z9U
         m1VMgWYQzf1wNkSv9qDOazAFJx/4dUnTe5Ghgh3CTFW3j3Ylal4+iELp9kV6RHxlJZql
         x9cBqFvvWS84N+i6ZwsVrkQ/Q2qfSWYDqcOBPLipZUeULa784YM0yTz5D61BgTmS094v
         ObPtjmAU3/J60QQH1wrIqxvjPDB5rTVCFurYMvHEXzwyLtFNg05PbnKrqbUe2gkiIYna
         v5pn4uKyyt08RfDMNH7AHVqrVbu+KcAOE5/y/TdqU+9U+x84fytzKMAyVchp1uuH7xE3
         hwAg==
X-Gm-Message-State: APjAAAXggNlc6Gy2H18E06kuZ79TEblF4+XOdPiupPYk3v4IO9Ib5tl9
        vQCk77g4JoFCnH4FWb+OD63HRuPA+8E=
X-Google-Smtp-Source: APXvYqzkeM4d2xoox7UrW26qsfl9DIQeUgb3ebwIZYrqCOeIByY+iEP0xv1YBmkPy1xY46M7C9jK0w==
X-Received: by 2002:a05:620a:16dc:: with SMTP id a28mr16541779qkn.200.1566846062457;
        Mon, 26 Aug 2019 12:01:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:01:01 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 3/6] rqchip/gic-v3-its: add reset pending table function
Date:   Mon, 26 Aug 2019 15:00:53 -0400
Message-Id: <20190826190056.27854-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function that is similar to gic_reset_prop_table but for pending
table.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 656b6c6e1bf8..124e2cb890cd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1989,17 +1989,23 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
+static void gic_reset_pending_table(void *va)
+{
+	memset(va, 0, LPI_PENDBASE_SZ);
+
+	/* Make sure the GIC will observe the zero-ed page */
+	gic_flush_dcache_to_poc(va, LPI_PENDBASE_SZ);
+}
+
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
 
-	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(LPI_PENDBASE_SZ));
+	pend_page = alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
 	if (!pend_page)
 		return NULL;
 
-	/* Make sure the GIC will observe the zero-ed page */
-	gic_flush_dcache_to_poc(page_address(pend_page), LPI_PENDBASE_SZ);
+	gic_reset_pending_table(page_address(pend_page));
 
 	return pend_page;
 }
-- 
2.23.0

