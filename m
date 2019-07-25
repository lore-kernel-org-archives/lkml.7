Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620B721871
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEdHBdGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbfGYI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:27:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389623AbfGYI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:27:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so23022047pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XrnR0ob5JN+jXhmz3b6uLie9luXhbO1bl9luxd0o9lU=;
        b=uEdHBdGN1tspb+2pw1vjjIP9TPRoE69vcLhIkbQ3Buu7aF3UPsHXWe2IGuA3tRNBVq
         eZXOen8g79oqskTFwJi1T4z8wTYMs5sHGS0dqZWc/XYrk3vIl90BAeCwfVc+QcLwYOQz
         684c2rKuEzuenlNVqPQqjGAjSAeU3XELQqNfmTeBKmIgEEhwTS98qHi5dH17lvRp0YYC
         s6m0F+PUjW1Agvc//exnF281ZadBdvEmKtcTVmcM4wsV2N3OFyRGwROU1WbmN1p0uxrN
         60cn7S8wSpSNHW/6RJ3ewRADxQ2F1NIrCVVYAo4bhsdyT7rNAgsxSWrJB+GgjsoyU1uJ
         Rx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XrnR0ob5JN+jXhmz3b6uLie9luXhbO1bl9luxd0o9lU=;
        b=SWGxaRhKlKg84l6IN84NL13Pu0j+NgxtOxXauZhBBoXIMBUcGw/Ono9Ym2mTbNOf2n
         NdlVqBYrGuPGtBAQ5P07sYX4drWdaHtrAPqPCeSUibPIJkwxX/ky+UgOwq0cDLjSDle9
         uehHGTdhd/9eXDnU8+UN9EpZHG+Ai1G8E/Yw6+2WbADEJkMDM4lHGpSTYR0v747nPUaQ
         j5+k2f4HqG+zTUymN4Pze3ltrpvKxyfDsrpQrbA1yAj6Tq46MVhKbfmvlda+tWnp2txg
         A8TmXxi5IWWI9C/o0SD1beKbncFKH9uhna89g+91irtKQV+UzeYF8KLKSHjZUN32P1e2
         xcgQ==
X-Gm-Message-State: APjAAAUgP0vRViTsc6LzmLFWIwYefKtRm7bv6IYGfi15DrIo6CYgHxL/
        8SXYAEUO28L69jr2qjs5rEHzI5u17QQ=
X-Google-Smtp-Source: APXvYqww6hvROz9O0Lb5ItTHVgyKuuT2KrkP+kX9Gqvrb1HRFc/sHhySqFiHwAfn8TyH0dHBPbAzXg==
X-Received: by 2002:a17:902:e383:: with SMTP id ch3mr89404861plb.23.1564043260596;
        Thu, 25 Jul 2019 01:27:40 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id 201sm58677399pfz.24.2019.07.25.01.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 01:27:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: i2c: ak4xxx-adda: Fix a possible null pointer dereference in build_adc_controls()
Date:   Thu, 25 Jul 2019 16:27:33 +0800
Message-Id: <20190725082733.15234-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In build_adc_controls(), there is an if statement on line 773 to check
whether ak->adc_info is NULL:
	if (! ak->adc_info || 
		! ak->adc_info[mixer_ch].switch_name)

When ak->adc_info is NULL, it is used on line 792:
    knew.name = ak->adc_info[mixer_ch].selector_name;

Thus, a possible null-pointer dereference may occur.

To fix this bug, referring to lines 773 and 774, ak->adc_info 
and ak->adc_info[mixer_ch].selector_name are checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/i2c/other/ak4xxx-adda.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 5f59316f982a..9a891470e84a 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -775,11 +775,13 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
 				return err;
 
 			memset(&knew, 0, sizeof(knew));
-			knew.name = ak->adc_info[mixer_ch].selector_name;
-			if (!knew.name) {
+			if (! ak->adc_info ||
+				! ak->adc_info[mixer_ch].selector_name) {
 				knew.name = "Capture Channel";
 				knew.index = mixer_ch + ak->idx_offset * 2;
 			}
+			else
+				knew.name = ak->adc_info[mixer_ch].selector_name;
 
 			knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 			knew.info = ak4xxx_capture_source_info;
-- 
2.17.0

