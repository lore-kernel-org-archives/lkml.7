Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75293C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD63206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SAmYe+PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFEOM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:12:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32833 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:12:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so7202939wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AycgXSGYqUAjsITGUjnhQpci5ICfquB/aTQgTSexg/Y=;
        b=SAmYe+PChAGdpz3sq/wSWM30WEDKfSGzSN7aCEWwBeVVYwBTaYCsR8tqJy2F6mPhTx
         UEEXrL7JujXQ6vElMFOuTPhlaA+BpBXz+2W1+aalkZh0k6taPWsHfWnYHGk7aAxSEbhT
         LAjZNa1A1Fh6k9NaRNQGCpDiwd+CFSbmT8UB45Ry5bQjWLFCt2M1NcfMwMDX2rvdSo+P
         GHZ/6io8pmjRFt1qxRcfPHuUZCj+xdzR+vt0Mb5u14YyACdNpab0HYjEGCpcJyJlwyAS
         ZpWMHVaNsjXy5tt7nssu3TvOObOZt70/I6DejgUIR5PHEzNv5qHOEyq0RoZRM79oLKyh
         UOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AycgXSGYqUAjsITGUjnhQpci5ICfquB/aTQgTSexg/Y=;
        b=NkErk68iEWPy4K9RLfGRAYp+7F2dfXXkEl7P4RlUaPM10dBUrKkBAHhHbmwnt2Svf/
         kkHHlyQKRuwWl3+RGPfy8nsMdcqYVbZ2C659dTKeGUKQkM+Ekl9LgtI9APpIpyb+V4yx
         q+VGNxrjQSMl5+Wmyk9WWbuFv0oDMfzDoVSkoBwGeA8F3KdqXPCk9qxPmzbnIuEfUbkp
         IOhejzR4l+VoCHx8hUl+85YE/tkENsXf0CUBG/kN5RfTIemKfLuDuLj5wjwhPMjvkwec
         bWBSmB1yMzTqp7NJkRfsL/ZnZBTq4ljVHGGDR6HoRYevtNNxn1N1bnBRk6KeqvTpbaBl
         Nm+A==
X-Gm-Message-State: APjAAAXlQ7e47Hd/w2ijNzlf08wQUHtbtg34VwZQ8YUk8EH0LEpAJVbe
        Kzr+kWVX4wSL2jI5U6KqWutONA==
X-Google-Smtp-Source: APXvYqwt/qL/+dVCADHJ7VzKOX6wFacIr8smg4S+3JxBM+1fYpsjKCJgyKEX+SxU7TlspnyF/Abntg==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr12845013wrw.138.1559743976264;
        Wed, 05 Jun 2019 07:12:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s8sm36292546wra.55.2019.06.05.07.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 07:12:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] drm/meson: fix primary plane disabling
Date:   Wed,  5 Jun 2019 16:12:51 +0200
Message-Id: <20190605141253.24165-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary plane disabling logic is broken on all supported Amlogic
SoCs, and the G12A primary plane disable register write is wrong.

This patchset solves thse issues, and has been tested with the Baylibre
ffmpeg-drm tool and modetest.

Neil Armstrong (2):
  drm/meson: fix primary plane disabling
  drm/meson: fix G12A primary plane disabling

 drivers/gpu/drm/meson/meson_crtc.c  | 6 ++----
 drivers/gpu/drm/meson/meson_plane.c | 8 +++++---
 drivers/gpu/drm/meson/meson_viu.c   | 3 +--
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.21.0

