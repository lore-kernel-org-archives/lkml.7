Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE2C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641D320873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9hevwQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfGRACZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 20:02:25 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50123 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfGRACZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:02:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id 65so12879018plf.16
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F4BwMGynHNNojraJ7LjreMR6L3I2Kny/UtiBEd/49jg=;
        b=K9hevwQMFXcVZY0TVfn6Ud/SV2/bHQesWc9wE618szqhc73WC4OW/bMO8wMFXc5LHT
         hBJsqQkPoYSzk0WIBzNs3qSkuRNk+q8717TU4h0P6ksPRJedS3kWLecav/KjMXIH7Mi5
         M/N9JoDiIr7xGzxxHzypHZTYjT5LP3c+lfUD2KPWSKXNoC4hlhUwAwd1OY9ZdIq7Pp97
         oqjPKHwwgQADwKO5BxCEdut3RWlfmF/gkW39Ja3geKDPXAnuszI+ynX67Pv0EtyrmlUl
         QuA6JPstUx1rlEZhmP65fPWS7RZ0ir8cg1pbk4fTrlHO/ilY/HIn9ObcMp7MViu9ngEE
         zIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F4BwMGynHNNojraJ7LjreMR6L3I2Kny/UtiBEd/49jg=;
        b=EW2A9tIVcFaDtYVqtwQUAPOrn+7VPVtVFMgMDWaZa766A6AV5CbMI+I7104q5v50Ak
         rbwOcvBtTXe5TqS9CcHtDDVRpz1Gfhzr8vEMMnN8UbAS8IvsgDV+dEMC305YyXJ5WRDF
         FUNJu6AkWL9t1+YsSUlnr7mAtLQNJ76+IO8GLWRCasHITakRnts9nDvi5lAUEGOAqRmM
         hTvOD3K4YfQp8yBnwP35jM4oaTpq5ZPknyE3r75B2nDhIKD+wX3BZoTgyg3sypIqsqYB
         zErJsLocdz50BcmOZ9ffgKUicsRnihpaW62PcbFcd5TbrH1+EPVovU40StxhGyMILxOR
         35dg==
X-Gm-Message-State: APjAAAWlmPiRHa7kNbdmjJSCnZdX9a8Wc7nCVZc7imS0/foDJxkUV2B5
        6HuyxKkmZOa2ve6e1vkTFDioxbDciv9+4P9oryyBeA==
X-Google-Smtp-Source: APXvYqwbaNEq2cmulN5Pfzy8ARhvkLv7MBCDx+b2D8ZSCoaObYtbmood/GQ5VD54MA7JAkzuFbKme7G/xBzZ4Lv3lK4edg==
X-Received: by 2002:a63:5765:: with SMTP id h37mr12364689pgm.183.1563408143830;
 Wed, 17 Jul 2019 17:02:23 -0700 (PDT)
Date:   Wed, 17 Jul 2019 17:02:04 -0700
Message-Id: <20190718000206.121392-1-vaibhavrustagi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH 0/2] Support kexec/kdump for clang built kernel
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes the following:

1. Adding compiler options to not use XMM registers in the purgatory code.
2. Reuse the implementation of memcpy and memset instead of relying on
__builtin_memcpy and __builtin_memset as it causes infinite recursion
in clang.

Nick Desaulniers (1):
  x86/purgatory: do not use __builtin_memcpy and __builtin_memset.

Vaibhav Rustagi (1):
  x86/purgatory: add -mno-sse, -mno-mmx, -mno-sse2 to Makefile

 arch/x86/purgatory/Makefile    |  4 ++++
 arch/x86/purgatory/purgatory.c |  6 ++++++
 arch/x86/purgatory/string.c    | 23 -----------------------
 3 files changed, 10 insertions(+), 23 deletions(-)
 delete mode 100644 arch/x86/purgatory/string.c

-- 
2.22.0.510.g264f2c817a-goog

