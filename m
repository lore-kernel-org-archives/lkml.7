Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C853C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WsDFoTDy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PE6rftCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfDSTqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:46:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDSTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83C12615C2; Fri, 19 Apr 2019 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703183;
        bh=efOXqiZEApACOspyq6NCpyux/k3Yp91jYp7zsyeW3Xg=;
        h=From:To:Cc:Subject:Date:From;
        b=WsDFoTDy4zGxQX3LMcfNVMb+qjS4ncTFeEI9ct7jP4tUmMXMkPmOGfr1oryaKY2E8
         s+2Ksgk7lYaU3k0gxt4sPSUaSZJWyuayQtxn0ABCBjGj0ZxdBb0cRBvxxjNBK46MXE
         ls1jrM9U0q/mUPoQKXuLKo9d4w/5UujZBRGn8ksk=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7331560DA8;
        Fri, 19 Apr 2019 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703182;
        bh=efOXqiZEApACOspyq6NCpyux/k3Yp91jYp7zsyeW3Xg=;
        h=From:To:Cc:Subject:Date:From;
        b=PE6rftCe733wjfx3ygRqFxXIiWgkxllGHP5vr85f7cJ7fdCxif4MRaMxRzMkrEUFb
         RIQsDp/jNqZLdT/X9KpUcuybFscBR8o1t0WteQbbNNvQwZTtsqu2HtFFLWjy0ynu5U
         jgRI9Gs636oeX7M39ZvTGFJT16HoAVoI7Y7Mq098=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7331560DA8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, Daniel Mack <daniel@zonque.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 0/3] drm/msm/a6xx: Add support for zap shader
Date:   Fri, 19 Apr 2019 13:46:13 -0600
Message-Id: <1555703176-5499-1-git-send-email-jcrouse@codeaurora.org>
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

v2: Reduced the redundant log messages for targets that don't need the zap
shader

Jordan Crouse (3):
  drm/msm/gpu: Move zap shader loading to adreno
  drm/msm/a6xx: Add zap shader load
  dt-bindings: drm/msm/gpu: Document a5xx / a6xx zap shader region

 .../devicetree/bindings/display/msm/gpu.txt        |   7 ++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              | 111 +----------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  38 +++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 135 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   6 +
 6 files changed, 187 insertions(+), 111 deletions(-)

-- 
2.7.4

