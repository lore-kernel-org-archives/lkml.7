Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B6EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753A6206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zAQ2uvSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfH0J63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:58:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfH0J63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:58:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so2410941wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtIIzwTDR1B8HezjMZLd0UUrjubJe6Pa7zbd04NstpY=;
        b=zAQ2uvSvJSVmWXzSLfN3dfzl/n5RCwFZYCTgk+n/eg1RDaVnKT69s8WDBwU+9jvvNr
         Zcosf/Sm886GfP1In/JAYTq0mTJA5pJq8/H6r8T0TGhOtRm6eaXGSobKTpUikVR6xOzo
         wecGUL4VzblD5iC96+CMpyhOrd2mh3EkQoIpR1P8ZD45ncg76XgjkinMPqym/E6+JmkR
         bqvvNZ/jlk/eMuacEWTOZuUW4ko4sTaXRtCyv82qgtMfVKWNz5FSYSgsaHlg1H01d2wo
         tUN476WU+HcumjeDsmXOuCodvBUolzMK1RnBxrYs3EyEVAp8H9nndkFhicDEZ9WYRtLC
         0nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtIIzwTDR1B8HezjMZLd0UUrjubJe6Pa7zbd04NstpY=;
        b=tczN1j+fFT66czbMlU8X4uTQ8/IR//HNcBMRORZhrto6Zyh0aX75an7RJK+ZLDfLLV
         m06whQIfDSDZnQuP/ns2RnvkYwGtlRTlppHmOBrq0lhCHsoPTr45EFOVHOM2E/viiTR0
         hV9u/y061Mk7K/P+H+EFcCx06oaq2lzUlgJMtblqoFqSrIEAHTtxE8aq66KP8fBjMFVh
         R65gBJXJy/67j5GUuu281AY0QpixefOPxK0jvwVb7CM7AI3sn8Egh4mdjscRSq7T0wA3
         pgJgtT+e2sGW9c6MEOgg6pPZbor0LjRLXnG1L6M/YCG6KiN44yS1fGQO0lPjSyb3BhCq
         K8hQ==
X-Gm-Message-State: APjAAAWDE2HRkKQ3tE8YxDYX/tK6W+FjEWfboLLWDRLhevG3fJAvkrAZ
        cFlIGigeBfqVVv+gDh2Km/ULaqCh/3QOsg==
X-Google-Smtp-Source: APXvYqxtnYf1tAwNYwh4f/eAjThvqPmtKVp37xwzQWjJOeB8wQJpDTM2QVLcJ49DhGpTADsj+rGFpA==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr9198967wma.16.1566899907058;
        Tue, 27 Aug 2019 02:58:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6sm10862084wrq.95.2019.08.27.02.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:58:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] drm/meson: add resume/suspend hooks
Date:   Tue, 27 Aug 2019 11:58:23 +0200
Message-Id: <20190827095825.21015-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the resume/suspend hooks in the Amlogic Meson VPU main driver
and the DW-HDMI Glue driver to correctly save state and disable HW before
suspend, and succesfully re-init the HW to recover functionnal display
after resume.

This serie has been tested on Amlogic G12A based SEI510 board, using
the newly accepted VRTC driver and the rtcwake utility.

Neil Armstrong (2):
  drm/meson: dw_hdmi: add resume/suspend hooks
  drm/meson: add resume/suspend hooks

 drivers/gpu/drm/meson/meson_drv.c     |  32 ++++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 110 ++++++++++++++++++--------
 2 files changed, 108 insertions(+), 34 deletions(-)

-- 
2.22.0

