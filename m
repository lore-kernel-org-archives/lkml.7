Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38FEC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C40206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXZG9PCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfIKVVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:21:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39411 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfIKVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:21:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so21569512ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6SoPHoZF8O/ZyTUvhLvM3bS5p+hTFKgEJPCR1inNr24=;
        b=nXZG9PCaIGcaUCi+K97or2ee6PvMcUhYMWXnsTwVQnIj+eLYOJ6Ux5QNQgtZjyGb/v
         VO/a/LPHUkjOAS9kbkuhzh+0Vw8AXlBaHP9t0ys2P1anJiuWCXsrpFla5FrVjIc67Mps
         Aoi8hwrO6bCFGkVWfqP4GvYhVVz3+/AAglW7BAUaq+XHPYhxxp4UbZx9RgjVSSyebDUI
         EVFH+ghpWaArXwELHif19GRWSAyMzK8yak6WsEVEZ2ETvDv4hfAYaCUH6avyYVXl7uhb
         NpAa9dr46gEqMbDBLsDKnL8JipU4kC+R389gAfe9HkNjIltoGrHYCqtbDZFEMQvHlg5V
         lM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6SoPHoZF8O/ZyTUvhLvM3bS5p+hTFKgEJPCR1inNr24=;
        b=LcXc685yLB79/dYZIaei7GA0k0ERV/NbKUWUBG/rzGuWCQ3nLW1jx3XpD5Ke06rhm6
         H6fs/o9D0CqjMsy8qfwPhPkqyxpwFOcCmwfE9O1gCv7wy+ZbENYhf4H2lusV4+xJzTN/
         rovHG+ynPEpDhcbgh6lXLsR+2BCwuIcxwKUzCULTpANprcTjZJShiPS9LKpO8AtZio+F
         Ij87/fs2dCvZKxSKDxsw3t4PGgVwG7wGTL7KMaF/IyfSbY3DF6apibHq945VNM84iGeN
         FGvSAW/Uf4FiuSaByoGAyjifEht+8uBJl7e/LCnMjKZ0enBPJ7wa64XMsTsjbRSZTbBa
         SQJQ==
X-Gm-Message-State: APjAAAW+gPCMu+/TnemOk4DM/9A2DmmHFSW/7PxWsCM7Y9wd7IG+0yWX
        lf04P7VpzvZtpWSptMIAPb95pB1jvrSAm5OjWAqtzy8=
X-Google-Smtp-Source: APXvYqw5gtIvkS2IDXojmcpznuHsletgXdaKcOehEFKttIYDF9R6NXCvBjoFTjMs6SDt7YFYvSkKYwWpmYrieL0erF0=
X-Received: by 2002:a2e:8814:: with SMTP id x20mr25078932ljh.221.1568236907441;
 Wed, 11 Sep 2019 14:21:47 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 11 Sep 2019 23:21:21 +0200
Message-ID: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
Subject: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Booting with default_ps_max_latency_us >6000 makes the device fail.
 Also SUBNQN is NULL and gives a warning on each boot/resume.
  $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
    subnqn    : (null)

 I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
 To be sure is not a Laptop issue only, I tested the device on
 my server board too with the same results.
 ( with 2x,4x link on the board and 4x on a PCI-E card ).

 Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
 Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52205f8d90b4..3093f224c7ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3079,6 +3079,9 @@ static const struct pci_device_id nvme_id_table[] = {
                .driver_data = NVME_QUIRK_LIGHTNVM, },
        { PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+        { PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
+                .driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+                                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.21.0
