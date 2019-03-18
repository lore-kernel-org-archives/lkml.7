Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E720854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hA54bfVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCRPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:55:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39112 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCRPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:54:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so1775177pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyk2s9BcFlwoxp6C3yAA1bD4RlL7e+5dFnYps4rvzag=;
        b=hA54bfVAEdqf5ciaOd/IOVKuGsgwpXPkm8NZaZRoRX7yws2lATXZHckOVU2aQIeiFV
         Is9wXOd/ZjEnZy8wXZG3Was51fhxK7Txa5+XBvOMyFE1gZL7L+rrZ2o2SNshPk7NJYVg
         v/qWMF5Xw9PT/ST4j0CO73ubXemxppRhx+tXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyk2s9BcFlwoxp6C3yAA1bD4RlL7e+5dFnYps4rvzag=;
        b=lq0jDBHETUGY+jYPKvuNwqL2zIRFT1n+riS26/ePIh17y/aXTDXw910Xe47tRUmvxp
         mBA0apX48EEaZ1E43gmMiIJvOR9yhJ4xrH+CealyOq6ncFLOAHIx2YdzlFla2igwGuMv
         +1WsSut7GeoamRlOwzejHMpLKGBfTgmP5L5Qq8brfCswQem70zj13LWKz7a+0QcE+yH2
         f+O2feymqAwuhZJAI6IYyX2kHALbsqJeNEuLGQvZM53pCgGhH0f/Ae9q/DT+qaOW0ZC4
         x1TCapdodmZyqbwzLEqtF1SOzYXqzZt4Vm2dR10UUsGN9iT6heX8r+6UpcKkR9XTRCuZ
         qfTg==
X-Gm-Message-State: APjAAAWswLAueDcl7fR/6tGOAVKB8p79BbVTMheN3NpZvW/hYHNheqNV
        GCzCIwDslCUJjFDhy7PBjX78PQ==
X-Google-Smtp-Source: APXvYqyecj2wq3uUR6cZFe+csugvYp+2AONPvTISfLDyjiZ+dxbyxKHwknczf8qnGzaKYB+vHrQlXQ==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr19319566plb.22.1552924498772;
        Mon, 18 Mar 2019 08:54:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s6sm13328933pfm.94.2019.03.18.08.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 08:54:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] firmware: vpd: Drop __iomem usage for memremap() memory
Date:   Mon, 18 Mar 2019 08:54:57 -0700
Message-Id: <20190318155457.197339-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memremap() doesn't return an iomem pointer, so we can just use memcpy()
and drop the __iomem annotation here. This silences a sparse warning.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>
Smgned-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index c0c0b4e4e281..f240946ed701 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -254,7 +254,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 
 static int vpd_sections_init(phys_addr_t physaddr)
 {
-	struct vpd_cbmem __iomem *temp;
+	struct vpd_cbmem *temp;
 	struct vpd_cbmem header;
 	int ret = 0;
 
@@ -262,7 +262,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
 	if (!temp)
 		return -ENOMEM;
 
-	memcpy_fromio(&header, temp, sizeof(struct vpd_cbmem));
+	memcpy(&header, temp, sizeof(struct vpd_cbmem));
 	memunmap(temp);
 
 	if (header.magic != VPD_CBMEM_MAGIC)
-- 
Sent by a computer through tubes

