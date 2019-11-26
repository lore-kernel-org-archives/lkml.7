Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1720727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovynd+4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfKZOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:37:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33945 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:37:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id bo14so8388232pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80HMpaNNIetcsBLd7p8lo9lIL8LSsMPMOHQiZQjM/QY=;
        b=Ovynd+4nfCXpIdjSo7JwbGc9Asx/QZxYdVvJbbLWnUkGavj9O/gzmNAQoZVBivoxkk
         8bBvbUiBH+zIJ17EC+QqaPOCjQOB0+twui8O5QzYgPDmt5iFkh8NU+aH45DKP0Qlns2+
         oGvjgfScGFrTYIP/9+WnOaTxsL9WXmfjqugv397u820EorOsDPTRyaAs5AT7jTg1om9M
         65DBfnV+WhDpK50zgk/FpEdwCYBH218NNq71MSw+KvgPK03Up0zpjWnJrNasS/FR9r2d
         WOl4P4sxsQsXQ6/P+sm75As9eDGiPO91VCHGrCinSA+lGJL1jfNh4r8AGuQB9IzAjiMi
         Qz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80HMpaNNIetcsBLd7p8lo9lIL8LSsMPMOHQiZQjM/QY=;
        b=VC5shJUYBCupcmdY0vDatbLPRlUB1Hy9xgqYmC08gKl4sCRTNRpq+BSddhozY59QwL
         LcsDoeA1+dOw7xz1YCMF7f+JwLEduTXMO6nwTsblbw3pt4BJvBf9cofHxV2vPY7hrL8F
         S5I0iND82Yv9/qyckiKUCn4wmEx/O2WAKcCt8YDFqNsK8mFx3W1SkjePnzH37KMYRxN9
         qQs9021mWcdexUXP9N2D4/QinuVfXN3TCDwutxXCpRyKXZoPyLNBtbqZ/HN2YK+gu7Cc
         sfxET0g7BquAdkW2Gmn9ZY0XxPxKR4pYI/g86aLaX/9bTCTiaamHd5Oo6oFx+dbiEgZa
         KfYw==
X-Gm-Message-State: APjAAAXzwYq4pJN/QPcFrM9KllyfHi3C+XPzxCMs3zIXrZl9j1Jjr9rE
        9/9pDmA48Pvl7zIjiOKMess=
X-Google-Smtp-Source: APXvYqzd9ce72I6gAvj+xnLOZWzZOqZUYH0IX8gGrkQkkg+9l3Kr021Yci59di4z5Fc/58/b7NEYig==
X-Received: by 2002:a17:90a:db43:: with SMTP id u3mr7454781pjx.56.1574779057481;
        Tue, 26 Nov 2019 06:37:37 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id b13sm13139368pgj.28.2019.11.26.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:37:36 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 0/2] perf: add support for logging debug messages to file
Date:   Tue, 26 Nov 2019 22:37:18 +0800
Message-Id: <20191126143720.10333-1-changbin.du@gmail.com>
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

v7:
  o fix a mistake.
v6:
  o rebase to perf/core.
v5:
  o doc default log path.
v4:
  o fix another segfault.
v3:
  o fix a segfault issue.
v2:
  o specific all debug options one time.

Changbin Du (2):
  perf: support multiple debug options separated by ','
  perf: add support for logging debug messages to file

 tools/perf/Documentation/perf.txt |  24 +++---
 tools/perf/util/debug.c           | 127 ++++++++++++++++++++----------
 2 files changed, 98 insertions(+), 53 deletions(-)

-- 
2.20.1

