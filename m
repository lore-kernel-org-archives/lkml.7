Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E951C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E4C21848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8kT4pXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfEJEe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:34:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38656 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEJEe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:34:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so2352118pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ib+MUjfQhZnZSro4VhngEMbvlKvKCZvtG3Xyv5qHdHM=;
        b=Y8kT4pXGqWTcxgxc4KCfDvBPKoX9ELoCs2hDyY4Ly2GO7yVbII5C5sIybh7CoMWWhn
         4irrfpAX6ysaErLDHDcQJRGttSZkhh9Ww19O4oEUoX5Wbl8w0QiEkoN7U8w2gWc7MbkW
         AqhObpLDDOK2kISIX3NSTtSucgohoBF4rSc+YzDtS8HF+vo0q/yfsdNP9L5CqD25sOsV
         PtGgfAAyumJepwJX9awssnffDPrKnW8KYZTbSbyPqXFjhgsqKv6kGET/MTYWpsHZkmK1
         39EJ/vXp90+YA8s+wb0a29uGlUi02OibPxvIzcamKW2OrcAS1QMohj5w5Mc1xXKnnSBU
         l8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ib+MUjfQhZnZSro4VhngEMbvlKvKCZvtG3Xyv5qHdHM=;
        b=Q2eYA2n4+4fr3e4TeJi+r6XprUwu2LkxhJSUEb6f7z4+mfiyIurAoFaHL1pJ8lRSwK
         CSIQOXNSMH9KCDTewzAzjqY8pvknrMIqTtS7fBQVGi2nilwNJq8SG22ty7p76z3ZmtkK
         Y0R9tnXtjgWxnPNKwpaavfXYkdPmRNh/Y34MWrHg8qf32+dZUVM/ZFeaQbx4GPpQHfxM
         U2foi2SfuFeZ2d2iEqBXcziBruVUBV48H4EJMZ4hBciKHo5CdJ1ivX7+xQpo7bdeq0bI
         XMtsciRr1DP6KqaxuO9254S7X/K46rubq3un8H9SSZ+i+DMcIuEhaecGr7Q8I6YI1y3K
         3Kyw==
X-Gm-Message-State: APjAAAX8al8Q1JolU19AQXE22syT4INN01MCkpTfiifQs3MqUM5rwaR7
        I+chojQk269OkuYhgxLAuF9iEA==
X-Google-Smtp-Source: APXvYqzWbJYyDIfDb0r0u0JljNU5JZ51XRGaYNlxCB4WAlDG+AP+mkXCY46HRjIg+iRu5M3TEr3K5Q==
X-Received: by 2002:a65:4907:: with SMTP id p7mr11059685pgs.288.1557462864894;
        Thu, 09 May 2019 21:34:24 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17sm4785317pfm.149.2019.05.09.21.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 21:34:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Qualcomm QCS404 CDSP improvements and fastrpc
Date:   Thu,  9 May 2019 21:34:13 -0700
Message-Id: <20190510043421.31393-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the non-Trustzone based CDSP support, restructures the
remoteproc nodes in the dts, introduces the IOMMU and adds the fastrpc nodes.

The matrix_multi app is used for verification, the test completes 100% of the
time, but exits only succesfully 70% of the time.

Bjorn Andersson (7):
  dt-bindings: remoteproc: Rename and amend Hexagon v56 binding
  remoteproc: qcom: qdsp6-adsp: Add support for QCS404 CDSP
  arm64: dts: qcom: qcs404-evb: Mark CDSP clocks protected
  arm64: dts: qcom: qcs404: Add TCSR node
  arm64: dts: qcom: qcs404: Fully describe the CDSP
  arm64: dts: qcom: qcs404: Move lpass and q6 into soc
  arm64: dts: qcom: qcs404: Define APPS IOMMU

Thierry Escande (1):
  arm64: dts: qcom: qcs404: Add fastrpc nodes

 ...qcom,adsp-pil.txt => qcom,hexagon-v56.txt} |  35 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |   7 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 364 +++++++++++++-----
 drivers/remoteproc/qcom_q6v5_adsp.c           |  73 +++-
 4 files changed, 358 insertions(+), 121 deletions(-)
 rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp-pil.txt => qcom,hexagon-v56.txt} (74%)

-- 
2.18.0

