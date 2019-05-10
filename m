Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4562C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2412084A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTuSMAv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEJWfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:35:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfEJWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:35:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so3932007pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hV5HxwGs7gY03wK3rK8o6uhUFP9lcwaLtj0H4FYh2dk=;
        b=lTuSMAv25fNL9J/QKC0HQ9qmLRckYs3hBlUXs/+YYhydsEvcq+SyATaNCV1rCMDz89
         BSTK5DP0LEnWSGUhOyGTr7I5U8Bw2WIhDsXgnfcmHVBa9ofbOBqOcP7XWDZOJDMDbQga
         4Sw5ibIdQSa7/HY4XS9y5VByC3g0GUYAx2VI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hV5HxwGs7gY03wK3rK8o6uhUFP9lcwaLtj0H4FYh2dk=;
        b=c2eBlQYUtjdydXYFTSgYXeCieitKlmy6u3QkMyN/hwdbttqE1jkrJbPkp9D3G/mut5
         r6CkpgX0o1GPxQ1jGmCCdloRWfQQqZdGWUxH3Ez7BwwQbYvnXF3mXLweYUAiWynZ0gv+
         Q46V76oFYzgvCjFw68+l7B0vK5PijRqrpaGLHUjOyiabUuewMjt1UVVGnQ3r1tu5WHkN
         KsHb3XXiT2YbIpSTe8KRwRjQEy+vJK9Mfni4Koj4yV6I/yaC/hE/om/nf4YHvOpMbkhW
         AUOuWhIeT0GI+PbxJKZlhf6JEMdYUPBiCAvsLxrWuxvSzzBiNHZSwrCu5mZyTpICbZf+
         td/Q==
X-Gm-Message-State: APjAAAUetFOQDY0hK72PrZJ+uuzrS4ou8cMxBUARdnoYEWJ8q6tO7C7O
        CgMwwYdHXrxbsNMPyRWC7SQk8Q==
X-Google-Smtp-Source: APXvYqx00UvXi9LVlDxBQ/qgIeKHowFgu4na2sTLOT4tSNXiduy9+oOD4eLycJ+CqSEWgmcp1mI+eQ==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr16401970pgt.75.1557527712392;
        Fri, 10 May 2019 15:35:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j6sm7689393pfe.107.2019.05.10.15.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:35:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 1/4] spi: For controllers that need realtime always use the pump thread
Date:   Fri, 10 May 2019 15:34:34 -0700
Message-Id: <20190510223437.84368-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510223437.84368-1-dianders@chromium.org>
References: <20190510223437.84368-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a controller specifies that it needs high priority for sending
messages we should always schedule our transfers on the thread.  If we
don't do this we'll do the transfer in the caller's context which
might not be very high priority.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..0597f7086de3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1230,8 +1230,11 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		return;
 	}
 
-	/* If another context is idling the device then defer */
-	if (ctlr->idling) {
+	/*
+	 * If another context is idling the device then defer.
+	 * If we are high priority then the thread should do the transfer.
+	 */
+	if (ctlr->idling || (ctlr->rt && !in_kthread)) {
 		kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		return;
-- 
2.21.0.1020.gf2820cf01a-goog

