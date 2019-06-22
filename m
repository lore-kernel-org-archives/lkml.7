Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1518CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA70620821
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSE0SwOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFVBVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:21:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfFVBVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 21:21:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so3778442plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gfKY55VDFmH9sfDf7QmSwnOcZWdz3/zPBcS1vbxTeIs=;
        b=vSE0SwOpKpJr4NR9EMm+8dVlG2peppROnIGEZle3TSjbPYS/NAc3/8BaXLuoGTies0
         nW1NbiYojr581BtnqZNlK3MJSythEOHVVihKngZUfmHVIMpsqUYWdw3IhT2sqHsV6sWi
         W4BIIOjK7yTDtJqj6eTDHISx+Nyl3A1NgqTXsv85rTbrlaBbEHGdSSYIfsVcXMHZp0nT
         oE2xzNxcPuzvVpIaOSx0u5orCPE/PvCFXZ/gGLN0HcqPW6q5yJj1NzwzTuey2x/FjTbU
         yNezDim0JlOy9KIv8aPaJR7SZmsGwSxPhVCbPTqtLYWdjKc2aGPEvVL4xVk2z+rXD2LP
         lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gfKY55VDFmH9sfDf7QmSwnOcZWdz3/zPBcS1vbxTeIs=;
        b=CrfRcXQOVQV+/pVIbbdqaK6MpiYCKL7thaF21W+spFCGp21rkBPJYhBTsP7rUSXnQf
         qc3TZiKELbxlOPnAyNkNvpXmeYgY1G8Um05XwIsTTeJWsCftiZBwpiMWT/ejFTwESJCc
         fuPwfJ4tQEpwX/dzMewJcoMIjfRZ/wIyJ7VAefl1Q/6nOY1XikL2VsBOKrI/q02MGp+/
         Ln4R2YgS1SstjK45mkCWwHVZbmDaoD4BXvq/Ggq1mnOpVYlS4SyDfSSa1YVrBA9rihbO
         BRM8sOrhnZ6hzjWo+pbst3yC4xTY3c1LKfFENkt5Xack1HFQbmlDa0csqeYrsPz+eEIH
         9mIw==
X-Gm-Message-State: APjAAAXWItctcBqZSm4YnPOikBBSOvlczVCJqBhOVQ7n7ySmhzziMf75
        KPO7j25Qsjhq3jO3+JM8fziHcA==
X-Google-Smtp-Source: APXvYqxsniCk8koIB+ws7n/g/Mm25oCraW+Hf6E/gRtPZkKce1g20AUH+H4Ip7W2ECP6AiHn+PnBgg==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr52642916plo.88.1561166510236;
        Fri, 21 Jun 2019 18:21:50 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u5sm3539148pgp.19.2019.06.21.18.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 18:21:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] soc: qcom: mdt_loader: Support loading non-split firmware
Date:   Fri, 21 Jun 2019 18:21:44 -0700
Message-Id: <20190622012146.19719-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically the firmware files for the various remoteprocs is split in a number
of files. But in some releases these files are available in their unsplit form.

Extend the mdt loader to detect the unsplit firmware and load it transparently.

Also expose the function that compose the metadata header for validation and
use this from the modem remoteproc driver, so that it can support unsplit files
as well.

Bjorn Andersson (2):
  soc: qcom: mdt_loader: Support loading non-split images
  remoteproc: qcom: q6v5-mss: Support loading non-split images

 drivers/remoteproc/qcom_q6v5_mss.c  | 33 ++++++++---
 drivers/soc/qcom/mdt_loader.c       | 88 ++++++++++++++++++++++++++++-
 include/linux/soc/qcom/mdt_loader.h |  2 +
 3 files changed, 112 insertions(+), 11 deletions(-)

-- 
2.18.0

