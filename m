Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1EC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C061D20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMwImYyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgAGSbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:31:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39244 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:31:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so594310wmj.4;
        Tue, 07 Jan 2020 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYKj/+nVSNkFF8hiZbulRw4b+kXEYHe/NgI/gzd5MSY=;
        b=MMwImYyrVDmD8Ux7KbUpIHXEyZX6nB9MQmJUG1wsRBsuQ8gKgd27orsaS86P4Ou/Nn
         MeBO3pfTh7YB89pK2I/0uTVZ0XX0kugebZ2mkLwKCgavj4DrlIq6em7iKe8l0jSJ7GDF
         qSzV/BJroRBIpeBtyX9+SDhWldZpbjThdPcr0+2L3zqbBoQeALCMSd9wBVHDWA81TKLu
         5l5EKvxYbAz5elbSiSkIeV2/0lQAbVW4QDm5C+ZBkf4iFHS4msyx/o/NRpzQeNqd1WJX
         sDZuXLP14E6xkVuzMp/xKjLxBZNJ3mYseHpDeTxOIKYPEPnxPdtCaF+r/k4o0Z1JB867
         lhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYKj/+nVSNkFF8hiZbulRw4b+kXEYHe/NgI/gzd5MSY=;
        b=R1uL0xYrd6Ag0wcFPCB9N3aTETzlAWSPismZDQow54zlpiAPBjufd/fdTNfTvwTC0s
         rgLzwssaNepVu4MaENgamBuPCNaw5EyXiNve5vTSEFB9yuUFKklrVKJsXaf5hgIeLbuW
         bHHb+gqHERWNa6k1kU6mxeaCP6354EZrQkBO1JZ/uMgjRs6LIbGt7szqqXLDeObPSNon
         S5ABNaVORpn2hEHoD7gIscnGwhQ/mh1Wxe89ydFy8DrhtTldKnVLx2tSK+kqSlVn9SgY
         ztWzcT+VMuqRyqky4VfEGXc3Rf9F+vh5icT6VxXasGTh2JQrr6fsuc98lSDs+0RI7REK
         x+Dg==
X-Gm-Message-State: APjAAAU7VDaTXa5DzjPs7OTPBbvCpwS8VX2FzF81a90bowZYL/wSEsOI
        bT/E9vuNCSKfxydf8mk/yJbyVNkK
X-Google-Smtp-Source: APXvYqyIl1DYZZmNJSTwnw6RcIIPbzyvahakbyePNgeB/AA+sPOB5csF4biu20RxiCAcDMNh+1I9Zg==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr350762wmd.127.1578421868590;
        Tue, 07 Jan 2020 10:31:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r6sm842764wrq.92.2020.01.07.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:31:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 2/3] ata: ahci_brcm: Perform reset after obtaining resources
Date:   Tue,  7 Jan 2020 10:30:21 -0800
Message-Id: <20200107183022.26224-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107183022.26224-1-f.fainelli@gmail.com>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources such as clocks, PHYs, regulators are likely to get a probe
deferral return code, which could lead to the AHCI controller being
reset a few times until it gets successfully probed. Since this is
typically the most time consuming operation, move it after the resources
have been acquired.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 718516fe6997..c229fea39a47 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -456,15 +456,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rcdev))
 		return PTR_ERR(priv->rcdev);
 
-	ret = reset_control_deassert(priv->rcdev);
-	if (ret)
-		return ret;
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
-	if (IS_ERR(hpriv)) {
-		ret = PTR_ERR(hpriv);
-		goto out_reset;
-	}
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
 
 	hpriv->plat_data = priv;
 	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
@@ -481,6 +475,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ret = reset_control_deassert(priv->rcdev);
+	if (ret)
+		return ret;
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.17.1

