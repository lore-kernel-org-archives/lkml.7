Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B26CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C120717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTT1qL4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJ2JQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:16:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35835 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfJ2JQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:16:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6so3222835pln.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxVCTrKNjWhjlkyA4a4PjlbJLD0+omh4Y9cUtwpdEOA=;
        b=YTT1qL4qmvHYO9gVLxUbJqc0lYWx8cwPWmKWLfFdXvGIPcSSnenZWgFrca+1x7sc43
         6BVik0e77zA0RyY9fp65ozg5QbUU6lsHWoTWfTIMXBmHIDMrbUkia6LAgNwKLD4mfg9K
         cH9ZfRjJIIfYvWFYZ/sOEM0XuRzcy7V/JeTS5P1JeX3Ufjm+3GRHJfLjHiHiUvN0b2di
         z+IAcM/Jyr3RsXRSPEWPavS0BIm2PuEdzTaORCsQBQli/Dh+q5xK/76ttc2EsBD3v4y4
         jC3EPA0dSQ44/J47btZe3F9In6rzsWKo12ik/e82+WFHbxyrFkJ7Qdc71Bb4RgY9yFmP
         uApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxVCTrKNjWhjlkyA4a4PjlbJLD0+omh4Y9cUtwpdEOA=;
        b=gnClPIOVdg+dd1lnrK/NKh23A5lsUqDX6IpRV86Pz2mlbxmF+XpyPx/iWplu7rUQDj
         5++GpRoxtmwCrtATapL7kdnfT7vRG5wkMbBqXqjhofRDoq5i/jej0Ht0VOwtwxcV+iXt
         i3QCVJZk/r9wFKPrmJYektUwgny+UB5EXFb7ljiXFgxvdwl19ZurOeSovi5bWG5BcO5I
         OlBunVK269RI8kiFhoUEq6NyKEykStl5mF2oHkoHWjK/kvI1HlLvcorIPvx1V1Sj4IvK
         ONDjxjDkTUml893VdEUCc2B8vA8du4ICNLQFgMqj0WJ91LzMsdJXRQ0u3t6cz//lUxYG
         bH9A==
X-Gm-Message-State: APjAAAVGros0UzutNsKIuqYinEvCIhXTUtmYgt6yViVt4gCZIn4PNtKP
        Jq2rJkNmMdFF4sMJ8m7oKos=
X-Google-Smtp-Source: APXvYqykXnxVExXdjyakWUi5HwnsRYnF0kqMc578j2xedEQEESIjGpSSAd3+1QNUsJuBEWD/uoBNHA==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr2960149plq.27.1572340607796;
        Tue, 29 Oct 2019 02:16:47 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id g18sm9910556pfh.51.2019.10.29.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:16:47 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (missing blank line)
Date:   Tue, 29 Oct 2019 02:16:35 -0700
Message-Id: <20191029091638.16101-1-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging.
 drivers/staging/kpc2000/kpc2000_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 6ba94b0131da..5712a88c8788 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -50,6 +50,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
-- 
2.20.1

