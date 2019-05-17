Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA53C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513E72087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JD5n94i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfEQVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:09:25 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42016 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfEQVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:09:25 -0400
Received: by mail-pl1-f169.google.com with SMTP id x15so3872214pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Osr4IBLKvqeoGIhILlOabAONYWC6fq+a0u3OcWitsE=;
        b=JD5n94i4mKalDB7/QIq6hwmxfHuc3LPfFo3nTv1rqK5hcqf3iPDGRh1EFIOki0v4Wa
         5eB4nDxybuOB6dUKwutNbxeO8PCEk7HcsT+DbzAoAr2P5dE8pFYxEVgZyzl4G6ZaPCbe
         hHCRMa8UyiV0LV6JwjoUeakRGvd8LWKz2nEZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Osr4IBLKvqeoGIhILlOabAONYWC6fq+a0u3OcWitsE=;
        b=gd5xKwouiM6bF4Ya0JAV7wX8qJNVIH5BkaOdau/7xGaUAO1p46lpfE1nR8zIjzggbS
         u+cwXruwkhECAVhwffgPKJ0pudDiyYPB9/6BYgKu3WmA8Pl/Bq9TIegfIMVjI7Wf6oDD
         Vdid9HbqS+TH3fXZfwzgaNyfNCopXXf2r4eQPVsSCi6ALcbU16yLLnrDGgg+pFPnQTk/
         Kfxctz9B0bh20pT0AFkZTtokjzcYVhCZ1ikrOn13t0AKDY3fyiTR2BpBhVbOlaGIoA9p
         DOyDw5/c8NyEO42R22JFpmZFqhjkjoM+shttChuHRXbueSZgSX80Mdu3tPcIsDS94X+Y
         2WNQ==
X-Gm-Message-State: APjAAAWLw43dpQ1K68Z3f/dEOYDLZNKdg+oZnnDEzp8uOtWnyAFNpnjc
        XwuXHKntJjA7XNdo6j+xCpv4m5qEOI9Eow==
X-Google-Smtp-Source: APXvYqxEO2VhzyiHpSv9o0CI0H1knnTnrlTCtf/zuChtA/femWc3y8FZABEnlw2/tjPIL9gPSU6oDQ==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr4553546plr.32.1558127364718;
        Fri, 17 May 2019 14:09:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q142sm7890448pfc.27.2019.05.17.14.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:09:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] qcom_scm: Fix some dma mapping things
Date:   Fri, 17 May 2019 14:09:20 -0700
Message-Id: <20190517210923.202131-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <23774.56553.445601.436491@mariner.uk.xensource.com>
References: <23774.56553.445601.436491@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes some DMA mapping problems reported
in the qcom SCM driver. I haven't tested these patches at all
so it could be totally broken. If someone can test them for
me I'd appreciate it. Otherwise, I'll spend some time dusting
off modem loading code to see if it works.

Stephen Boyd (3):
  firmware: qcom_scm: Use proper types for dma mappings
  firmware: qcom_scm: Cleanup code in qcom_scm_assign_mem()
  firmware: qcom_scm: Fix some typos in docs and printks

 drivers/firmware/qcom_scm.c | 47 +++++++++++++++++++------------------
 include/linux/qcom_scm.h    |  9 +++----
 2 files changed, 29 insertions(+), 27 deletions(-)


base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
-- 
Sent by a computer through tubes

