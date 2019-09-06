Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB53C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8721924
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btK5FQnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbfIFUyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:54:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfIFUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:54:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so7827150wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9iZd0ALlBtpvj30ArgRGZaBRGe1rTkTBEtd4b0i1Vc=;
        b=btK5FQnLBlm6g7F416aGcrBn6jKUVra0FTu/DzgotZjZZuNDjoag8X+yBz0OLsKp6g
         Dq0RNsj2G7PfChBamSp11AcXANSgZLr7jxrx9kU6qpb1k3bpucpdf1T1h3RS1T+vBWsX
         GgAM1IG11ZZgh7Jkt5RnbO/uixzBtCrnMFg6A5nLkUyLBfuGRt+PzpF9KYtRBx65nrSf
         NruggiKMgiaX+ZtQeHwrIhQi0SweCAzo45ox8Z0bHnv6tcIktZ4vX/le4+SmtgWxIDuV
         A8fhK0Tos5nt8AvqRRiWJcFnrJcw3avzHgC+mJmpgsq+jOxpZbmCgHCwGQtRKzX7Lvbk
         fLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9iZd0ALlBtpvj30ArgRGZaBRGe1rTkTBEtd4b0i1Vc=;
        b=B4cH0X47vHRe4KET2Ef6waPcGVD9Zxwaz9KuTN8+yNCvilEA+NIqA4oVu377D2BSqK
         GMlF1JNob9aSYnHvSJ7mUc0ixsi2SLjz1By1SV9oaBnJftHKHSYA0qUlTwjpPwzuE9VA
         4uikR1LA+iB9pQFb14bMdeJOXnY1WxlT4X1JdhebsUnRAcH1HqOII/wdvSEkbAzz0oy0
         sMVegt3OCMLEpmT6XD491dY933HTemf+7IVlgonnC5IfTqrHwqZMDiXLv7ev+SNTPVCs
         5L84Pg2B6il7ksE8ceFfBfTRwk4pxdqFkGiFpENU+GrgKY1/3EO4Bh2r2GAfwD7+r7Sm
         GhFQ==
X-Gm-Message-State: APjAAAWdUUarg7C2AjhZZLMGg0GPcXqS+Rk4IktzLTaNSzpX5UlSs5Zd
        UDTxcxb3UtEaVvx7OvyBBSCtVw==
X-Google-Smtp-Source: APXvYqyg2YEhEjYWydK83Ag5waDnG5m0XCWk7plAWFXr9llFtUEHf6PI9Pb+1bqi64S6ZcbbChrJKA==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr9335213wme.127.1567803255262;
        Fri, 06 Sep 2019 13:54:15 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id q5sm317416wmq.3.2019.09.06.13.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 13:54:14 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        linux@roeck-us.net, wim@linux-watchdog.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] qcom_wdt bark irq support
Date:   Fri,  6 Sep 2019 22:54:09 +0200
Message-Id: <20190906205411.31666-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pre-timeout when the bark irq is avaible.

This is the fifth version of the patchset addressing all the review
issues to date:

 v5:
    include linux/bits.h
    pretimeout only enables IRQs if value != 0
    remove unnecessary subtract operation
    add clarity to the conditional in the probe function
    revert the irq registration changes
        
 v4:
    remove unnecessary include and private variable
    provide macro for WDT EN register values
    use pretimeout as per its API intent
    handle EPROBE_DEFER on get_irq
    modify the irq registration as per pm8916_wdt
    
 v3
    remove unecessary variable from the driver's private storage
 
 v2:
     register the pre-timeout notifier.

With the second patch in the set, I took the oportunity to do some
cleanup in the same code base removing an unnecesary variable from the
driver's private storage.

Jorge Ramirez-Ortiz (2):
  watchdog: qcom: support pre-timeout when the bark irq is available
  watchdog: qcom: remove unnecessary variable from private storage

 drivers/watchdog/qcom-wdt.c | 85 +++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 13 deletions(-)

-- 
2.23.0

