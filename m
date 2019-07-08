Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95744C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714DD2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ms9u75JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403817AbfGHRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:33:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42262 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbfGHRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:33:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so16970388wrp.9;
        Mon, 08 Jul 2019 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4VeygN0Abg7eEmu02zPFKG/LiENvzvS9nqQqihkBL4=;
        b=Ms9u75JBvQ3ZWj+BbPa8CjoX1faSTZB5rIGp8XdgdD+Ph+4ylCuVHXHEpV83vhU0Nl
         0g1hzGyVSMzgFBNeszzX20XxoFoIr6vaBzjTKkesBzJXV6zZUxeEAH7kMoRL39cV2U8p
         hcqgM2xqn1LqHZly3XYgYNyxgoyvGu0dUp04G5jpcB3Icoqf7YT1nghZXcI2H0G+48/S
         N8U2riQAIlEyNF790SnBjFDHoQ2BQ6ZLL3bjbpefR1jXwbCc9fOnh/UbFiSZFe0IB6OD
         awZv2tPTY599CabMhLP82xSrw97aV6CgqeJex86/nMA50+nWzu3LLiSYJjxaUXOSrSOG
         YO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4VeygN0Abg7eEmu02zPFKG/LiENvzvS9nqQqihkBL4=;
        b=NqH7TOKwlQtuNsADT2K7+HBzb6MR7vJ0pBSs9DjH1R5rkm49ERTuq06ijDwioCdarz
         l0GegfSEK3kSVi6ZXQtJRQokklx3H9hP1VlHitFDDfs6appQOLjh3YEDfGY2MH3wykxx
         wXZ2aiP01aWdPD1emC1Yea4iq44qnwsz8gWg3OMd+zgDjar9SSoZUfnG5Np2tmQxf3wg
         txuHd8875yMsZtyQprlfabrHtrky335UZZ5x0Q1vZW3H09w4jaC7VsA1dTiXFml4N6xE
         cNhajKQHMeJ4Sj9cnSAmub7OTDnLwYeq9WOy8Na6e7Bx9MaNfI2+NvTZaOVVD2i5m3Sc
         xBRg==
X-Gm-Message-State: APjAAAX/P6DmaS0qxrRwVi0PeBgxFJFa08NdrCYT79eUZr8W3eNGq2Rh
        W7Au0X3CUPGukqD0nL3ZE4g=
X-Google-Smtp-Source: APXvYqzfDOsaXbuIlIodiPzCSM9B4fMT2fL+R7nHm6g6q58Rvjk/xi/cA3+25XYz89sPIVOalja1uw==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr1029573wrs.93.1562607225190;
        Mon, 08 Jul 2019 10:33:45 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133D62000D8A33B20A298F2F2.dip0.t-ipconnect.de. [2003:f1:33d6:2000:d8a3:3b20:a298:f2f2])
        by smtp.googlemail.com with ESMTPSA id s3sm222975wmh.27.2019.07.08.10.33.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:33:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, jianxin.pan@amlogic.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/2] Amlogic 32-bit Meson SDHC MMC controller driver
Date:   Mon,  8 Jul 2019 19:33:28 +0200
Message-Id: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is RFC v1 of the attempt to upstream the driver for the "SDHC" MMC
controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

The public S805 (Meson8b) datasheet has some documentation starting on
page 74: [0]

The goal of this RFC v1 is to:
- find out how to set up the MMC clock correctly with Jianxin's help (see
  the description of patch #2 with questions)
- get feedback from the MMC maintainers to see which bits need changing


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf


Martin Blumenstingl (2):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.txt    |   34 +
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1161 +++++++++++++++++
 4 files changed, 1210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c

-- 
2.22.0

