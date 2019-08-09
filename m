Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB18C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E49208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUgvvikf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406729AbfHIMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:13:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406714AbfHIMNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:13:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so58286171lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 05:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khC2xFZGDuzHm7LauVefQf76DxyJ5wKd6wD3GFIWUBg=;
        b=YUgvvikfXP7Algmo5FVFozvaeWU2EgvjF+cD5mnYuI9U/j45lqwxwPig/8wh+wBIYJ
         vuM2ziYQxZ3XRGtGKH8leZv/0X/H5XGfN1teN4G6dK5r5mNF99DaoQBvutQOFSVgwerk
         9hK95niDmQhtp26IAkvdHZCV9wiiW3TXt449kOLrWnGCjOlO//g5MXgC16LV+89FUL9f
         3zsyayZsATMVEY1Wc5XXhy87ejlE2aYZ++BhvhVtk2AaWLM9L0u0zz8JAEu8ZmpFvpWu
         69JrTgiRNMAMoGfpFEMoxM7A/bOsdIg1DJByonCqXf1r4c4b7onV3S+OXPKN6QADsvbR
         0rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khC2xFZGDuzHm7LauVefQf76DxyJ5wKd6wD3GFIWUBg=;
        b=jXJ5q5kB4fGCsBvjYEZmZd7aHyScruQF3lY7wYln4W5myS0kJvCWrBRN6WS3O5xlRL
         6od9yqhCFghixnfBQ5o/ILe10yFf4dWXqkeKJVM6VgDmQt9+6XuTPq/7Of/qip9Vki/Q
         D0hx9RpUxauDB7riIZTK1ItGFGOl/S7Y5qTKGlz4fwKTRnWD3mIz2KlDYxtWsLAjKd9A
         W/eoQgjlI8EM4hL/b6+lmVDKb0qvKg/oc4OSObqat76i53ZjLCoUvFc+Yrh8gNeNx9F8
         FvnAUiqJCluAEsKCuBK97veLtc1PFM0wVM+W2Vwu1vnN9nJNNqaVcQAmcsxBvhVYPMzD
         Sj3w==
X-Gm-Message-State: APjAAAXRsQjFg2YVTvNSRS7ul1kbIphU6xFI4DGFNMayL2FeNYg/G25f
        6rplf9EX6bbSNY4XYBiNZcqs8Q==
X-Google-Smtp-Source: APXvYqwRqWQziVL8uoa4G3k4jkXSZfMfrqNN15MtnOv5kCBBjJo+CYN2nXEZmgvdeMjACcuywFWqNA==
X-Received: by 2002:a2e:8455:: with SMTP id u21mr10848999ljh.20.1565352808013;
        Fri, 09 Aug 2019 05:13:28 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id f23sm1083425lfc.25.2019.08.09.05.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 05:13:27 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v3 0/3] interconnect: Add path tagging support
Date:   Fri,  9 Aug 2019 15:13:22 +0300
Message-Id: <20190809121325.8138-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

v3:
- New patch to add a pre_aggregate() callback.

v2: https://lore.kernel.org/lkml/20190618091724.28232-1-georgi.djakov@linaro.org/
- Store tag with the request. (Evan)
- Reorganize the code to save bandwidth values into buckets and use the
  tag as a bitfield. (Evan)
- Clear the aggregated values after icc_set().

v1: https://lore.kernel.org/lkml/20190208172152.1807-1-georgi.djakov@linaro.org/


David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (2):
  interconnect: Add support for path tags
  interconnect: Add pre_aggregate() callback

 drivers/interconnect/core.c           |  27 ++++-
 drivers/interconnect/qcom/sdm845.c    | 136 ++++++++++++++++++++------
 include/linux/interconnect-provider.h |   7 +-
 include/linux/interconnect.h          |   5 +
 4 files changed, 140 insertions(+), 35 deletions(-)

