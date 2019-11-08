Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDA8214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGtIZ68c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfKHI7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:59:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37892 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbfKHI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:59:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id s10so4408455edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:openpgp:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=e1hgerGf785CLDmFjdBmSkwZ7CYxAA5GHC3QoDaUv84=;
        b=yGtIZ68cDcCfzbYOtkcHgJAya3CqiJFju+o1ghD8pby+dS1efblKTsKu92GXH0Zu5R
         OfKynjHDE73q9d10OA+l+CaPITcqZQXymqfGcl7pVM6CR1OfwJCC6eYQjTesDIuK69xP
         mD8zMocye5Ootfmit1RSGVa6Ilp6r4sE0Dcy/N9pM7W4IFcxdv2BK2yf1YeTeHu1nIMV
         iW27Si4KsXfga1v1oj4+eF+7QUx6lgswW9F+Boo9VU5KRHJIE9mg5H49t4tWMKp7OfVq
         SiuSOO6yoh91Fr2LGc+iTSKhPsy5Jdu7W4gFzvR6I2KJhxJolUoLYh9YQPueGnoPQpZH
         ltqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :mime-version:content-language:content-transfer-encoding;
        bh=e1hgerGf785CLDmFjdBmSkwZ7CYxAA5GHC3QoDaUv84=;
        b=fVX0JFL80R0hLXMuxDCF0kr5llN+UC0TXspRWUWCgfbnYu2nYnV0hTjDVJaVEzRxqi
         U1qZSu0wJr+LTUFUjUbZVU9ICZRsk75h5F8AoYCqFdYbi+5hPL+4jYLqRX8+I1rYJuML
         i5fJMcJQcqGgFDSB7CpRpmdpCNf3qfxIqoj9QK4G01Usmgx6ozRmXja4BZQfG/mBv5Dm
         akU+0yRVVJLH+LwuriOe93ArmgTRorvM6mv1xf79wOWhjtH/gPaQzVopS8LwKTbqavjk
         g3jFC0hVqzIubOjjwP8tQtdMcSy+l8CpAo9TV2YB5GriyzAVAxe6PC1d6EENHl9Py9dy
         ExEQ==
X-Gm-Message-State: APjAAAWcf7tjCH1Yl5J28HJEPT25oqAZKdR2uzcPpmHQLbpuAluq2kL6
        GHsXwiKGR09qMLcJAlbq3D4hWaMNZ4k=
X-Google-Smtp-Source: APXvYqzE6Zz+fYojrXFq8RAXFWKAJbJFcH/HLgEMz3Ox2gSDMcChzTjhr+Dm0LuQ+RCv9/HqjyTQGw==
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr7603343ejh.29.1573203553940;
        Fri, 08 Nov 2019 00:59:13 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v3sm120036edq.62.2019.11.08.00.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 00:59:13 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL v2] interconnect changes for 5.5
Openpgp: preference=signencrypt
Message-ID: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
Date:   Fri, 8 Nov 2019 10:59:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the updated pull request with interconnect patches for the 5.5 merge
window. The details are in the signed tag. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.5-rc1

for you to fetch changes up to 83561a721dc23330d36e0ce499e716cd65f436fe:

  interconnect: Move interconnect drivers to core_initcall (2019-11-07 19:26:19
+0200)

----------------------------------------------------------------
interconnect patches for 5.5

Here are the interconnect updates for the 5.5-rc1 merge window.

- New interconnect driver for msm8974 platforms.
- Change the initcall level of a driver, so it is available earlier to
other dependent drivers.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Brian Masney (2):
      dt-bindings: interconnect: qcom: add msm8974 bindings
      interconnect: qcom: add msm8974 driver

Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Jordan Crouse (1):
      interconnect: Move interconnect drivers to core_initcall

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml |  62 +
 drivers/interconnect/core.c                                      |   4 +
 drivers/interconnect/qcom/Kconfig                                |   9 +
 drivers/interconnect/qcom/Makefile                               |   2 +
 drivers/interconnect/qcom/msm8974.c                              | 796 ++++++++
 drivers/interconnect/qcom/qcs404.c                               |  17 +-
 drivers/interconnect/qcom/sdm845.c                               |  16 +-
 include/dt-bindings/interconnect/qcom,msm8974.h                  | 146 ++
 8 files changed, 1048 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
