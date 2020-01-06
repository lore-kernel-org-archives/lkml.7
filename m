Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30C9C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A8320848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdV+YKJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAFPRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:20 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42383 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:18 -0500
Received: by mail-wr1-f42.google.com with SMTP id q6so49920518wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJ0mr1VWMGhD0hVJLZ9ZIIn5jKvvmiJ3Y4rzn7LBNbk=;
        b=OdV+YKJ76dFnccPkFBU9f006TXXIhBiuLYkoKvV7ppMkKbVF0b3zR4LXOZzcUWCNOa
         CDSL9CJFm0FwKSpFfDXo8jQS/2ViNXS3pLOG5Hf0YRIY+jU9djzSz9DBHPS3jWANp4QA
         9EPjg8z1aBJaoHYk7jTSk+p/BKhSNcuildd742DYrc0G+YUeBu9eHvVn5X/Q10yPtLJH
         2ow8NsUkSjqlJ7OCT84/ohCUAZ/lVllaFT5v4DYO+KNrN4BlSM5qR4S+rP5Dtb0ecl/V
         E9OJJxPmejuTpODDkX304hjg5sPi/9rq/PrPIHZQXrEaCKnEIemTOGsOOELN0MlLLBjH
         OzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJ0mr1VWMGhD0hVJLZ9ZIIn5jKvvmiJ3Y4rzn7LBNbk=;
        b=mP7VsiGAXuWubn8pi0KOlf3ubIpNTz/2Jv9XjHuItAGYcWPifD1/oxKW/ruHnoT628
         39OHicCnd3pqakPww1nZiQ/vdc6AtdDueq0XrJDQI3+dHJ6Z40DGghEVaFjFdJCznMn4
         D9xVwHgdX2tlwNERzgIFIPNJ12aCQljLw7ZAGZTW6TkChjVoCczw3e4hPRRH3tMihumO
         POyWqzOiNTwu1F6io6rmIKsKl7OuyAVjQxBhqLSusWwTSaApjGkFj417rkgmE+Aq1gGW
         D6dXN+XS0Nf+KAbrz5kxcQAU4/IRrrzhcGdJPZoJjGwH3WSfU6xHcZcuSULNQKFetVh4
         yA2Q==
X-Gm-Message-State: APjAAAXcVqr9ay+p5JC1rbfoHmFu5PHyNNA7/IttdD8FVpgJV12oPhXi
        s5LZVDWUPRtj8OrJ89SSrbbwZu6VWLbvAw==
X-Google-Smtp-Source: APXvYqzRcsMyqVZ/N0cqQteFF/ISWt+yhbWUk/y5CgQQTwwBMBRi79mBuZT8l8jcRj8o3Oq4Gsno0A==
X-Received: by 2002:adf:f605:: with SMTP id t5mr20038985wrp.282.1578323835553;
        Mon, 06 Jan 2020 07:17:15 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:14 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/6] drm/etnaviv: update hwdb selection logic
Date:   Mon,  6 Jan 2020 16:16:50 +0100
Message-Id: <20200106151655.311413-6-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take product id, customer id and eco id into account. If that
delivers no match try a search for model and revision.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index eb0f3eb87ced..cf3bb26e2e43 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -46,7 +46,13 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
 		if (etnaviv_chip_identities[i].model == ident->model &&
-		    etnaviv_chip_identities[i].revision == ident->revision) {
+		    etnaviv_chip_identities[i].revision == ident->revision &&
+		    (etnaviv_chip_identities[i].product_id == ident->product_id ||
+			 etnaviv_chip_identities[i].product_id == ~0U) &&
+		    (etnaviv_chip_identities[i].customer_id == ident->customer_id ||
+			 etnaviv_chip_identities[i].customer_id == ~0U) &&
+		    (etnaviv_chip_identities[i].eco_id == ident->eco_id ||
+			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
 			return true;
-- 
2.24.1

