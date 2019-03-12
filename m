Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C47C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCEA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UUGIQVVy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kasUnOmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCLSOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:14:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfCLSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F2CF61A88; Tue, 12 Mar 2019 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414452;
        bh=VfoQ9P+nBV3qLb1P5GFp8/EbXMKBz+LBU60OvazZA68=;
        h=From:To:Cc:Subject:Date:From;
        b=UUGIQVVylF3H8pQoU6D2lESNVWcX9WfTVLKXccV0Gevh02RsKOQmt5XHkcsPO+8mN
         1I+N3ZQYtGpDi5jr9t3v+fxnUbAkgOIUqqwtPc4xXFYAIEG3k7qqV4ArnxWHlO2s3L
         Oa4/wCh/DqgEDTjd5pQuO9n3uM+Tj6cJjRPq7VDY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80F6B619B1;
        Tue, 12 Mar 2019 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414447;
        bh=VfoQ9P+nBV3qLb1P5GFp8/EbXMKBz+LBU60OvazZA68=;
        h=From:To:Cc:Subject:Date:From;
        b=kasUnOmq7pYyOiMC/Jm9UKzf34zQZbFOFwKU5PzuHxCQUZAz2HoJI5Am9gXXfe3so
         h2KICw3FVFB+HpulmDBBtnuGuJ/pAntOOHR9s1iaunTxbfAe3zdhZBoKC99W4umcbl
         TmNPssS5xHQua16yrVOiLrmRP0XYeg3w1m3mgqf8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80F6B619B1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        Mark Rutland <mark.rutland@arm.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 0/4] drm/msm/a6xx: Add support for zap shader
Date:   Tue, 12 Mar 2019 12:13:38 -0600
Message-Id: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series adds support for loading the zap shader on a6xx and using it
to get the GPU out of secure mode.

The Adreno a5xx and a6xx GPUs boot in "secure" mode which restricts the memory
the GPU is allowed to use. To get the GPU out of secure mode we need to write
to a register. However some bootloaders block access to this register and
require that the GPU instead perform a sequence to pull the GPU out of secure
mode. This sequence requires a special "zap" shader that will execute in
secure mode, clear out all the internal GPU settings and then transition to
in-secure mode.

This series adds support for loading and using the zap shader on a6xx assuming
that the shader exists and that the bootloader supports the secure mode. If any
part of the sequence fails then fall back to writing the register. If we get it
wrong, then writing to the register will trigger a protection mode error and
the system will go down.

The actual zap shader works almost identically to the one on 5xx outside of
a minor workaround for system resume. The first patch moves the a5xx specific
support to the generic adreno driver. The second patch add support for the
zap shader and the final two patches add the DT bindings and DT settings for
setting up the reserved memory that the shader requires.


Jordan Crouse (4):
  drm/msm/gpu: Move zap shader loading to adreno
  drm/msm/a6xx: Add zap shader load
  dt-bindings: drm/msm/gpu: Document a5xx / a6xx zap shader region
  arm64: dts: sdm845: Add zap shader region for GPU

 .../devicetree/bindings/display/msm/gpu.txt        |   7 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  11 ++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              | 109 +-------------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  38 ++++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 113 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   6 ++
 7 files changed, 176 insertions(+), 109 deletions(-)

-- 
2.7.4

