Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BCFC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE472073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBqhh5Em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKXOHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:07:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34454 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKXOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:07:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so5300077ljc.1;
        Sun, 24 Nov 2019 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bg5GpAxFjEyHhb6UxLV4Zo8pi9OBMfOKtL7ZoDiUptg=;
        b=VBqhh5EmM0AiPWFf803YYdLXZoq7psW4zJIbVf245kSW7bbm0DDr2Bm7XGKRmci29s
         NfjLvKeLlD+z9QUBkLz1zxsAHdfFzBBzb2K6IB6WBqOBwY3P6GXwin5YZM8ykOdLdCIu
         NP0TgR2W6oEXULKBqFYVrHqQMvwqXi0l5BOyiS1ooO/wGwqNvSPZ1JXTVsFpoYkc5AHs
         0Z1ARhS0rU0RbFXEaTqYCMfilUfCUF6saA931Usi7tpaEsslDypEyBjUaxrE4UrV/jYU
         AOpa6T99YDMm8lWpY32Rf4A6gaPrD63io1EOPBXYmR4ntmHlucp9X2KkPB2jwXDz4Nff
         0aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bg5GpAxFjEyHhb6UxLV4Zo8pi9OBMfOKtL7ZoDiUptg=;
        b=Bli48qWnw3wW5rZbqcgA5zRu84uMUxPCJ/V/WlvLDiUBPA9w6anGUw0DRqR6gaTjz9
         A0V9kxHMLmc/v4KvHZb42YdejeauHDktem0uDq8Ys4FEHpMd8QyOTHNHpOgvWLvLteba
         Mlq4V8knL+JuAg2Q7DTSkW7gME9RujlRNKNqrq/pM4Rjz4+2Gze+qmq+cNv2vPBKxHCd
         yCzm74/3SKZ9eS+gDKdHD9MiV0sc7sLuc99WG1NgaFW/sQ8nm9hD/tHtE5qfD/08wNIk
         SMfQ5pHfar7r3yGT9FE4e+1OObjrmezwlRT4Q9vYKfI7nFLsSptZB5/Kom/XhzA8/D2v
         4vhQ==
X-Gm-Message-State: APjAAAUaAgrvB+CnaruUvfl0X0v+ycJ66X+c8fz8ICGkDMFVkWJi92Ju
        XRJgQTv1LMvs5tJ7t25HdXht0S3u
X-Google-Smtp-Source: APXvYqyFzOFkvmfBUiGwu814GAnhxLxs6vI94Z/1M3nTu+r7ovxcoTmytPfa5qpMk/oOzb4De+tBpw==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr12420071lja.217.1574604425002;
        Sun, 24 Nov 2019 06:07:05 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id g21sm2273681ljh.2.2019.11.24.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 06:07:04 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        kristian@klausen.dk, andy@infradead.org, dvhart@infradead.org,
        corentin.chary@gmail.com, Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v5 0/2] platform/x86 asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Date:   Sun, 24 Nov 2019 16:06:25 +0200
Message-Id: <20191124140625.20736-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of Throttle themal policy ACPI device to
existing asus_wmi platform driver. Support of this device is required
for ASUS TUF laptops on Ryzen CPUs to properly work on Linux.

v2: fixed indentation.
v3: patches 2/3 and 3/3 are refactored.
v4: patch 2/3 are simplified.
v5: add new device instead of merging with fan boost mode

Leonid Maksymchuk (2):
  platform/x86 asus_wmi: Support throttle thermal policy
  platform/x86 asus_wmi: Set throttle thermal policy to default

 drivers/platform/x86/asus-wmi.c            | 128 +++++++++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 129 insertions(+)

-- 
1.8.3.1

