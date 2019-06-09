Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD120684
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI+eAeI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfFIT2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:28:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41150 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfFIT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:28:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so5106382lfa.8;
        Sun, 09 Jun 2019 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZoIoKi0kkLJMizKse887C3ko3aOcz0ZOXxYdZLy4d4=;
        b=rI+eAeI12KQMNNI8DRChQtMvW8+8G2Bielug4vr/1U4QwhU8FT21DcLXLHKG6FiRIU
         otZxHzdn343b8Re4GM4Y3YfoiXWHwmh0X22F/ty0x+zQNwk2dLgdRpSBl3hJiOe6+CDD
         yIIkp/b8DBYxgr2SuffdNBUCdb/TJ7L3QPdEmI5lckiWmcu7pQrFLPEqZijHG7diAjKb
         9GqFHqL2PPMJAmW1dAeNccyHhAdEig5mbTDDZFpFK3acMlSWHMHCLNRooJcqp/79T7MS
         jiG7By7Q+qNx+I+9F+ctvXLnvc4tIfOLCloDCB0hJcCcdnrawKqdk0CNLGrQMKu6/LV5
         yagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZoIoKi0kkLJMizKse887C3ko3aOcz0ZOXxYdZLy4d4=;
        b=aHxu3nhQ1kWyNNw0VFI//D1JQ7KD7zHJcRlvoNaXcK01TpqEcGsyvGEQ4eV1sRVh0F
         bpxSQrIO3r9dgbOM/IS8Nf2fP7V0+CvQnTH+kJ6fes9Dw6NxxJfb8F1YN8pYgJLrXr4D
         mXgtoYDfNqBzr+ILOpJPRu6jMuP3dl+tDW2KGHSNfcy9qdQ5R3fAn4iKQ/a7ETl6MVRN
         gDvJmKLPDK771Rtd2YxYwtOHMhfshqVW4Jdf2IP/lNAM5YXMMiXnEo+0af2SL9I/k+T+
         P1dXm0euaz79KsnXqcKg7RBIYMmMmj0EB5jBv/zMkP5Of56QN0jeyuv1bx+YAHZce8+F
         YuAg==
X-Gm-Message-State: APjAAAWLtvZXuJquQw059O6LLVgfzbweoMWRzy/3aXYD4Ya+Ym4ptXQj
        7TR1OPAzk6jXVmfxaK3Xk8o=
X-Google-Smtp-Source: APXvYqxfNYZrf+mO+N684rY5EEzLcUrScGZGCBGK1tq5V93tEM7Hh6WQsrOlxHMQV3aB+GtB4IHERg==
X-Received: by 2002:ac2:514b:: with SMTP id q11mr33037205lfd.33.1560108531932;
        Sun, 09 Jun 2019 12:28:51 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id e26sm1531685ljl.33.2019.06.09.12.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:28:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Few more cleanups for tegra-timer
Date:   Sun,  9 Jun 2019 22:27:27 +0300
Message-Id: <20190609192730.29459-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I took a look at tegra-timer once again and spotted few more things that
could be improved in addition to [0] which is already in linux-next.

Please apply this small series in addition to [0], thanks in advance!

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=111529

Dmitry Osipenko (3):
  clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
  clocksource/drivers/tegra: Set and use timer's period
  clocksource/drivers/tegra: Drop unneeded typecasting in one place

 drivers/clocksource/timer-tegra.c | 47 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

-- 
2.21.0

