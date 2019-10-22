Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E95A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keHs2RpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfJVOIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:08:55 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44298 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:08:54 -0400
Received: by mail-wr1-f46.google.com with SMTP id z9so18220454wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:from:subject:openpgp:cc:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=gZd1p6fUssdVq9L3/zQnlWDjkbzH5VjZcJqBdDJdR9g=;
        b=keHs2RpNHJdPkb6uEUy9aPA5uOwZGIgiKzr7hjcHSht944XIqlyXIkEh36Z5ImF2ut
         FGfc24+pz7Tyb0U62ZJG24ULnyNDZmzkUa8ISCWjuvq2d4RdMaPSasnDnSDZu1HrdTtA
         F1GnjDJ5bm5zioxzlrNME5nNCnCc+kc/dcT0SE/V743y6KuMzj7mJigk00Z+VmREl/cY
         HKqelj9dHtjLwLswgJaAW1N6YNb/eBpUDeHzrgvjCERb6xiSpSd0XkYjNPUKuEqV0KAd
         yMqCsAfGiu2biHYzaFn/J3R60/sPcpKj5/IYWv14xo5XCTsS+I7LlmQbPCuocLSG8A6H
         U3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:cc:message-id:date
         :mime-version:content-language:content-transfer-encoding;
        bh=gZd1p6fUssdVq9L3/zQnlWDjkbzH5VjZcJqBdDJdR9g=;
        b=LG5mo30tKR6NvuPZ0qPe+f60WAHDAqrY3wy4WL3exAP4ki+rhoPeCB7C3Q+0l6qiq+
         evaT3dVZG+YpwWQxQzAtl6ZSIfIGXuaGfe80e4ksYcdwLY5mu6rDQipcNpblXTinXscG
         ni/NA7qdybKoiGrT1ghEZ/aYY2FZH7DcuBDcMJlan97B3/IAyj67f+6cUfkCliaMQawZ
         wgzCbOCy3CrHEHK1SF6kcvl8I1Dhj19c9wPVMN6wP5YNJcev/YpA9c1zj/UT00pYDYA3
         9GLPdo14oycoCueKCdLyCnxr6vCmgEnJhDv3P7zHP67IkblGr725+ViW2zSnwN+BlLU2
         aDFw==
X-Gm-Message-State: APjAAAVurXdtuXgrA9NnAhkatSegbxmEvl/Ea6tnUCZMC5M0lzcv0m7m
        XjAE1AnBceQy31BbPxrI5rCosdvNRX/tuQ==
X-Google-Smtp-Source: APXvYqxWclLCiBW43xRG3JowpwK/J4RNacQW5rqIrov9rEu/uBMIJkFGUQGH6Wt42JWQOxSi3n5P2A==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr3945170wrl.235.1571753330819;
        Tue, 22 Oct 2019 07:08:50 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l8sm787765wru.22.2019.10.22.07.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:08:49 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect fixes for 5.4
Openpgp: preference=signencrypt
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <f9c1befb-9170-5189-6383-3311773c02f2@linaro.org>
Date:   Tue, 22 Oct 2019 17:08:49 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a tiny pull request with interconnect fixes for 5.4-rc. Could you please
take them into char-misc for the next possible rc.

Thanks,
Georgi

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.4-rc5

for you to fetch changes up to a8dfe193a60c6db7c54e03e3f1b96e0aa7244990:

  interconnect: Add locking in icc_set_tag() (2019-10-20 12:14:41 +0300)

----------------------------------------------------------------
interconnect fixes for 5.4

Two tiny fixes for the current release:

- Fix memory allocation size in a driver.
- Add missing mutex.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

 drivers/interconnect/core.c        | 4 ++++
 drivers/interconnect/qcom/qcs404.c | 3 ++-
 drivers/interconnect/qcom/sdm845.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)
