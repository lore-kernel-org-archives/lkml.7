Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90562C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A1F20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RierUITp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCGACd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:02:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCGACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:02:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so9918971pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IihfxZYifKk0KW+eipCJOHHxBrOvGm4jAWFyDjgwqAc=;
        b=RierUITpDT0OYUASNfohoHe5YdyMJjGPQaigUeKARCXVefpg5POg+dEnCEwP7Xyeps
         R0xwlL26a0Hea+SDq2VTLXlEpDEVF5TysVeANae+wkAO4rK82qcVf8SENllAeyhhNteN
         EOdfAdNjkhtubMDCO64VO3rwhoEz7qDd4InzZqMncys3jOsy58oU4ehLtOpNNircLYn9
         /OBVi9jeQZ+60oivqPKe4BEfTsf+FhK6YvdQYamRZ9F+GZaS9J/R5+QBIWTz7XQJJDuF
         hEYHmb+f6V2z2/maA9szsb3pHApWJwO5rjz63N11Ts/eyC+8X8/ubsq7XMJoeRaw6u7S
         UEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IihfxZYifKk0KW+eipCJOHHxBrOvGm4jAWFyDjgwqAc=;
        b=JG+9hvfJhRS82Gc537oSpbFzo5v0lAD2F/WSpN7gv/YbKCLslMRQkaZoVTgBoRWDto
         jjxv26v5vJH0A3O1Sj9qp6MVX8qwwDe7HAXI22oNRY+UjdX25nS4e6vlMtXrYq7I+WYu
         YsqKvPQKnS/P8Zhrn1xQbtCmlzmvFsTZXD+teIZF1u7gsYxbqyOVazXsI13X2qAMpRa/
         DDzYKewz0syxwl7BEtgMJsibcaDV7beiqUfZGIxtvCXQK1HwwCJOfUAAKUgkX6IE7qK9
         yDq3Ea4CrobVr2ZjhOavvyqdsF+BXYYj3kby/Ug3vbUK2moJdVoOYf88qDHOJ7ke/c2g
         ln6w==
X-Gm-Message-State: APjAAAWNKB5mu33qA64KIs9ZpNIIq8c4LX7BihwjkgLCNtxndF1PGPdK
        pWVefYakiLMqlnlvGpMeDUcYv8fEab4=
X-Google-Smtp-Source: APXvYqwJTvmvt7gbhsLajrEHFJndquLLl8hLEruwJhoAFKmeC1hwMUvEBqHaWPnSrJbBNqokC2dQaA==
X-Received: by 2002:a17:902:b492:: with SMTP id y18mr9602897plr.175.1551916951541;
        Wed, 06 Mar 2019 16:02:31 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n10sm4105589pfa.139.2019.03.06.16.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:02:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Qualcomm QCS404 Compute DSP loader
Date:   Wed,  6 Mar 2019 16:03:16 -0800
Message-Id: <20190307000318.1750-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remoteproc support for booting the Compute DSP on QCS404, without TrustZone
support.

Bjorn Andersson (2):
  dt-bindings: remoteproc: Rename and amend Hexagon v56 binding
  remoteproc: qcom: qdsp6-adsp: Add support for QCS404 CDSP

 ...qcom,adsp-pil.txt => qcom,hexagon-v56.txt} | 34 ++++++---
 drivers/remoteproc/qcom_q6v5_adsp.c           | 73 ++++++++++++++-----
 2 files changed, 79 insertions(+), 28 deletions(-)
 rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp-pil.txt => qcom,hexagon-v56.txt} (74%)

-- 
2.18.0

