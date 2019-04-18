Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E072184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDzFggAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbfDRK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:28:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbfDRK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:28:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so1227274lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3gfH/JykxYqyNODMHJRTCz28W0rt6sVKpWMKmlcLa0g=;
        b=bDzFggAEGO3gW/BNfAQqBub+y1/YofP2uesJU2aripwzJm1ek+6H6nnJxPZR+AwNd6
         BFgY0z7Vq6lUhExyez4m4CZX7/LQM0nbJwh7O3DnwOVwUaw/hic9EWaswSs8/qE7uSQ7
         /HGC0QtMkbWJa8aBkaDSIEO9YHeSdlv+wUdz7Wlwh5NmuHPMtqnjPwGuFaDUjqdnrA0l
         RG36RA0DE3bdQfU1cCWDhz6gtB3uRBhJyoXgCK7KntcWU75b6JsXhKjz1sdZQBSURtgW
         CTpateCWhDuLFaP8PMel7LCUDtBq49B9qjPUJzKlaDTkJqIv7WajvM8wBpKca2lAz43b
         oJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3gfH/JykxYqyNODMHJRTCz28W0rt6sVKpWMKmlcLa0g=;
        b=uQxkpGKE0pHrOJvCSXYwhdkgemS+Sf0iKyz+do1Sgqc6GfgHbtvhcWQr8IU9ZUljbv
         VRPiRqevoWD576+jy855ZcHk1jYeWkpMBPOLNkocXBKbecGgE+g2hHhenXfJ2SMxDmyX
         ANKSHzfaFq5HSibnDZXA5AsOmvlHbpCbOzDboGAiObeG4AlSULU0AjZduNCAMU4sVNp6
         Z+EJMShsdpy7a2fdrl13YKtHMS4/90u8fs75ZHR9/bdOSRmO/CHWiLt+xfdhpNjTqZ//
         9oupXcTKir+akhY/C6qbCJs4sdEeZRcAacbC6/bF9rzGsuEcczAn8Vd9BgRyFgEEZ47x
         +uCg==
X-Gm-Message-State: APjAAAVec8DrWhp8+0TdkEuA7jgh4Jrr1+fKhoXtEG8XE37QR2BuygsO
        Jlfc4IKHc9zr4pJrM0IzKbuZbA==
X-Google-Smtp-Source: APXvYqy0HmQvgHWnRoeyNXiHx4H5QwoDLvnZDnOXgt1KG6894LmpVJ0o9lEPamOUcXKwvLMSUQxYog==
X-Received: by 2002:a19:7005:: with SMTP id h5mr26334193lfc.143.1555583282594;
        Thu, 18 Apr 2019 03:28:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l13sm320409ljj.96.2019.04.18.03.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:28:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] PM / Domains: Improve support for multi PM domains
Date:   Thu, 18 Apr 2019 12:27:54 +0200
Message-Id: <20190418102757.1246-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while since the introduction for the support for multi PM domains
per device in genpd. In this small series, a couple of different improvement
are being made to this code in genpd.

Ulf Hansson (3):
  PM / Domains: Don't kfree() the virtual device in the error path
  PM / Domains: Allow OF lookup for multi PM domain case from
    ->attach_dev()
  PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM
    domain

 drivers/base/power/domain.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.1

