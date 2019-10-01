Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1496C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E8F21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZCCL6Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJAHjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:39:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:39:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so7282671pfb.12;
        Tue, 01 Oct 2019 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+XFVlqmdczgfds1Dy3o5Q1n0UPcPm7FLBJVkbS1FRI=;
        b=kZCCL6Wv6ckxpsHQfP+jMu5n4JpfOYT7ga47pCoO6uutcU6zZrOm55rBGFlhH9x5zO
         x8Iwi3y9n+iUUObpezPF57bsLFwJcXhgmKd0JCEjTZ3Mgta7i4vx3+eh+ac9CIWMFdGU
         P+k8VHxMK7iG0ka/iHqUkv1dug5WK2tQEtbN+rJcMEZ2q4w8OcJl5239zu3Amrxm8ZRP
         EwKcuShpZ85tg2suVwzZ8lDLUjsmZetUDc+LWuiIcM4B7mowdLHNONz1qMc0+pFxi8Kk
         YesWe/Y3LQxpfw2FeJrVpb9eUF9Wb/2a5EkQody0trLjgKnQFkQuiH5HiPbbRpRybzfW
         pYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+XFVlqmdczgfds1Dy3o5Q1n0UPcPm7FLBJVkbS1FRI=;
        b=I5GEPNrSjrODd6OxkUgLda2gHnfcx0swIt2HbpY94JimgTnFtYay9peZcNeGFkew7Q
         wBA99ja5Oi035C3F2vIgPZ4cG1UGbo83xPR43sr6AXoW8PZjEbyJVMBg2hVJPRjg/que
         Ebt5XmH3KNsXnRRlo9BHeviXjjkxhzuUXGAaYuOQv8f99qY0ZmpupCnc11wGBbZWw+o4
         5IObQqJvn9idMKmSWCPJNxUsQI+KxL8Lon1yGcQlc1xlB7cT7N0mHT7fwwkhE5WCmNcm
         lDof7ScRc6GAfZ0y6xDFuiCMWpoDf/mL50dRevK3M0UmVkpT9h5Ev+fzupOj3Cb/2eDv
         Vk1g==
X-Gm-Message-State: APjAAAV1UHW+OUIfPou7W2x+rqyjU8Ua5aEwrA1SdHsfBiO6P4ExEAUN
        73Vuxasf7oztbEo2YQ9z/eA=
X-Google-Smtp-Source: APXvYqyS/slV7GS5YvJ7kRHM3s6Z948KYm85VVT9ES4WvZ/YOhx/a+DDOUToG0ox75TZC06wlRzJew==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr3979423pjl.96.1569915551132;
        Tue, 01 Oct 2019 00:39:11 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.191])
        by smtp.gmail.com with ESMTPSA id g19sm23133024pgm.63.2019.10.01.00.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:39:10 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 RESEND-next 0/3] Odroid c2 missing regulator linking
Date:   Tue,  1 Oct 2019 07:38:58 +0000
Message-Id: <20191001073901.372-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this changes got lost so resend these changes again.

Below small changes help re-configure or fix missing inter linking
of regulator node.

Re-based on *next-20191001*
Changes from previous patch's series.
Build using Cross Compiler.

Added missing Reviewed-by Neil's and Martin.
Added few suggestion from martin for rename of node.

Changes for previous changes.
Fix some typo.
Updated few patches as per Martin's suggestion.

Best Regards
-Anand

Anand Moon (3):
  arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0
    regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to
    VDDIO_AO3V3 regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI
    supply

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

-- 
2.23.0

