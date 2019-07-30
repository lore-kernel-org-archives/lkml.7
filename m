Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF614C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3482064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQWasVmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfG3TIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:08:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37429 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfG3TIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:08:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so30325757pfa.4;
        Tue, 30 Jul 2019 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RwScSV2tOJrhTcKuLdNlPuzxyeuThbTOgSuSjKvnN1g=;
        b=XQWasVmxIMhThkuU7Gh1OJvZv2+json5GP9QnFWuixG9f7fDcct19H9If6CEMnD7eW
         9nzRzPiKC+QQOAPtxX3Mw1tKt8mOaqjco4tHGn0Ht/L1zN5l8U3Fbd4F2xBWS7xBH/4t
         eGvo6uTJ0MxSkEPEd550gteKyHxCGIqYZ84d6Au6Oyu61Hp0hCH5FHQmUVCgnVPKNWlD
         nf7FXr2idHirHJvP4WNMCf61pOB2ddar7LA40NHi5nvEQUZuNhRrFmESYCI3lSfQ0kgG
         tkhmVEAWnDIAsICM14mn0wKTkIylFYZR8pw8Yfi8Ps2il0H8c6VqRyTcaJ1BR8ZawE20
         lq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RwScSV2tOJrhTcKuLdNlPuzxyeuThbTOgSuSjKvnN1g=;
        b=iZZcFaM2oX7R1uPJ4CpaO6FFUwcbjYwlf9GcFuyqr8BlN7KxhJVdhEvO8xq98TKcnX
         p8CPq2R3T1EppIJCoHVR82bWnof7PkWNTJYY2VC0RHl7CmoPO51eLDsm3hyHQN97aWiV
         xlIUQh9p9Be8gtDvJP1n4lOJtnQ424J9FQpr1hOWkCADzVA8V/TcVzG14sBahcSuni/4
         kVRC1LP5UrwJRvsW0WwVKXhj+7bwDX4wr/GqLDrxRgHT74lynwRETIzVmUzKB4GY7nTF
         a0XsW8Jk1dbaBo+dEFLRJhhvvn6f5JfNCOlXPguDyS94XUhfPowIvLHu7j6wSP/tQGUf
         cq7A==
X-Gm-Message-State: APjAAAUtmBK/pN+v5gHNSzDhAOrHbEbLkOeLFuV2redbOV+eq0sUc0AK
        sEx2cFFvbFtucmun7kglnjIvGVsL
X-Google-Smtp-Source: APXvYqxZziQLkWNns8ll7Je6JLU0I//8d41DN01Gya+68dE0jvgoh8GXeFrG3iABxQMHIz6CCgFpEQ==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr84913057pje.129.1564513727854;
        Tue, 30 Jul 2019 12:08:47 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.16.0])
        by smtp.gmail.com with ESMTPSA id c12sm53416324pgb.83.2019.07.30.12.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 12:08:47 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     paulus@samba.org, b.zolnierkie@samsung.com, davem@davemloft.net,
        mpatocka@redhat.com, syrjala@sci.fi, sam@ravnborg.org,
        daniel.vetter@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video/fbdev/aty128fb: Remove dead code
Date:   Wed, 31 Jul 2019 00:44:13 +0530
Message-Id: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is dead code since 3.15. If there is no plan to use it
further, this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c   | 18 ------------------
 drivers/video/fbdev/aty/atyfb_base.c | 29 -----------------------------
 2 files changed, 47 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 8504e19..fc1e45d 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -487,11 +487,6 @@ static int aty128_encode_var(struct fb_var_screeninfo *var,
                              const struct aty128fb_par *par);
 static int aty128_decode_var(struct fb_var_screeninfo *var,
                              struct aty128fb_par *par);
-#if 0
-static void aty128_get_pllinfo(struct aty128fb_par *par, void __iomem *bios);
-static void __iomem *aty128_map_ROM(struct pci_dev *pdev,
-				    const struct aty128fb_par *par);
-#endif
 static void aty128_timings(struct aty128fb_par *par);
 static void aty128_init_engine(struct aty128fb_par *par);
 static void aty128_reset_engine(const struct aty128fb_par *par);
@@ -1665,19 +1660,6 @@ static void aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
 			  struct aty128fb_par *par)
 {
 	if (par->chip_gen == rage_M3) {
-#if 0
-		/* Note: For now, on M3, we set palette on both heads, which may
-		 * be useless. Can someone with a M3 check this ?
-		 * 
-		 * This code would still be useful if using the second CRTC to 
-		 * do mirroring
-		 */
-
-		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) |
-			    DAC_PALETTE_ACCESS_CNTL);
-		aty_st_8(PALETTE_INDEX, regno);
-		aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
-#endif
 		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) &
 			    ~DAC_PALETTE_ACCESS_CNTL);
 	}
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 72bcfbe..6dda5d8 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -1188,19 +1188,6 @@ static int aty_crtc_to_var(const struct crtc *crtc,
 		(c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);
 
 	switch (pix_width) {
-#if 0
-	case CRTC_PIX_WIDTH_4BPP:
-		bpp = 4;
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		break;
-#endif
 	case CRTC_PIX_WIDTH_8BPP:
 		bpp = 8;
 		var->red.offset = 0;
@@ -1466,11 +1453,6 @@ static int atyfb_set_par(struct fb_info *info)
 		var->bits_per_pixel,
 		par->crtc.vxres * var->bits_per_pixel / 8);
 #endif /* CONFIG_BOOTX_TEXT */
-#if 0
-	/* switch to accelerator mode */
-	if (!(par->crtc.gen_cntl & CRTC_EXT_DISP_EN))
-		aty_st_le32(CRTC_GEN_CNTL, par->crtc.gen_cntl | CRTC_EXT_DISP_EN, par);
-#endif
 #ifdef DEBUG
 {
 	/* dump non shadow CRTC, pll, LCD registers */
@@ -2396,17 +2378,6 @@ static int aty_init(struct fb_info *info)
 			par->pll_ops = &aty_pll_ibm514;
 			break;
 #endif
-#if 0 /* dead code */
-		case CLK_STG1703:
-			par->pll_ops = &aty_pll_stg1703;
-			break;
-		case CLK_CH8398:
-			par->pll_ops = &aty_pll_ch8398;
-			break;
-		case CLK_ATT20C408:
-			par->pll_ops = &aty_pll_att20c408;
-			break;
-#endif
 		default:
 			PRINTKI("aty_init: CLK type not implemented yet!");
 			par->pll_ops = &aty_pll_unsupported;
-- 
1.9.1

