Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD82C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0024A93
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtBWZujo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFDHUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:20:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34988 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFDHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:20:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so12147913pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cW54g37zzSz4GWvh5hRmHVol1ElNCqsUtdX3i5TDki8=;
        b=RtBWZujoWwW3pFIZuHpnWrxTc8YvUZAJEdbpx9IY/AVKKprlylZPo4sQDdv+iGW4f3
         BD2uhbla9+ITaG+pHmSjpvZ6jmb9i7Shw7kH3FG1mQIuzf6Lc60QAFndAoaY80zc7gQJ
         b6BcwbyIqhZa1t93ZOHF4wBec3eumarIxn2Y44vVRphfZg4giYiVNtIVx84AMWaSVzuX
         PFJT4EEWaOVsk+nBA8U2nC7/MZsLgO3a/rr5LOrZjkeCAcCqHViQKrKWGsR2i4iWgU37
         21RwAgEHaunjZ0eB5GI7IrxjfCr8qk8hEo4yHZAjJoUbLTjoKrKTC2mGKsZ5u1aX6TLe
         UlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cW54g37zzSz4GWvh5hRmHVol1ElNCqsUtdX3i5TDki8=;
        b=Mc+SOTWl/hWBUrPURgBneXgT4aXCCiIqM6VfYq2RKGZFaBKoKs3WduqdHK5GakqQVb
         DvPS7ZvQauJX08+ov34+9QVIEBWYBWD44kDy/6/G5EwjJjtVy+XnEI1fnb+6tXSpiEAv
         hle5pkJx+E7BUKW1QrTs6aBV7cb7u1lwRyd68tgzBygua0sU1tnGvI8wQ4rOZ9EUqoj0
         gU5NRU6ExKSYzrmOnF/dc9G5YI2nD6HkoGRXuLxeW3NcwwFWIEt9yWhShnwRTZF8Dxg/
         9hHOeWdOFBRpLrRPPhhvQ3KbROB5hfqzOZxEUlkqQdug0ptuL4Bcq+lQfb2WAlpbLHRO
         R0Fg==
X-Gm-Message-State: APjAAAXYfeOmq+Ystj84h6vN/72iOp555oqHYfCqx5a2euhGes8OO0/L
        WpbwhSNgU6gcLIg24IqMv0YM1Q==
X-Google-Smtp-Source: APXvYqx5aLQZoHyol1PmiF+AvixuAC4swlY3kkqgRqnYCzZ0I1A/uWV/nxPZxmDkkkzGfx3kB+M9PQ==
X-Received: by 2002:a17:90b:8d3:: with SMTP id ds19mr34718088pjb.135.1559632804480;
        Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm17747446pgv.4.2019.06.04.00.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/3] (Qualcomm) UFS device reset support
Date:   Tue,  4 Jun 2019 00:19:58 -0700
Message-Id: <20190604072001.9288-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series exposes the ufs_reset line as a gpio, adds support for ufshcd to
acquire and toggle this and then adds this to SDM845 MTP.

Bjorn Andersson (3):
  pinctrl: qcom: sdm845: Expose ufs_reset as gpio
  scsi: ufs: Allow resetting the UFS device
  arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         | 12 ++---
 drivers/scsi/ufs/ufshcd.c                     | 44 +++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                     |  4 ++
 5 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.18.0

