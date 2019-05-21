Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07125C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F31217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S7QjycdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfEUNdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:33:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32902 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:33:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so407131plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=6DhNXUXvjOx5TdLJG046rhe1p/zFy9SRsFvLrb3LWAY=;
        b=S7QjycdUhRwSZortZ4EL6ZO0RapptH+4FI6NLggI3kDl5jIRR9t2VtWQ0ZwxayAbKr
         MwpfA5hW7RZHgM95EWdEHj9vjZfPfOD+1rN893a8xfMzJvoSIG+Arva07zAxi2XyubQm
         E6+wDekbmus6Zf1BFBUYL5fis5wa+ybZgMgHJkZbAWpaUaT3eU3Fjcs1lRmjL2qCsk0V
         DKdPZYPjtoOxk0hAHarIaE3Kbenw789Gx2y5SAfQvrludnt1YckX/9cCt8i2KoTovDjb
         H0y2UqJpADasHcsIcggS2isUgahHgSFRlhCkkJ7r4dxNWOiocJVHFTkbyHaBufTVEj69
         uOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6DhNXUXvjOx5TdLJG046rhe1p/zFy9SRsFvLrb3LWAY=;
        b=gB5VYT+1Ta0uYb0Z3AIXVDiwCqwUA6hvooWazW0Rfmsor6gAD2N6mGtW8lHI+Udlkf
         yUjNnEa6iq6kNTkZb7zWsXAg4TCv9lUPQtVmXFi/CFBFDrzYBkROk5t6X7WGXlkB1IDW
         K2e6K1lWT/lgB4qwcXJUr06/zEedC/wM0IqmqMa9LjM8F1CZxWv/K+UvL/zPSrBkPuQ1
         HTYQtWPKVWHH5v7xTyi2azxJx5pbiXd4j8AEyI950IqzhnkLK2+zKEK4NqtiaRB0ldf3
         mmuYSUse80efPaaRwihdcgK+WyhNIykSNio11ulvHQi6dKBqz/YhEGJFZBYHssgH1ufA
         2WKA==
X-Gm-Message-State: APjAAAVaXd549kKtXGxamtt7S0p9K+PGxCTQCUfTu5uOXa2laEzA3JRU
        1VruTdhQFrZ31wJynJs8P0uVdA==
X-Google-Smtp-Source: APXvYqyAjZ5acKN8+o7pqrj3tahQQc6YSy7LvT8KCU7b2OQClCwcHqK3rZuDV4SHB1yXbH6zwRvxiA==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr7828797plb.187.1558445582924;
        Tue, 21 May 2019 06:33:02 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d15sm65368906pfm.186.2019.05.21.06.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 06:33:02 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Extend dt bindings to support I2C on sifive devices and a fix broken IRQ in polling mode.
Date:   Tue, 21 May 2019 19:02:51 +0530
Message-Id: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is based on mainline v5.2-rc1 and extends DT-bindings for Opencore based I2C IP block reimplemented 
in FU540 SoC, available on HiFive unleashed board (Rev A00), and also provides a workaround for broken IRQ
which affects the already available I2C polling mode interface in mainline, for FU540-C000 chipsets. 

The polling mode workaround patch fixes the CPU stall issue, when-ever i2c transfer are initiated.

This workaround checks if it's a FU540 chipset based on device tree information, and check's for open
core's IF(interrupt flag) and BUSY flags to break from the polling loop upon completion of transfer.

To test the patch, a PMOD-AD2 sensor is connected to HiFive Unleashed board over J1 connector, and 
appropriate device node is added into board specific device tree as per the information provided in 
dt-bindings in Documentation/devicetree/bindings/i2c/i2c-sifive.txt.
Without this workaround, the CPU stall's infinitely.

Busybox i2c utilities used to verify workaround : i2cdetect, i2cdump, i2cset, i2cget


Patch History:
V5<->V6:
-Incorporated suggestions on v5 patch as follows:
-Reformatted compatibility strings in dt doc with one valid combination on each line.
-Removed interrupt-parents from optional property list. 
-With rebase to v5.2-rc1, the v5 variant of polling workaround PATCH becomes in-compatible.
 Till kernel v5.1 the polling mode was enabled based on i2c->flags, wherease in kernel v5.2-rc1 polling mode is set as
 master transfer algorithim at probe time itself, and i2c->flags checks are removed.
-Modified v5 to check for SiFive device type in polling function and include the workaround/fix for broken IRQ.

v4<->V5:
-Removed un-necessary checks of OCORES_FLAG_BROKEN_IRQ.

V3<->V4:
-Incorporated suggestions on v3 patch as follows:
-OCORES_FLAG_BROKEN_IRQ BIT position rectified.
-Updated BORKEN_IRQ flag checks such that if sifive device (Fu540-C000) is identified,then use polling mode as IRQ is broken.

V2<->V3:
-Incorporated review comments on v2 patch as follows:
-Rectified compatibility string sequence with the most specific one at the first (dt bindings). 
-Moved interrupts and interrupt-parent under optional property list (dt-bindings).
-Updated reference to sifive-blocks-ip-versioning.txt and URL to IP repository used (dt-bindings).
-Removed example for i2c0 device node from binding doc (dt-bindings).
-Included sifive,i2c0 device under compatibility table in i2c-ocores driver (i2c-ocores).
-Updated polling mode hooks for SoC specific fix to handle broken IRQ (i2c-ocores).


V1<->V2:
-Incorporate review comments from Andrew
-Extend dt bindings into i2c-ocores.txt instead of adding new file
-Rename SIFIVE_FLAG_POLL to OCORES_FLAG_BROKEN_IRQ

V1:
-Update dt bindings for sifive i2c devices
-Fix broken IRQ affecting i2c polling mode interface.



Sagar Shrikant Kadam (3):
  dt-bindings: i2c: extend existing opencore bindings.
  i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
  i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.

 .../devicetree/bindings/i2c/i2c-ocores.txt         |  9 ++++-
 drivers/i2c/busses/i2c-ocores.c                    | 47 +++++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

-- 
1.9.1

