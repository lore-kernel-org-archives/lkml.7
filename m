Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB521D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+21Gz52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfKGOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33678 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbfKGOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id w30so3267335wra.0;
        Thu, 07 Nov 2019 06:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crb4hxU6Nx4zLot+hNJis4uv/TIATBfBFFC0hFKh3gI=;
        b=B+21Gz52S35Yza5Kiw6aM2iIUvlrqlQvvymCXHbWobtQZw3h7KXV0ThAkzTocj1Cx2
         dia2rAA25F7Q6l7fo0OpRlOJgoBVW1E8k0iB1HoxvJTVvMfLzzcNfvjbCp61xvoj+3M1
         VHd6eK+t/ivpvA5gSWDuVVUk85GTqHC8+6Jyuzteh8ru1XN3EqU/gwsS4jJf+tFtXNCU
         RaS9nfhgKc3qXikCuyME23TRqFD/LOHU5SDdgkioXVSd7UJextp6eWnD3YZgrj9ZMgDP
         vBD8GpHWwjCcx3Q6b1RKsVA7y5wOh1rWbe3BAQoE9F+YAU7wn4cKtnJW2hU6NY5gEaj4
         HAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crb4hxU6Nx4zLot+hNJis4uv/TIATBfBFFC0hFKh3gI=;
        b=C7DhTcyVyGa1BFGZ5KQCShGjjnzvoR0ZokHvoWC4HMKCNCNkGR851UwbbH8Ap9afxD
         A89LnH2btPg+zG7NKRH2j/bBpQHSuadEyZyE/ll2p7jh6gI2BVkxINiSlI9klaOI9Odk
         nb3MJEqSAEdlCvoza873157HCnqlYS1KQwPe2pvFDawNVwwX30wIxtonLOkC2zHng1UG
         TUpkOvc2LbHgZInqHDi6gUZFRv0/LKtqREoxNwOFv1TjKpWPieTbos7jlIqRdFOed1c6
         maAzDHGJNfK7Mft+WhqEEqX5uyTihKed4wvkAQuJx1IK16JPx2nrPQcdvIkhGHXtR7N7
         LOuA==
X-Gm-Message-State: APjAAAXr3SXxr3eIgAmeyuUOwbb95PTrPFntMEKAvy5UFfLEuNrmR85S
        4qTNVy6BKY7JsymfBnnIGRStzbrKaGw=
X-Google-Smtp-Source: APXvYqzuCYvmigRsZGbVQkDj4lmG6Y++Ic1XNhR+P8mJH5qTqjobCyzMlEM6L69gzswbK5BRfgD7Kw==
X-Received: by 2002:adf:db92:: with SMTP id u18mr3052564wri.1.1573136092687;
        Thu, 07 Nov 2019 06:14:52 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:52 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 12/13] phy: usb: USB driver is crashing during S3 resume on 7216
Date:   Thu,  7 Nov 2019 09:13:38 -0500
Message-Id: <20191107141339.6079-13-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a result of the USB 2.0 clocks not being disabled/enabled
during suspend/resume on XHCI only systems.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 2a06965d20b8..86d7ba7c3af3 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -538,7 +538,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		brcm_usb_wake_enable(&priv->ini, true);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			clk_disable_unprepare(priv->usb_30_clk);
-		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+		if (priv->phys[BRCM_USB_PHY_2_0].inited || !priv->has_eohci)
 			clk_disable_unprepare(priv->usb_20_clk);
 		if (priv->wake_irq >= 0)
 			enable_irq_wake(priv->wake_irq);
-- 
2.17.1

