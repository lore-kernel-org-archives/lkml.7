Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608BEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EA5222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXk0laZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKHMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:54:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35958 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:54:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so6972267wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yshGOj9Ch5cE328Kakq2jbK6ElAXVlG2qF7B16agtk8=;
        b=jXk0laZiZ7dVouzVSZZEpr3BtIY7fCiWtvJqfuBiz2sZLnWYB0f5Prc/G/YVedO5Kx
         Ni/U9FrBR2C1RkiAkPrTPlcEQhN4aLoEOIjkJudga1tIJ92CV+bf6vVjU3g8sl9TN+Ef
         AUPC34Zjwl+ypl2U7UnsRkwH9IBJBwSvN0Cm0XkSN1YrsRenzHZS67e9CTFg0YGXAKFH
         vGawzaFOULVSKEfQS5SsDZIPwh/akCgnnoeE7MydolQKKFORjZt8AxvcyxbmFFugD/Mh
         GlOu3jFqY9N37EmvBQes/I83BaarnYSp7vzhXn4SM82kU05CnpVRnbMGnyVv4cmtp918
         Zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yshGOj9Ch5cE328Kakq2jbK6ElAXVlG2qF7B16agtk8=;
        b=Vl4jeZCyr3rUJZIwluXJ75MS0/8/Rvzo8depVoo0lOcvYLdXSup6LhhCl5x9Cv9GsY
         dRUgGO/gpx/BJl7lNKA4zEKyCbzlsSWY8bpV5c7Vnow4TAHO3+sAA5DvOfVDprbtJGg4
         /Rf+F3hVit5qRVw12SKF/A5h+NzmezOIOhrV9jV34NJ7rvMWsMgxdASVDBCeQz12zIGc
         RW3EK3nzJ39HDSETneo1LOXZrFsQ/zI+xaIkvV976ZMkqFSaxwZ4gKzgO7QgkTgzlrOk
         KwGa254yER+2oE+VnC5uFSbazBM7kdnb3LVrBfsRKeXeTH59YT56q01pVk5jOTVwC/j4
         RPhg==
X-Gm-Message-State: APjAAAUyoOVumG1E2hz7JH6v/UFx+HMtNUr5vtUBNw1DJqXSJxm/1mig
        K/2VTOYu9I/shmsL+AfdUCNyZw==
X-Google-Smtp-Source: APXvYqzbNikqrJSo8k+BuM6iHT4Ihgi0eBvausj8E13CkiAJyXZO00bBITlai5QO/dMzM+Y7XTgdpg==
X-Received: by 2002:adf:d842:: with SMTP id k2mr1401685wrl.163.1573217659672;
        Fri, 08 Nov 2019 04:54:19 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 19sm8515234wrc.47.2019.11.08.04.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 04:54:18 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 0/2] interconnect changes for 5.5
Date:   Fri,  8 Nov 2019 14:53:47 +0200
Message-Id: <20191108125349.24191-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is new interconnect material for 5.5 which is a new driver. I have
dropped the fixes that you pulled already.

Thanks,
Georgi

Brian Masney (2):
  dt-bindings: interconnect: qcom: add msm8974 bindings
  interconnect: qcom: add msm8974 driver

 .../bindings/interconnect/qcom,msm8974.yaml   |  62 ++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8974.c           | 784 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++
 5 files changed, 1003 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

