Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F48C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8925F2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB7P4zOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCTTxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:53:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34305 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfCTTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:53:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id v64so2691351pfb.1;
        Wed, 20 Mar 2019 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UoFfgHfSWzPt3xT3667SWw0cZSd2ZgW4vdHLz8aEP/c=;
        b=HB7P4zOepspAY/gcj8X/kaOc4wMKQZbXPl/ZFppy3PId/E1cVFzOj8LcRLTWLjgzzM
         8SJx26xY047j1GgiXmRscZUqHPq+7Df8dD/5JEQJy95DE2345Q4YKUqpEWvLBC1toC8X
         0t6x11omhyrwB+V8LZVQcV4TGIsY9uREZz38b8Q3J2Fg5j7XwmtLM4/r5ukfU05E6oeq
         FO1cB8JPCPnrgoJnG+UdKUTfAFhjmDRDOLy2vNus0vP+oYl0YSfxhYR0XQU8+H9djZF4
         yVzxfbO/f9x8shA6ANJIlm3cVJOBBJCCXVH2/hkz0FTVJqTMorgW0ocl4KKhuXOQrnbQ
         HunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UoFfgHfSWzPt3xT3667SWw0cZSd2ZgW4vdHLz8aEP/c=;
        b=g4SPWsIUKgZ/7r1Ax+qatuwLHgBL3lrtFbIlRAnY0DjL+rkzP/lsBCzw2w+eMxwrEh
         rJitgF+dW9UT0FxQKBJEmcxrQ8vXnDaW4bkJAUpbT2pi4/E18aF0SWEyopoHpZHjSuqN
         Xj6MdvSv9Dxk59qUdtg/KSSCwqHNxw5II1MWL6I/DWQxy3h+0R6mTgiRLHNLyJ7CAOrp
         iJ749Sa7K7V+LZ9EFzW39a9pJBJ844PLjBvr+jUpq4fsw9DTuOb6e++e/4m3GldNKd4n
         iX2q5nVRvBCU1fflg/n9KFO0K9g+GYythqJ0d+HDQKypiWKxlxBSYAw9LTcgDZe3BLF8
         Zp5Q==
X-Gm-Message-State: APjAAAVugdHOiWU7/0WvWdQ5Ogz3R5FsPnA/A5GjupYj3DRPhSn8AP7u
        7mOjlDFUywQd8fM5PIoWpD90E6jQ
X-Google-Smtp-Source: APXvYqxAHQP5alxmQiAAdbO0PkrCj5W8rtFRA2xZFHbcY+n/87+mzxJK61FG/US0pM5Fu2rQav9rQQ==
X-Received: by 2002:a65:6149:: with SMTP id o9mr9038067pgv.315.1553111599849;
        Wed, 20 Mar 2019 12:53:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y37sm3805933pgk.78.2019.03.20.12.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:53:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list), hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com, arun.parameswaran@broadcom.com
Subject: [PATCH net-next 0/2] net: phy: Move Omega PHY entry to Cygnus PHY driver
Date:   Wed, 20 Mar 2019 12:53:11 -0700
Message-Id: <20190320195313.15658-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to pave the way for adding some specific Omega PHY features
that may not be desirable on other products covered by the bcm7xxx PHY
driver, split the Omega PHY entry into the Cygnus PHY driver such that
the PHY drivers are reflective of product lines/business units
maintaining them within Broadcom.

No functional changes intended.

Florian Fainelli (2):
  net: phy: Prepare for moving Omega out of bcm7xxx
  net: phy: Move Omega PHY entry to Cygnus PHY driver

 drivers/net/phy/Kconfig       |   5 +-
 drivers/net/phy/bcm-cygnus.c  | 147 +++++++++++++++++++++++++++++++++-
 drivers/net/phy/bcm-phy-lib.c |  52 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |  20 +++++
 drivers/net/phy/bcm7xxx.c     |  76 +-----------------
 5 files changed, 225 insertions(+), 75 deletions(-)

-- 
2.17.1

