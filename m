Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D600BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C5020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNtJuPJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFGIf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:35:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40145 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:35:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so781830pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOLXUpq3s4svc3Cb5o0cuO6zNdr2zIZ53GxxO13HULA=;
        b=cNtJuPJdBf+76+FIHXRqrb62Gu0a3W5bwRWSGq/Awpg612ChWmX34W/4ee+7sMq6cB
         OdsiTvGx/uswbz32NfXfuf9d0wREnzw5qCeujamyKkTpviW94LFzkTawp0gw1n6MZdyf
         azN9VWlvdHaocIMwVVa5KskNRl++9A5zAlswQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOLXUpq3s4svc3Cb5o0cuO6zNdr2zIZ53GxxO13HULA=;
        b=cy3s7lfZxR/cS7g+gN8cuM/kI91DJTn2R15+uV5Vcu0I0kzCm3VpxNHbbNsRUwbgXa
         Ymyi51sVfObxK87qb7WlW1fxj+b5Hyx2h2svpqW8bPxo8Eh2ZfBns/N6mDhvZwX0PJeW
         wRFo1eFie0EYyzYrHDccagpG2vJVTElLyr0T0PIJ0xfi+WcFcLzA2b3f6PvqpIbK4N1S
         9PDdMiS+0BllfdV2p4PikmlRgvuCvFmyyuLokYjMw9voXAFAVTlL/yrJ1ME/+I3Vikpk
         0armXGjZmzprXVkQSowgCbSCbi3mSNHoiiiD+zoZJdrCQx+NJiUzkz2lLX78jZ1VWeFE
         b7mQ==
X-Gm-Message-State: APjAAAUrAAzLd0ocgMTVouxRlH6K6x/0U83+ag2mFvqF4yRn8J5hAody
        J2kQPgLhMyWebeTOfc7pBrFC6w==
X-Google-Smtp-Source: APXvYqyQFIagXtjKC+oKCI13OrcGrXZcIXeRXH0yCpp8sYK+T78yBASGcqSO+GyLmvngeJ8aX5FkvA==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr4268037pjp.62.1559896528709;
        Fri, 07 Jun 2019 01:35:28 -0700 (PDT)
Received: from tfiga.tok.corp.google.com ([2401:fa00:4:4:6d27:f13:a0fa:d4b6])
        by smtp.gmail.com with ESMTPSA id l13sm1240509pjq.20.2019.06.07.01.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:35:28 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] MAINTAINERS: media: Add Tomasz Figa as a videobuf2 reviewer
Date:   Fri,  7 Jun 2019 17:35:18 +0900
Message-Id: <20190607083518.90078-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to review most of the vb2 patches anyway and we need some active
reviewers, so let add me to the MAINTAINERS file as such.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98cd84977350..b5f65f61becb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16758,6 +16758,7 @@ VIDEOBUF2 FRAMEWORK
 M:	Pawel Osciak <pawel@osciak.com>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
+R:	Tomasz Figa <tfiga@chromium.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/common/videobuf2/*
-- 
2.22.0.rc1.311.g5d7573a151-goog

