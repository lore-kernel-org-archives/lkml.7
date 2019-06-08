Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C044BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87030208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2HdysXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfFHFEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:04:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfFHFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:04:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so2193926pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MI5UP8+6YzX1wT43lJpua6JKjZgkLt+dbe6TcXG9cy8=;
        b=Z2HdysXy7QD5MtVYuQPu7sZPtUTxdmzw3yNdieEQ6kdhO6eifQihTq5GULJg7Y8de4
         aUQCU2nclqpJsZzBm7Y1MWR8uzCyK8PDAwKAgMWAFMs/n6q99tqerXjRgrB844Rziliw
         o+i/m88RKRI5RZVJjuni8ysJclc4uYOq0kj++HvzY5ZLuZZPj+d7vT2nXdQbFifX0ewn
         zkNMcnGiJeVDKXaglu90C9ZRixUeowTKmwUl0JJd8LM4twLryHXcWHMMgXY6wcUZkdDz
         My9j6lsxDaQfpaL/vsPij1ymzOqJrSAGwpIbT3v8vr8wezhuUPM/zD8BneLzK3hJXfvF
         zfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MI5UP8+6YzX1wT43lJpua6JKjZgkLt+dbe6TcXG9cy8=;
        b=apsiGUEuoEE10EOPaVPOTs8hczFlE2/mqgzy3OcRL9rfX6kUXZJCZ+D2FZYDTg1XTk
         J3R0FOWtZLo4ecbqgtfgEQaU6R8P65rDMbNF/MI23HIxAhFsBQX7I9ZaKA1MSGDecP6z
         a6onLGYgVT0z2QVlT3tC8OHeR+jAguH2JB1tqqVfMLSMMyP+/pfGQ6OclJYtHgckYJJW
         UscRZE0AVnkGceewuE9RPejKZMkTKav9ctgUgGmu5OTxrA9e9NSLJ6/rhTb95uktdKMd
         kFnleA4EIh2muqOe7JJbm8Z6sUbotf85G2WodAV5HztgKXqTn2WTaU5fvelhTXWdSzF2
         3vrg==
X-Gm-Message-State: APjAAAX9tzWIo78Q3eCn/ce72VFzG6K/rVbx5qor0xu6IRQG8DPfWuvj
        6u4VCCWfXMS2apghmZ30REtuXQ==
X-Google-Smtp-Source: APXvYqzgWooneYqQXysZKH4LudPeWAk7m7Gra9BixdXpmIfM9kEjOY99VzJO08laxBbJSRvlGoVELQ==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr47155236pfb.0.1559970293715;
        Fri, 07 Jun 2019 22:04:53 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b8sm4522482pff.20.2019.06.07.22.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 22:04:53 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 0/3] Qualcomm UFS device reset support
Date:   Fri,  7 Jun 2019 22:04:47 -0700
Message-Id: <20190608050450.12056-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new ufs vops to allow platform specific methods for
resetting an attached UFS device, then implements this for the Qualcomm driver.

Bjorn Andersson (3):
  scsi: ufs: Introduce vops for resetting device
  scsi: ufs-qcom: Implement device_reset vops
  arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 ++
 drivers/scsi/ufs/ufs-qcom.c                   | 32 +++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h                   |  4 +++
 drivers/scsi/ufs/ufshcd.c                     |  6 ++++
 drivers/scsi/ufs/ufshcd.h                     |  8 +++++
 6 files changed, 54 insertions(+)

-- 
2.18.0

