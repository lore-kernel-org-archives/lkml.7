Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAABC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADAE20882
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1vGz6VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgAIKka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:40:30 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38358 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgAIKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:40:30 -0500
Received: by mail-wr1-f45.google.com with SMTP id y17so6858318wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqGsdCvIdnOjKGyC4Z1g17HfRx0ggaWpe7LvfUSZS2M=;
        b=z1vGz6VIfz5f1fRHjZNzjX5ZpK7PzOHCbOTq9shnVwcVnGUjBd5aPGAMqgUnxwPOIY
         n4cVog/tBbv1MTaG+OyRRCjy8SEHp6/U08cCYsnwiNMb6FS7jYfCKIuZTayLW5U4ZC8u
         7vH4BrOtFG3StG7jgULSaifTtdcC7u2LSu/GUlfC1rEjLXjjoTXKkcn91SBmqzV5qzj6
         hnrq4wkz85ybzN1si89IlQbVYZYW0t1hPg0bdzzOR1WQwQia5pIf9WmAfkc5kf53qKT3
         yEf5TYYGHzmP7woV8EaEIBaH1MqA3ibqFMhgxhnpeEIdwNRyA8xTFEsafikBLXRxcGJ0
         j9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqGsdCvIdnOjKGyC4Z1g17HfRx0ggaWpe7LvfUSZS2M=;
        b=Lh+Zg6fHe1F/6wND3OvETI02+NhuGxrs7KrzoM9bQ4j7a2OSY18bSIbq7eNHCMHP5p
         GBiqmmrY7DNvcrLf6w51Kxxe3O5QY6Kk8aNlOg7ZNT8jZySu7Kyrs0h8RBySmXMUcRqZ
         myTBVzHwd5eij2NBz5LqrHlnG4oMeNdQUnxRcN5k51snhrRZat9eAQOlmq6DdaYEUoDQ
         m+GpqsDuzBVS7sWDu07NNd9zdhTCw9qdjGCXZgNIUaaib6PCbxKtquUdshncoHKuYDMO
         GPncaXmdvQLPS+OIUd9LmyHy4X5KHatsnPkgebrIPNd0RG09AhuNQ3U59I24mw6QWxIh
         TQxw==
X-Gm-Message-State: APjAAAU/a3FL9EfPXMFTN7qyCviOqCCCd8vfUBFgpQT4IYI34XULnwEp
        9aYKzDjkI+QDZx70/W/iIIAoiQ==
X-Google-Smtp-Source: APXvYqx7FHnJkOinan+595YYU0e1klIvY9H/DvMGG6+QPuFO0inHAbCIfLB+RB/b8LFfO7PlntGtrA==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr9908622wrt.70.1578566428180;
        Thu, 09 Jan 2020 02:40:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b10sm7858576wrt.90.2020.01.09.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:40:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: patches for 5.6
Date:   Thu,  9 Jan 2020 10:40:13 +0000
Message-Id: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.6 which mostly includes imx driver
and a core fix in cleanup path.

Can you please queue them up for 5.6.

thanks,


Bitan Biswas (1):
  nvmem: core: fix memory abort in cleanup path

Peng Fan (3):
  nvmem: imx: scu: fix write SIP
  nvmem: imx: scu: correct the fuse word index
  nvmem: imx: ocotp: introduce ocotp_ctrl_reg

 drivers/nvmem/core.c          |  8 ++--
 drivers/nvmem/imx-ocotp-scu.c | 16 ++++---
 drivers/nvmem/imx-ocotp.c     | 79 +++++++++++++++++++++++++----------
 3 files changed, 69 insertions(+), 34 deletions(-)

-- 
2.21.0

