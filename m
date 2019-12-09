Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B366A206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8fEdZ06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLIGmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:42:50 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43634 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfLIGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:42:50 -0500
Received: by mail-wr1-f52.google.com with SMTP id d16so14755150wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 22:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z/gqeIwlwYbkGvHNph1xnPeB0WmTDYnMy3C6ZnEFL6M=;
        b=F8fEdZ06skVaGbXmvNuOAlUdaVrRsbGbV5scEVIU8NAkzAS0yg92goupztkyGwj7KJ
         2d3l5g5mkPhjsM8MPcWoRA6MEyckiD6ldXPI3qw0tCf+7Oxb/u6Sc4txD43o8FrpiALo
         eiKrFkJgcuvmNM9ESNomvOc2TWuLm3MJibnXWNu7V5Mur7zP7o0ad+IQ+sL7ric3qiNZ
         AtJuBbs+9uiuy7GuIRuyHjMKCK/eMRJx3D8l7vSp0OT+MzbZzxfk+Hdq026AhtVyZR//
         BPRv/AdNPg4O7F24I1RVpgnfKOfcdURAZucCPW+mC2ZhJABx/Z8W/5sXw7Ek/VusCmgx
         cOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z/gqeIwlwYbkGvHNph1xnPeB0WmTDYnMy3C6ZnEFL6M=;
        b=CzX0HihpX/Q1Q57q81WJyiDUasO4QiQbEBcoOGtrb+nqhWREghUWrA1dFXQuoKqEsh
         jujrjaoa4fxf//5b1xOn/OP42Ctvei+uph+4R4teOKbY4XkdXjA0nNTx1bO8PYJ2W21p
         B04jGnjIolE99PDFH6Jv7YRPQV1cEZngqS2ghGcH3yFrCPXfVsTWTwqv3Ct1wLQdHjMf
         zNBXvAB/DafwZ6F6aHMQvO+Cl3cdxBNR2RgPjUsbk5bCtT+h7KM+ejwiH6KhyOu1YYQF
         1NWK1tkmfUtYzqtMiQWMHiFuuqq1lJSYIGpGK9UDpctfwjpLi3mmnx0hfrT+bhrzVG3a
         YLMA==
X-Gm-Message-State: APjAAAWd9fNonjl5O90tnYVaoxlEPbY6A4+bWqT9JnBfGkOj/eKl7ZLR
        Oe46vz6mmL2nucv9jPM6Zl4=
X-Google-Smtp-Source: APXvYqyPn/RrXy5ko7WN2H39RabnTEknHHNVKRMODNdg6XvnUOedIKK8sNY9CIVa5wedKOsn9+TCZw==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr173008wrr.74.1575873768489;
        Sun, 08 Dec 2019 22:42:48 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id t13sm12980016wmt.23.2019.12.08.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 22:42:47 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     miquel.raynal@bootlin.com, richard@nod.at,
        frieder.schrempf@kontron.de, bbrezillon@kernel.org,
        linux-mtd@lists.infradead.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 0/1] Add new series Micron SPI NAND devices
Date:   Mon,  9 Dec 2019 07:42:22 +0100
Message-Id: <20191209064223.10003-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

This patch is for the new series of Micron SPI NAND devices and the
below datasheet links are for the new devices.

M78A:
[1] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf
[2] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf

M79A:
[3] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf
[4] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf

M70A:
[5] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf
[6] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf
[7] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf
[8] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf

Shivamurthy Shastri (1):
  mtd: spinand: Add support for new Micron SPI NAND devices

 drivers/mtd/nand/spi/micron.c | 129 +++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 11 deletions(-)

-- 
2.17.1

