Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F641C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACED206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gztPNJBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCBUkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:40:17 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49550 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfCBUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 15:40:17 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id B8732CFD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 20:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7h3wbAyVR6hX for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 14:40:15 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 86B3293A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 14:40:15 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id k24so1235667ioa.18
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y0xx9CNXAixKOH4s5a9j3si4MaIeGUmv4k00ayMuflo=;
        b=gztPNJBLGbWlOJbSRex3nzA5ccPx7vtzkktwN6hbhpQ1D4PZSQRZOSLhtM9lQniHOQ
         ENluWtq09STllAwZ4W9LMdZklm8BCpLSlgMcXWVo1MmTg7+IjN23XVqov8dUeC2mxPLr
         kTGNPlSO9P0dBFs7X023jWPCNfHtq0IWPMUBC2ZmSH3YeEETxf41YPEaVaNuGx+xb4Gy
         7Ir//uFI+dmz5HxIxeVum0xJPsncaJLEGNzuskYa8qtPQHaThh0DGPX5YSykYl7Vn3Sa
         /fmly4T/eZkaZrUXqV3toWM2IBNZLymuM0T9gg11E9CuBeS+r+BBZXSfK6tQpgFwqbMd
         avbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0xx9CNXAixKOH4s5a9j3si4MaIeGUmv4k00ayMuflo=;
        b=YfZLFX8TM9yKsx3JS0QqnBeXejlusRADjasJ8wZBgzdtM6caMUWxOssecLNT1f5gLD
         wcz/+3O2pl5PSsWjG9a5eVekpeeI4eEZDxFsa5lKhgn7jRXkXy27HSBHcYsD7TiEUOVJ
         vQYqWWl6d4rpa3O0WsH4yK4Y4JIAH4WGHcwiCNc6uSCVDW5Wasg2ue8idQ3l84bXeZaQ
         /EzPYCW+CpUhJCTpUhj8KPz5LXUHOeTSfrIraRHaKBIjV5udymsWZmgcS2wvcSYAd9Dj
         0B/+0kb5URtvwUDB4t+ixzfEDITmHjafz8Pm3tFJP8PfZQtnND1qTr64aiossWZwk0/Y
         +z+g==
X-Gm-Message-State: APjAAAWqGPmOmMA1C/SssUFib3MXhVzRgulHC1oYGzQs6i9QjVX3VE1i
        tgMrvKRbSFkfU6IAgQXxAckHZx228ozC0S5IbURqMSrOvoxqFcnn1mmMJ3ydvszGxjaqr0gmlRq
        p+6LhGBBoORSVz+bHMxnQdWkn5JtV
X-Received: by 2002:a24:9403:: with SMTP id j3mr1235072ite.44.1551559215171;
        Sat, 02 Mar 2019 12:40:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFPLCWGb3LVhLsQB+BEE5/Cy74SW7BlFPgT6WLuCdLF/CUN441tV1U3tjfyq2f9sYQBipGSQ==
X-Received: by 2002:a24:9403:: with SMTP id j3mr1235060ite.44.1551559214949;
        Sat, 02 Mar 2019 12:40:14 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p141sm900936itb.39.2019.03.02.12.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 12:40:14 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] omapfb: Fix potential NULL pointer dereference in kmalloc
Date:   Sat,  2 Mar 2019 14:40:04 -0600
Message-Id: <20190302204006.9953-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated, using kmalloc, for new_compat may fail. This patch
checks for such an error and prevents potential NULL pointer
dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
index 136d30484d02..0592c436b2da 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
@@ -111,6 +111,8 @@ static void __init omapdss_omapify_node(struct device_node *node)
 
 	new_len = prop->length + strlen(prefix) * num_strs;
 	new_compat = kmalloc(new_len, GFP_KERNEL);
+	if (!new_compat)
+		return;
 
 	omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
 
-- 
2.17.1

