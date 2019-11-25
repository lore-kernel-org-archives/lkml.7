Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C342075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKYMAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:00:00 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:1231 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbfKYMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:00:00 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Nov 2019 17:29:59 +0530
IronPort-SDR: fGVvEbj3FbHStOiD96Mom5gthGHa8KO1XYyHL8KQT4lSK5jDoYhy9GFDdyNRMiCfXnWSAAGJ75
 +/dIjDLw5Nj1o1vpbO+k6vIHuXwJzLbSxdpRsKyPnGTJHmyPqcAwDo5SfHx2gqM5gzNLmD42tY
 gCh607ITCmTatSPKQqp4hDYIAh9e0xNJ8yp4ZgQWQaX6wmk4KseFT33Ml8UfV1TbZBsqUKV5KN
 GwPhaRPLNEyQkDanxd5ow47ksSvulK3qIl6YunVQtYt4y5ZlKhWVRjRzVNBFwDXKTF6ZIr0Z/O
 2RuPJ5STTqrkswm+/lv4ZpjQ
Received: from kalyant-linux.qualcomm.com ([10.204.66.210])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Nov 2019 17:29:32 +0530
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 1241C432B; Mon, 25 Nov 2019 17:29:32 +0530 (IST)
From:   Kalyan Thota <kalyan_t@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org, dhar@codeaurora.org,
        jsanka@codeaurora.org, chandanu@codeaurora.org,
        travitej@codeaurora.org, nganji@codeaurora.org
Subject: [PATCH 0/4] Add support for SC7180 display 
Date:   Mon, 25 Nov 2019 17:29:25 +0530
Message-Id: <1574683169-19342-1-git-send-email-kalyan_t@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7180 follows a newer architecture where in some flush controls have been re-organized to simplify programming and provide for future expandability.
Specifically:
1) The TIMING_<j> bits that control flush of INTF_<j> have been replaced with a common INTF flush bit which flushes the programming in the MDP_CTL_<id>_INTF_ACTIVE register
2) Individual flush bits for MERGE_3D, DSC and CDWN have been added which flush the programming in the MDP_CTL_<id>_MERGE_3D_ACTIVE, ... etc respectively
3) PERIPH flush bit has been added to flush DSP packets for DisplayPort

The complete datapath is described using the MDP_CTL_<id>_TOP and newly added ACTIVE registers to handle other sub blocks
such as interface (INTF) resources, PingPong buffer / Layer Mixer, Display Stream Compression (DSC) resources, writeback (WB) and 3D Merge
selections that are part of the datapath.

Kalyan Thota (4):
  dt-bindings: msm:disp: add sc7180 DPU variant
  msm:disp:dpu1: add support for display for SC7180 target
  msm:disp:dpu1: setup display datapath for SC7180 target
  msm:disp:dpu1: add mixer selection for display topology

 .../devicetree/bindings/display/msm/dpu.txt        |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  21 ++-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  21 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 191 +++++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  84 ++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  24 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  28 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/msm_drv.c                      |   4 +-
 12 files changed, 370 insertions(+), 23 deletions(-)

-- 
1.9.1

