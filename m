Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AAEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DED208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4t+HM1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfG3PYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:24:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37880 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfG3PYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:24:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so46884939qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WRQrRymvzeuce3KKDbksGCaiWLluhsSldgXmnzTmp8s=;
        b=y4t+HM1gzG3E/sK8yoWFX8FDHUW4HdMLmLbt/cIJqBMgLDJ71onmHxZPXuKyUkHaxg
         iriURYdjLTQwVa5uDNBPkJ2ZPyjb3ZWnQIqtpvcQgO4wRj0B/bmhvAWBObA32nhn1xFY
         j5DnUpbNffMqYSsmKeyXaTdP0OBjCRh/xqwWe44VkcUy8YQExEbcxLYLW3MktSFoewjc
         c+Pul3W9Hw/RRpOIMKf6Q+A05UVHAf2tc3EuxAyHrRI5WaToby0adDO665ppycGWkpcu
         KCSdoRgWUd0qCiLlc5Dbcpgddpli/glSpFxlzM+SsjNviSfmJkqlpTEfpi4hgLBk+U6U
         EeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WRQrRymvzeuce3KKDbksGCaiWLluhsSldgXmnzTmp8s=;
        b=Ydkr+Y/2o6c6KsAay/DJ4B9opiHR7lIzT4Bgk2xyOR5/14TIP7CZFFEFbVUd6X963o
         rLt1jgi9owzl/UC1r0bAC66FtFmJ/OC6+1k0Z+oSxPRf0NPVjyJSB/U8Z0D+WTnUqVPg
         UoZDPQk4wt8enwmXoBGENNLQEpK1nwZE/VoLCVtSns9OrPcmLK9ucuHwYFDDZjtp/ymg
         fjS+F6WmbL/tQL0VM3nrlAf+YWY8FD+muwrIz9IUDpMH2EmwXYIFeVP7rEtgtenmT1Rj
         DQIA0jFFnvKLkJJ4sK2PGCGHvk5BFBL1T6kbFUm1r5hCJt2Jn0nQHWNFP/CVgTpp6shq
         HJKQ==
X-Gm-Message-State: APjAAAW9rfe+MKfM3oz2fb/fyDYJiPVulUWrPaV4kJA266mEb8zhIniq
        6vXL2vm5L5pNTL4Eh6xllAjZZw==
X-Google-Smtp-Source: APXvYqyg4l1a/B04E8+LgeFlAnxW+Kg5rRx3jm0+QKFBC6Q4BagEPljVLBschqWhEsjHslipIZbtNg==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr81637690qkd.5.1564500285402;
        Tue, 30 Jul 2019 08:24:45 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id r14sm27251082qkm.100.2019.07.30.08.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 08:24:44 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        vinod.koul@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 0/2] Add support for AOSS resources that are used to warm up the SoC
Date:   Tue, 30 Jul 2019 11:24:41 -0400
Message-Id: <1564500283-16038-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Always On Sub System (AOSS) hosts certain resources
that are used to warm up the soc if the temperature falls
below certain threshold. These resources are
added can be considered as thermal warming devices
(opposite of thermal cooling devices).

These resources are controlled via AOSS QMP protocol
In kernel, these devices can be treated the same way as any other
thermal cooling device and hence are registered with the thermal
cooling framework.

To use these resources as warming devices require further tweaks in
the thermal framework which are out of scope of this patch series.

Thara Gopinath (2):
  soc: qcom: Extend AOSS QMP driver to support resources that are used
    to wake up the SoC.
  arm64: dts: qcom: Extend AOSS QMP node

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   8 +++
 drivers/soc/qcom/qcom_aoss.c         | 131 +++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

-- 
2.1.4

