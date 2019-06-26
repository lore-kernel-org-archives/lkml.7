Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3903216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CkNwh7Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFZUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:00:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37108 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:00:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id 25so554831pgy.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbc5Dh7+LimPALKjevNG5TAL9t57bWZBL2kItsK/MGQ=;
        b=CkNwh7ImC7XRLo+IkDMSV65GVm9m0viwqgH4AavERqe8iu6suGXWtvaUEOEbUOT3Wr
         Od3Vtk8Cjoz/hAPqd1KEq/YT4O8aCxDN8/lTdkHwqmka+YIsPr26ZS9J0caSV3HfN6fB
         9W6mrgrc400ohIbFHSKvo0cHaaF4OOfE1xRm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbc5Dh7+LimPALKjevNG5TAL9t57bWZBL2kItsK/MGQ=;
        b=eXJ4yCUTbbQ1mb/EXBMX6uGJBSexJzPEp7DRX94f6RdqTW3sDkf5AjyRYUHfARVs/8
         BA84PChrfQcIQRESamarWVZrQ22yNEdfX5KafGegp3beUnXQ6AULQqCTJigyOMfFAF4X
         XfMtRZ/BraOH3ZrrF6hnrRLYvQuGNMqqy+Z4QMtk2ixsNzJZL89YOP29fEKViCgnMaXp
         pW5DVewzIuhv7vtg2Sf/2eDcYENfbmOTZXwLlrMIJbGD5+rpLONxgAmCcAKM+jNvpsw4
         j6p8PLig3p53BtzuSmkexOldN/ecV/UvTd2RliC9dbREjeRN6P5lonjU5Oyngbi17dAY
         Zu4g==
X-Gm-Message-State: APjAAAVAjIYkmoQjz07SUF1xRH2QIMS5yDr2WZzKaX4rxhCs5KOeQ+sx
        jTMtN8F/LYRfyJCUtjV8qgjVQw==
X-Google-Smtp-Source: APXvYqwB3pTyrU5OpVfKMXgRlwrNkGcKuGijwGZQPEfQcgd8uyGotsUUkSTgOyEqSDdxAqwt78e5IA==
X-Received: by 2002:a63:c006:: with SMTP id h6mr4516271pgg.285.1561579233579;
        Wed, 26 Jun 2019 13:00:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id e20sm59204pfi.35.2019.06.26.13.00.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:00:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     groeck@chromium.org, drinkcat@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block, bfq: Init saved_wr_start_at_switch_to_srt in unlikely case
Date:   Wed, 26 Jun 2019 12:59:19 -0700
Message-Id: <20190626195919.107425-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some debug code suggested by Paolo was tripping when I did reboot
stress tests.  Specifically in bfq_bfqq_resume_state()
"bic->saved_wr_start_at_switch_to_srt" was later than the current
value of "jiffies".  A bit of debugging showed that
"bic->saved_wr_start_at_switch_to_srt" was actually 0 and a bit more
debugging showed that was because we had run through the "unlikely"
case in the bfq_bfqq_save_state() function.

Let's init "saved_wr_start_at_switch_to_srt" in the unlikely case to
something sane.

NOTE: this fixes no known real-world errors.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
---
Paolo said to add his Reviewed-by in https://crrev.com/c/1678756.

 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 72840ebf953e..008c93d6b8d7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2678,6 +2678,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		 * to enjoy weight raising if split soon.
 		 */
 		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
+		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
 		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
 		bic->saved_last_wr_start_finish = jiffies;
 	} else {
-- 
2.22.0.410.gd8fdbe21b5-goog

