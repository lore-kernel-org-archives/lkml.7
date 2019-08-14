Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A9C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1308D2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftcdFcJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHNIrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:47:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfHNIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:47:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so3708672wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/+yqj5iDEOb/fVOsCO1ED+9HZ4hDgi6+BjHGS7ALHlI=;
        b=ftcdFcJFnojSaAVRgoj8t0YFQ6bc0oLXrca+8lALcViUCbDsN/2MYAYcbvxuXPu5S2
         p+BJAQA2e9xcNQyBqNVI7F1Dcyz8RAhsCOsHe9li2ZnvFIOuEMJbJd6vdHypimzhIVvJ
         Trsk57hS17GmTp3qGFr99J0f7eDPdT6pBHMQf0oqQbkIXqeGelhKPSKR59+VKVXME320
         JD+NHJqykfCMxhqd38zSgjdzixC9SKTObAe3RbFe1INPr+RG5zvLmiwv0QSubOLxOnLW
         7QCxg7n27BhLIVSeAxBaSMMx8/ay8AZCIIfV0DQmxR90k2c8D/hh65ULIMinG0JuHoWs
         FBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/+yqj5iDEOb/fVOsCO1ED+9HZ4hDgi6+BjHGS7ALHlI=;
        b=OzqQ2t73q4EM5QKgNlXqXylX7WU2yfTiYhw3pW7ciM3PO7xfgCepFfKqIffYbF+MAS
         yNjzvJl1OFNyfkpUKN+bKhM7gmna4V5TVEzifxoOMH4oISzHruiuBPORCy8qOru9ijaw
         ktRlCq4fIVYQyxqad2IyNotRhWwmzyNCRFHjxewX2Qqqy2UmpQzFojJ2PUZSNMSZJQNE
         9D2T527Y5S7gMIeSoRtGMuGpytlC1ek0exiWI6v4bZ9vnhnXkMNoJuRm9nkR4xzwfJRM
         CP8mGCc+biP/RGyZ5RGj6f8oRl4RQDw259lmlX1L6PXI6YJa21uKeXMzwmfNGPoc/eoM
         Ztig==
X-Gm-Message-State: APjAAAUmjr5jet5dFAVQWmU93SmLd7RHuegbwPMHsvu569feyvWrB0zv
        UO5kzPnHOXYZgghkHU13672NkQ==
X-Google-Smtp-Source: APXvYqwy8UjmeGxcUiBkY/7MBPqm+9sdDqx0iBl9OOhWJbW+/fCY6VXHIqHD3sg2P9E9oI1FJssNAA==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr7428220wmj.165.1565772442346;
        Wed, 14 Aug 2019 01:47:22 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id u186sm7176141wmu.26.2019.08.14.01.47.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 01:47:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Aniket Masule <amasule@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/2] Venus interconnect support for sdm845
Date:   Wed, 14 Aug 2019 11:46:59 +0300
Message-Id: <20190814084701.25455-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are two patches which adds interconnect bandwidth requests
depending on the resolution (macroblocks) in order to lower
bandwidth pressure on the interconnect and memory.

regards,
Stan

Stanimir Varbanov (2):
  venus: use on-chip interconnect API
  arm64: dts: sdm845: Add interconnect properties for Venus

 arch/arm64/boot/dts/qcom/sdm845.dtsi        |  3 +
 drivers/media/platform/qcom/venus/core.c    | 34 +++++++++++
 drivers/media/platform/qcom/venus/core.h    | 14 +++++
 drivers/media/platform/qcom/venus/helpers.c | 67 ++++++++++++++++++++-
 4 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.17.1

