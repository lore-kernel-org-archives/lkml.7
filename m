Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E9420740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoRaJPhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfKYPPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:15:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34003 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfKYPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:15:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so7346162pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+cJWFYs7n1nVhuf5BK8dltsVU5DkvDssdrgSXpcEK4=;
        b=BoRaJPhiQXF5B6Wz6cZYg0IrobpS7DDokJG9m2HVnMwX3laL82jIeMaT0Jdc4ITM3X
         VgAZq6KkTE2nsZ11sj9FFZ8t7bo0hP/UI9lcT2FqB1d9jAHwQRubVACCd5/UWipn57+U
         EpZsdCjYEQJB4oaspLDybG3+3x9MOQr6Q9II5EWG9PLQ2NWTSt1tA+d0NtU+pdEv9Ocj
         3mztFf5iXcFa2/ZlEBOnKFjQUDqy9Qw6gm8DBzvf9KwYV7aoNuq0r50LdOGLgT1yxRle
         KqLjxMKQMVXcKZQAFiI6SHFIGNnSr7SnzX9iGjs3ySFhIHG8s/B0YEDDCoOX7pRd+Sv/
         W0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+cJWFYs7n1nVhuf5BK8dltsVU5DkvDssdrgSXpcEK4=;
        b=klLnaYuOXqBaXamvd/4/lQEJYY8hk41f00sJ2ti/+ajUFN9BKZoYwBVNKj097J6Ya4
         iYVN2AdMJfDN9Orbbz1O/bwqOHcQw7toFbuh52iF4DI85KY5fKrAeNbLyaIiPkvMDpn6
         fA26S2oUpu2i0sWw4ERnHSgkq9nEbwAubyBDswsIacpqAPjxKt/Ds8RNQZdudEtSS6Hc
         AjyejTIrpFIzaJXiKuAF4QE7qO0AdRVFQBNPHaHpQwpGyOqjUTMWWtOoB6yWQOCZQtP2
         Hb3ludmgVgBenOW6MgzuDgCUAEQgDvNCHdhddXzyiQY2Wl8OPCp7qy98dyDrITyjCrgu
         K+Vw==
X-Gm-Message-State: APjAAAWghl0aPcaam9BX8UO1LwssfhszfU8i+mBvz+P4Do7hexICWG7D
        ZFT4iD26rhmPxxewCM+FSpU=
X-Google-Smtp-Source: APXvYqzUxgcyUWOOa1gasyLJl9QC7x2z799DPXorp5X03UELSt7DJwPZW+Ka110BHFOMSu/9ulIgGw==
X-Received: by 2002:a65:6245:: with SMTP id q5mr33095490pgv.347.1574694906175;
        Mon, 25 Nov 2019 07:15:06 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id v17sm9334631pfc.41.2019.11.25.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:15:05 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 0/2] perf: add support for logging debug messages to file
Date:   Mon, 25 Nov 2019 23:14:44 +0800
Message-Id: <20191125151446.10948-1-changbin.du@gmail.com>
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

 tools/perf/Documentation/perf.txt |  20 +++--
 tools/perf/util/debug.c           | 127 ++++++++++++++++++++----------
 2 files changed, 96 insertions(+), 51 deletions(-)

-- 
2.20.1

