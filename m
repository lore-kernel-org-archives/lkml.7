Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FE220665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAL6XCnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfHMSdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:33:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39062 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:33:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so48087794pfn.6;
        Tue, 13 Aug 2019 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S0LAFVLBNQXq0CeH2oVRWGFd66rcpydEf8kpIAS8gsI=;
        b=gAL6XCnWC5cPaEND00MxphBmP8GrhrUVCmuEq2m8iAWJy1JbET8rK9EE7YXwhNLGpf
         FM54iOmeXDZTbKpvO+SPoM35CBsJi0JKDBK7sGVSDx/AhQNU80iCUDrdntePz9980YSo
         HBDn3T9lebdqcge1mzbqupUtrdCaElVeIjW7gLr9ROUxTh9S9ulhZqmoXmd2XTGOSYrU
         OI+2E8RLJTAUkxTEMsuA9cLHMZ469126ijS6wBgEDghlnhcmmXnUTr696hlMCPBSpre6
         swohnYlKfTYCyNwhiEvJGR1+ZWfHZZpRBeYuO81mdywvHYM2DAW3nTws4oqnNxqUuPUD
         cnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S0LAFVLBNQXq0CeH2oVRWGFd66rcpydEf8kpIAS8gsI=;
        b=IQm0S5fbQE9NpbE5HOQFiC1eqSs/zaNSXpfjXWW6yNuPhPzloYbt7pplf4jIskHEjL
         e72pG4HkoWwbPJJ1DteNRmh8r9YlBMA21irAsbWi5K5TPUNjhB+dW9b+QnV4nW2LdCW4
         MJ2V5AKaBvryzZKN5FHXdkdyJ6Py1OFMgHrfKr2dpSa10dOMT/G9aSEZU0BToaM0mLHm
         iijgPoNcq80wDv/zVXmzpjqigcnOdCUDxyFhidDgI5Qv3X4zpIFLnO/05qMOCwm38Fdh
         1PdeB6uAwTd/wXR1DLWBqA9lSbMrP7zgERAzHV6CgXpiGOM5BvGtWFnikFIDDqv2voAz
         VFlQ==
X-Gm-Message-State: APjAAAXdtnslyQb4JvtjOhJaibcIq11ep2F7itOXqVHhZYxrQ56rSy45
        oGxk29py+psbUbi6kVOR0M9z/++/Jrw=
X-Google-Smtp-Source: APXvYqxlwgbqYkkBJXeQ9r9S2GdXtfKyx+HG1e/PmZhbwai+YjZ3+Sc6eIYRPRtPtXY8CUwwZinVeA==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr3459182pjo.94.1565721199642;
        Tue, 13 Aug 2019 11:33:19 -0700 (PDT)
Received: from localhost.localdomain ([219.91.191.55])
        by smtp.gmail.com with ESMTPSA id g2sm176911142pfq.88.2019.08.13.11.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 11:33:18 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH v2 0/2] act8865 regulator modes and suspend states
Date:   Wed, 14 Aug 2019 00:02:54 +0530
Message-Id: <1565721176-8955-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements operating mode and suspend state support for act8865.

Changes since v1:
- Added REGULATOR_MODE_FAST for DCDC regulators.
- get_mode() hook now reads values from the hardware.
- Removed op_mode[] from act8865 structure as it is no longer needed.
- Fixed ldo register addresses in set_mode() hook.
- Reverted act8865.h changes.

Raag Jadav (2):
  regulator: act8865: operating mode and suspend state support
  dt-bindings: regulator: act8865 regulator modes and suspend states

 .../bindings/regulator/act8865-regulator.txt       |  27 ++-
 drivers/regulator/act8865-regulator.c              | 187 ++++++++++++++++++++-
 .../regulator/active-semi,8865-regulator.h         |  28 +++
 3 files changed, 239 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8865-regulator.h

-- 
2.7.4

