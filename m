Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB51C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B821744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnXpGput"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAFTTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37855 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so27375826pfn.4;
        Mon, 06 Jan 2020 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=heHz5wZuzXTdBGUmx/YHIf/45oIB7A91VueQZsvfKjE=;
        b=DnXpGput7gtpmON1fqiLnDOfVc681O5mWoaNZbQ/Tnw7QOg9aVfdryzL2FcP+EPQod
         iVOpopUdj8aB4pFwFJAtZRGfwLajTUF/yvCwusWMiU5Q5Nz7r3gTH63KRIJFVYOoWMM2
         O+pXWl0V2STFGnS7TXo0Tp1yHSh522djSrsWOQsmTT5k2m0YscarL9uJe88lTTX2ZgEy
         NWdGx6KE0FqHKLCwrzrlG6yGEFQ7YYfchb1fYr9+cETIs5vWVPK/7o6D6gO/0MNCLzxJ
         TT7pba2ntof5WGShFaOdIhiTmLNf4d/xJoWK0CFY7MSJH7I1Au+EZNNoMM4aHXGL0gsh
         NTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=heHz5wZuzXTdBGUmx/YHIf/45oIB7A91VueQZsvfKjE=;
        b=fCaAyO3kxZ6X0ZQzoLH3gBF6t8IHQpx/tUiukS5Wp3+LE6KoddAsyTTweIQJzJf4l8
         GVIc+6R8lEU0d1ksZnLFzZxaDbVTwlklSyDwOAlo31Q8Rd5flLijuEAGo+sgq5Qx1bpo
         DyQzBPSGK5K69aU/o9I076eWFmkLwJdU4xkUHtmycyMM4m+Pcjd/SmJGAjwqWDrVKAkr
         75PgYlNeIDmYqUY/uJUQsog3IdjkI1IAepb6XkFg+6Xok8IsiKu5tuqsH512//m+FV45
         JvRSVOU3AQVrjVSrYl59H1vc4xjQ4uRIfTJswrdhsVrpVYciyyxjqlHQWGe582y/I2OQ
         +wjA==
X-Gm-Message-State: APjAAAUNJpY1pO4jCwZWyfEL3cxOzqg2kO1I2zECix5s+VrhHut6IgLQ
        qHoUqXDwUZkGCja154DX/XkYKGaS
X-Google-Smtp-Source: APXvYqw02VHBv9pALmTt4e66yjxNPt0213mHu1XoW1os+69zviUlI+QEIwTyoxOUmaFmR9g8oJ80YA==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr110270721pfd.144.1578338349310;
        Mon, 06 Jan 2020 11:19:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g10sm72795594pgh.35.2020.01.06.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:08 -0800 (PST)
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
Subject: [PATCH v2 0/2] ata: ahci_brcm: Follow-up changes for BCM7216
Date:   Mon,  6 Jan 2020 11:19:04 -0800
Message-Id: <20200106191906.18266-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

These two patches are a follow-up to my previous series titled: ata:
ahci_brcm: Fixes and new device support.

After submitting the BCM7216 RESCAL reset driver, Philipp the reset
controller maintained indicated that the reset line should be self
de-asserting and so reset_control_reset() should be used instead.

These two patches update the driver in that regard. It would be great if
you could apply those and get them queued up for 5.6 since they are
directly related to the previous series.

Changes in v2:
- updated error path after moving the reset line control

Thanks!

Florian Fainelli (2):
  ata: ahci_brcm: Perform reset after obtaining resources
  ata: ahci_brcm: BCM7216 reset is self de-asserting

 drivers/ata/ahci_brcm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.17.1

