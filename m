Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA529C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B7L2LlJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEIRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:24:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:24:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so1676067pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O7p7NTvVuCz3Gx9e1JJz1oyAzlFcn1IdSFVX36X3QfA=;
        b=B7L2LlJN021oT4mU4t8DmWuWOHn9EHEhxgaMb30YkPy61+GfoLji1wxe6NTpWb5pLw
         qpma7dhni1viZxz+Aw7AHXQLazmpPZnq5boazM+nfeZrdOc5yH+MjngOd1Fit+aPZmKG
         Jwk/vIl26z4LUxRtoUM6auka6TlvyMavdVLOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7p7NTvVuCz3Gx9e1JJz1oyAzlFcn1IdSFVX36X3QfA=;
        b=jXrJhowfC10F92rtT1/2a4b4d3JQRuxGCJA2RglUY6rUH5Nlm9QPrqRgSAK6MsBkfX
         O02oBAFr3H6Mb4ZbFJXRTo+0cEvYaruSejQA41SxM1I2TG3evlzkY5JAp+Pa3BUKMDex
         9jhuOmqUy6wsyq7WUeidTmJdaan9fW9IiG0f8t5DfH6X6dg22Gn3i+nhJJ3WniHqbAcv
         Xjzpspw2sxrZI+PoonsGzlTBGObbiCTs4BSm1OoEIaGLoWWFj5ebx20nfGwqpgXLrSGZ
         OjPiEIWVj4EOngI1n+E0cTiN8TE8to5TcXNEjdkRz4Q1oJDgwJNlIl2qPb5PQ8n4mgd2
         cMkA==
X-Gm-Message-State: APjAAAU0d9xkMVXhlGmbfhf0bqzb5q6MxoIm6lGWU3TvkjfWVKGv+25z
        GnAoPp+J8cVxylaibdfIjBHhLQ==
X-Google-Smtp-Source: APXvYqxCYbzrMzhW5xZiImCpKDe6+G2qK6l5xaDKLeoFmS7L6yU4j623I/gTKX5S9B6AvIdcLsVn5g==
X-Received: by 2002:a63:1820:: with SMTP id y32mr7065621pgl.287.1557422674957;
        Thu, 09 May 2019 10:24:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m8sm3989699pgn.59.2019.05.09.10.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:24:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date:   Thu,  9 May 2019 10:24:25 -0700
Message-Id: <20190509172427.17835-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes data hold timing issues for various sdhci-iproc
ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
in quirks.

Changes from v2:
 - Added info to commit message as to stable tag selection decision
   as per Adrian Hunter

Changes from v1:
 - Change fixes tag to Cc: stable@vger.kernel.org to specify version
   to backport to

Trac Hoang (2):
  mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
    problem
  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

