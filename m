Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55030215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aM1vUqNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1OSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:18:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1OSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:18:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so27879546wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmBrf0xqWz93gyW7QbCHP8mXJjqNqFkUYk+vbwEVB8s=;
        b=aM1vUqNsSpqBNiApc4iz65iEABx7XJ1axHnAjaD8ZrzUv0tRaVVhznKeoFj9RvUCmD
         ppZSu2UVOxZhScA22OQ63Hj2t8SsB1Y3o/8ozblAcVgp3jSyjw6M2+i4r9mkqtkZVjRm
         gEgySW2xq6vdzwcZ48FCn1Tg+WyXjt4OTusE/pLxYGkn8xC1391qiwtRrhqjMiLNDeFt
         Egg7mbZ0tm7Yb0Obo0seGdRUxvkKyS8DG/egQfTdRIu0GTJeJSZqhCzAWWjhe7s/f1v9
         XgrmLEXUxHXd1BE+9aMHiO6OfygrtYfiScxmxsycVCVKT5ksGDwMZjWYfbDKrr020FE1
         uv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmBrf0xqWz93gyW7QbCHP8mXJjqNqFkUYk+vbwEVB8s=;
        b=O0nMhoPtf+aEwAfoUAiVPMBr+KL8Ub0A6/e70VKbZHtwrseqj9Tbdw+ag5dTkYhJI0
         J1pAhU/+AkggVoWdxjARurmJYUr3HV5AfcunxBT7Qri4OjLKJdmPuixdHAW8YmCAUzWM
         84setwgNsMWzta3LdgEjv700bCeB4KTjI01726Rxccuzvh1ejn18ePSCG2XL6rhGrZpj
         WDyujKCvqRNlvgyyHnH0Nl5Xhq5QcAZa8wjcNcFwhBuAYq6ptnR5TT+X7rscUSnD4oA5
         WzNLeva5rmlkojIJbn+El+XFvvZn7H2i8GqH+wK53ziIeLuTGzRUoqRi8+UJkfrXHrt6
         aRfQ==
X-Gm-Message-State: APjAAAUzHZAtunitHfD4oo/6GaDZ3V1jXPnB7YtUuu2EUI6liP3eRZzd
        7NtGwmWbW9WNOiOUtHb4wxzFiQ==
X-Google-Smtp-Source: APXvYqz8o+Q52MqClLfUk6mTe+L+SVyrESEGjsTfL5qd16dFy78u2RSOKRh8c9qQv3AWXa+WkyjGWQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr27635310wrv.198.1574950700480;
        Thu, 28 Nov 2019 06:18:20 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f6sm23947092wrr.15.2019.11.28.06.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:18:19 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v4 0/3] interconnect: Add basic tracepoints
Date:   Thu, 28 Nov 2019 16:18:15 +0200
Message-Id: <20191128141818.32168-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

v4:
- Move CREATE_TRACE_POINTS below all other headers and remove internal.h
  from trace.h
- Picked Steven's Reviewed-by.

v3: http://lore.kernel.org/r/20191122152712.19105-1-georgi.djakov@linaro.org
- In order to avoid #including a file with relative path, move the trace.h
  header into drivers/interconnect/. (Steven)

v2: https://lore.kernel.org/r/20191101130031.27996-1-georgi.djakov@linaro.org
- Moved dev_name() into TP_fast_assign() to reduce cache footprint. (Steven)
- Added path name to traces (Bjorn)
- Added trace for path, device and ret. (Bjorn)

v1: https://lore.kernel.org/r/20191018140224.15087-1-georgi.djakov@linaro.org

Georgi Djakov (3):
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints

 drivers/interconnect/Makefile   |  1 +
 drivers/interconnect/core.c     | 55 +++++++++------------
 drivers/interconnect/internal.h | 42 ++++++++++++++++
 drivers/interconnect/trace.h    | 88 +++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+), 31 deletions(-)
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 drivers/interconnect/trace.h

