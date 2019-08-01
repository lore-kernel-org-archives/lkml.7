Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1470C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DF0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAh9kB/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfHATO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:14:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45171 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388474AbfHATOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:14:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so34604635pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wwlQEgQ2FyDPAeL6ENYaL15yrnle3X3rQuh/+NrKALI=;
        b=WAh9kB/E0xeB+fL6pxZOTDBVim4wPIqFEH3c2Jlx1E9XJTo17J8mc6Aao14jse/jsw
         1NKjSGN5oLHP0MxmPgNK/rrIRK/Wrz3zUbMAOZv771C8GxD+GRnEt/TAYBwcUxJfaGHJ
         4N2ASzt0Fx90sLka4+22SAA5AsjUqh4vnOqMAGlBRfpV3W6R1piM35lK0GB7XU5fp31x
         I/1QQuufI5f84xWrS2cB7i/wA6EU+mXeWN6cjtY47mdarBraGk1GBYFHzg7Tsel9Xlx2
         JMmWmtlUG8O7fJbohdNdJjiLhtpRifQmtrr/Io78DJ2Fud76N2yraAWio0zT1Tma+aPJ
         jaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wwlQEgQ2FyDPAeL6ENYaL15yrnle3X3rQuh/+NrKALI=;
        b=FfbuOyDx6sFr8sDOLeRLqpgkDZAXS8upx7PvL+tVmxV2w2n15iRIOObX/EdPAgHVKd
         R8h0FqRF1IvD0iXbz8m6K+Y/ujd+cEAW9QvkNBr9NKAc3r6kDni5re2qBTRXlZCPb0vW
         vRfFnCjBXviTJ5xDCm9M9atkfTMYn+4MCXF5B4Dp42jeqSl4BXkkvfKvIYz5TffIxei3
         7s/gsPwK6/0jxAMLmgO3zZajoYmd8wIfF3CXGqtvKOIj0m6OEKn2WwPbr67myjahAyXa
         6+5ysvQA1c3dAsF0mbJ2FyYYEz6MHlg5BDE0RdwPZMaK435Chnh4vyOL+LzuLtCcRymd
         JEog==
X-Gm-Message-State: APjAAAWVp6Q27HlQLdLzfCiy2N+FVB71WpaQOWZ35mitY6eDrM2sYUAO
        GvcT3+K+6Ulm9sMjzqrTNmY=
X-Google-Smtp-Source: APXvYqxjQOQFzCASEPDo0eElanfO4nXgn14wivj0dO1cCXNCkkvrSueIZv4ahnVFfDt0hgC10AeTFQ==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr77664858pgr.308.1564686864623;
        Thu, 01 Aug 2019 12:14:24 -0700 (PDT)
Received: from localhost.localdomain ([223.191.5.161])
        by smtp.gmail.com with ESMTPSA id bo20sm4625811pjb.23.2019.08.01.12.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:14:24 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/3] parport: parport_serial: Use dev_get_drvdata
Date:   Thu,  1 Aug 2019 20:14:08 +0100
Message-Id: <20190801191408.10977-3-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190801191408.10977-1-sudipm.mukherjee@gmail.com>
References: <20190801191408.10977-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 461fd8a24278..b11f5d238eda 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -660,8 +660,7 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 
 static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct parport_serial_private *priv = pci_get_drvdata(pdev);
+	struct parport_serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv->serial)
 		pciserial_suspend_ports(priv->serial);
@@ -672,8 +671,7 @@ static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 
 static int __maybe_unused parport_serial_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct parport_serial_private *priv = pci_get_drvdata(pdev);
+	struct parport_serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);
-- 
2.11.0

