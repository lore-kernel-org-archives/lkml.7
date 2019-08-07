Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DB7C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E721BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYMVfjHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHGFjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:39:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42167 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHGFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so38986238plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lX8IG8R2jbuFCwsdoK0pzaeJEZdXalK6j85VMKRjgxQ=;
        b=DYMVfjHzfJ1cOe7Y/fcx9vdQcjtJc27q/Ci2eXoM+zBh9/ckVpNefswtCR2HXum19W
         we07s/fxc4GekXam4scFbX7zDa6Eq0pr3ZmE13K8dwBTbJD82iIKeAZWoewh/itwnwhH
         JYgtywKiKqZsDVjpcTLEbET7gSV7aHQN1Afv1f+gw39lhnd7LvT1TkfKBAkuz69cqqzM
         4yhBIxHWhBZNnxSDH5SxO0g2DRJG/SuDBJcH3VJJDyaiht1N59ESbQNpRJN5rYd0Vzl/
         ThT5MYRw1nbBmsnusuxgYPuH1BimBxKiosTtg5LHlCIn5h90YAkQWuqaHLbvHbAY1LmF
         966g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lX8IG8R2jbuFCwsdoK0pzaeJEZdXalK6j85VMKRjgxQ=;
        b=RoBMMEdXOZKREl+KKiaF8QdQFZTj5CqWo9c2ZQ6TMa4bxFmtWoe7dhjig3v0FhryGZ
         oqm+pKNorf4nhYSWx/2CDtUjOpsHLx6BmUouXRGcxXNgFUovb4UKzFdYHM97R0TpbbRS
         h/uv6AYbCAKI3sPDVdkOw9oFCIvBoUHyW/gsDYfS4cdi+FM4M+TAroS41srrMImkYB8U
         0BOwjWIJ7RpBg7AlOK55SNJL5rDWdRcBjer3NEs3itja86JX8EcBdvJfOV/Gdxj01z8k
         lbcb15tN7ePRztvcDbHahMHrS9pyTWZv2gYVqYs+gQmuFxG+4U88PEuSVj5hivzdoiT9
         1oUQ==
X-Gm-Message-State: APjAAAV7BaQ49t8/laazMppCXyz60xu6ud9tlGvf029Vx8zx+eEtJGmA
        IBMFcXtheql7LZrjQzKaAAGxYw==
X-Google-Smtp-Source: APXvYqwldcGGBa3zhtoh7iC85dGC9Qe60kQsnnLZTi7wsiXGj3UJXTX+1tNyKDYw8gh85OLy7D/wDA==
X-Received: by 2002:a62:6044:: with SMTP id u65mr7428811pfb.15.1565156386238;
        Tue, 06 Aug 2019 22:39:46 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 0/9] remoteproc: qcom: post mortem debug support
Date:   Tue,  6 Aug 2019 22:39:33 -0700
Message-Id: <20190807053942.9836-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces two components that aids in post mortem
debugging of Qualcomm systems. The first part is used to store information
about loaded images in IMEM, for post mortem tools to know where the kernel
loaded the remoteproc firmware. The second part invokes a stop operation on the
remoteprocs during a kernel panic, in order to trigger them to flush caches
etc.

Bjorn Andersson (9):
  remoteproc: qcom: Introduce driver to store pil info in IMEM
  remoteproc: qcom: mss: Update IMEM PIL info on load
  remoteproc: qcom: pas: Update IMEM PIL info on load
  remoteproc: qcom: wcnss: Update IMEM PIL info on load
  arm64: dts: qcom: qcs404: Add IMEM and PIL info region
  arm64: dts: qcom: sdm845: Add IMEM and PIL info region
  remoteproc: Introduce "panic" callback in ops
  remoteproc: qcom: q6v5: Add common panic handler
  remoteproc: qcom: Introduce panic handler for PAS and ADSP

 arch/arm64/boot/dts/qcom/qcs404.dtsi |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi |  10 ++
 drivers/remoteproc/Kconfig           |   6 ++
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/qcom_pil_info.c   | 139 +++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h   |   6 ++
 drivers/remoteproc/qcom_q6v5.c       |  19 ++++
 drivers/remoteproc/qcom_q6v5.h       |   1 +
 drivers/remoteproc/qcom_q6v5_adsp.c  |   8 ++
 drivers/remoteproc/qcom_q6v5_mss.c   |   3 +
 drivers/remoteproc/qcom_q6v5_pas.c   |  23 ++++-
 drivers/remoteproc/qcom_wcnss.c      |  14 ++-
 drivers/remoteproc/remoteproc_core.c |  16 +++
 include/linux/remoteproc.h           |   3 +
 14 files changed, 253 insertions(+), 6 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

-- 
2.18.0

