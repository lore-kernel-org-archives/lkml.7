Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4455C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1B621D7B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jAp8hBi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfKIQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 11:20:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36001 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfKIQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 11:20:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so9207462wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QxJTiFF2tFspkmtu1wQfetzhDZKVTexM39tXBbbNRGs=;
        b=jAp8hBi+ormRFjudgmYDiSOMdMveumDKk8iOfwVa1a0eKHmKLPwJfvvfj+Jaqh6MXK
         mG2saAwOrBs+yzS6Su8/Kh3ceJmMJNRYGZzWKIHnJGbqwLMeTxdPD/pTsQqZ/smIYxZa
         Hwmd4oRNfGvXmdxoZNtE+mVe97U1cod2JiQz7gqBU3IqHM4KJ39huM5ppJ3m48M97ub4
         zy9NGpj6R36mc4jbjPYTyoQAFnV0n0pDuFVc76MS/0BGlAEOWe0PCYGR+/pvMQWqmmyT
         kPIdEmeaczhaDmnUK83Y3v53jNywzQO4ZNyDxNCUZDYPA5eodKreRbqd2eDRFhzHUDEl
         w47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QxJTiFF2tFspkmtu1wQfetzhDZKVTexM39tXBbbNRGs=;
        b=iySEO5ytMVclYqZ/MUbE8J0iQ5LlfSIFXcnSNW+/uz/F5vIJl/Mx8YfvlUXgp1hTgl
         sKN2gVF18fjsRRq3Z0OTc8RXHBOj3iUzcHJrSakag6Kt4X9GNLTYVlVWco6Lev/OF2iD
         6fByWotRjAJRHlX5AE6/VFcckyqH/37OgrY7cxqZ/O39qL+QbMWsnkpNfxC+XJt/GZ9p
         NtU5H3jYeoK9ui0rsRV2foW2g3duMA6Yp+WHUAkOVRf0U114+16CdUNMuDme09I3cFGz
         sxSxEGhG9BtwiwuIinizrZq/C+W0I+Z3CZDHF4vKEiq99g0hXGDP5T5aSVl7SJABuV7G
         ebZw==
X-Gm-Message-State: APjAAAUfIlzVC9R6O+Aw1BIfkT0ZrkEsFw9cxbUTNFBq1xyBMjkH3n1k
        tj4BzMcMoRsf4WkVNJIzskrGhw==
X-Google-Smtp-Source: APXvYqzfpSw1QICUjqw55lc5O3xioumYYFSINgP6PwukID8b6dRepSRuAyhR68WqcEXvuvmDdCS1+A==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr13557036wmo.147.1573316445172;
        Sat, 09 Nov 2019 08:20:45 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v8sm14534975wra.79.2019.11.09.08.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Nov 2019 08:20:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 0/2] ARM64: dts: allwinner: Add devicetree for pineH64 modelB
Date:   Sat,  9 Nov 2019 16:20:31 +0000
Message-Id: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Pineh64 have two existing model (A and B) with some hardware difference and
so need two different DT file.
But the current situation has only one file for both.
This serie fix this situation by being more clear on which DT file is
needed for both model.

Regards

Change since v3:
- state the current file is model A and add a new modelB file.

Change since v2:
- Added the HDMI connector node to model A

Changes since v1:
- Added the first patch for stating which model support the
  sun50i-h6-pine-h64.dts

Corentin Labbe (2):
  ARM64: dts: sun50i-h6-pine-h64: state that the DT supports the modelA
  ARM64: dts: allwinner: add pineh64 model B

 .../devicetree/bindings/arm/sunxi.yaml        |  9 ++++++--
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-modelB.dts   | 21 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++----
 4 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts

-- 
2.23.0

