Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B1FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9D2214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQe5f84M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfJJSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:36:56 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33387 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:36:55 -0400
Received: by mail-pl1-f202.google.com with SMTP id d2so4396095pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sVYS71JsFcVLaSydirD+S+xHiSXAzbKTw4LNqNx48fs=;
        b=mQe5f84M2j/mmDSE7zakAWeBxepbx8dmBgD+NaQLXmSvMD9iCqxbuX43aXTM7pJjGZ
         uVSKlnGrrMyAgoPlxg2V8x/kzzAeU+mAcAtGwE4qSSVDN/pV7PkrLweB+/NHMr1O8Afg
         xS1rdVax+4sYskD2QIGYLuTJVcvmxZslH0VpClu1zeNhhzecZ5mUpD1Yzycjo2FTe+FU
         NIUtfRI2uPdEy1npk6Vz1rZa31olbkJfsayRuKaPjy5ANuLj1YXVSKaLePce2MqPnTbF
         yjQ5fldKRkfJTy9p9IeKKnR/iHoMJ7/qTkx29OEZ7VtyB3/ecn2RHmjAGjDTQMOKZe5U
         DqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sVYS71JsFcVLaSydirD+S+xHiSXAzbKTw4LNqNx48fs=;
        b=WokXAxdrDmBh8AghOn/be0rSmBMLeBUqOnD7M7EOXM6sc6v9CyURIr6do86Qix2WZa
         GBYiqFkXXsaun0elzS/lxoKl92K1fAkPHec5eXNVen4MiyG+Q0ZiEMYDoBJhG/shoRzt
         by1ssUPg8Toxxd4g3YQrcwbFk1Y9hW7umKN8UoUi0Ro3rKL12eaV5x/lh6khTVfJ5SFx
         +k+RghnczWWRKnfu9rhIW8v53yeBHeIkkbJ04EZtW3uO4kFNb0lgOhsjz/DGPpa3z1TV
         TiOhl6ixugGW5LNTF9rr3kDeOK0BRgJCchld9mUwRdIG2ZGdAiNASfe6mMdLENQWwQrO
         tyYw==
X-Gm-Message-State: APjAAAX9r0Li2c5DBSVELnqn4sjPEQS0yAN6po1PHJimgF7Z6H1Iu/Vb
        RtvIIgyAJTX6oTF1cdpqo4051BEnK0Rv
X-Google-Smtp-Source: APXvYqwgFb0Ynu/P6r+/5rFDlO1lVHefNBBwjlLNcJS1GD8sYOKknOl1wbq8Y+xmI2GqXESV4yLJe/lJqtYG
X-Received: by 2002:a63:2d81:: with SMTP id t123mr12662972pgt.306.1570732613143;
 Thu, 10 Oct 2019 11:36:53 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:44 -0700
Message-Id: <20191010183649.23768-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 0/5] Improve objdump parsing, fix LLVM objdump
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objdump command line is piped through grep and expand meaning
failures don't surface. Refactor symbol__disassemble so that it manages
the memory for the read line, as well as trimming and expanding tabs.
Correct the objdump flag '--no-show-raw' to be '--no-show-raw-insn'
which binutils objdump permissively allows but fails with LLVM objdump.

Ian Rogers (5):
  perf annotate: avoid reallocation in objdump parsing
  perf annotate: use run-command.h to fork objdump
  perf annotate: don't pipe objdump output through grep
  perf annotate: don't pipe objdump output through expand
  perf annotate: fix objdump --no-show-raw-insn flag

 tools/perf/util/annotate.c | 195 +++++++++++++++++++++++++------------
 1 file changed, 131 insertions(+), 64 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

