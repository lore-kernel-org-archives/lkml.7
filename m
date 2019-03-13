Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57871C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCF72147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGpnAGmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfCMJAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:00:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34242 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCMJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:00:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so869144lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDWo2E/IxyzUQjpn5J9mS8eOFQRMRegBPNLZgP9rh94=;
        b=vGpnAGmHg1gzSr7JgjNs/r2n8diM7N9D4IsBkP2WfK4MqemtpQRKY3oT2aNhqIrpTJ
         ep1V8dhjGdccoBo33QuN7mkN/r0yf8bthUzEc8eljxlqYxSzNCMfookuOyq35sxN2kDq
         A1YVx/ZFHentnRc7We3uc1BVbxewHNiMm+rQYhh78Gj5IKkj/vlVarcOtDQQgwmUSie/
         +H0QFWPXAgFHPROY9bYJ8Bxf2HQHQaSupYP9fZzbD3AyICZyf6MesdSrPAv+1676xtrr
         hynyA5RzhfkHIJrymp+/m9qtYzvw29MnpdGjEDkjaWfjp9ZgpK0Gaw1NanUKG25CFhmh
         4GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDWo2E/IxyzUQjpn5J9mS8eOFQRMRegBPNLZgP9rh94=;
        b=Xb5DBhr5ijRfEtl4NwpeOlD2OulYcdjmM5+F6VBJF3NHq4X6T+XozvIk1ds6xq3RQ6
         s9I0Q1RdFNMUUbYaOKfJk6ejopL8WVoq6J8VKUS7SqlN/YJMqugkjOvEtESpm1d2c2CT
         lbk3F5eU7nJmu6xOM0mMgJ+r9nr5m+ucOVzmPop/UOblJT0jnW454GZ3Vf1Qrh3E9OUm
         t24wGWGgBQQoj8pPcpZ8SSHGAvn6dZEbsxK5MtgtrIUaFGi7BKx1Ipc9L33IbUcosZXD
         lLx2TskiyDl4wBzFW3E0LZ6XtNIIsW2oDiDESkrmkXhCLNFH4QU/keZHyg9IPhETMgXk
         C6CQ==
X-Gm-Message-State: APjAAAV4oNWD5Ic9/lRy36vovu+AIjImzVk2pd8x6BvwUJFSch36lMqL
        xyd90lfLtEkZDA0nldWEpjluKQ==
X-Google-Smtp-Source: APXvYqzcb3uaU4Xf3AoIxYVZLsc1qgPR+Ba2dh+wfv+KbtnO2j/3c+s/cDAC0U3NrR/7YXvg2oRT6A==
X-Received: by 2002:a19:7914:: with SMTP id u20mr8050229lfc.41.1552467613357;
        Wed, 13 Mar 2019 02:00:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u15sm1701986lja.73.2019.03.13.02.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 02:00:12 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/4] Introduce OPP bandwidth bindings
Date:   Wed, 13 Mar 2019 11:00:06 +0200
Message-Id: <20190313090010.20534-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a previous discussion [1].

Every functional block on a SoC can contribute to the system power
efficiency by expressing its own bandwidth needs (to memory or other SoC
modules). This will allow the system to save power when high throughput
is not required (and also provide maximum throughput when needed).

There are at least three ways for a device to determine its bandwidth
needs:
	1. The device can dynamically calculate the needed bandwidth
based on some known variable. For example: UART (baud rate), I2C (fast
mode, high-speed mode, etc), USB (specification version, data transfer
type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
(video format, resolution, frame-rate)

	2. There is a hardware specific value. For example: hardware
specific constant value (e.g. for PRNG) or use-case specific value that
is hard-coded.

	3. Predefined SoC/board specific bandwidth values. For example:
CPU or GPU bandwidth is related to the current core frequency and both
bandwidth and frequency are scaled together.

This patchset is trying to address point 3 above by extending the OPP
bindings to support predefined SoC/board bandwidth values and adds
support in cpufreq-dt to scale the interconnect between the CPU and the
DDR together with frequency and voltage.

[1] https://patchwork.kernel.org/patch/10577315/

Georgi Djakov (4):
  dt-bindings: opp: Introduce opp-bw-MBs bindings
  OPP: Add support for parsing the interconnect bandwidth
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling

 Documentation/devicetree/bindings/opp/opp.txt | 45 ++++++++++++
 drivers/cpufreq/cpufreq-dt.c                  | 27 ++++++-
 drivers/opp/core.c                            | 71 +++++++++++++++++++
 drivers/opp/of.c                              | 44 ++++++++++++
 drivers/opp/opp.h                             |  6 ++
 include/linux/pm_opp.h                        | 14 ++++
 6 files changed, 206 insertions(+), 1 deletion(-)

