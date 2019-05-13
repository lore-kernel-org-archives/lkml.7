Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CDC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B7920862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5QBRMRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEMUaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:30:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36563 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:30:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id z17so5346936uar.3;
        Mon, 13 May 2019 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJi5lC96vbQ5kIDUFpwE/Nznn3R+YuYl3oTaGEijmGo=;
        b=S5QBRMRX4vmrvpFOpauCjHSowRBDI2/0TAffVvirzFa/nPY24bqEHrREytwdPcvSYN
         o+qQYHgehn8maKl4MddbHnstr3QvNheBiQGW0FxJLIamFX5e4GZmNAzmSEAjiUi/cBqn
         zuolDQMJwm6UZwRAvbc5S6soxCDYxAf87EUPMV+a0IHNiRmAGgsUZAzpPkhdODdIo1x7
         FhR1pMxwwP0sYyhwIlidp5farRaisKDmattJtPtPFKLmlojODZT+la/GZPTMba9fJBMK
         UmqG3y6PtpLCCjnZRcY+TIlU+XIwSe7Yt6XTZjjd+wxGPvFnZDYldTPnpHErwGMRM5du
         YV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJi5lC96vbQ5kIDUFpwE/Nznn3R+YuYl3oTaGEijmGo=;
        b=ui5JdT9OXufn0gQGlQLfgpLz7xX9mkExkjro+M7b4LI81ck6zgP1Jx4atZNiAMiz0+
         OV6RZ9jXFEDNag3PO7mVFRxi6MfcWISFfTDsK6tNDUa7mXldLaReam7aZqsUtvOoj8gi
         ynveUaVqFJ7cOgwHrnYr0jUMpG9eTcjvSsssD67m3aq4ou7H4g8dOdfrrUhWfxYzbOCe
         VTv6l6O5L6QJZS7a5FnMye4499jGGrng0Hj77bu2BF6sLhXnMeCvd9h0fLcRhg0VyocK
         2bgxsUhSzSOuIiryjP7vRCQw6fp17kHUN0FUFei5JxYm2bDTZhoPRFh0bfMGG2NKsUvq
         yaJQ==
X-Gm-Message-State: APjAAAUmsqyjvbu0r0kw98ZmeSWQwu95LbxYWe6EtsTkOI9rNi95HGz0
        5wPcXNT8ulo4WD9/YjDNDg==
X-Google-Smtp-Source: APXvYqxvp+g2jLmI6bVnZkxN8U7wCgP69Ut4cq3E97D7jH4E16GiHN1oRAPx1KXUw3b992Gn8RKZTg==
X-Received: by 2002:ab0:6783:: with SMTP id v3mr14845341uar.8.1557779422261;
        Mon, 13 May 2019 13:30:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id 143sm1285120vkj.44.2019.05.13.13.30.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 13:30:21 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v1 0/2] Huawei WMI laptop extras driver
Date:   Mon, 13 May 2019 16:30:04 -0400
Message-Id: <20190513203009.28686-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the WMI BIOS management interface found on Huawei laptops, extra features
such as micmute LED, charging thresholds, and fn-lock can be controlled.

A platform driver has been implemented along with the existing WMI driver. The
platform driver controls the LED, battery charging thresholds, and fn-lock.

We enable sound micmute hooks to platform driver on Huawei laptops to get the
LED to work.

Ayman Bagabas (2):
  platform/x86: Huawei WMI laptop extras driver update
  sound: Enable micmute led for Huawei laptops

 drivers/platform/x86/Kconfig      |   8 +-
 drivers/platform/x86/huawei-wmi.c | 578 +++++++++++++++++++++++++-----
 sound/pci/hda/patch_realtek.c     |   9 +-
 3 files changed, 504 insertions(+), 91 deletions(-)

-- 
2.20.1

