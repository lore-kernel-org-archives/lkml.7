Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BBC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72E20865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN5ZrlCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfJDCkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:40:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfJDCkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:40:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so5093698wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDoiJmGYUtzjrwlsrPKBXvV3pN04b8p2t0+TxXOg3HU=;
        b=WN5ZrlCj3o5nlTV/c2/kkesRdrJy7SAKPf2UmYyxFrXEAtZG/ODrfgvx26WlhhpFz2
         aKnkzr9kd8Zb5gRKMBbKguKxqKEvMc0Cxa92yDz3dHQtAI2GOYgzJu8NheCeXpnv8/jH
         QiVKoHvxhunoxex348iadQyG13yEzRefUXLUdinhPz1bbhIuQo1bqA6W2EaIkFsnvmxw
         cD4ZHS9rjGAE1oyrCrCl19Ul80y0g7K1kRg9DNGWML89YlpIt7lSQxisZq5Ux4PB9db5
         rPsBPQNe5tdDkZ1sJTxSf+eHObjKbY7hT1rarvgkA2tm1chdPC8w7iFh2gA7FviEEp7l
         C+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDoiJmGYUtzjrwlsrPKBXvV3pN04b8p2t0+TxXOg3HU=;
        b=lMHmMJs3u2lrE1DA6K7NWFo4HylgqeHs9gM7C4kVFOD+qTBZ5XGIVVZjHyZLbw/HId
         Bm+/EEzPu4iMxKNqN5/MhLmmM0O+TotMQ4PyGDjBf00/yEmoZtY+H+mjhHE/30mtObQR
         fU/lUAvbahPMJvQDn3PFyjFlyz9mHdHSJf/ZNx/GO4Csrsl68PCVcPdIXsUxf1mZ5jas
         HcLLC91vya6rTkA/Azy2m3Y2dBmJnO8dAIrI8VopnLCZM6M38jWV+CQ8QopK1tQ6QBzq
         8ZaFKljaLKBMIsRTA3bYyHmF2bvALXuxtfBe4H+3q50QghVwA+y/GNUBtjlujwi4Lc5j
         EA/A==
X-Gm-Message-State: APjAAAUZwb4tiCsuL+XfjKT8BZtG5fHX39mjOQjm37kNFtaEAOPIpen5
        KhrjMcwk+jBLsTTVvMs42ww=
X-Google-Smtp-Source: APXvYqyOAeyBZeOPlx/V0V4vYx6gI1hrzNZm6HnC4Qchm9fX73xBDBbJOfmHdNOP+lPcHleLuXz9gA==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr9364825wrn.307.1570156810268;
        Thu, 03 Oct 2019 19:40:10 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id o19sm7447776wmh.27.2019.10.03.19.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 19:40:09 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 0/2] perf: add support for logging debug messages to file
Date:   Fri,  4 Oct 2019 10:39:52 +0800
Message-Id: <20191004023954.1116-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in TUI mode, it is impossible to show all the debug messages to
console. This make it hard to debug perf issues using debug messages.
This patch adds support for logging debug messages to file to resolve
this problem.

v3:
  o fix a segfault issue.
v2:
  o specific all debug options one time.

Changbin Du (2):
  perf: support multiple debug options separated by ','
  perf: add support for logging debug messages to file

 tools/perf/Documentation/perf.txt |  15 ++--
 tools/perf/util/debug.c           | 124 +++++++++++++++++++-----------
 2 files changed, 90 insertions(+), 49 deletions(-)

-- 
2.20.1

