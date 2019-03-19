Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938142146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9AM4YQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCSCUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:44 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53941 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:41 -0400
Received: by mail-it1-f194.google.com with SMTP id w85so6997958itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cj86xX4XozhEzBWPSaIZD8xNHra5AQsgtyWOlTKAxcE=;
        b=f9AM4YQMr4y4PVVPppaa6Jluq1ZnsgjMb7yYGX3qrVRrnnGqCdVFBxXKRIkoD4FbjE
         3X9M5hUyIwaAmW7BhF9tDEbkxw8vHCRZg+9OKMPGeluXwzhbQQD4iN98XzjMWafQ3cJq
         dPk4xZOgRVxGR5PKFoCOwtvGseKc4B/ng9bmOkzjHo/Fg2DfCitXwevebed3pnIY8dZv
         l9iWHOXz269RQYY5bEmK3OQnux7cnvudIilfqepkfiJWDDpiDq25ZNZ1Ssn6lgE6FfAe
         uCuHBOD39cF5u30rTWp9gxS38T/VsL8dPAH1BuBLco9WQhRF2QsEjLqNHs46wBqQbYBx
         gIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cj86xX4XozhEzBWPSaIZD8xNHra5AQsgtyWOlTKAxcE=;
        b=fqegQ2uiYLc11vvxwCBuieXyA5MNbeEaC+xpQT++gJ8Dyjx+wND4VbIFM2oTlOf+9U
         FaZ4ZH7HxUtJnsB5dyXa1o//6ydiy3TDLPgW1YUMVXoXQtFGY8S7I3vr0TFg+Z5Tou4u
         DYr9g8gA3u2aRFhpMpmdvqs8Rd0ohs9ESBMza1h87FSfOeQLgR2Cv7JO2QzC5rr+JpBc
         gj8EuU7nNoCBYLxUdTSzQdpPgmjVrSufy0QBUGiFwuSdSGO5Tyb0yJJUPn/BmCKk1SI5
         /JV4KqcZwrXHcY0Fk+q+b47ZXxsft2vprzEQy1u7/o2lpakyvzeZDLxKhln7ho2rd4yq
         ICZw==
X-Gm-Message-State: APjAAAXfVNc+JD9ccTgeQq6A+Yw4BiY5atF7b05kiH1CI7282813cdU9
        nE3D1czBO0SRAsGy14q0hoI=
X-Google-Smtp-Source: APXvYqzG+ar6Y8pBY7mR2M4rdK/LuvD4Jruap9WhbX21KN7yNPz6OcQGuW8VYUx94SdZGtLQ+obU1w==
X-Received: by 2002:a05:660c:6ca:: with SMTP id z10mr41362itk.171.1552962040583;
        Mon, 18 Mar 2019 19:20:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:40 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 07/11] staging: mt7621-mmc: Check for nonzero number of scatterlist entries
Date:   Mon, 18 Mar 2019 20:20:08 -0600
Message-Id: <20190319022012.11051-8-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer descriptor setup loop is correct only if it is setting up at
least one bd struct.  Besides, there is an error somewhere if
dma_map_sg() returns 0.  So add a paranoid check for this condition.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index c272aa780719..31c5b44bd29f 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -593,7 +593,12 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	struct bd *bd;
 	u32 j;
 
-	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
+	// Shouldn't happen; we configure the mmc host layer
+	// based on MAX_BD_NUM:
+	BUG_ON(sglen > MAX_BD_NUM);
+	// Correct setup below requires at least one bd
+	// (and dma_map_sg should not return 0):
+	BUG_ON(sglen == 0);
 
 	gpd = dma->gpd;
 	bd  = dma->bd;
-- 
2.21.0

