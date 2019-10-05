Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF3C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C3C222C5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhiRqVnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfJEJog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:44:36 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35267 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:44:36 -0400
Received: by mail-pf1-f180.google.com with SMTP id 205so5426095pfw.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsLzyk4cLtJ1BsL0pj+tOIyv2uo2YDHISl9Wqf9mUJQ=;
        b=BhiRqVnQZCeZKTuBwXu0GRxK4pmARihnJjooRHPB0xGLsH7b/uf+P5sXJhoTwYZZmv
         gyJ3w3JU5dVMHUZesxndOg4hiEQi/OM71knG1p64AaEUCtpsy39rfKPxjTx8ijMROb7Q
         SC00j3fHPgaFgma9AJlKA9Osci27XKS8Y8Yys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsLzyk4cLtJ1BsL0pj+tOIyv2uo2YDHISl9Wqf9mUJQ=;
        b=ZZAmF/OgM9MoXdZV+GpRumbwTsb2MoNEa2PKYLsYGKg4iKx1w8w3pt/m/CSqitu6Yg
         2Kc1iAiH2UQymICy3hHXPPX6eqOg874DGItq/zdcndRnoeUaNhm0Z8Zhz1wQYbH7FFWc
         CZx0jXJ+UGbiUC+BuxPiTOClFGsCMWKJZJxxwqtij22khpKI8mxVTw/SJ6iAlnzs5tK6
         hd/FNHlacQ3fITc+9F2nTSGaWxaJ/4Kw7IBmwpNb83l2M+nxhLHSkpfzqAFvbA4ZG2wc
         T4UMw9nrmCvpSPhrqoGYUEm0SsOSvHqen38eUiGaVxby1xZP6PEHwUd+/4vv7Z0dOVtR
         Koiw==
X-Gm-Message-State: APjAAAXf8aqqr9B81k2RpjIGYKn6vXuBCQvtAe54Ik2tL4FGm4pmvMEl
        yGZUkS6P1O4Vcd6lN6EYeselbg==
X-Google-Smtp-Source: APXvYqx0MHX5m0aqntaz8yO1KmDVqjRSOZbYZ7k8pegKmCs4EbmDU0kCblnsnC9PihgrpTT85euvPw==
X-Received: by 2002:a17:90a:33e7:: with SMTP id n94mr22493367pjb.15.1570268675429;
        Sat, 05 Oct 2019 02:44:35 -0700 (PDT)
Received: from ikjn-glaptop.roam.corp.google.com ([61.254.209.103])
        by smtp.gmail.com with ESMTPSA id s1sm9012998pjs.31.2019.10.05.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:44:34 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 0/3] HID: google: whiskers, minor fixes.
Date:   Sat,  5 Oct 2019 17:44:16 +0800
Message-Id: <20191005094416.126152-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ikjoon Jang (3):
  dt-bindings: input: Add DT bindings for Whiskers switch
  HID: google: Add of_match table to Whiskers switch device.
  HID: google: whiskers: mask out extra flags in EC event_type

 .../devicetree/bindings/input/cros-cbas.yaml  | 25 +++++++++++++++++++
 drivers/hid/hid-google-hammer.c               | 13 +++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

-- 
2.23.0.581.g78d2f28ef7-goog

