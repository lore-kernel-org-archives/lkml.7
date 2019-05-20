Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A98C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56042081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DpAUZRyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfETHKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:10:47 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:32830 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfETHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:10:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id d9so273347wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sN2cJH8aGxHGUMGlIBIdt6/B9FMCCSTgrlFf6cvH18M=;
        b=DpAUZRyGAbDyXkSFmLo+2sNoIaK/G4lsWYUu2PTrsPxZMUdwwjieCJRWdhADBypb0Y
         TSx3zUrxXa1we1Isin4rkNtlhQKVTHCg06TTVCA/vZJzVKP96PY+oswqMqaWQUTCcM5n
         ab3ZsoIjfeZBuNC+H2CSPwckZulUYc/pEGwSVTeu/AAaFbHSBN3bNF1U0ouqDkWipqqt
         G18e8DaoDasCFyKot9A6qCOX3P/L50cEr+vIDhWcHdK4Xvb0mchJi9mVU3vb7h5NXrw1
         sBmDhW2VVw6QJqJTLA3f28FpJKSIGrng916LcRiqso7NZsr3PufR1xJwSfgeeRU7ZN3d
         Zr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sN2cJH8aGxHGUMGlIBIdt6/B9FMCCSTgrlFf6cvH18M=;
        b=i8aR/lPdwh/zCr27erS11q0dVnScyhmT3eCSDpxT96Dm1Tixvi4bTFNR+k3hjy2wwG
         sdw/pSvhOgZeiWpBo55Wgz7vM1Cc4SPQlycxAKO3WhD+COWDstvCzaCEOiwmwk4/Edae
         r5yEuftJ6au50D4/wRQE9G+L7UKvB/3rVULeMag2jqJGVvyRNOk0OO2goZh/9oaeqRaP
         FKvDIN56QtHKKgEsaF1IaMSZK8ecb2muLl37vDkOgDi3KhadrWAzqAQFA6qU7e3BK5L5
         6qJIHkDZypQNs+J2RLSO0irkXPiGGqxQcOsipLgqMayM8X6uBa1BM81Hn/A8cSVOGzOd
         ORdg==
X-Gm-Message-State: APjAAAWzoy9VTXco4DaGoBHOHIDEOQu7fB2ZANMxGVf5IazLsBSrO4AP
        lHogcmsSU+bKYa+Tow6TxRun7/S7tzk=
X-Google-Smtp-Source: APXvYqx+MoUZgbYXBujdIkYxNyuE8NZpSbCu9C+zXBWPGGK83VTZxN6xvrpfuCRooQYL7cwPX3bYgQ==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr4989533wri.190.1558336246012;
        Mon, 20 May 2019 00:10:46 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y132sm24017306wmd.35.2019.05.20.00.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 00:10:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/2] at24: use devm_i2c_new_dummy_device()
Date:   Mon, 20 May 2019 09:10:40 +0200
Message-Id: <20190520071042.21072-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that we have a resource managed version of i2c_new_dummy_device(),
use it in at24.

v1 -> v2:
- i2c_new_dummy_device() returns ERR_PTR(), not NULL so check the value
  correctly
- remove the no longer needed i2c_unregister_device() in error path

Bartosz Golaszewski (2):
  eeprom: at24: use devm_i2c_new_dummy_device()
  eeprom: at24: drop unnecessary label

 drivers/misc/eeprom/at24.c | 75 ++++++++++++--------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

-- 
2.21.0

