Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF19C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2E20879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1iL5rjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfEYQ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:58:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39234 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfEYQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:58:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so7149016pfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aQqWzt66jrrDi2emr9tHOYNw97iSCax0BxY/rhchcY=;
        b=f1iL5rjbcx05E+yDBGqEbbV/7PFjs8GXhMD0uJox1RxA/AS9E+dnvQPKxuFJF/RWg9
         KTDgSmoaqqPGc7mBW5zX/idYQD/87851p0Y2o5uGDDLq8MYjuE7mFUgQ1BJY24jI+5UV
         UoN9WxjRD6CXsqixXXbfTh+zjExbiGI3MSyoUG+dpj+hi7EizBe67xjY4dykkRBb/EPO
         R1wSXamtc6dQKh30/ZO6YLXcrq7vGYfxTF23kRcprH9Akdo5du6/h06iBL+t8DbpsJG1
         V1YperF41yxqKTBRT0/5RyOHBihnBCPqCs6pulqeFXspjH+hn//2v+TzFKaolDqiRVl5
         2Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aQqWzt66jrrDi2emr9tHOYNw97iSCax0BxY/rhchcY=;
        b=rYxxU3myW89XWrAW4ulHHDVkD3Y/SKKhBxrWwgHHygLVqYb/cdLTS8njbnT459hInS
         lqqZuiQMaOM4EqG9KbVSMJUJY08/eon/eKZuvHpXNtZEPr0gGpPWtRqDfLNnQj5yix6a
         6uWoyyJO3WULyA8qttLKSiFTsZmVIpwm2gPKfH8J6BqbyZ3CgGGVhe/ugcNLtyz11FL/
         6x/ba4q2xap+la4b3vI2l7UUDYs0ihjPyCZWl1HUdFXREhmLlVEDQSo0KzoAL3BgTAjS
         zdab7YSMcJYISBUW29A3p9ldGW8VUwAAAjDllXRR8BsJQoDMJEHpRlbmmBX0nk2iYQEj
         a9EQ==
X-Gm-Message-State: APjAAAVCZAI2wukxKfWQ8m/qEg0hMbSPQrerzIT6vzvhY35oxXSuUpvQ
        BQBp76JqxmMxXz1CdqZClkaNGsWy
X-Google-Smtp-Source: APXvYqzQ5wfVbk9rxXY03f7RUGH9l2VVBvCN+TyN1BzfbPpAxccFHPmEzC7WDTqyRI0OSlWU7hBFBA==
X-Received: by 2002:a63:d901:: with SMTP id r1mr28706454pgg.271.1558803489975;
        Sat, 25 May 2019 09:58:09 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id q142sm8787585pfc.27.2019.05.25.09.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 09:58:08 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 0/4] trace: introduce trace event injection
Date:   Sat, 25 May 2019 09:57:58 -0700
Message-Id: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces trace event injection, the first 3 patches
are some trivial prerequisites, the last one implements the trace
event injection. Please check each patch for details.

I have tested them with both valid and invalid input on different
tracepoints, it works as expected.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

---

Cong Wang (4):
  trace: fold type initialization into tracing_generic_entry_update()
  trace: let filter_assign_type() detect FILTER_PTR_STRING
  trace: make trace_get_fields() global
  trace: introduce trace event injection

 include/linux/trace_events.h       |   9 +
 kernel/trace/Makefile              |   1 +
 kernel/trace/trace.c               |   8 +-
 kernel/trace/trace.h               |   1 +
 kernel/trace/trace_event_perf.c    |   3 +-
 kernel/trace/trace_events.c        |  12 +-
 kernel/trace/trace_events_filter.c |   3 +
 kernel/trace/trace_events_inject.c | 330 +++++++++++++++++++++++++++++
 8 files changed, 353 insertions(+), 14 deletions(-)
 create mode 100644 kernel/trace/trace_events_inject.c

-- 
2.21.0

