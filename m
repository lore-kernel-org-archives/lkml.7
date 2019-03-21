Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB20218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ltujBy46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCUIVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfCUIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so3811070pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAeeHxVdVZULk1ejIDgs0UYX15J3tI1qhH97ASwxQRI=;
        b=ltujBy46qdUJbhNUSfovtB6qyiJsGqBN71Ak64lsxOWzIvLu6QRDlVM2PRLLDhOg9O
         4yaUGWnngus8WgLK4h4Uk2fXof7mlRa8hI9Ah6eHzwd3uW/pcSHyZZg9ZV2E/Jn9bvuE
         7jXiUoSjiojyEGXgzkGEzZ8kRAK3+utej7xqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAeeHxVdVZULk1ejIDgs0UYX15J3tI1qhH97ASwxQRI=;
        b=m4icqcsazGcBD4jPA7SPmiO5iNTfNhS0LCba9u5e7cdZI386KNmfy4vYtyvEALFpu0
         o7ZIxGecJ7egO3n6lyxVvajqBuEpXlQRCnwPDDdCmVtyag7LQwnP8X35wzk215Nd+zOx
         tLLrziN0hJL/Q61Lq4cvV9CF7OQ9XAcbS9xUEMc9VHE9jnrPf+PtUX1WABr3K/L6DdhY
         QGAuIZCoz0g599Mfr63sxSoZBlu/QwN1zUP7VN1uugCU1oCfGYENDEPatVp+W0SyHOwF
         PVfGozm98EmvJWR4w4SNhNOKseJefqauX3dEvE00rqdvEKa8EuyZTLDf7TKlh1Dwsp3B
         3nzw==
X-Gm-Message-State: APjAAAVAtxWZ4D16CDCvG5ZmzZQ1Z57LxHyvVy+dgCQwX4VJj9hBtru1
        pDWQD/LqMXWTY+7WTzLkegikRw==
X-Google-Smtp-Source: APXvYqz5mgkngF1Jx3tOG2kReTeQ60djEBWglEe0Xv/SC+9HmdFKcuxYUrTl0k1BRl4i9fNBYl0kEw==
X-Received: by 2002:aa7:83cb:: with SMTP id j11mr2103596pfn.117.1553156476331;
        Thu, 21 Mar 2019 01:21:16 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id b138sm6288681pfb.48.2019.03.21.01.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:21:15 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date:   Thu, 21 Mar 2019 13:51:00 +0530
Message-Id: <20190321082104.2874-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v7 patchset for supporting goodix GT5553 CTP. Here is the
previous version[1]

Changes for v5:
- rebase on linux-next
Changes for v5:
- document bindings for required regulators, which are need during
  power-on sequence
- enable, disable required regulators as described in power-on sequence
  using normal regulator calls
- update the proper commi messages
Changes for v4:
- document AVDD22, DVDD12, VDDIO as optional properties
- use regulator bulk calls, for get, enable and disable functionalities
Changes for v4:
- devm_add_action_or_reset for disabling regulator
Changes for v3:
- add cover-letter
- s/ADVV28/AVDD28 on commit head
- fix few typo
Changes for v2:
- Rename vcc-supply with AVDD28-supply
- disable regulator in remove
- fix to setup regulator in probe code
- add chipdata
- drop example node in dt-bindings

[1] https://patchwork.kernel.org/cover/10819645/

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document regulator properties
  Input: goodix - Add regulators suppot
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  3 +
 drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.18.0.321.gffc6fa0e3

