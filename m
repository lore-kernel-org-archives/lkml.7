Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9FCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280D221852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa62tk3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbfJRA2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51889 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJRA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so4331530wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NrXgXJZY222y3tTmyAGTvYq8mCRdP4iBc/fomM2DVk=;
        b=fa62tk3MFVLXABWRGdL2LTQ/BrAfMWbpRfijB0brMR7Y1sAFftjZ4RFOAt3ocBBUhP
         NLRJ7WRD50R/mHbnxf3yum/2pJa4DCOElKitUpa5hyTz9+zPPg5D+U4gp7ntqRrmgX77
         MrS7GgUwmcq8fpeJIOJaHya7OVgS7pD3DMV/IgYe/PCSgSGuT84YWlQSjsdra242Sw+A
         Hz4InP3HCaS5LS0NUug+TK5ux6cz37HHlLbtt4uEFdaAvY6vbcK0xg7x7UWlU8+XBvrW
         xRZ8mpnTGjsFU7Sc7gN38w/k6SC1tbTGRUBQrGol+NQUfhaEIKgxFi9Db7UUC7qanrZB
         xSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NrXgXJZY222y3tTmyAGTvYq8mCRdP4iBc/fomM2DVk=;
        b=bI2KUSACFasxNKSLrYZpcpAUkp4hihX6p6j0y/sJtgedso0vs0rQU/N5U3vXlPpYWe
         P/awG8yHO6QzZkJcywDQ8ghU2kUYXUmuSjAOEuXZCDKa8L/DYkkAyfSAB+7wlNfNEdq8
         eY6I6Vsw77QvXa8ZYfZtlEHMFs0gzOYBMYyOIO2C45CQpUfMF9ZCWpePMz5CqoNhFull
         Gk3VR15bIqE8aR6g2P3EHcj6IDx1gIcO8iX2+EoUa9Tv1RedwCOliT5mC+q2wjMv3g8o
         O4lLI84626PwAZOiFoe5VgZfMUvnCIxC3Xcb20vAZopOGqoNp6NkGAQG2H+h8e6krwQm
         5DJQ==
X-Gm-Message-State: APjAAAWsw1nxVqGheELnWCwVaPHB0WjWvDRobcxO+66zprXbGw5yt6AI
        lzQ1FJlV5EWhktM6lq8DWmw=
X-Google-Smtp-Source: APXvYqw4ZtMTmE/XCbR4QpXNTKdqIwQsRgsQ0H56TVc6tKi8L75rnCkfVPSCAlC56cSujRMrG9/3Rw==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr5007300wmd.5.1571358493087;
        Thu, 17 Oct 2019 17:28:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id p10sm4437649wrx.2.2019.10.17.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:28:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 0/2] perf: add support for logging debug messages to file
Date:   Fri, 18 Oct 2019 08:27:55 +0800
Message-Id: <20191018002757.4112-1-changbin.du@gmail.com>
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

 tools/perf/Documentation/perf.txt |  16 ++--
 tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 48 deletions(-)

-- 
2.20.1

