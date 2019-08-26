Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F53C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFCC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvZI/TSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfHZH3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:29:44 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42188 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfHZH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:29:44 -0400
Received: by mail-pg1-f180.google.com with SMTP id p3so10047711pgb.9;
        Mon, 26 Aug 2019 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WtULKYQmU1MAdTBRsLIJVkkfqb/nPQehYfnTGkRhEE=;
        b=RvZI/TSCeXAgp7oon0iN6E2mRdzDcLsxO5UVXJoC+CKq14vk7Mh0sSmXb6UP6EQzUl
         CY2lcfuDOTgqWs7T+1d17x61faPQkx3IpLMIII0NB3SG1SUj7Qiqz9UzFybuVGdp+v37
         qNptFAfEDnqJdtA3bq+Ofzl9Yqxlo2cvInLcP3ZNEx6XUbRmdaT+UZec4/bdPTcvwjex
         gcWkvsvEwJaJTO3q7gOUX7wGBNO4as33PEQ3CHP1W/okCkWP08EoAa7wqsEg24uirffV
         VzwAmKvBC4hddL2zMXl5FFH+Vf5MRK0OyfSVqQjWqkO7LYLgZttNY41QvO810sQY2t4Z
         UTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WtULKYQmU1MAdTBRsLIJVkkfqb/nPQehYfnTGkRhEE=;
        b=NilufgEI1UiLM7uI8+aoBlqBrFf99obBwIF6YMRflYIe81Dc9EKCklBLgn7v0stg3Q
         YGE9CF0c/OhnavCDFvApRTDTMbpK9JGXjXl1llPzJOkdKF2lJKID0kNCGA57fUrb5B/J
         Afw0jBJKtih7bzjHUOw3xz1T0TH8z1k+EoaFyE+Xc5aVZKN1DwXZiVPD+zGFNVT8cUdJ
         eEFQigxBmgpBSubJetMFfJ6uCo9HdkLupJITS1rlbZWuqnOLwcFv3dqyFegbHBtkTD2g
         kPiIZxTrFpJFFFt1VdfYkMwvDwoSyW7oAOWv6WXbFE5jnXb8MvE0xnNvpSqAPD8ah0lA
         cy8Q==
X-Gm-Message-State: APjAAAWnA1EoIXwAk3y13wk9DEj/VSW//IUuHaZTCe3fYr/B8+Dqq9Cn
        SYuMxaFn5h+XQhFMHpb+UVs=
X-Google-Smtp-Source: APXvYqyPebsUaxcnXHQK8IjMAvPLWlt2Q5wzh7KMoezYBwvPOfW2a3rqtAJyw1J2vxUDlF2d/VQjLQ==
X-Received: by 2002:aa7:9edc:: with SMTP id r28mr18125599pfq.219.1566804583541;
        Mon, 26 Aug 2019 00:29:43 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p90sm11195670pjp.7.2019.08.26.00.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:29:42 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 0/3] keep console alive even if missing the 'enable' clock
Date:   Mon, 26 Aug 2019 15:29:26 +0800
Message-Id: <20190826072929.7696-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

After the commit 4007098f4ce4 (serial: sprd: Add power management for the Spreadtrum serial controller),
the 'enable' clock was forced to be configured in device tree, otherwise the uart devices couldn't be
probed successfully.

With this patch-set, the uart device which is used as console would be allowed to register even without
any clock configured in device tree, this will make debug easier.

Chunyan Zhang (3):
  serial: sprd: check the right port and membase
  serial: sprd: add console_initcall in sprd's uart driver
  serial: sprd: keep console alive even if missing the 'enable' clock

 drivers/tty/serial/sprd_serial.c | 42 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.20.1

