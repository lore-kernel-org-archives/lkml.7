Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE4C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 01:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94AE20828
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 01:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+/lwDK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfGVBOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 21:14:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36632 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfGVBOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 21:14:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so18375415plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxrHh6McJPmb0BUyuKAMGJm5W6/dqmmILsrmEIr6jp0=;
        b=P+/lwDK0UIpfr1x1UkpSWMcSg5+D0RjXDcAO+gYmB3Jgdn7EZZgiLqGcDKwMLrrGNM
         iG/KzA0SulLfVQYD2a4Eq3kiukTDvkbwBZA50rK20Zhg9MJ2TEQuwo7PkZWpi4+jdJ8M
         phsOXEu9STOHF7le6eInUV3tip2Rsbs7rF+XpgnkLRQ4eAastivO0bmbmbZERBECX2in
         6MMr5JnX93ZN2vd63HS/CiWaq73cclV5Br0KVhh+60mD7EVhmHsZZzsvOF4d4fJ62LJ0
         DuK7pdc1VQdfiyKx7WOLne6wjED5+K0I+LJWyZZ5+tWEqEtsiWbW60pKL2ozoBLbDpdf
         3tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxrHh6McJPmb0BUyuKAMGJm5W6/dqmmILsrmEIr6jp0=;
        b=srFRgfpLzNs3gANUaFe/K5oNZB1O41iuAzbMLGD1/PC/uu0InoHc90SgtU0VBjhtOB
         S7JzkPnESFNTKaUEPP3BgCLmPqTZEMaBRjz03uvxcN/QXrSjgt5b/8OqMTuk2lvrzw+g
         05uE72kiybcL6LjuPievbxGEG1SjOOrxS2Sfh2h2EOKhGmHj8RZIoHd32Neh/kdK57Km
         TwWp0haOy0N+mNcPdWyY687vxiy5twhjfPkps5DyNuHJBzNROkJRbSd/CDe0pEKNcXkA
         2oKbEIIQXDpgmumMBvCjUQwehCsPgkFV1vWpZbIS424/Zrr2UFsagk6Z0y0MTc2CMMyb
         wF1Q==
X-Gm-Message-State: APjAAAXs+CagPNnwjDQgOLG6JkXwhXzmo14/ef10dT59sn9pGnttMFss
        np2l9gkBL2r3qI19PEqsNKh3ynxE
X-Google-Smtp-Source: APXvYqzKVYMjneN4Cd4DN6quxs63G+wGApc4HOB0WPcViT7628Fcf6IprlpO02mHkx57G3A+YoEKWg==
X-Received: by 2002:a17:902:d81:: with SMTP id 1mr75352868plv.323.1563758086141;
        Sun, 21 Jul 2019 18:14:46 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id j5sm31758426pgp.59.2019.07.21.18.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 18:14:45 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v2] video: radeon.h Fix Shifting signed 32 bit value by 31 bits problem
Date:   Sun, 21 Jul 2019 18:14:32 -0700
Message-Id: <1563758072-898-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <46c5dc00-eb00-e229-62af-6e171f9f2a40@samsung.com>
References: <46c5dc00-eb00-e229-62af-6e171f9f2a40@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix RB2D_DC_BUSY and HORZ_AUTO_RATIO_INC defines to use "U" cast to
avoid shifting signed 32 bit values by 31 bit problem. This is not a
problem for gcc built kernel.

However, the header file being a public api, other compilers may not
handle the condition safely resulting in undefined behavior.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v2:
	Replace bit shift operations with BIT() macro

 include/video/radeon.h | 338 ++++++++++++++++++++++++-------------------------
 1 file changed, 169 insertions(+), 169 deletions(-)

diff --git a/include/video/radeon.h b/include/video/radeon.h
index 005eae1..65bf5cf 100644
--- a/include/video/radeon.h
+++ b/include/video/radeon.h
@@ -183,8 +183,8 @@
 #define CUR_CLR1                               0x0270
 #define FP_HORZ_VERT_ACTIVE                    0x0278
 #define CRTC_MORE_CNTL                         0x027C
-#define CRTC_H_CUTOFF_ACTIVE_EN                (1<<4)
-#define CRTC_V_CUTOFF_ACTIVE_EN                (1<<5)
+#define CRTC_H_CUTOFF_ACTIVE_EN                BIT(4)
+#define CRTC_V_CUTOFF_ACTIVE_EN                BIT(5)
 #define DAC_EXT_CNTL                           0x0280
 #define FP_GEN_CNTL                            0x0284
 #define FP_HORZ_STRETCH                        0x028C
@@ -413,7 +413,7 @@
 #define BIOS_6_SCRATCH			       0x0028
 #define BIOS_7_SCRATCH			       0x002c
 
-#define HDP_SOFT_RESET                         (1 << 26)
+#define HDP_SOFT_RESET                         BIT(26)
 
 #define TV_DAC_CNTL                            0x088c
 #define GPIOPAD_MASK                           0x0198
@@ -454,12 +454,12 @@
 #define SCLK_MORE_CNTL				   0x0035
 
 /* MCLK_CNTL bit constants */
-#define FORCEON_MCLKA				   (1 << 16)
-#define FORCEON_MCLKB         		   	   (1 << 17)
-#define FORCEON_YCLKA         	    	   	   (1 << 18)
-#define FORCEON_YCLKB         		   	   (1 << 19)
-#define FORCEON_MC            		   	   (1 << 20)
-#define FORCEON_AIC           		   	   (1 << 21)
+#define FORCEON_MCLKA				   BIT(16)
+#define FORCEON_MCLKB         		   	   BIT(17)
+#define FORCEON_YCLKA         	    	   	   BIT(18)
+#define FORCEON_YCLKB         		   	   BIT(19)
+#define FORCEON_MC            		   	   BIT(20)
+#define FORCEON_AIC           		   	   BIT(21)
 
 /* SCLK_CNTL bit constants */
 #define DYN_STOP_LAT_MASK			   0x00007ff8
@@ -500,11 +500,11 @@
 #define PIX2CLK_SRC_SEL_PSCANCLK                   0x01
 #define PIX2CLK_SRC_SEL_BYTECLK                    0x02
 #define PIX2CLK_SRC_SEL_P2PLLCLK                   0x03
-#define PIX2CLK_ALWAYS_ONb                         (1<<6)
-#define PIX2CLK_DAC_ALWAYS_ONb                     (1<<7)
-#define PIXCLK_TV_SRC_SEL                          (1 << 8)
-#define PIXCLK_LVDS_ALWAYS_ONb                     (1 << 14)
-#define PIXCLK_TMDS_ALWAYS_ONb                     (1 << 15)
+#define PIX2CLK_ALWAYS_ONb                         BIT(6)
+#define PIX2CLK_DAC_ALWAYS_ONb                     BIT(7)
+#define PIXCLK_TV_SRC_SEL                          BIT(8)
+#define PIXCLK_LVDS_ALWAYS_ONb                     BIT(14)
+#define PIXCLK_TMDS_ALWAYS_ONb                     BIT(15)
 
 
 /* CLOCK_CNTL_INDEX bit constants */
@@ -514,59 +514,59 @@
 #define CFG_VGA_RAM_EN                             0x00000100
 #define CFG_ATI_REV_ID_MASK			   (0xf << 16)
 #define CFG_ATI_REV_A11				   (0 << 16)
-#define CFG_ATI_REV_A12				   (1 << 16)
+#define CFG_ATI_REV_A12				   BIT(16)
 #define CFG_ATI_REV_A13				   (2 << 16)
 
 /* CRTC_EXT_CNTL bit constants */
 #define VGA_ATI_LINEAR                             0x00000008
 #define VGA_128KAP_PAGING                          0x00000010
-#define	XCRT_CNT_EN				   (1 << 6)
-#define CRTC_HSYNC_DIS				   (1 << 8)
-#define CRTC_VSYNC_DIS				   (1 << 9)
-#define CRTC_DISPLAY_DIS			   (1 << 10)
-#define CRTC_CRT_ON				   (1 << 15)
+#define	XCRT_CNT_EN				   BIT(6)
+#define CRTC_HSYNC_DIS				   BIT(8)
+#define CRTC_VSYNC_DIS				   BIT(9)
+#define CRTC_DISPLAY_DIS			   BIT(10)
+#define CRTC_CRT_ON				   BIT(15)
 
 
 /* DSTCACHE_CTLSTAT bit constants */
-#define RB2D_DC_FLUSH_2D			   (1 << 0)
-#define RB2D_DC_FREE_2D				   (1 << 2)
+#define RB2D_DC_FLUSH_2D			   BIT(0)
+#define RB2D_DC_FREE_2D				   BIT(2)
 #define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
-#define RB2D_DC_BUSY				   (1 << 31)
+#define RB2D_DC_BUSY				   BIT(31)
 
 /* DSTCACHE_MODE bits constants */
-#define RB2D_DC_AUTOFLUSH_ENABLE                   (1 << 8)
-#define RB2D_DC_DC_DISABLE_IGNORE_PE               (1 << 17)
+#define RB2D_DC_AUTOFLUSH_ENABLE                   BIT(8)
+#define RB2D_DC_DC_DISABLE_IGNORE_PE               BIT(17)
 
 /* CRTC_GEN_CNTL bit constants */
 #define CRTC_DBL_SCAN_EN                           0x00000001
 #define CRTC_CUR_EN                                0x00010000
-#define CRTC_INTERLACE_EN			   (1 << 1)
-#define CRTC_BYPASS_LUT_EN     			   (1 << 14)
-#define CRTC_EXT_DISP_EN      			   (1 << 24)
-#define CRTC_EN					   (1 << 25)
-#define CRTC_DISP_REQ_EN_B                         (1 << 26)
+#define CRTC_INTERLACE_EN			   BIT(1)
+#define CRTC_BYPASS_LUT_EN     			   BIT(14)
+#define CRTC_EXT_DISP_EN      			   BIT(24)
+#define CRTC_EN					   BIT(25)
+#define CRTC_DISP_REQ_EN_B                         BIT(26)
 
 /* CRTC_STATUS bit constants */
 #define CRTC_VBLANK                                0x00000001
 
 /* CRTC2_GEN_CNTL bit constants */
-#define CRT2_ON                                    (1 << 7)
-#define CRTC2_DISPLAY_DIS                          (1 << 23)
-#define CRTC2_EN                                   (1 << 25)
-#define CRTC2_DISP_REQ_EN_B                        (1 << 26)
+#define CRT2_ON                                    BIT(7)
+#define CRTC2_DISPLAY_DIS                          BIT(23)
+#define CRTC2_EN                                   BIT(25)
+#define CRTC2_DISP_REQ_EN_B                        BIT(26)
 
 /* CUR_OFFSET, CUR_HORZ_VERT_POSN, CUR_HORZ_VERT_OFF bit constants */
 #define CUR_LOCK                                   0x80000000
 
 /* GPIO bit constants */
-#define GPIO_A_0		(1 <<  0)
-#define GPIO_A_1		(1 <<  1)
-#define GPIO_Y_0		(1 <<  8)
-#define GPIO_Y_1		(1 <<  9)
-#define GPIO_EN_0		(1 << 16)
-#define GPIO_EN_1		(1 << 17)
-#define GPIO_MASK_0		(1 << 24)
-#define GPIO_MASK_1		(1 << 25)
+#define GPIO_A_0		BIT(0)
+#define GPIO_A_1		BIT(1)
+#define GPIO_Y_0		BIT(8)
+#define GPIO_Y_1		BIT(9)
+#define GPIO_EN_0		BIT(16)
+#define GPIO_EN_1		BIT(17)
+#define GPIO_MASK_0		BIT(24)
+#define GPIO_MASK_1		BIT(25)
 #define VGA_DDC_DATA_OUTPUT	GPIO_A_0
 #define VGA_DDC_CLK_OUTPUT	GPIO_A_1
 #define VGA_DDC_DATA_INPUT	GPIO_Y_0
@@ -594,61 +594,61 @@
 #define FP_V_SYNC_WID_SHIFT			   0x00000010
 
 /* FP_GEN_CNTL bit constants */
-#define FP_FPON					   (1 << 0)
-#define FP_TMDS_EN				   (1 << 2)
-#define FP_PANEL_FORMAT                            (1 << 3)
-#define FP_EN_TMDS				   (1 << 7)
-#define FP_DETECT_SENSE				   (1 << 8)
+#define FP_FPON					   BIT(0)
+#define FP_TMDS_EN				   BIT(2)
+#define FP_PANEL_FORMAT                            BIT(3)
+#define FP_EN_TMDS				   BIT(7)
+#define FP_DETECT_SENSE				   BIT(8)
 #define R200_FP_SOURCE_SEL_MASK                    (3 << 10)
 #define R200_FP_SOURCE_SEL_CRTC1                   (0 << 10)
-#define R200_FP_SOURCE_SEL_CRTC2                   (1 << 10)
+#define R200_FP_SOURCE_SEL_CRTC2                   BIT(10)
 #define R200_FP_SOURCE_SEL_RMX                     (2 << 10)
 #define R200_FP_SOURCE_SEL_TRANS                   (3 << 10)
 #define FP_SEL_CRTC1				   (0 << 13)
-#define FP_SEL_CRTC2				   (1 << 13)
-#define FP_USE_VGA_HSYNC                           (1 << 14)
-#define FP_CRTC_DONT_SHADOW_HPAR		   (1 << 15)
-#define FP_CRTC_DONT_SHADOW_VPAR		   (1 << 16)
-#define FP_CRTC_DONT_SHADOW_HEND		   (1 << 17)
-#define FP_CRTC_USE_SHADOW_VEND			   (1 << 18)
-#define FP_RMX_HVSYNC_CONTROL_EN		   (1 << 20)
-#define FP_DFP_SYNC_SEL				   (1 << 21)
-#define FP_CRTC_LOCK_8DOT			   (1 << 22)
-#define FP_CRT_SYNC_SEL				   (1 << 23)
-#define FP_USE_SHADOW_EN			   (1 << 24)
-#define FP_CRT_SYNC_ALT				   (1 << 26)
+#define FP_SEL_CRTC2				   BIT(13)
+#define FP_USE_VGA_HSYNC                           BIT(14)
+#define FP_CRTC_DONT_SHADOW_HPAR		   BIT(15)
+#define FP_CRTC_DONT_SHADOW_VPAR		   BIT(16)
+#define FP_CRTC_DONT_SHADOW_HEND		   BIT(17)
+#define FP_CRTC_USE_SHADOW_VEND			   BIT(18)
+#define FP_RMX_HVSYNC_CONTROL_EN		   BIT(20)
+#define FP_DFP_SYNC_SEL				   BIT(21)
+#define FP_CRTC_LOCK_8DOT			   BIT(22)
+#define FP_CRT_SYNC_SEL				   BIT(23)
+#define FP_USE_SHADOW_EN			   BIT(24)
+#define FP_CRT_SYNC_ALT				   BIT(26)
 
 /* FP2_GEN_CNTL bit constants */
-#define FP2_BLANK_EN             (1 <<  1)
-#define FP2_ON                   (1 <<  2)
-#define FP2_PANEL_FORMAT         (1 <<  3)
+#define FP2_BLANK_EN             BIT(1)
+#define FP2_ON                   BIT(2)
+#define FP2_PANEL_FORMAT         BIT(3)
 #define FP2_SOURCE_SEL_MASK      (3 << 10)
-#define FP2_SOURCE_SEL_CRTC2     (1 << 10)
+#define FP2_SOURCE_SEL_CRTC2     BIT(10)
 #define FP2_SRC_SEL_MASK         (3 << 13)
-#define FP2_SRC_SEL_CRTC2        (1 << 13)
-#define FP2_FP_POL               (1 << 16)
-#define FP2_LP_POL               (1 << 17)
-#define FP2_SCK_POL              (1 << 18)
+#define FP2_SRC_SEL_CRTC2        BIT(13)
+#define FP2_FP_POL               BIT(16)
+#define FP2_LP_POL               BIT(17)
+#define FP2_SCK_POL              BIT(18)
 #define FP2_LCD_CNTL_MASK        (7 << 19)
-#define FP2_PAD_FLOP_EN          (1 << 22)
-#define FP2_CRC_EN               (1 << 23)
-#define FP2_CRC_READ_EN          (1 << 24)
-#define FP2_DV0_EN               (1 << 25)
-#define FP2_DV0_RATE_SEL_SDR     (1 << 26)
+#define FP2_PAD_FLOP_EN          BIT(22)
+#define FP2_CRC_EN               BIT(23)
+#define FP2_CRC_READ_EN          BIT(24)
+#define FP2_DV0_EN               BIT(25)
+#define FP2_DV0_RATE_SEL_SDR     BIT(26)
 
 
 /* LVDS_GEN_CNTL bit constants */
-#define LVDS_ON					   (1 << 0)
-#define LVDS_DISPLAY_DIS			   (1 << 1)
-#define LVDS_PANEL_TYPE				   (1 << 2)
-#define LVDS_PANEL_FORMAT			   (1 << 3)
-#define LVDS_EN					   (1 << 7)
+#define LVDS_ON					   BIT(0)
+#define LVDS_DISPLAY_DIS			   BIT(1)
+#define LVDS_PANEL_TYPE				   BIT(2)
+#define LVDS_PANEL_FORMAT			   BIT(3)
+#define LVDS_EN					   BIT(7)
 #define LVDS_BL_MOD_LEVEL_MASK			   0x0000ff00
 #define LVDS_BL_MOD_LEVEL_SHIFT			   8
-#define LVDS_BL_MOD_EN				   (1 << 16)
-#define LVDS_DIGON				   (1 << 18)
-#define LVDS_BLON				   (1 << 19)
-#define LVDS_SEL_CRTC2				   (1 << 23)
+#define LVDS_BL_MOD_EN				   BIT(16)
+#define LVDS_DIGON				   BIT(18)
+#define LVDS_BLON				   BIT(19)
+#define LVDS_SEL_CRTC2				   BIT(23)
 #define LVDS_STATE_MASK	\
 	(LVDS_ON | LVDS_DISPLAY_DIS | LVDS_BL_MOD_LEVEL_MASK | LVDS_BLON)
 
@@ -657,10 +657,10 @@
 #define HSYNC_DELAY_MASK			   (0xf << 0x1c)
 
 /* TMDS_TRANSMITTER_CNTL bit constants */
-#define TMDS_PLL_EN				   (1 << 0)
-#define TMDS_PLLRST				   (1 << 1)
-#define TMDS_RAN_PAT_RST			   (1 << 7)
-#define TMDS_ICHCSEL				   (1 << 28)
+#define TMDS_PLL_EN				   BIT(0)
+#define TMDS_PLLRST				   BIT(1)
+#define TMDS_RAN_PAT_RST			   BIT(7)
+#define TMDS_ICHCSEL				   BIT(28)
 
 /* FP_HORZ_STRETCH bit constants */
 #define HORZ_STRETCH_RATIO_MASK			   0xffff
@@ -668,11 +668,11 @@
 #define HORZ_PANEL_SIZE				   (0x1ff << 16)
 #define HORZ_PANEL_SHIFT			   16
 #define HORZ_STRETCH_PIXREP			   (0 << 25)
-#define HORZ_STRETCH_BLEND			   (1 << 26)
-#define HORZ_STRETCH_ENABLE			   (1 << 25)
-#define HORZ_AUTO_RATIO				   (1 << 27)
+#define HORZ_STRETCH_BLEND			   BIT(26)
+#define HORZ_STRETCH_ENABLE			   BIT(25)
+#define HORZ_AUTO_RATIO				   BIT(27)
 #define HORZ_FP_LOOP_STRETCH			   (0x7 << 28)
-#define HORZ_AUTO_RATIO_INC			   (1 << 31)
+#define HORZ_AUTO_RATIO_INC			   BIT(31)
 
 
 /* FP_VERT_STRETCH bit constants */
@@ -681,9 +681,9 @@
 #define VERT_PANEL_SIZE				   (0xfff << 12)
 #define VERT_PANEL_SHIFT			   12
 #define VERT_STRETCH_LINREP			   (0 << 26)
-#define VERT_STRETCH_BLEND			   (1 << 26)
-#define VERT_STRETCH_ENABLE			   (1 << 25)
-#define VERT_AUTO_RATIO_EN			   (1 << 27)
+#define VERT_STRETCH_BLEND			   BIT(26)
+#define VERT_STRETCH_ENABLE			   BIT(25)
+#define VERT_AUTO_RATIO_EN			   BIT(27)
 #define VERT_FP_LOOP_STRETCH			   (0x7 << 28)
 #define VERT_STRETCH_RESERVED			   0xf1000000
 
@@ -692,23 +692,23 @@
 #define DAC_4BPP_PIX_ORDER                         0x00000200
 #define DAC_CRC_EN                                 0x00080000
 #define DAC_MASK_ALL				   (0xff << 24)
-#define DAC_PDWN                                   (1 << 15)
-#define DAC_EXPAND_MODE				   (1 << 14)
-#define DAC_VGA_ADR_EN				   (1 << 13)
+#define DAC_PDWN                                   BIT(15)
+#define DAC_EXPAND_MODE				   BIT(14)
+#define DAC_VGA_ADR_EN				   BIT(13)
 #define DAC_RANGE_CNTL				   (3 <<  0)
 #define DAC_RANGE_CNTL_MASK    			   0x03
-#define DAC_BLANKING				   (1 <<  2)
-#define DAC_CMP_EN                                 (1 <<  3)
-#define DAC_CMP_OUTPUT                             (1 <<  7)
+#define DAC_BLANKING				   BIT(2)
+#define DAC_CMP_EN                                 BIT(3)
+#define DAC_CMP_OUTPUT                             BIT(7)
 
 /* DAC_CNTL2 bit constants */
-#define DAC2_EXPAND_MODE			   (1 << 14)
-#define DAC2_CMP_EN                                (1 << 7)
-#define DAC2_PALETTE_ACCESS_CNTL                   (1 << 5)
+#define DAC2_EXPAND_MODE			   BIT(14)
+#define DAC2_CMP_EN                                BIT(7)
+#define DAC2_PALETTE_ACCESS_CNTL                   BIT(5)
 
 /* DAC_EXT_CNTL bit constants */
-#define DAC_FORCE_BLANK_OFF_EN                     (1 << 4)
-#define DAC_FORCE_DATA_EN                          (1 << 5)
+#define DAC_FORCE_BLANK_OFF_EN                     BIT(4)
+#define DAC_FORCE_DATA_EN                          BIT(5)
 #define DAC_FORCE_DATA_SEL_MASK                    (3 << 6)
 #define DAC_FORCE_DATA_MASK                        0x0003ff00
 #define DAC_FORCE_DATA_SHIFT                       8
@@ -737,25 +737,25 @@
 
 
 /* RBBM_SOFT_RESET bit constants */
-#define SOFT_RESET_CP           		   (1 <<  0)
-#define SOFT_RESET_HI           		   (1 <<  1)
-#define SOFT_RESET_SE           		   (1 <<  2)
-#define SOFT_RESET_RE           		   (1 <<  3)
-#define SOFT_RESET_PP           		   (1 <<  4)
-#define SOFT_RESET_E2           		   (1 <<  5)
-#define SOFT_RESET_RB           		   (1 <<  6)
-#define SOFT_RESET_HDP          		   (1 <<  7)
+#define SOFT_RESET_CP           		   BIT(0)
+#define SOFT_RESET_HI           		   BIT(1)
+#define SOFT_RESET_SE           		   BIT(2)
+#define SOFT_RESET_RE           		   BIT(3)
+#define SOFT_RESET_PP           		   BIT(4)
+#define SOFT_RESET_E2           		   BIT(5)
+#define SOFT_RESET_RB           		   BIT(6)
+#define SOFT_RESET_HDP          		   BIT(7)
 
 /* WAIT_UNTIL bit constants */
-#define WAIT_DMA_GUI_IDLE			   (1 << 9)
-#define WAIT_2D_IDLECLEAN			   (1 << 16)
+#define WAIT_DMA_GUI_IDLE			   BIT(9)
+#define WAIT_2D_IDLECLEAN			   BIT(16)
 
 /* SURFACE_CNTL bit consants */
-#define SURF_TRANSLATION_DIS			   (1 << 8)
-#define NONSURF_AP0_SWP_16BPP			   (1 << 20)
-#define NONSURF_AP0_SWP_32BPP			   (1 << 21)
-#define NONSURF_AP1_SWP_16BPP			   (1 << 22)
-#define NONSURF_AP1_SWP_32BPP			   (1 << 23)
+#define SURF_TRANSLATION_DIS			   BIT(8)
+#define NONSURF_AP0_SWP_16BPP			   BIT(20)
+#define NONSURF_AP0_SWP_32BPP			   BIT(21)
+#define NONSURF_AP1_SWP_16BPP			   BIT(22)
+#define NONSURF_AP1_SWP_32BPP			   BIT(23)
 
 /* DEFAULT_SC_BOTTOM_RIGHT bit constants */
 #define DEFAULT_SC_RIGHT_MAX			   (0x1fff << 0)
@@ -829,7 +829,7 @@
 #define BYTE_ORDER_MSB_TO_LSB                      0x00000000
 #define BYTE_ORDER_LSB_TO_MSB                      0x40000000
 #define DP_CONVERSION_TEMP                         0x80000000
-#define HOST_BIG_ENDIAN_EN			   (1 << 29)
+#define HOST_BIG_ENDIAN_EN			   BIT(29)
 
 
 /* DP_GUI_MASTER_CNTL bit constants */
@@ -885,7 +885,7 @@
 #define GMC_AUX_CLIP_CLEAR                         0x20000000
 #define GMC_WRITE_MASK_LEAVE                       0x00000000
 #define GMC_WRITE_MASK_SET                         0x40000000
-#define GMC_CLR_CMP_CNTL_DIS      		   (1 << 28)
+#define GMC_CLR_CMP_CNTL_DIS      		   BIT(28)
 #define GMC_SRC_DATATYPE_COLOR			   (3 << 12)
 #define ROP3_S                			   0x00cc0000
 #define ROP3_SRCCOPY				   0x00cc0000
@@ -951,33 +951,33 @@
 #define TV_DAC_CNTL_BDACPD                         0x04000000
 
 /* DISP_MISC_CNTL constants */
-#define DISP_MISC_CNTL_SOFT_RESET_GRPH_PP          (1 << 0)
-#define DISP_MISC_CNTL_SOFT_RESET_SUBPIC_PP        (1 << 1)
-#define DISP_MISC_CNTL_SOFT_RESET_OV0_PP           (1 << 2)
-#define DISP_MISC_CNTL_SOFT_RESET_GRPH_SCLK        (1 << 4)
-#define DISP_MISC_CNTL_SOFT_RESET_SUBPIC_SCLK      (1 << 5)
-#define DISP_MISC_CNTL_SOFT_RESET_OV0_SCLK         (1 << 6)
-#define DISP_MISC_CNTL_SOFT_RESET_GRPH2_PP         (1 << 12)
-#define DISP_MISC_CNTL_SOFT_RESET_GRPH2_SCLK       (1 << 15)
-#define DISP_MISC_CNTL_SOFT_RESET_LVDS             (1 << 16)
-#define DISP_MISC_CNTL_SOFT_RESET_TMDS             (1 << 17)
-#define DISP_MISC_CNTL_SOFT_RESET_DIG_TMDS         (1 << 18)
-#define DISP_MISC_CNTL_SOFT_RESET_TV               (1 << 19)
+#define DISP_MISC_CNTL_SOFT_RESET_GRPH_PP          BIT(0)
+#define DISP_MISC_CNTL_SOFT_RESET_SUBPIC_PP        BIT(1)
+#define DISP_MISC_CNTL_SOFT_RESET_OV0_PP           BIT(2)
+#define DISP_MISC_CNTL_SOFT_RESET_GRPH_SCLK        BIT(4)
+#define DISP_MISC_CNTL_SOFT_RESET_SUBPIC_SCLK      BIT(5)
+#define DISP_MISC_CNTL_SOFT_RESET_OV0_SCLK         BIT(6)
+#define DISP_MISC_CNTL_SOFT_RESET_GRPH2_PP         BIT(12)
+#define DISP_MISC_CNTL_SOFT_RESET_GRPH2_SCLK       BIT(15)
+#define DISP_MISC_CNTL_SOFT_RESET_LVDS             BIT(16)
+#define DISP_MISC_CNTL_SOFT_RESET_TMDS             BIT(17)
+#define DISP_MISC_CNTL_SOFT_RESET_DIG_TMDS         BIT(18)
+#define DISP_MISC_CNTL_SOFT_RESET_TV               BIT(19)
 
 /* DISP_PWR_MAN constants */
-#define DISP_PWR_MAN_DISP_PWR_MAN_D3_CRTC_EN       (1 << 0)
-#define DISP_PWR_MAN_DISP2_PWR_MAN_D3_CRTC2_EN     (1 << 4)
-#define DISP_PWR_MAN_DISP_D3_RST                   (1 << 16)
-#define DISP_PWR_MAN_DISP_D3_REG_RST               (1 << 17)
-#define DISP_PWR_MAN_DISP_D3_GRPH_RST              (1 << 18)
-#define DISP_PWR_MAN_DISP_D3_SUBPIC_RST            (1 << 19)
-#define DISP_PWR_MAN_DISP_D3_OV0_RST               (1 << 20)
-#define DISP_PWR_MAN_DISP_D1D2_GRPH_RST            (1 << 21)
-#define DISP_PWR_MAN_DISP_D1D2_SUBPIC_RST          (1 << 22)
-#define DISP_PWR_MAN_DISP_D1D2_OV0_RST             (1 << 23)
-#define DISP_PWR_MAN_DIG_TMDS_ENABLE_RST           (1 << 24)
-#define DISP_PWR_MAN_TV_ENABLE_RST                 (1 << 25)
-#define DISP_PWR_MAN_AUTO_PWRUP_EN                 (1 << 26)
+#define DISP_PWR_MAN_DISP_PWR_MAN_D3_CRTC_EN       BIT(0)
+#define DISP_PWR_MAN_DISP2_PWR_MAN_D3_CRTC2_EN     BIT(4)
+#define DISP_PWR_MAN_DISP_D3_RST                   BIT(16)
+#define DISP_PWR_MAN_DISP_D3_REG_RST               BIT(17)
+#define DISP_PWR_MAN_DISP_D3_GRPH_RST              BIT(18)
+#define DISP_PWR_MAN_DISP_D3_SUBPIC_RST            BIT(19)
+#define DISP_PWR_MAN_DISP_D3_OV0_RST               BIT(20)
+#define DISP_PWR_MAN_DISP_D1D2_GRPH_RST            BIT(21)
+#define DISP_PWR_MAN_DISP_D1D2_SUBPIC_RST          BIT(22)
+#define DISP_PWR_MAN_DISP_D1D2_OV0_RST             BIT(23)
+#define DISP_PWR_MAN_DIG_TMDS_ENABLE_RST           BIT(24)
+#define DISP_PWR_MAN_TV_ENABLE_RST                 BIT(25)
+#define DISP_PWR_MAN_AUTO_PWRUP_EN                 BIT(26)
 
 /* masks */
 
@@ -1110,14 +1110,14 @@
 #define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb           0x00002000L
 #define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb               0x00004000L
 #define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb               0x00008000L
-#define PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb      (1 << 9)
-#define PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb               (1 << 10)
-#define PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb           (1 << 13)
-#define PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb         (1 << 16)
-#define PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb           (1 << 17)
-#define PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb              (1 << 18)
-#define PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb          (1 << 19)
-#define PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF  (1 << 23)
+#define PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb      BIT(9)
+#define PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb               BIT(10)
+#define PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb           BIT(13)
+#define PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb         BIT(16)
+#define PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb           BIT(17)
+#define PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb              BIT(18)
+#define PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb          BIT(19)
+#define PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF  BIT(23)
 
 
 // pllP2PLL_DIV_0
@@ -1160,21 +1160,21 @@
 #define SCLK_CNTL__FORCE_TV_SCLK                        0x20000000L
 #define SCLK_CNTL__FORCE_SUBPIC                         0x40000000L
 #define SCLK_CNTL__FORCE_OV0                            0x80000000L
-#define SCLK_CNTL__R300_FORCE_VAP                       (1<<21)
-#define SCLK_CNTL__R300_FORCE_SR                        (1<<25)
-#define SCLK_CNTL__R300_FORCE_PX                        (1<<26)
-#define SCLK_CNTL__R300_FORCE_TX                        (1<<27)
-#define SCLK_CNTL__R300_FORCE_US                        (1<<28)
-#define SCLK_CNTL__R300_FORCE_SU                        (1<<30)
+#define SCLK_CNTL__R300_FORCE_VAP                       BIT(21)
+#define SCLK_CNTL__R300_FORCE_SR                        BIT(25)
+#define SCLK_CNTL__R300_FORCE_PX                        BIT(26)
+#define SCLK_CNTL__R300_FORCE_TX                        BIT(27)
+#define SCLK_CNTL__R300_FORCE_US                        BIT(28)
+#define SCLK_CNTL__R300_FORCE_SU                        BIT(30)
 #define SCLK_CNTL__FORCEON_MASK                         0xffff8000L
 
 // pllSCLK_CNTL2
-#define SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT           (1<<10)
-#define SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT            (1<<11)
-#define SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT           (1<<12)
-#define SCLK_CNTL2__R300_FORCE_TCL                      (1<<13)
-#define SCLK_CNTL2__R300_FORCE_CBA                      (1<<14)
-#define SCLK_CNTL2__R300_FORCE_GA                       (1<<15)
+#define SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT           BIT(10)
+#define SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT            BIT(11)
+#define SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT           BIT(12)
+#define SCLK_CNTL2__R300_FORCE_TCL                      BIT(13)
+#define SCLK_CNTL2__R300_FORCE_CBA                      BIT(14)
+#define SCLK_CNTL2__R300_FORCE_GA                       BIT(15)
 
 // SCLK_MORE_CNTL
 #define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT          0x00000001L
@@ -1217,8 +1217,8 @@
 #define MCLK_CNTL__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
 #define MCLK_CNTL__MRDCKB0_SOUTSEL_MASK                 0x30000000L
 #define MCLK_CNTL__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
-#define MCLK_CNTL__R300_DISABLE_MC_MCLKA                (1 << 21)
-#define MCLK_CNTL__R300_DISABLE_MC_MCLKB                (1 << 21)
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKA                BIT(21)
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKB                BIT(21)
 
 // MCLK_MISC
 #define MCLK_MISC__SCLK_SOURCED_FROM_MPLL_SEL_MASK         0x00000003L
@@ -1259,7 +1259,7 @@
 #define VCLK_ECP_CNTL__ECP_DIV_MASK                        0x00000300L
 #define VCLK_ECP_CNTL__ECP_FORCE_ON                        0x00040000L
 #define VCLK_ECP_CNTL__SUBCLK_FORCE_ON                     0x00080000L
-#define VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF  (1<<23)
+#define VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF  BIT(23)
 
 // PLL_PWRMGT_CNTL
 #define PLL_PWRMGT_CNTL__MPLL_TURNOFF_MASK                 0x00000001L
-- 
2.7.4

