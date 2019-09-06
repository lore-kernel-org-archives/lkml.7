Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43031C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189A22173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey2hqfA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404699AbfIFMdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:33:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404687AbfIFMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:33:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so3415674pgb.10;
        Fri, 06 Sep 2019 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz8E2Km3qb90hXAs0IYE6gU7l6QgyfYQZCSLqivyf6E=;
        b=Ey2hqfA7IQvWIjwaZRXLK1MJoLAYZ3w+rNkhCSb2zOJvC3mTkVwW4A3QD/q7u9b5Ru
         84ARDBD6Hxgad++SUaJVDTD20qNcP3oTvxITLv8nkFhFFP562ePZK8saL8OE/oHb10jj
         R32kFFJSqkH2XltA6GO5F1ZEdhkERcUULQytBhvCx/v/iPAmL0qxt9szZqHHL02NhrxH
         uBj1NDFBL2ZljD9+V9/98u7l7lNX5aHrqko49U5yXC80L9KOHHde2J07RPH91rEwmshU
         zKHMvFFtYRNeWaydN/C3775jUprLyNNwkOtEjrp/x02h2+YjbyRQJek7qsulMR8724Vc
         uvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz8E2Km3qb90hXAs0IYE6gU7l6QgyfYQZCSLqivyf6E=;
        b=Dy566/+Oy5cGzLcYm6ixW/7ew9a7tFhBJrGdapk9AoagNpqTdakPpeBw7PA8fLpHIZ
         TOecVfigRejrvnen9I3tXmuqsjNpyxl0ktjtd4RQ3iXNi7lsMVY9FVL3zk8+pVQu4z3D
         zoKXODSLjtZW29k17onc/U2SVxKP5m0gkDk+2CNLskCiuK7cNNiDAS2sI/RHxIev3soM
         FvUjfxacFyQvGgJzzuGP2dpI5usAJLvBou8yH91GQ16Q2MfN83i2/nGkqvRgsfIKZiu+
         PpphVUkrc707c+oT4/oSTd1Qtvg5ExUh5unFREP25nXrIHTvpmXmpFsRPxpiq1kLmVTy
         D9ew==
X-Gm-Message-State: APjAAAXozbdr4eF/wkkQXGTFa5uFnaVM7hVWnPHzmzXxswBCsWxF5e7+
        v3LWuok/v1TDsvJbvEfEWdA=
X-Google-Smtp-Source: APXvYqyyFCOHTFvEoDeCLFQhX/mZ4AJ7iNpCfpGLKwFKukF531c5Ct9E3LFVHRm7nIXjQiD0S/lk7Q==
X-Received: by 2002:aa7:8592:: with SMTP id w18mr10425002pfn.237.1567773188389;
        Fri, 06 Sep 2019 05:33:08 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id h70sm4752933pgc.36.2019.09.06.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:33:07 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3-next 0/3] Odroid c2 missing regulator linking
Date:   Fri,  6 Sep 2019 12:32:56 +0000
Message-Id: <20190906123259.351-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below small changes help re-configure or fix missing inter linking
of regulator node.

Re-based on linux-next-20190904
Changes from previous patch's series.
Build using Cross Compiler.

Added missing Reviewed-by Neil's and Martin.
Added few suggestion from martin for rename of node.

Dependencies:
Changes based top on my previous usb fix series patch's.

[0] https://patchwork.kernel.org/patch/11113095/
[1] https://patchwork.kernel.org/patch/11113099/
[3] https://patchwork.kernel.org/patch/11113103/

Hope this series get picked up for 5.4-rc1, finger crossed.

Changes for previous changes.
Fix some typo.
Updated few patches as per Martin's suggestion.

I will try to commit less mistake in the future.

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

