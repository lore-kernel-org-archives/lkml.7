Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA6C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39948206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FS3TKK/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfGOK5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:57:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51936 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:57:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so14694862wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub5f0na4GPQpBSoQ+OsF8cwS68edtFbv7d8hORSDg9A=;
        b=FS3TKK/EpKKg26Wo24BT/Zuph86L0wK1B/lZJrIUDXTw8HESm8Q+LV0kFzmUVjKouF
         uIw26FmHjPsGtUNodNQCJWaC4r/3+37YM+e9FK1Et5mse3UqoZAYVWNLRv27VQnExHyC
         YCcQzIuIEde34+2IZwoHMtbIxjEbnSDfRFj0kYtAeWR3ub3pmbLx07WsiZ+qxq3rnUGo
         9PwascXPJ2/jRYYLO/v7OmVnTc+kxRLH8KyA1/YLmkipq7KCULeyggQwBzuMpnie3D3D
         0ajzxpE/CNJ6I19/XQzx9sEGqnVrVsSBdqP3c+AzP7B1egbr40syjjc1JanLB2+bfXn+
         uSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub5f0na4GPQpBSoQ+OsF8cwS68edtFbv7d8hORSDg9A=;
        b=PPGB4MnIbNns/V/ICT2PcrsTHNMJgmw9Ftxp5UYW81DL+hJPpVm8uRR4+IzzGeCnp5
         CO003mtmW24IA2KOXjYU2pzh7BMgsRtBR894mmWzkvhC6g7aDk4oEucRMeah+oUSH5FZ
         52xvhW5rLUhM0S6LgG/pgMmTBo7Y9qANguiRtwmiHJ1bfW0y4KIWI77IP1tNsqY01fBV
         w0kxbS/CjnmhBDE6SNu+WbtOik+pgvl2gxFEy8AghiFJB+739K7NOVJrO/UdodAmYOcn
         YPYsQ2ogJS3o5p7qypNqgTWAg8p9w9U3gfSbVI61mcoAiFSC4sWtlvqjvG6XgWDfak0K
         04cA==
X-Gm-Message-State: APjAAAXtdxB0dsVixpIIjCmE0cVe50+4FjesoYD1Lo0IzF4usTFBFEZe
        Le0zhGK8gDvBEiTSkVwBWeneAA==
X-Google-Smtp-Source: APXvYqxROvFKewgTDbtvwvjbknUcifi1+bsHFs74Pa8CbcOdOCg4b7cq7uPAKkq7GDP2KQk7rfkiqA==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr22539235wmf.60.1563188253569;
        Mon, 15 Jul 2019 03:57:33 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id z1sm18186559wrv.90.2019.07.15.03.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:57:33 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 0/1] block, bfq: eliminate latency regression with fast drives
Date:   Mon, 15 Jul 2019 12:57:18 +0200
Message-Id: <20190715105719.20353-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[V2 that should apply cleanly on current HEAD]

Hi Jens,
I've spotted a regression on a fast SSD: a loss of I/O-latency control
with interactive tasks (such as the application start up I usually
test). Details in the commit.

I do hope that, after proper review, this commit makes it for 5.3.

Thanks,
Paolo


Paolo Valente (1):
  block, bfq: check also in-flight I/O in dispatch plugging

 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

--
2.20.1
