Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2DC4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2D5208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPpfxyx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfIVCih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:38:37 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44053 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfIVCig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:38:36 -0400
Received: by mail-pg1-f170.google.com with SMTP id g3so4378349pgs.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wSbkkwawgKPbta1zkW9vqCbl1AsXFrP27iZvO6nPnQ=;
        b=aPpfxyx4jp2EX2CCs7/pY6hOVi2VrEUnY/kwUEJCr+U9S1ztGz1iC3n4cS3E9nBoYq
         IyYvKTXgbMJEZMWxk4ewnFPcmZTwGb+N9rpcn8LTSU/JDOmufvPy+F1X0m1VOnZa/lHp
         WPYYiSma0P3MWE6DoPQ/7gX4xXV/PryQNL0vcPkY3FRyAhiFw39+eODGerNs7eWqgbTz
         knOuLsn5pNl9+gBp9cERdYu76zEiX+0+f//KOpeSOFBEgQb147wAKKVTgRYDtsb3KW17
         Ol1melwTC5/64/OTcrNlTmn7UJ7INwWMOryuJv/UTO2tTrlyLI+/KKSba3YDm/CH4pdO
         sAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wSbkkwawgKPbta1zkW9vqCbl1AsXFrP27iZvO6nPnQ=;
        b=gRy4A4NtGDBpbHsTnhP6+5gZtYIeg5fq0WBlSGNy9ZDdC0V/kBNgPlenk5plu8yL/3
         D1ta4KYCzX+U7i8UsCVnO6wIXIBNh0IE6OVUIphRBvMh9LDXEbscsS4/Eej5ogTuE0U1
         uRdO2W3O5UqggEQIg/IlCUwpw9Nhy87K/+aSVYNCNSSoAD1ZzOIVDSaUduNqFjZxTEHh
         YKxVoj27sJFdUgFEVeyAay2ieRMmZfPKo1tSCtqtOqSfZ0YMSja7WagYNcMb0lycQe15
         waFFUnqevdEOieL2uVA4w6fB1NiRtfW7RdHFwWMHINydhuXQbnEODk9uj+vqhjXddLO4
         EsJw==
X-Gm-Message-State: APjAAAVrF/6imgVtORwRZRdc0VLQqwjFzUD2QYFg4yi8tOzdrBxcK4p0
        Z2zk+sycboLa5bt8VNLpI/c=
X-Google-Smtp-Source: APXvYqwDfsX3WrxtAQN75rIXrzLn4djltv2OUYxYw3pnEPeaFmmhvXOD6eNsbtP8pvvqD+nWh5FmHQ==
X-Received: by 2002:a17:90a:1b27:: with SMTP id q36mr13769936pjq.113.1569119914572;
        Sat, 21 Sep 2019 19:38:34 -0700 (PDT)
Received: from localhost.localdomain ([207.148.65.56])
        by smtp.gmail.com with ESMTPSA id p20sm5597047pgj.47.2019.09.21.19.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:38:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 0/2] perf: add support for logging debug messages to file
Date:   Sun, 22 Sep 2019 10:38:21 +0800
Message-Id: <20190922023823.12543-1-changbin.du@gmail.com>
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

v2:
  o specific all debug options one time.

Changbin Du (2):
  perf: support multiple debug options separated by ','
  perf: add support for logging debug messages to file

 tools/perf/Documentation/perf.txt |  14 ++--
 tools/perf/util/debug.c           | 106 ++++++++++++++++++------------
 2 files changed, 73 insertions(+), 47 deletions(-)

-- 
2.20.1

