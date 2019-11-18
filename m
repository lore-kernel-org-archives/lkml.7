Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566E6222ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3l3yuLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:52:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36108 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfKRSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:52:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so10819537pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=egFH3kuFucvTg7OqPB5zoeZ6qaqFrTRq5yDDJDvTdIo=;
        b=v3l3yuLhgcvBYCBBdRVhzwcMUqf4Aqpe8f7s6UY1qh8/KMup5icZeqyESukWQPYnv4
         2nfJXsOX24U//KD4UOdcasPL3I3IIRaIjUuz0I0fYmoBJxnBMGojWNjnMUmH2I4pN623
         Dxls0HXa3k9wznm5s4Yz94VXONrlgKhKtYd5us8vrnVOqVmYgGWK/xnzbRzUl+fS/qc2
         eomGW2SoFgyV19hy9vw6gMjl8oKFifvF0k61CzbkqXcdEoAH4bh5UwnPXh8N2WTIART9
         7vOm7v18HY9l7QjacU+gXi4nNKg85wCFxSIg04Wu82gFnOjYZhuB58LX9MNoOhqUuzYp
         15iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=egFH3kuFucvTg7OqPB5zoeZ6qaqFrTRq5yDDJDvTdIo=;
        b=bWOXjtR2r+WWuxPVi43yZOrLkg8GZ63aN9XjlF4jAnC/i+1xefCeyY1reOxjmIAck2
         8ZzkcivWWn0RBQ7ziQpDGbCbnsTyHUiwgG+UyUJB1bYBfSKg0cLoWyHDN1Wo6/PjSv1/
         wd3TARsGtNm/JnOzUzlCiMoU+yxIiH6qh39R+aRJ+tmWOATYX5YOLIgYvY1wBkV3vFwW
         kNp6Ev1Z6tlvjwjOftSy3eEO7TC4aG9UO2qWMSYpq3VlKicDf6CvdfzwXbQhBcCHI8yl
         XkMW9MKR3n8ENi7yEONI7ZFEgEd4fd7styaYIU7j727MEJCXdRb6VcUgNqffl+n6aX1a
         hl9Q==
X-Gm-Message-State: APjAAAUUEMfpq4NCnaiI3jYkchJqDm9lM3NNsRyKxMzZj1MX79M/9qCH
        j+RbiDM5PdoCvIQviO58H07d2z8fNqo=
X-Google-Smtp-Source: APXvYqw1sGIEgdtfa6PWVeIepoQvSUgca88oxsSX/P2NCccowq+CxP5jMUK2ILZ/b/Tvxb5gW6PpVA==
X-Received: by 2002:aa7:9432:: with SMTP id y18mr827350pfo.250.1574103128959;
        Mon, 18 Nov 2019 10:52:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r10sm19878910pgn.68.2019.11.18.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:52:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: next v5.4-rc8
Date:   Mon, 18 Nov 2019 11:52:05 -0700
Message-Id: <20191118185207.30441-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

Since we have an rc8 and the fix are trivial, please consider for the next
merge window.

Thanks,
Mathieu

Wei Yongjun (2):
  coresight: funnel: Fix missing spin_lock_init()
  coresight: replicator: Fix missing spin_lock_init()

 drivers/hwtracing/coresight/coresight-funnel.c     | 1 +
 drivers/hwtracing/coresight/coresight-replicator.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1

