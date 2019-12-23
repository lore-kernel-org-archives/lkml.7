Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F7C2D0D5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A4C2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdccdyXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWLdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:33:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39521 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfLWLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:33:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so17406224lja.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 03:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W86PjKWMp0DXo0oqU8GNbupPzD4JvnNKtjFCMr2/NeY=;
        b=NdccdyXLPkXmuyhQhYpFznqNVNxOoSsQFB6qZE+cGCN/yafZMxkrGX0vWu+TxIsXW/
         X5BGr3a08PLAYMNKPk/W2RNBFvKi062Fy0T4WRkjPVBQTpKEkYFbAv7ZMAYw+R/2YrT9
         UGJ46wZHvNC6WDA9XZS7gBWDVCB31c93auJxUMVpu0QsAJwj3Mhvxp+Bopcqu7p5Aajj
         v1YibMM54480J3Qh7wX7BLOSZMEigllisVovl2hKKF9ck7cUrijaKtfHSczq7eIdwtm5
         +duB5ivl1vG4Eshuy2LtdzkuhTKtCGtOujbkafb06ml+1+gIV9k1KhjG6oAnGCBp1su0
         ZUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W86PjKWMp0DXo0oqU8GNbupPzD4JvnNKtjFCMr2/NeY=;
        b=EB8Bo70Eiwj3DeIMOq4ptuvyv4XzEqr2mlkJhS/KjLhZrdiW66Wf0Q/yeEEYLanYlM
         6MCJXJzm7ZBV6IxMbNU+nSBU4U11Br3//VbgVmCSHk+d0LlDXwn0Pc10oWCdhb8DxjfH
         /s657P6chXR4f2S8zP/BjJ0MEev6wxj0VtugmrPO4FJFy7OblGnfJMUhIOjxy8L+AY0P
         Vfgdz8w7idtnX5yw1f5yfX/GkA662oPwRgfocc16o/jaGBMElQo8BUm2Vtzd1nPn5Sko
         ssaIBF0fZP5gRzrNMuJb+XDqpidg5zyl1iZ3X49AHB8ZFXKzk8PKxvx5Aavdz+pHAhl3
         TfPg==
X-Gm-Message-State: APjAAAVtC4ian6VkANlHTQLlZbUHcY3PpvlyvIISxvlKdwFS6B3KEAMY
        i41IHagTf0imD2zMWQ8svnJkJQ==
X-Google-Smtp-Source: APXvYqyvE4LFXz14TEeueaK3Hw30PRJx8l5ut0WQKynuK1BG5vv7bGEblHk4zcQqosmEsfb6sqn3Mw==
X-Received: by 2002:a2e:2d01:: with SMTP id t1mr12640896ljt.36.1577100808204;
        Mon, 23 Dec 2019 03:33:28 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id g15sm8381500ljk.8.2019.12.23.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 03:33:27 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 00/12] Venus new features
Date:   Mon, 23 Dec 2019 13:32:59 +0200
Message-Id: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chnages since v2:

  - addressed DT schema review comments in patches 6/12 to 9/12


v2 can be found at [1].

regards,
Stan

[1] https://lkml.org/lkml/2019/12/18/444

Aniket Masule (2):
  media: venus: introduce core selection
  media: venus: vdec: handle 10bit bitstreams

Stanimir Varbanov (10):
  venus: redesign clocks and pm domains control
  venus: venc: blacklist two encoder properties
  v4l: Add source event change for bit-depth
  dt-bindings: media: venus: Convert msm8916 to DT schema
  dt-bindings: media: venus: Convert msm8996 to DT schema
  dt-bindings: media: venus: Convert sdm845 to DT schema
  dt-bindings: media: venus: Add sdm845v2 DT schema
  venus: core: add sdm845-v2 DT compatible and resource struct
  arm64: dts: sdm845: follow venus-sdm845v2 DT binding
  dt-bindings: media: venus: delete old binding document

 .../bindings/media/qcom,msm8916-venus.yaml    | 117 +++
 .../bindings/media/qcom,msm8996-venus.yaml    | 153 +++
 .../bindings/media/qcom,sdm845-venus-v2.yaml  | 139 +++
 .../bindings/media/qcom,sdm845-venus.yaml     | 157 +++
 .../devicetree/bindings/media/qcom,venus.txt  | 120 ---
 .../media/uapi/v4l/vidioc-dqevent.rst         |   8 +-
 .../media/videodev2.h.rst.exceptions          |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  25 +-
 drivers/media/platform/qcom/venus/Makefile    |   2 +-
 drivers/media/platform/qcom/venus/core.c      | 122 ++-
 drivers/media/platform/qcom/venus/core.h      |  31 +-
 drivers/media/platform/qcom/venus/helpers.c   | 435 ++------
 drivers/media/platform/qcom/venus/helpers.h   |   4 -
 drivers/media/platform/qcom/venus/hfi_cmds.c  |   2 +
 .../media/platform/qcom/venus/hfi_helper.h    |   6 +
 .../media/platform/qcom/venus/hfi_parser.h    |   5 +
 .../media/platform/qcom/venus/pm_helpers.c    | 964 ++++++++++++++++++
 .../media/platform/qcom/venus/pm_helpers.h    |  65 ++
 drivers/media/platform/qcom/venus/vdec.c      |  88 +-
 drivers/media/platform/qcom/venus/venc.c      |  75 +-
 include/uapi/linux/videodev2.h                |   1 +
 21 files changed, 1873 insertions(+), 647 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
 create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/qcom,venus.txt
 create mode 100644 drivers/media/platform/qcom/venus/pm_helpers.c
 create mode 100644 drivers/media/platform/qcom/venus/pm_helpers.h

-- 
2.17.1

