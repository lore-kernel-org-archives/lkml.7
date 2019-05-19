Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98332C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25820449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbRR2bxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfESSPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:15:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45311 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfESSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:15:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so6067563pfm.12;
        Sun, 19 May 2019 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LvoOGjtS9Q4v/OhQz+Xvt2yLQuispJiUfyTAeVDnMZ4=;
        b=bbRR2bxzUuOllnh0/6nD2eAg5pGTqwoSpcBcQaFo8iNh0RHv2G1k2pQ4c1QaPL9SXa
         NV0HHNI4IOKBJjVtUSkNJKOmUmqRIzz1ziVWFtDM1Z2kxBM1M8+8MxMZss9oXSfI2vfq
         zVA8+Y0cSykPo5ytUKv4j/vwduPDRq2U2bQhZ0EyuUtRqO7Kf/ozSApKW9EdGHIyHdFM
         Fpp5Of40958AdVd7rzupfDZSClSGIIoobTEdTmBSyf+g+PN051tgvztE7JAS26MnNZ1U
         Hor1qStqQVSlC/bblDycPbwp2WL29cnbm4NI8KN4F90N2ygDm+JQ+nrBtYyoSTgjdXnu
         1mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LvoOGjtS9Q4v/OhQz+Xvt2yLQuispJiUfyTAeVDnMZ4=;
        b=AAars4n4wQXOcidKuaNj1ISdxBVwo1WEsF8CKzyA3NbZM0FvGewtowCN719I6s3I7U
         pWrekPU0bd7gWhd9YM6jn7oVUrZ1McZiest24LaYmSmBXzKlvfsnOXT+7bJ1klGfD2+e
         whXqrn+9zUwR81b+X3o15AYa3V6QS38kXNxpPq3652fXt3QFHP+JTRvmw4faFfuV+UIx
         540Es4dQMCnD4+mNDi3RnBsH2hTyxvs7lNMbPXeazNK3dUFRyt/+JpXYfasjcB+CiHz1
         1xo3j2cu528L1a2ofhaJMmNctwpYy902W6MYVvepgVUe0Jgpx95OYc3xiMatLJRtG5bB
         h44Q==
X-Gm-Message-State: APjAAAXRTH9WRdJs6FWGvg/mbhXzqNdu7JQ7RS5SBfDAvbJgFRUlZQ6W
        qPCDFOR5bS20kVcwGXiWHoDo3/JDFL0=
X-Google-Smtp-Source: APXvYqy3lkVNGdk2GsXbhC3BVFIuGkQcOtV/abTkec19BkOZMMKFGsQMT/jBr9HzKg45Z2p2n3q2XQ==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr25216471pgs.24.1558238148827;
        Sat, 18 May 2019 20:55:48 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id a11sm5188982pff.128.2019.05.18.20.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 20:55:48 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] usb: fix typos in code comments
Date:   Sun, 19 May 2019 11:55:42 +0800
Message-Id: <20190519035542.22094-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 Documentation/devicetree/bindings/usb/s3c2410-usb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
index e45b38ce2986..26c85afd0b53 100644
--- a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
+++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
@@ -4,7 +4,7 @@ OHCI
 
 Required properties:
  - compatible: should be "samsung,s3c2410-ohci" for USB host controller
- - reg: address and lenght of the controller memory mapped region
+ - reg: address and length of the controller memory mapped region
  - interrupts: interrupt number for the USB OHCI controller
  - clocks: Should reference the bus and host clocks
  - clock-names: Should contain two strings
-- 
2.18.0

