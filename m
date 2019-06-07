Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31504C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0553220657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wot8PIqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfFGOgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:36:31 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43233 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfFGOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:36:23 -0400
Received: by mail-wr1-f42.google.com with SMTP id r18so2399084wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TO+tC7fWacYRsyaMhXsAdQ88u5H88kvpQVp+NFQh548=;
        b=wot8PIqPhYozDkznWIfR6NX+5Uv1uNcwGbUL8jdwMi40PIL5lo+5PcwXgHuFFXdSxW
         6nGcqDqwbFtln+27LGMaeHeZ2PfVuDkx/BPXDJReWR8p1j7bnv+/62dl2cqRB6riOPT+
         Yzu0/fRLT8RC5DsS5FHymOJOWkFDV0ZK3T3Y0pgEvyY1WL5GSTDprsyhjo9aRA3Pii50
         SfECmLAsQuJDU7EgwTLOVE+/GU2Hi3vTciKRCLNkN3dmmxUpZnmPGgslHl7phfhxrE9x
         Qo9stTwYM++QxvZ4yd6R6BzdbQQeJGz6Cx+EWPbFyZ33u/pWRXyyYBq3BsMilycJl3O3
         P8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TO+tC7fWacYRsyaMhXsAdQ88u5H88kvpQVp+NFQh548=;
        b=NhCrFn9bFbNpncNVFFOSDvMwMxltbVQ9Vd2eaViHVrubC9u5FZ2OogXAQJjGSU5J6H
         a2yVmfexS2qBkSIF4j5/j3ltAty2nlE45+xFZriu8N5RHSJ8OPBKg+vAIX5Kg/9Bx/Ya
         XPWRi66s5jJamB7Aq/7DJFVn3twyXJ7GLsj8/i9Ljba03iptwXEQK9x/5KHOoStMOLeB
         qZlQnQMd+kp5wTvrovl10jQVQRS7nrpDfsx59SxJGaM6J4mF2NwY3eZwOyXKICbFJ1Ca
         4cwAt29k3GjpiB1Pi9WpTTkZr6aoGP/fQ9tYQDzsiE89otkRXvIVCWtKdC07xu/fQSiw
         tT/w==
X-Gm-Message-State: APjAAAVS4HUCHGSyfi3TSycTECM+Sg3GzB2C4LzPKYFXl9Vt0FBC4lSS
        oWNH9WAQQ2VGCGzL751Bcc5iEw==
X-Google-Smtp-Source: APXvYqzp193xcZ1DXAoc8s8Qwn8FldnWiAZPOrOiUlzFVU21d9JnxhQ1Lfqlh6J4gMVli5EEUZD6xA==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr33358901wrr.70.1559918181755;
        Fri, 07 Jun 2019 07:36:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm2999829wmt.6.2019.06.07.07.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:36:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/4] arm64: dts: meson-g12a: bluetooth fixups
Date:   Fri,  7 Jun 2019 16:36:14 +0200
Message-Id: <20190607143618.32213-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches :
- adds the 32khz low power clock to the bluetooth node, since this
  clock is needed for the bluetooth part of the module to initialize
- bumps the bus speed to 2Mbaud/s

Changes since v1:
- removed the invalid Fixes tags
- added the reviewed/acked by tags

Neil Armstrong (4):
  arm64: dts: meson-g12a-sei510: add 32k clock to bluetooth node
  arm64: dts: meson-g12a-x96-max: add 32k clock to bluetooth node
  arm64: dts: meson-g12a-sei510: bump bluetooth bus speed to 2Mbaud/s
  arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  | 3 +++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.21.0

