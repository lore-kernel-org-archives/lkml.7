Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37BC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E2A205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMnp87Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLFSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so3783929pfb.0;
        Fri, 06 Dec 2019 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I11/1g/9q+frAVf8+DPvgghH4KQ81JT2S0kbypabsyc=;
        b=VMnp87KdtKaHKbIdIynQJjnh6Rwx73cgOqHapRh8B69i4jp/3sjISCsxhLktJIGkSy
         ZNe1M/lVfmzI6SIW2RwIZd/xu5yFsCzRRZOmM7mhk/UlM0bWSQrRNUBxQQnAmPprF42J
         sZVVochTM/CWvOunmhgF/FvGmCl+XtfvNxs2ZmvDeqHmpb2EX5Y08QJCJDs4qAD+fRjo
         Y5ojsHjT4xc3OK5ssN763cBtqpVYzc7Ec4VqydoM4Jlmha7xuedeCW5Fl0Hr23YdJxPt
         ChmAu38tXs01yOllIWYQTSVi32qxfNHAoT1Gj3Ikgiy6PR1RCo+9jbDRygLnTxTKky6a
         aHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I11/1g/9q+frAVf8+DPvgghH4KQ81JT2S0kbypabsyc=;
        b=miJw0UmpmA6pTGRznRI+y45+WjGg3X4JP/FiDJ3YPzAfzRzzqpVV7shuA+Ff8/KfBI
         w6HviFvchbPyFVZ0FXgxPrs4g6fiGVGimxakm1owR6zKXN7znxm3KOW8L3Dum+rEtnLY
         clFBbH7+GKDuP39B6FCYkdlDEBPUWuRL3siWeCuCzjZqUtAR01YrRj7bAuKdklryfjZj
         ci8+l3BMSvBiR5Y3biBeIdBSgIV2dPxFRlKR1Sa+342+aCQbEM5JTqaB2F8XCjaRJK+A
         DUcmo/onSgfTyreLt9Qxm9BF9MW5qHLEzDe7QvdweWLVOOwd8HmpTcIfgm6x0fxjKlLJ
         9iWg==
X-Gm-Message-State: APjAAAXwjbee2YbA+amSKXLVWKweCT19sjY0GAFuAPWOuTCZW1VN0hUu
        m0aRNGUT399nwoRW9rHdJl8=
X-Google-Smtp-Source: APXvYqwoypDoF4nKIA4Nt1tXSNz7e6TbMFkJOI8WhnkDVk2bs1ION4YrEP1wl6B0klb7gqb3Vn4+mA==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr15684240pfk.216.1575657991783;
        Fri, 06 Dec 2019 10:46:31 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:31 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 4/8] mfd: rk808: use syscore for RK818 PMIC shutdown
Date:   Fri,  6 Dec 2019 18:45:32 +0000
Message-Id: <20191206184536.2507-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common syscore_shutdown for RK818 PMIC to do
clean I2C shutdown, drop the unused pm_pwroff_fn
function pointers.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mfd/rk808.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 0a098fbdf112..4b3b90dad4f8 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -467,11 +467,6 @@ static void rk808_update_bits(unsigned int reg, unsigned int mask,
 			"can't write to register 0x%x: %x!\n", reg, ret);
 }
 
-static void rk818_device_shutdown(void)
-{
-	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
-}
-
 static void rk8xx_syscore_shutdown(void)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
@@ -494,6 +489,9 @@ static void rk8xx_syscore_shutdown(void)
 			rk808_update_bits(RK817_SYS_CFG(3),
 					RK817_SLPPIN_FUNC_MSK, SLPPIN_DN_FUN);
 			break;
+		case RK818_ID:
+			rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
+			break;
 		default:
 			break;
 		}
@@ -583,7 +581,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
 		cells = rk818s;
 		nr_cells = ARRAY_SIZE(rk818s);
-		rk808->pm_pwroff_fn = rk818_device_shutdown;
 		break;
 	case RK809_ID:
 	case RK817_ID:
-- 
2.24.0

