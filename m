Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C53C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF412070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv4kVx+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfLUXkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:40:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46844 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUXkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:40:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so12854739wrl.13;
        Sat, 21 Dec 2019 15:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RmWbAyq2x2FQ/eXkiKP+PMRrJG+Y/ELry3MB1iDJjI0=;
        b=Bv4kVx+o/NOBXP8zDIVimIFIv4tMcU0fI1QgLDSj0xOhD56XrhHOdE0rJQ9ObyeOdC
         ripmIjxb8KhX9QNUKlgPiWS7Zpm5FW96RCBygiqFhCg03iIvJz5iUW61LslzLsws+kZ4
         dD4XI9VlomwFpNBwwh52oLwC/Tpml3VPMwT/gbu7kWloLBF4RyAMkcTwlngf1m5zIi1r
         d+hLJyqUfYlMX2dGDq+u3Fp7QMm/LrkMzwAAybH/d+TtfQk7FAyiG+usAx0LltJhXHMN
         ix/RNSBJ2ORy3lOq0NN9sEdjM275V3uPHXLLd2WM4hqiU0WsUYnc3jq/1OJEuFa0blTe
         peAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RmWbAyq2x2FQ/eXkiKP+PMRrJG+Y/ELry3MB1iDJjI0=;
        b=ANRue0yH+nIwfjHZZ+ikzrFEUaVM9IZNRg1Zh7NSK1Kg4vCYrEF7YqgLyIdVxQasBZ
         10UNRhCfP7+lmxDurwyaODOwVHjaHChAiDNo5p6HO/JmmmQJol5yeRu9NWcepRHquLPY
         TPnLy17OI+GDnL2CqRd7Qy0B5/ikdViXzPgIzFQqAV0D8ukoIuOqIsSLhnwk7DYxEfVX
         uca4p2qfgfHolW4glPBpB5g39BuR2YEsX4KYF8J376Y6EWi063Si6ENGaSgjcW2zI8tP
         U67o+P3GzJdJI0Xf+VXcVvXqYE3Hxjw9NqSlRKw/maaK+KejLh8+V3QyL0FM5GQ2RbO6
         XhkQ==
X-Gm-Message-State: APjAAAV68Ph7Vn2BkiqW0vY/cC14eSt0iLjfRuhXA72FZNbtbJDBbQ4t
        P/9YXGKuI1t3CXUPy+Qchuk=
X-Google-Smtp-Source: APXvYqzXx8ZPXfqLyIXY0OdujHrfgOinaUOJY87FeNbc/3H/8o1rN4AVZKtiGKizERG2hw6cfGdneQ==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr22460931wrt.381.1576971639652;
        Sat, 21 Dec 2019 15:40:39 -0800 (PST)
Received: from localhost.localdomain (p5B3F6223.dip0.t-ipconnect.de. [91.63.98.35])
        by smtp.gmail.com with ESMTPSA id q3sm14179151wmj.38.2019.12.21.15.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:40:38 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add regulator support for mpq7920
Date:   Sun, 22 Dec 2019 00:40:25 +0100
Message-Id: <20191221234029.7796-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../bindings/regulator/mpq7920.yaml           | 135 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 396 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  72 ++++
 7 files changed, 623 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

