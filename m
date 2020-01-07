Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C60C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABDF20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN3qgW8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgAGSbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:31:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52367 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:31:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so596931wmc.2;
        Tue, 07 Jan 2020 10:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2AIBgXOTt+FNqRRQOGxbKR2OzFOPesMCKgzqENIefV4=;
        b=lN3qgW8Qjj/SN4TmaX+IEt8cLdHHR8EZJq1ielL4kn36yIfUTERAeNCdt8N7sTRe97
         9N44NTiraiWuWiWKLyKlZXdJ5umc5eZ2MdGMAKg8EjAdZ88P2KvOHAdSBTDBaMfgwwCi
         3QrNbL5AksqFdnWnmCOcl2qm5c3rHq2fJ2s5W8zamNbld+kyO3A7QyUXr+/r57Qto8NA
         LhtjeEkQDGSFu5L7m7GVy60+gqQ5pFa89nTAeax7cBPhkf0tg+xNjuS1FXZbjpA/KoBJ
         Tg4arrl2eNDaOqUJztjHe3uWXGSZLk6Nrz5wMBn7AzX4xLJiZSEsgDVkge/M5lYLpAjG
         L2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2AIBgXOTt+FNqRRQOGxbKR2OzFOPesMCKgzqENIefV4=;
        b=IMIZ1DUxLWqZm29BRKHLXx5SQf/mrhal6sWxDQXaScOFkNOE0xDc41KbTaLglJq4om
         uZDTv//dF6BLtJ/Ie9iseUzC80QUDG+LIUkfG833wyCIRZpv0c16MO+T/RicH84t6qbI
         cph/xogL66f7rCYruXiFAUedncSy1wpAwuEFdBINqbnmKXOBt8iv0IYWh6BPuLbsDyOf
         cMqK58KnTA02/z2E74XtcXj1dr0U0/zWiaCYiG3c553YcdNSln+BTcA3Xwelik+8n0ln
         LDQdkZYEkKQNXwfs+fDTxwS8iafR2jgnlgqSo/vt1EarAmynYyY9tZhjnDJLadBjTUQ3
         j1yQ==
X-Gm-Message-State: APjAAAUdKQvEUhsgAA42CraQzOQTEdamgIfAqqKKV3NciXGYLEO95w9W
        7zb2oLbugL+aKZhdUo4DW8zKnF/7
X-Google-Smtp-Source: APXvYqzQ3lG8ltsrcEOxs4u9sQW97RuaPH6OBwhNcSTS9/SdGRiUtgahvHGzweT6zmMBZnU0oHXYsA==
X-Received: by 2002:a05:600c:2c2:: with SMTP id 2mr347879wmn.155.1578421862498;
        Tue, 07 Jan 2020 10:31:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r6sm842764wrq.92.2020.01.07.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:31:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 0/3] ata: ahci_brcm: Follow-up changes for BCM7216
Date:   Tue,  7 Jan 2020 10:30:19 -0800
Message-Id: <20200107183022.26224-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Philipp,

These three patches are a follow-up to my previous series titled: ata:
ahci_brcm: Fixes and new device support.

After submitting the BCM7216 RESCAL reset driver, Philipp the reset
controller maintained indicated that the reset line should be self
de-asserting and so reset_control_reset() should be used instead.

These three patches update the driver in that regard. It would be great if
you could apply those and get them queued up for 5.6 since they are
directly related to the previous series.

Changes in v3:
- introduced a preliminary patch making use of the proper reset control
  API in order to manage the optional reset controller line
- updated patches after introducing that preliminary patch

Changes in v2:
- updated error path after moving the reset line control

Thanks!

Florian Fainelli (3):
  ata: ahci_brcm: Correct reset control API usage
  ata: ahci_brcm: Perform reset after obtaining resources
  ata: ahci_brcm: BCM7216 reset is self de-asserting

 drivers/ata/ahci_brcm.c | 42 +++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

-- 
2.17.1

