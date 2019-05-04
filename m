Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB9C04AA9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB6D205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="aEli/RHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEDSic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38544 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEDSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so6530397lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9RavLGoIs/lnDK5Lu6hOyR7V69/kOZA5XlkRY8NIyQ=;
        b=aEli/RHJ/0kQtLT28mmdqbdwfQ4kVP0Ocn6go9/A66iEW33ePeTgOQcGjpHXhMsTOx
         wMLTfazjmoJr/0DILN4xRci//Zir/PATnYdDLo9Q0o6i2Nm6pcjOhhNIiv7GlHZDTMWV
         q6qBAwEbi5hABxneTtdsGMXpYRYYu0V3vZ0BzW+ppwRb0ZzX04uh8w0yzolMtZ/PLmB4
         zlbsnR+YS55wyUjxDIib0jkWg/wMpqzCNriH4VBaivpDFOHjoeYgf0Qg4ohMrSGRsMzY
         1sVAG92FtAOeusA9O0dUWyWHhhM9rRlQfEngv1CmQOQRuFF3YPzb6Toe19/oJ/BSw2TO
         1UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9RavLGoIs/lnDK5Lu6hOyR7V69/kOZA5XlkRY8NIyQ=;
        b=P2LQgzXOOrwrVxxBYEFhl2JZElcfAbWB7isL0r2gjIH39R2+o1d6GfPLUu61dX25aR
         l+Mq3XSuvM6PEQx1WpcuUu9NlBlthYPAuZNtVPHTwqj7YR3vD8nGunUtPatMX07SYDCR
         ka3AyhqvTfPXwqHjejB/RSfJNza3VlZGmeArEg83Q9pvm2pBjemkdHQ+fNX38oeG5oPg
         oRxxAmG6IL7lDwPMlAHiySdv9pkCamyNf9oQhcsieNPGxZwwAvX2+Lkg7RIVgC08DXa4
         3hPt3KTTnHUD0og1nzbiY4pg8u9UPSPnyN1mFWYJ8/bGF4kWfXuBQ3gNE1CosNTSSLP8
         1pGg==
X-Gm-Message-State: APjAAAVrygemipBUFnfE4fpDDo5/1K75HTKbnvHRfBzNdKkpmItDPpRf
        NVyjB0VUUwcVVgytdVv8GP1OwA==
X-Google-Smtp-Source: APXvYqzJ3dlSV6eQsQZzATJQq1zPRD5tE6hnql1aWMg4ppBR7Kgyqaf4MeAyrbqGi/v9F6wemsMtbw==
X-Received: by 2002:ac2:457a:: with SMTP id k26mr5602909lfm.161.1556995108764;
        Sat, 04 May 2019 11:38:28 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:28 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 02/26] lightnvm: pblk: rollback on error during gc read
Date:   Sat,  4 May 2019 20:37:47 +0200
Message-Id: <20190504183811.18725-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

A line is left unsigned to the blocks lists in case pblk_gc_line
returns an error.

This moves the line back to be appropriate list, which can then be
picked up by the garbage collector.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 901e49951ab5..65692e6d76e6 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -358,8 +358,13 @@ static int pblk_gc_read(struct pblk *pblk)
 
 	pblk_gc_kick(pblk);
 
-	if (pblk_gc_line(pblk, line))
+	if (pblk_gc_line(pblk, line)) {
 		pblk_err(pblk, "failed to GC line %d\n", line->id);
+		/* rollback */
+		spin_lock(&gc->r_lock);
+		list_add_tail(&line->list, &gc->r_list);
+		spin_unlock(&gc->r_lock);
+	}
 
 	return 0;
 }
-- 
2.19.1

