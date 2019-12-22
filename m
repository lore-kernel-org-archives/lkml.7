Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C52C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F9820733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyK5VB/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLVUpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:45:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLVUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:45:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so14587895wre.10;
        Sun, 22 Dec 2019 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4+rTus2NxW8CdBcDQP+AlQ20MDROyr2Jjwi3989i+Bg=;
        b=MyK5VB/tjTp7tnEi4fMhduxkAdQEN6tmOw/ELaDsjiq2eN0UJcuKypgLUC5WSTaQr3
         7YjFv50HI9B0TmdlHLLKOM1gIFVHu3kS2ElnM9skuV25irqkKuyjN7EuNfEykOi6LnQe
         Em4TFF8R0Z7IwZNOzoU1q/fFuYmcLXOpJN1er1cCbnUj1BzihGVJBmcnVhPjvdoig0MJ
         G8/dhUX/PE+h87i+xB2wobrctH/GU7P3vAiL7hdjk5tWMJOdRR66jrk72/qgSlr2VVS7
         Y3gUGCZ1kJRSC2u2L0sUVMcKgPnpMiWLHXJaV9BFXEIizhrIZVjHM2OZBV5TNodxunrM
         GUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4+rTus2NxW8CdBcDQP+AlQ20MDROyr2Jjwi3989i+Bg=;
        b=f6mo4cpRIcE590IXX3t5W8A6G8f6zegxJFLbKwowBwAatwHT697ID18l7JBxhKkzRU
         xJyFlAN5un6nDOpYultGyA6jzvtWcRsh5VL7x+SlG4y5hNqFrCGGxz/ZaDsqTwgA5VDI
         I3mv9m3kFuUwMpHYx96YzattnhpCedeX9suSmu4+Gol18f/+hn7eUh9YV4gIsuCAJBGa
         Orfp3DF7H+Je03SqIHJfhMw9wLOo89WGsji/HZIRmujLXFFii2n2yPsRdk64YRsMFc6i
         r0xZSnqV+mwlNFDfjb4288ycHsNavyG69xMv1J8Dw9NfcjAV+xPWoC6VrcLmsE44bZGC
         b37w==
X-Gm-Message-State: APjAAAV0Fb8EZtXQWUhYBspMyC1Yp3lJqvaBTcCsLr04JE92cOW4CtX8
        nHXeYrSV8lGkPImbrB/kGn0=
X-Google-Smtp-Source: APXvYqyOZCPmaU+08UkTlF4huxdYdHJoSPmdoO9aAVaXuiU88DXVlOX6YzaqUjEHUuLTNVXE0lU0NQ==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr27528694wro.216.1577047518728;
        Sun, 22 Dec 2019 12:45:18 -0800 (PST)
Received: from localhost.localdomain (p5B3F6AB6.dip0.t-ipconnect.de. [91.63.106.182])
        by smtp.gmail.com with ESMTPSA id o4sm17603792wrx.25.2019.12.22.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 12:45:17 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add regulator support for mpq7920
Date:   Sun, 22 Dec 2019 21:45:03 +0100
Message-Id: <20191222204507.32413-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V3:
    - fixed review comments in Documentation and dt_bindings_check passed 

Changes in V2:
    - fixed all the review comments in the driver, avoid ternery operator, inline & constant
    - fixed/modifed review comments in Documentation

This patch series add support for PMIC regulator driver for Monolithic
Power System's MPQ7920 chipset. MPQ7920 provides support for 4-BUCK converter,
one fixed voltage RTCLDO and 4-LDO regualtor, accessed over I2C.

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

 .../bindings/regulator/mpq7920.yaml           | 143 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 396 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  72 ++++
 7 files changed, 631 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

