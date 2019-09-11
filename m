Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A688C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D08520863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTx76i9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfIKQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:11:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36629 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfIKQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:11:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id l20so20579490ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FS9BUbBclyp2IA2GPd0WAymWJkDYs3hcacEPYz2WRDM=;
        b=WTx76i9yRZ3Jlg22eMMItVdab7Xk/VYaGX0nNTw/Y1PYQPPBGb8bwm0759ZejQA4Od
         E/HTovj53jrC2Q28PalEh7OrWRPQLdz76n8KuOU9SAj3sCpJyDo+d8+MYSvRFEnapoGt
         6g/OHNmjcw/83SiEpAo6ZJew15jZnOMQ3F3Mj1dyG/sjKeZPr6K0RPpLDoI1WA676JI5
         gICZEYfUSMKlsVV11ljoWyajG96TxeqqfVuZtT2ubFTmIvqxki+c3QQipSHDFfyliaGD
         vTmga6lvgfx0VCxK9ySTZuqZaECVjuunZtsCv3oTdPjHK3b9HGNJ0dbeuQ8HUs/rHlj1
         Zxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FS9BUbBclyp2IA2GPd0WAymWJkDYs3hcacEPYz2WRDM=;
        b=T3xc44sY8vBIJJIFJcX6nwFjtPX3nTIa+kQZFZfF+f370fBqMBy2v/CahQA9tlvSca
         f+3kAVPIdX2wZNhtn8lnz3xFRRYYu1oZTcgQWyiMf/O+wTlEkpRJhijUPbOQ3vCthDHa
         vpl8QmU7ZqB9vED9ToV5GfztKkT/NfRg3aDFBO0GP4LeLwbJJHdXPo0uqot+VaoQqYm8
         7XKfNO/tVexKPIo/Yf7d7GOZTjPQSoIUyKw3UaNczhbDNYUPezqs7mkZ/eW3X5keguOq
         GkR8Wjh1cpt8hnB+lPGYesnNEYnvki8A/jZWhovz6PLWdcqj5nBFsaj5f+zQBl8co3X/
         vwrw==
X-Gm-Message-State: APjAAAX3SCxw7mTnCQsSLL3A0Df7oEK4Lc3NU7heEzBsEgapKJRELfVA
        9W3bO+2eiXbDCWdk2PxFKr19T+znOMWSpRIy3S9Z4ic=
X-Google-Smtp-Source: APXvYqxtxCaFEV9s/OhrYuSNAxZosmyisdaBnW66w+2sQPPw0T0xY6CsdS6quqxRi8SK76R4dh6G39ebd+aggdBL0YY=
X-Received: by 2002:a2e:9cd7:: with SMTP id g23mr23741007ljj.25.1568218308264;
 Wed, 11 Sep 2019 09:11:48 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 11 Sep 2019 18:11:22 +0200
Message-ID: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
Subject: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
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
 To be sure is not a Laptop issue only, I tested the device on my
server board too
 with the same results. ( with 2x,4x link on the motherboard and 4x on
a PCI-E card ).

 Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 732d5b63ec05..627625758b40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3038,6 +3038,9 @@ static const struct pci_device_id nvme_id_table[] = {
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
