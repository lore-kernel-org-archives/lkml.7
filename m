Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93B2465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojyAodJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLRRxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:53:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39742 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfLRRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:53:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so2328543lfb.6;
        Wed, 18 Dec 2019 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tANAGAdpU+BFt2vwt7q1SVWW9LOxxvMiToKQfU2dzGY=;
        b=ojyAodJsS39WwSn2v9z10Ilwua3eGiadQEkWeX95j+itQ849iU+10jsELlgwfvZxvL
         ilaHyAX00JDOH7L6FEvOsipkdwKtAON35PsYKDFMlX2ZE0Rr2yw65RRtwJcdPFXKuYbI
         mPhpTZp48pUHRo2qADJN8rVJQyEvcvXfu1Ln4HHOl28n9ldfyN/MDz9vvCfLfR9M7bGn
         6/8fVzk67IjdvkNw8uWWAsRzrlLnWJ41UUu8m3+RCthdgAOivTu+oLGnlyxK8xW01S32
         IDsQH4rmIoNc1C4XKkNx8TpVcMU4275JgYjemVI5hLi3d22ykeW3WJT6cXW+h03U1CDq
         du4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tANAGAdpU+BFt2vwt7q1SVWW9LOxxvMiToKQfU2dzGY=;
        b=ZgONUXxsnur90jAJpYR2eWmRRQaxx4seYpxqBn4gCHt6VuKTIvS39pE+jPvo/HwjEG
         PJXhh6Wk0IabLKPSKlILv2Ul8FUDHAVTazrwpcqtPqCLtkSyYKPI7pZu3pKEqL5N5lyZ
         Sj0bnZw2rJeGD+7AABvVQJEoJB857SNh80Q70pS93IL3EIRpR5agL+Cx4kmINriNe+9W
         2+ZgL4sR/oLVE6UQczR6c778dp4NPXfYL/zf8s7pZV1DN+O0KB3Aim8Uwmx+6iCkRy2T
         5QJIXfCmgkLHmnBj6Roi5v8P8Hrj2pI/mmFfOx0StM0N/NCe1l6RifRhuS4wCSSs3Bla
         Nc1g==
X-Gm-Message-State: APjAAAXf+8EMYdAzqD80Vt8CvnKXmN+HZUscIcfVIDmawQyh5vzz7KEj
        0GAsT/GetlpgZdSoRP8pWNb+yliV
X-Google-Smtp-Source: APXvYqwgJ4OIShl4gWAypmuZ77/QGVn2SFvXdJnirvnhCMOQ+zoxPP+l1VUVnz4DOkM/l0djWNNMQA==
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr2553655lfp.88.1576691616167;
        Wed, 18 Dec 2019 09:53:36 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id n14sm1530480lfe.5.2019.12.18.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:53:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] NVIDIA Tegra USB2 drivers clean up
Date:   Wed, 18 Dec 2019 20:53:09 +0300
Message-Id: <20191218175313.16235-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small patch series brings the NVIDIA Tegra USB2 PHY driver into a better
shape by refactoring code to match upstream standards, the ChipIdea/Tegra UDC
driver also gets a minor update. Please review and apply, thanks in advance!

Dmitry Osipenko (4):
  dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
  usb: phy: tegra: Hook up init/shutdown callbacks
  usb: phy: tegra: Perform general clean up of the code
  usb: phy: tegra: Use relaxed versions of readl/writel

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |   4 +
 drivers/usb/chipidea/ci_hdrc_tegra.c          |   9 -
 drivers/usb/phy/phy-tegra-usb.c               | 715 ++++++++++--------
 3 files changed, 395 insertions(+), 333 deletions(-)

-- 
2.24.0

