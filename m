Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D270CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6F32184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNztzyFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfJVSbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:31:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfJVSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:31:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so11157170pff.9;
        Tue, 22 Oct 2019 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeDvAjQsjrYrlLSuu+Jz91MnGz1OObnz6v+WgTTWu5c=;
        b=gNztzyFHWTtfSDCaP/HfT9zML2AyKrbFMMzvR9H+nYAokweZkjfCBHOp3Xzh/GF+tZ
         davs+puk3rn8lzmgcQgZREMAXBv6WGKyR2GDKTuglcL8/a9h8L0+msxpAlh+GcVurkel
         B+U64TbXlLAq5tHow2iIei6DMzWMgD098kfesOkkv8+/M1vCXIv3Kb3xP/vQorI6pLh6
         lUWAcHDbuf4T6S9FkFgnktH2QC6MbbeMpej6WEJuGeWWUw3bXS+dG8FmLZHUzUGNCx8f
         KRSX/3idatgF5LbyT9pCxGuGjOogxaAi3YHkKwXQEO9dDqLD2KWnYR6Yhe5P7MOELP9J
         aQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeDvAjQsjrYrlLSuu+Jz91MnGz1OObnz6v+WgTTWu5c=;
        b=nt7NBRkjj1kr6fNEvAQpOiZ/f3kqKA72VbWZWJIdJQyc6E3D3Flylm+AEjXgRz2H5f
         K8FMQFPM8AufP5gbprtQl+cwQbIIfx0PV2+/9/CFcI+HmaWACAZXopMXEqmQmQBb48ap
         PPOQkd/rSkkm++TsPHuRbAPIPWb9cu82W+uKOkUa/oh3D+CvjVQL73gmp/UCu6XjRG4V
         N1Ffd5Qghj2AjoPSTMcihMeGPNtXvd8iNhWv8RbKv8/k8KGuAkHsqwIiz/yWMWwmXYIO
         GXBs1xlRf5awCGD5hzTLY+nBXOaUfL2xjACc97Cl9ISB1Mh+MNGs2ufzUqDwVcZtBS+c
         J1qw==
X-Gm-Message-State: APjAAAWBdpZ2lYv0GoyNbdpjmlgu96uCyaIO+j5IkcpzDp49ikYTSAEM
        +KyRbxBUEv2lzqzdE7DkmFg=
X-Google-Smtp-Source: APXvYqzna4x7O6NiaYj3+n+EKQggUVh1mmKq21UR1LLUMJLAz77V7BP09P9HL2gIhzrBXlRLzgA8gg==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr6612216pje.113.1571769090041;
        Tue, 22 Oct 2019 11:31:30 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::2398])
        by smtp.gmail.com with ESMTPSA id m19sm16787947pjl.28.2019.10.22.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 11:31:29 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <olteanv@gmail.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH net-next v10 0/3] net: phy: support 1000Base-X auto-negotiation for BCM54616S
Date:   Tue, 22 Oct 2019 11:31:05 -0700
Message-Id: <20191022183108.14029-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch series aims at supporting auto negotiation when BCM54616S is
running in 1000Base-X mode: without the patch series, BCM54616S PHY driver
would report incorrect link speed in 1000Base-X mode.

Patch #1 (of 3) modifies assignment to OR when dealing with dev_flags in
phy_attach_direct function, so that dev_flags updated in BCM54616S PHY's
probe callback won't be lost.

Patch #2 (of 3) adds several genphy_c37_* functions to support clause 37
1000Base-X auto-negotiation, and these functions are called in BCM54616S
PHY driver.

Patch #3 (of 3) detects BCM54616S PHY's operation mode and calls according
genphy_c37_* functions to configure auto-negotiation and parse link
attributes (speed, duplex, and etc.) in 1000Base-X mode.

Heiner Kallweit (1):
  net: phy: add support for clause 37 auto-negotiation

Tao Ren (2):
  net: phy: modify assignment to OR for dev_flags in phy_attach_direct
  net: phy: broadcom: add 1000Base-X support for BCM54616S

 drivers/net/phy/broadcom.c   |  57 +++++++++++++-
 drivers/net/phy/phy_device.c | 141 ++++++++++++++++++++++++++++++++++-
 include/linux/brcmphy.h      |  10 ++-
 include/linux/phy.h          |   4 +
 4 files changed, 205 insertions(+), 7 deletions(-)

-- 
2.17.1

