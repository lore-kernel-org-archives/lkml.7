Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6279FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296D9214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRerCR5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfIPEq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 00:46:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41743 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfIPEq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:46:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so19047187pgg.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eZFkBnflecr+DvKcb7QmnRx1V4AOQ4wu/rTk5RgsQlE=;
        b=GRerCR5mayXn8ulWUW1HvXXend3toobCOp29hKe9BSHh3KDRoW9STMgGkvMr0s3j7y
         sR9Cfcu4sqkYO9uYRUU3Ldzx/b1gOT9uYiyn1TUn2X24dFT+Aakxvqub6ODcSFZ8RTc1
         sjhJAlYiGajTxbEDupG0gu3aKvGT6wY0hXHtqx45EVx9XQCCWVcng7tPc/elJZR/4NOw
         LCWM1GbyLxnuoUMhA/UMsfCBm838zYeWrGOCwqo7nECoPmaYWtOX/RDLttQUZeC7o/PB
         acveA2TaxK/KmLAnyBJHS53JI+O+ZkAn2XRkphXS3ATH1xo6H/4C3t6rKOe6R9E8vm2S
         /KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eZFkBnflecr+DvKcb7QmnRx1V4AOQ4wu/rTk5RgsQlE=;
        b=uANZx/XUQ+BOuF8aG5rZGGrw8gxanrwG4oqtDbsGXsVIRqRr+i+VAWOJmXWvbDpRE0
         E8G1ZihcJ2xL87Bz04z0a+UmXSLmRLoi1LE8y4jUqbfehfWeELN97hWme0yaIiWgHN0q
         8onsjKVQjzNsw3Bhl9+7817YdJyVlxn4/8zxwgBBCcWTxJg6N10hSASP0dqBYbFZA0qA
         bDQRDKqVl8U09xpWcYxf2LWwzNnFlfwKQeqYd96Oj0EAUQjmD5QzIi3Lw2+sKTrJ4pCP
         4/pf4poy+8H8MH5ew0c/r6Vb7wtG3zZujO77OMfHo2rOyDrZ5NBUT6TXPQJNSHS5yXOJ
         sRRg==
X-Gm-Message-State: APjAAAVPzWBlkGPv36TtfsLIX0FArJJjJZezzFLsdJEBaVvydSsS/j4+
        49iNSummmyEI2KSNCYvKDys=
X-Google-Smtp-Source: APXvYqwURLPCh7octjiUsD/AciT+W+XRQZ3HOhIT6iQWWnu5H75FNN8UbaqElu7/h1yhBEWH5uaobQ==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr18346227pjg.80.1568609217015;
        Sun, 15 Sep 2019 21:46:57 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id 22sm6090674pfj.139.2019.09.15.21.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 21:46:56 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:46:51 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Roman.Li@amd.com,
        yamada.masahiro@socionext.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Message-ID: <20190916044651.GA72121@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc throws compile error with below message:

HDRINST usr/include/drm/i915_drm.h
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/Makefile:70: *** missing 'endif'.  Stop.
scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
make[3]: *** Waiting for unfinished jobs....
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/drm.h
scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm' failed
make[2]: *** [drivers/gpu/drm] Error 2
scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu' failed
make[1]: *** [drivers/gpu] Error 2
make[1]: *** Waiting for unfinished jobs....

Add 'endif' to Makefile to stop compile error.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index a2eb59e..5b2a65b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -44,6 +44,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
+endif
 ifdef CONFIG_DRM_AMD_DC_DCN2_1
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
-- 
2.6.2

