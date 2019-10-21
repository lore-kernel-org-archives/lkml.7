Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AECA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D3220700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlR8/GBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfJUFN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:13:29 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45227 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfJUFN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:13:28 -0400
Received: by mail-pg1-f182.google.com with SMTP id r1so6998127pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTvX2ZoO7TzY2BxJZxSJoG0yIQ3DzcVkh48Y2GNXR2M=;
        b=nlR8/GBlqaQpZhcCEG1KNYmAF8kFV86aPV3heKZ7aty+qbvXhJDQTcDo3Sgsp4NGvT
         jkWjQeaK6K/tYk8i+Mbe/pK/ib96IDUbaNdjRBTWuBmDEDDcQeO5pq3q9KRVxBKjHQfW
         VZ5VULsDVbjCgbrIISLnn+WvucIVrtmkmr4IQ/IoEVmQIdHlMt+Ey8JbBMhNLRuxHZwQ
         kUWlhjJ8nQEV6vUFLGPvGck0mIwGqw+ZZ8ChMrYMNxuH6/k+uMw8tFu5q71Ikc3Zk1fs
         5KqkfzzIAAQ3S9NXjcJl7/FLDFS7znUizsULiPbYQ8NAf8CcIZu0oPhbLUNp9cLzWvwl
         rcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTvX2ZoO7TzY2BxJZxSJoG0yIQ3DzcVkh48Y2GNXR2M=;
        b=D3lZJabqDKgcpJz/yU/5la2EHtN1k/TPnHcRTMLjIdbYdL9CbEjCEq4G2OOywG5IY1
         6cuvcmVfEYWfQ6T46Htdy56T6GR5Zrw5nd5McSYZb3ZWb/q5u9GamzGqKiZ5zpfZN2ab
         fjyKX4Ymxc6916sYbOQZANUha/qzzolEXzzykXySPdWUxrrspGsXeGmP6HgNBKU2sm2z
         ZX6lNWpYF4F7P5t/+Wp05urL3u7NS8fVjKkOO3L7gmLAw753LbBr1vhhCbJ2VsuINqXi
         jAL9ev9C3moqZC65/F7GoLv+VEYa9ZPg5zySMvUhHZ9Ig60nU3qKYr80R+4tQIaW5cVZ
         ypKA==
X-Gm-Message-State: APjAAAXZMHYADD4zQtL2YCZ/Dfny5trjNVVFOCOcT6+tJnDgb5BqrV+b
        t8OXAA4c4t33Iqftz4De6HWbUw==
X-Google-Smtp-Source: APXvYqyy5kW+io7pprvVHWwtLdIyuNVF+sU4eQmX9yUQuw6Xz3npw4kLPeNqS4AseF/48jCFDo2P9w==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr20462574pfa.87.1571634805702;
        Sun, 20 Oct 2019 22:13:25 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h68sm15716862pfb.149.2019.10.20.22.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:13:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] arm64: dts: qcom: msm8996: Introduce IFC6640
Date:   Sun, 20 Oct 2019 22:13:11 -0700
Message-Id: <20191021051322.297560-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor msm8996 and db820c in order to make it follow the structure of newer
platforms, move db820c specific things to db820c.dtsi and then introduce the
Informace 6640 Single Board Computer.

Bjorn Andersson (11):
  arm64: dts: qcom: db820c: Move non-soc entries out of /soc
  arm64: dts: qcom: msm8996: Use node references in db820c
  arm64: dts: qcom: msm8996: Move regulator consumers to db820c
  arm64: dts: qcom: msm8996: Move regulators to db820c
  arm64: dts: qcom: db820c: Group root nodes
  arm64: dts: qcom: db820c: Sort all nodes
  arm64: dts: qcom: db820c: Remove pin specific files
  arm64: dts: qcom: msm8996: Pad addresses
  arm64: dts: qcom: msm8996: Sort all nodes in msm8996.dtsi
  arm64: dts: qcom: db820c: Use regulator names from schematics
  arm64: dts: qcom: msm8996: Introduce IFC6640

 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/apq8096-db820c-pins.dtsi    |  109 -
 .../dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   92 -
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 1416 ++++---
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  412 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 3505 ++++++++---------
 6 files changed, 2982 insertions(+), 2553 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts

-- 
2.23.0

