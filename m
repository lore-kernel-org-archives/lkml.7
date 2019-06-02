Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B1C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A86B27975
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYvCheit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFBP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:59:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37051 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfFBP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so6843035qtk.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+x69TcqR+bFk5ojFt7qJV1dRlBhJRgOfaQiTn1tZPS8=;
        b=MYvCheitu3trQbthrCc+NFtNRsCrAR0AMpD2tJHUlLfNo3NAxwCOI08WShtnySj6Lx
         4S95Rt70PtwzG5dzxZh4Z2SykzZgIEWiHW+dOJi/LAI8Swf/NIJROgPvx+8EfncWdSNR
         5FH0cayP0kzhWdojRYM1FeqLGGONVmBpZ36e6/ttlVZMWIu40UhLcSerIk+EmaPZkyz/
         JsRiHN4EzcULpDLEzME+p0e0oAeWkLOnix0Er6dV4xN744QJoQkXU7NgYQy4MiwTPa43
         v7b5CT/tTr+lVF+vkHnF3uXRnFkMhFNzSWRGn4v5LVzUT022VoTYBwSPCIK8IDhSWEf1
         Pr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+x69TcqR+bFk5ojFt7qJV1dRlBhJRgOfaQiTn1tZPS8=;
        b=T6HSjSK752UgOdb7x8jJR6B5I8omyb/prmR4oRHzfx3h2veys0enV5APipbv1il3Ac
         4oyzywaPnRHUnXIqZQiqGU8jIOUqgcH/8SuGrGb8isZdKbjLWkvB2CpuUyeA1BrPyv+k
         1czptf2ek876ncFG+oEaNDqwsl4jEgVjQ7nFFps6tSV1SKPSBH8YimBEutYl1b8nPfiG
         YwkTg7cAYzr45HBXYng2C21VbsdQVo2kZVnGeeLGsmwohTwdfIIdU1Y54QUrcJWm9Ed+
         dxvFs8Co+tq5bd34Lsb+th9VOS3RS8CIPi1i80b0j881tbzhjgA10TT2L2tXN1XD3P6J
         8new==
X-Gm-Message-State: APjAAAWCDvIE24BtOahuCdJcZ4XHfAmjrmSMq16zhGLjnfsleYPHxZUB
        hftF2SU4hFddr/4EknUJvp0=
X-Google-Smtp-Source: APXvYqyWB7XjANhzDLQmvPMM3f7fCuYB6dOenwwz6hucZ/BpvdVr4r69D3ginhLR0O6khN2GZ/qjmQ==
X-Received: by 2002:a05:6214:206:: with SMTP id i6mr13189095qvt.169.1559491159296;
        Sun, 02 Jun 2019 08:59:19 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:18 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: kpc2000: kpc_spi: remove function kp_spi_bytes_per_word()
Date:   Sun,  2 Jun 2019 15:58:36 +0000
Message-Id: <b086eac79a4061c7cd67bd587de9d302f9820610.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559488571.git.gneukum1@gmail.com>
References: <cover.1559488571.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static function kp_spi_bytes_per_word() is defined in kpc2000_spi.c,
but it is completely unused. As this function is unused, it can and
should be removed.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 049b1e324031..b513432a26ed 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -162,20 +162,6 @@ union kp_spi_ffctrl {
 /***************
  * SPI Helpers *
  ***************/
-	static inline int
-kp_spi_bytes_per_word(int word_len)
-{
-	if (word_len <= 8){
-		return 1;
-	}
-	else if (word_len <= 16) {
-		return 2;
-	}
-	else { /* word_len <= 32 */
-		return 4;
-	}
-}
-
 	static inline u64
 kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 {
-- 
2.21.0

