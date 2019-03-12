Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85FB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAbiG+x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfCLUmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:42:23 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:39799 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCLUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:42:23 -0400
Received: by mail-yw1-f53.google.com with SMTP id z191so3268460ywa.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=WW8DrH/nL/7WHJBmrq7GgUpvZpUNPiMEgwmiPL47BpI=;
        b=kAbiG+x988k0BMT9NQODTa4FmtKqbKp8czgNwLaIPjk2Rl6JckeAjdYEwatQn+GndB
         MA6KbblEqjUbNDZZZYMw1HssGutGPVeOYQ8/M3Hji1/N4xVaIH+AnTmok6zJpPa3ILMT
         n1Gg9ADgIMm8/1834QusgHkASTOAban/ql0qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=WW8DrH/nL/7WHJBmrq7GgUpvZpUNPiMEgwmiPL47BpI=;
        b=hBoppKwjmvo9pLQNUED3rhqf0+QxEvjGfz4SPybxN76Vqxz7gm6nCFm4otW4tuOIEM
         Oj6vVADzVuzMWrBmIFd0W1DwupzDxGnXJdLOgaKZX4kF0tU5VmPF4jVYqfZhMsLiVrLD
         uB7fOsgbYN0xw2FCkVXHX4zLlKPzPydik4qc8OCpxUEyv12cdYlHAa4Ig3kxCsXMCsKp
         UzFknPMW4CFIiH+qk+Fk6D0uecXQ2m9fd0hNbsQt1e32clZLTQ7xnSE5zS7xmfFe6QEG
         LgjWvOq3BcVn8GpOLjQS9Pay6TLJu6mcuDZ285P/ybXl0MoZHBzIRZUAA9m3nQHaKajV
         rcgw==
X-Gm-Message-State: APjAAAXfUBYobMCW02gMfixhIOi+mxviQr7ghCX1fRWTEH3R8QSSwlIf
        NuQ0IpUZiiNAmhGfYOssAIBCvdy2IA/yH8nXW2ryRw==
X-Google-Smtp-Source: APXvYqyC8ex2k1+IuF8NMVO1z1CTxILibfC/HXrrMyIXIcLqz8fcFPDs+4IAmIv23+SogssOJ+PIS4RxLSkFPOQ7WR0=
X-Received: by 2002:a25:34d3:: with SMTP id b202mr34425337yba.188.1552423342298;
 Tue, 12 Mar 2019 13:42:22 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Mar 2019 13:42:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Date:   Tue, 12 Mar 2019 13:42:21 -0700
Message-ID: <CAG5bF+RRSGq6rQjLzG4SF84pCJw-MP2Sw1aMEsyDojEznwDaSQ@mail.gmail.com>
Subject: [PATCH v2 0/2] Bluetooth: hci_qca: Fix WCN3990 firmware download
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware download to the WCN3990 often fails with a 'TLV response size
mismatch' error:

[  133.064659] Bluetooth: hci0: setting up wcn3990
[  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
[  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
[  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)

This is caused by a vendor event 'without command' that is misinterpreted.
Drop the event.

Matthias Kaehlcke (2):
  Bluetooth: hci_qca: Rename STATE_<flags> to QCA_<flags>
  Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event

 drivers/bluetooth/hci_qca.c | 73 ++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 10 deletions(-)

-- 
2.21.0.360.g471c308f928-goog
