Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD4C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F77206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5KEvVPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfG2QdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:33:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40859 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfG2QdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:33:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id a186so39634619vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hkKjlu5QjGs/T3e0RTvio/pt/qKYz2W25QWtnEmwNpA=;
        b=B5KEvVPs/R08nW/X8iJscPrmioD+SoELM7xRWLLE0Zm0kwBVrdY5pYjdN1Xuf2NBT0
         rS+xv97P7PgJRnFBFXBXRtPn0E6W8lS1Bco9qxudNc9iL/dKJ3HsHgSqpj2UYPRVsgN5
         ZGNl7/PVqT9L/ByfL+YvaOjXN5cBf1edMWfNbwx88NweWNrqOGBliZDi5RaOsuG9+12l
         SBAJLKE7nb5zTU6lJZRC6vzU0W/76o9x+TMm5WhF9A/8v5aDZpHxkhV0Q7RwkGSqUcKN
         3pib9KPjkAh42bgicvh7s95J8JLdISFwiVd6WK0YEk1m6YRIl+/h4TfD6cWh7joVYsGX
         zDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hkKjlu5QjGs/T3e0RTvio/pt/qKYz2W25QWtnEmwNpA=;
        b=kbd1tRuM+DikzHPbMy3xbY62r36b8Eeq0eHcjxqXs0BhvLWvVX0ROAQMTnO1OTbVzq
         hcTA0/ZuQKYDZbJVNCAlpp1ALf6Tk0iifJhzNfMT2rnI9jmljAE7UXcyFBOR9jbHON7q
         VAnLVr5qQYeEJ3NTSb6ExXpxZgl23366xLoRyPgHeMYEfyue3EFfUoMoHSbF8iRaYOdl
         uMEuT71BmnfDGe3QmjSHbvh8FZ7qdqrJzOdXj+/6huKldUaq4xg4dQjTUHRrf2yfKeFz
         3vbDfSj6T30xcHAWuk8m6smJ4/YmffrwBg3BK2qypD2iwd6uK+EPNBwUB+YQrA8LpgrE
         apuA==
X-Gm-Message-State: APjAAAXvKdWfel+eqWtuKgVMUenXU+1lajLDTShZmXfWKzlXmh/BrovN
        cLR1kJML2pcuw1aHZHKpw0BJeA==
X-Google-Smtp-Source: APXvYqxb+t1CMrD4OgI0r5vaUyMz9p0pH+fzMZGSO+XV5OIRRL5VmlcXYTgTA0qJr0wh7Hy/R/B+PA==
X-Received: by 2002:a67:8e48:: with SMTP id q69mr24743215vsd.72.1564418002818;
        Mon, 29 Jul 2019 09:33:22 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o9sm39762738vkd.27.2019.07.29.09.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 09:33:22 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for AOSS resources that are used to warm up the SoC
Date:   Mon, 29 Jul 2019 12:33:19 -0400
Message-Id: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Always On Sub System (AOSS) hosts certain resources
that are used to warm up the soc if the temperature falls
below certain threshold. These resources are
added can be considered as thermal warming devices
(opposite of thermal cooling devices).

These resources are controlled via AOSS QMP protocol
In kernel, these devices can be treated the same way as any other
thermal cooling device and hence are registered with the thermal
cooling framework.

To use these resources as warming devices require further tweaks in
the thermal framework which are out of scope of this patch series.

Thara Gopinath (2):
  soc: qcom: Extend AOSS QMP driver to support resources that are used
    to wake up the SoC.
  arm64: dts: qcom: Extend AOSS QMP node

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   8 +++
 drivers/soc/qcom/qcom_aoss.c         | 129 +++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

-- 
2.1.4

