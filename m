Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1EDC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B282080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jknekqfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfJaSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:46:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfJaSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:46:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so4615070pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZB/HP5rByh41Vpe5hUbFd2NNqVPk5ZV2uMfwHrp4YQ=;
        b=jknekqfCQdDs4huuyK7WRBTw4sn2JFkqcgwzKW+KIDZErDMn8IXEkAU69lC91ZePTN
         s8Yvp8L0VCT1N/bjIf+g69sZQL4yX5cvMEygUApCEN8dr1MewmmwQkyLW13mY6kfnZHV
         PeRPIoQaMyTQ78DHwiaXOxekIf7lGq+Xz6N6uj7bNURYnrN5BAb3obdQoqq1wZHKJnAx
         6L2mApTK85k7QKJMDGwgVaUPZFLqFKwgKxXwqbTDz8DsMI4sVe3F9KM+7DihbS/LJYJi
         tRke62p1QAF4LGFAVh4+u3fyyX8SaPK4n+oOcgmI/Te0weEvBtBQlSLoomEiD9Cd/2g8
         ptsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZB/HP5rByh41Vpe5hUbFd2NNqVPk5ZV2uMfwHrp4YQ=;
        b=s6MCSjnGcn4Mrn/aihhEYs9sgGPo4+4IfohUeOSQ/iyMOA50fXej5iP2mJvdOygz4F
         BF5wr4fwQfRNENvfMY9WvoZMdeHOCUurJ8MRbmm2WkBWFBOeAj0ZjefXwKumQYJojrf8
         hY080CeD9Dmwn/TaVyHH2vG1UrHGTRT3hyGLnWu5N6IPfZI5E+kT+iUQdTghRMhgVCOm
         2gMpaO7dFw4pw+MNZVLvpPslFFyrODoxmR256R9MEdUXWvOI3VL3/I9sGmKGIFruJZwQ
         SzDjmEqHVOQw3htkekNFkevv518/J5ygo9go9QlDkSmrco0t3e21N7x+8UTHd5QHJv1e
         Lguw==
X-Gm-Message-State: APjAAAVWRQe0HkonckfbnTAWuB77jWMfqJ7l4SHa+qVOfrlp/XPutCrg
        NW9r5eFjyBp6ribE90+967TRcNXxQuA=
X-Google-Smtp-Source: APXvYqyyo2asPSNJFpPqVF/uSfEkTI/6KyfThLC1g8UCU9Q61QKHz5HCqXIPplnQXSNmAfaHfYeuFg==
X-Received: by 2002:a17:90a:2e18:: with SMTP id q24mr9375378pjd.61.1572547595658;
        Thu, 31 Oct 2019 11:46:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b82sm3950874pfb.33.2019.10.31.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:46:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/2] remoteproc: mss: Improve memory assignment
Date:   Thu, 31 Oct 2019 11:46:30 -0700
Message-Id: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two things came up in the effort of figuring out why the modem crashed the
entire system when being restarted; the first one solves the actual problem, in
that it's not possible to reclaim the main modem firmware region unless the
modem subsystem is running - causing the crash.

The second patch aligns the firmware loading process to that of the downstream
driver, which seems to be a requirement in 8974 as well.

Bjorn Andersson (2):
  remoteproc: qcom_q6v5_mss: Don't reassign mpss region on shutdown
  remoteproc: qcom_q6v5_mss: Validate each segment during loading

 drivers/remoteproc/qcom_q6v5_mss.c | 85 +++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 32 deletions(-)

-- 
2.23.0

