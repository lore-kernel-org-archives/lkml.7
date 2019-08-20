Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7220644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbCzqGLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfHTIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:48:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfHTIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:48:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so11495616wrr.0;
        Tue, 20 Aug 2019 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C+7nBjsZO3aX1mRx8/Iq0aFxeGfSOIEcnsK8e+lmsI=;
        b=tbCzqGLD8/3cH1EWSqqXatbWhpVG34OnjPqcnrlXPBxtblOeoOoq26sPGI6ZJv7RmE
         pNBC/uVZqUkqp2OzxAbAi87YfX41a6cPrLOwdLbTMVTJf5RWijqDiwjg3lLY08JWcGZD
         +LkqGFOwQ/Nd5ND4UfAaTe0b4C115lHLa4nE5Wq8Z8VzEWXk+0dxb5Xqr9dPd6GGm8EH
         054ulyrkUkexbZs4O5IDGIDq7wVDyEmPtsKg19ZT4yoU/j661oKjutj1oHTTnUmUSLJr
         KZH+QX9k1AY08pjjhzPnxdEHeX0pd3WwIuxAdSvIoB0ucRT9utqLQeNSdpKStnGlrIlJ
         CCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C+7nBjsZO3aX1mRx8/Iq0aFxeGfSOIEcnsK8e+lmsI=;
        b=TMXsiortSePtXUnmnsXvZxABx0OnVGXE9AG10K3jJ3XM75DNw739k4rNvMhWKncL3A
         Xm9p79/tDr+NIFDPwzJ/QHeWODRLNfS9HFsJjtE1HQbBbWY++QNvcQHrfzKT4PmhC8sa
         3ux4xlkqcqxica6Uqx2t2jl6Mwy5MofKQ+r4Ih790N55Pi+XRFopvwenHysmQHtnvdV3
         TLkXSstc7uVDRamu3uaedXm6kHsHvP4BQ2/sswB08AfeycWK0FyUjvqf1MwqncG+qcpw
         srh8L5JZBhRvYTn1ipGL24xR6zXW2Z0Yc94nbKnR2tjOHqxByvRLEa1JoQC81qGwtwdj
         sm/w==
X-Gm-Message-State: APjAAAUV1haPB5WzCGx4H7EfjlCwXieMhOKslCTpI8Fc7YqazeoNixxD
        KnYyz6M6ydf5SUk3Bt1dpPHMelCShf8=
X-Google-Smtp-Source: APXvYqyUld/dVDp3RIzoXsnAneXbfGY444TiVyq4KPpT9uqB141+w0edXpKXOFubORzPmsFOCNetLg==
X-Received: by 2002:adf:e390:: with SMTP id e16mr22866189wrm.153.1566290935429;
        Tue, 20 Aug 2019 01:48:55 -0700 (PDT)
Received: from vd-lxpc-hfe.ad.vahle.at ([80.110.31.209])
        by smtp.gmail.com with ESMTPSA id s64sm36437105wmf.16.2019.08.20.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:48:54 -0700 (PDT)
From:   Hubert Feurstein <h.feurstein@gmail.com>
X-Google-Original-From: Hubert Feurstein <hubert.feurstein@vahle.at>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hubert Feurstein <h.feurstein@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 0/4] Improve phc2sys precision for mv88e6xxx switch in combination with imx6-fec
Date:   Tue, 20 Aug 2019 10:48:29 +0200
Message-Id: <20190820084833.6019-1-hubert.feurstein@vahle.at>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Feurstein <h.feurstein@gmail.com>

Changelog:
 v3: mv88e6xxx_smi_indirect_write: forward ptp_sts only on the last write
     Copied Miroslav Lichvar because of PTP offset compensation patch
 v2: Added patch for PTP offset compensation
     Removed mdiobus_write_sts as there was no user
     Removed ptp_sts_supported-boolean and introduced flags instead

With this patchset the phc2sys synchronisation precision improved to +/-555ns on
an IMX6DL with an MV88E6220 switch attached.

This patchset takes into account the comments from the following discussions:
- https://lkml.org/lkml/2019/8/2/1364
- https://lkml.org/lkml/2019/8/5/169

Patch 01 adds the required infrastructure in the MDIO layer.
Patch 02 adds additional PTP offset compensation.
Patch 03 adds support for the PTP_SYS_OFFSET_EXTENDED ioctl in the mv88e6xxx driver.
Patch 04 adds support for the PTP system timestamping in the imx-fec driver.

The following tests show the improvement caused by each patch. The system clock 
precision was set to 15ns instead of 333ns (as described in https://lkml.org/lkml/2019/8/2/1364).

Without this patchset applied, the phc2sys synchronisation performance was very 
poor:

  offset: min -27120 max 28840 mean 2.44 stddev 8040.78 count 1236
  delay:  min 282103 max 386385 mean 352568.03 stddev 27814.27 count 1236
  (test runtime 20 minutes)

Results after appling patch 01-03:

  offset: min -12316 max 13314 mean -9.38 stddev 4274.82 count 1022
  delay:  min 69977 max 96266 mean 87939.04 stddev 6466.17 count 1022
  (test runtime 16 minutes)

Results after appling patch 04:

  offset: min -788 max 528 mean -0.06 stddev 185.02 count 7171
  delay:  min 1773 max 2031 mean 1909.43 stddev 33.74 count 7171
  (test runtime 119 minutes)

Hubert Feurstein (4):
  net: mdio: add support for passing a PTP system timestamp to the
    mii_bus driver
  net: mdio: add PTP offset compensation to mdiobus_write_sts
  net: dsa: mv88e6xxx: extend PTP gettime function to read system clock
  net: fec: add support for PTP system timestamping for MDIO devices

 drivers/net/dsa/mv88e6xxx/chip.h          |  2 +
 drivers/net/dsa/mv88e6xxx/ptp.c           | 11 +--
 drivers/net/dsa/mv88e6xxx/smi.c           |  7 +-
 drivers/net/ethernet/freescale/fec_main.c |  7 +-
 drivers/net/phy/mdio_bus.c                | 88 +++++++++++++++++++++++
 include/linux/mdio.h                      |  5 ++
 include/linux/phy.h                       | 42 +++++++++++
 7 files changed, 156 insertions(+), 6 deletions(-)

-- 
2.22.1

