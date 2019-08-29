Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DAA23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPNyl9bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfH2I2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:28:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37845 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2I2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:28:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so2483109wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzOzQ7ynNYPsf5UEf3oNVdWEvvfgnb0uEvn4yxU+dLs=;
        b=QPNyl9bMqWt4Ql4fbNSFnjlCr6qZyRx72Wt1Cmuc/ixB6/sURqA0apu4dMeF95ssMH
         z7Z52E5m0ZoGHzwad4fl9hFfZLe1KPqYa29im2xvPtD+RqsvLfRlGWc9tN5Taw5Lzzog
         NOrUwBGhR4z3bRwYlKnvJzpRqR6DIXZpsVSl/3/JRBLEvZ0QoVtvmuObXYFCJ9jHB5pL
         EfRzj+6ciBU9+Yc82c2SLft70V/uKGHcyx4GGFhUajRtlBaQ30eHJu/a2PcaIxihMV6y
         c8cRLCU5eqJsKFNP05qxPNNvGnECK11TMuAbR2flOLod0XdSjD4L/fzhioCxei6Nd2Pq
         SnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzOzQ7ynNYPsf5UEf3oNVdWEvvfgnb0uEvn4yxU+dLs=;
        b=uGrdahAmbLlWrnJSqmSd11v/7lGlIQ11hImONEjqTpYZg/4tWaM8sMVWYCAVJc8tCx
         UbFQ06ITV3VZVaGVu197wJoXHXHVGJMHCa09Ui9urKbATzzzoowypXOs+6IlSHBB7B6v
         mapXe2B90g6yKOP2jfRaH68sBZjvoA9G+Ndtgf8jxXPQKX847h8HWo+61N/QmayrT3Gt
         94Fg3c9V1OXmsXOc8qtSwnsaZEo7wiNwZY8Obh08BpI9VRoDGJR2OMFn+1Dps6GyESA6
         MOlAhUuJmwCZWsGmfXqsNp4G0K+x0Xd76FN8X1PUErAv8f4bEWoAx+mb86941rSVht6P
         INFw==
X-Gm-Message-State: APjAAAUrKbvtlElzQgKEcD81G4Ib4kTb4rJCxPS6TtJc5bxIbBR1vuHD
        dACF3/h82eM/1stgv6COVKy5+5dMW5k=
X-Google-Smtp-Source: APXvYqzo/MzO7CuJCSuJyZul1Nz9EvB3vy9Skp24N4C+UVIfER7+lsH6iDc5xX2Ky69Od3DEsRhOBw==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr10054615wrx.241.1567067282414;
        Thu, 29 Aug 2019 01:28:02 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id f24sm1884489wmc.25.2019.08.29.01.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 01:28:01 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, jassisinghbrar@gmail.com
Cc:     niklas.cassel@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mbox changes for QCS404 DVFS
Date:   Thu, 29 Aug 2019 10:27:57 +0200
Message-Id: <20190829082759.6256-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the mailbox changes required to enable CPU frequency scaling on
Qualcomm's QCS404.

v2: sboyd review
    replace if statement with a of_match_device
    dont modify platform_set_drvdata

Jorge Ramirez-Ortiz (2):
  mbox: qcom: add APCS child device for QCS404
  mbox: qcom: replace integer with valid macro

 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.22.0

