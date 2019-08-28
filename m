Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B11214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXzfzF8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfH1TSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:18:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1TSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:18:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so427125pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vHp+AlJWbxwSEhvcybAlK/zvFEbIb+ho63MMWY45s5U=;
        b=OXzfzF8SHK5OVa1FXapO5oDS5zvMZGPSS9RJWui7hSNBkf4ory1gv0WNv6XKxIJ7rP
         0x1eIiwgvL0/ZU9x0ljGPdVoCDiejKmy92yBw/kXT3Gx6hrJK9vGNWCIeWeFs9t6potT
         r1pIx37KVjyTFCkjkSf32IMnD8jHtn28GUXVjqi/Gl1uS7IvguN7uqQS0unKPritvTba
         XTfw91vQOs2MoxPwx9i0LC6p/8rDJFj8YFABW8SLcTbtjAjOexvJdrUHD+oXBc7WiVbt
         SP+Yny2sx/cBesb+y1XpGnT7bOe8NjLz1PT7XVFfeNLryROzcooQ5b4b7wC/JsgoGm5j
         iryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vHp+AlJWbxwSEhvcybAlK/zvFEbIb+ho63MMWY45s5U=;
        b=R5DkZNTknG3kWI0XRvPqWabSYAKtT5RabIjwJ79gI5YZERz8uCE8nDdEXUpTSjtYdr
         bqFMJhnG53bTzqr8FKpiQ4R0NXsnUq4QtzCmS/zPULKH5T7a2JmeL5rX1vQlVoZfv2Tl
         v+6jIHllsKQ9NEefsnqpQPEqNyGJBZu7lIx+3uMCmZf7oxB9C5HhaPZ0fXTvAG430yo1
         ovn5PP15cMzJYSHYwJ6L9kSSvGLfX/r4QbPWRfi0dhVK7LeDT5koH2c2HqsI4tRXuPCC
         PIUXK44jCJw6Q6WYdRfFkYUQVyMCCsOe5zk+TbsZ1Y/iSpeIl2jDexGVir3Jr9OsxAXL
         Cglg==
X-Gm-Message-State: APjAAAV821Rtg8WS9E5truHOFSYUs7JGzJiiWtFptXjCl5ZAf0+14nD/
        PfwGuJGShoQpmMnUn35eGVu8/g==
X-Google-Smtp-Source: APXvYqx067TVuFdfipJijenpJw8x/0zHsb2O7KTSR5Ivwe9Nw0BicO9ZvzvDmQ1alVdoCVidC06fWw==
X-Received: by 2002:a63:4e60:: with SMTP id o32mr4933655pgl.68.1567019880871;
        Wed, 28 Aug 2019 12:18:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n128sm122717pfn.46.2019.08.28.12.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 12:18:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bean Huo <beanhuo@micron.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/3] Qualcomm UFS device reset support
Date:   Wed, 28 Aug 2019 12:17:53 -0700
Message-Id: <20190828191756.24312-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new ufs vops to allow platform specific methods for
resetting an attached UFS device, then implements this for the Qualcomm driver.
This reset seems to be necessary for the majority of Dragonboard845c devices.

Bean requested in v3 that a software fallback mechanism, using
UIC_CMD_DME_END_PT_RST. I have not been successful in validating that this
works for me, so I'm postponing this effort and hoping we can add it
incrementally at a later time.

Bjorn Andersson (3):
  scsi: ufs: Introduce vops for resetting device
  scsi: ufs-qcom: Implement device_reset vops
  arm64: dts: qcom: sdm845: Specify UFS device-reset GPIO

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 ++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  2 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 ++
 drivers/scsi/ufs/ufs-qcom.c                   | 36 +++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h                   |  4 +++
 drivers/scsi/ufs/ufshcd.c                     |  6 ++++
 drivers/scsi/ufs/ufshcd.h                     |  8 +++++
 7 files changed, 60 insertions(+)

-- 
2.18.0

