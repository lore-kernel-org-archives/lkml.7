Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4520862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trLVViIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEMUZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:25:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46085 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:25:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so19339104edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Er9e77I7AjeKoDkXcYi3wcJKFOWUoBq85CSzzlD7DBA=;
        b=trLVViIX/rrypZR2cLvz2Vn/RDXBrVxloNLYKr1/roYOiSNqZDub96DBFEJ7xzzvAN
         FXdO2HTRdjkIjaZuvjAz8HfUEtSLCcbuAsbreIinoQWejV2BfgrYCZBh76zcGytFsKPc
         6O8YWFbDlY9wSRet3m9tajA0vCwxkhoMUuwj/PFoGj02585WGuy3QvQ5BY8R4fOcLpTL
         8CaDx/Igyovv6r6IOGhSKuuW9omx8UJl+lx0mfv9z5TnARVN1FlkytRrSxCsCWgjkWsN
         McFOWl+lvcyCBME/dGRvl+4QMN/eL1Wu3/wn62kob875Pzi9C2jFkxDpT+5Gsy0LlXH7
         +k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Er9e77I7AjeKoDkXcYi3wcJKFOWUoBq85CSzzlD7DBA=;
        b=PrYW5DBn1m3xkQdS/T5G+SMi6D4CpO8bNunBd71VTRXJUibRtehfafTvSqWlIRtUCb
         AkDG1/amZk39yW2BOL+d4raxeTGVgZtocd9NinGHAXd0jmnDPE7dF+T/IE32kTvgg7V5
         DmOQb96ow80doEgnQJuQGfHCf5SW0wVtGLGqpYcezXvYNcoRSi0Ub9YqTUxYruN07fB/
         r9DRP3HB5XnvtwdCWLEXhYbRLEniO2DWlWWP2ttCVdm+5VAXvEPs6OkP1igvMn/QFP++
         uCYI1teU9bM21/AdphhBuAXwDr0yjGR/MuyuTDncVjBFWRq6J52usroWurcTXSv+Czr/
         soPQ==
X-Gm-Message-State: APjAAAUglZd0x10z1zJHWFzpiO8f0HRYM1vEGTm9qxDtqHu4zYPfJG0u
        nnP9B/LtB6sW7pUlvJTeoUpe5A27
X-Google-Smtp-Source: APXvYqz4eD/+kOge9iORr/87hGa3M3O7voVJN8UIpwxmy9HoXa0SkKbXKbG8oU6BZ7KBfAc0z1x0kw==
X-Received: by 2002:a17:906:2542:: with SMTP id j2mr24117404ejb.217.1557779134001;
        Mon, 13 May 2019 13:25:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k37sm4036076edb.11.2019.05.13.13.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING
        AND DEBUGGING), John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: [PATCH v2 0/3] perf vendor events arm64: support for Brahma-B53, Cortex-A57/A72
Date:   Mon, 13 May 2019 13:25:19 -0700
Message-Id: <20190513202522.9050-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Based on discussion about the last patch, it turned out that we can
remove the [[:xdigit:]] wildcard entirely since get_cpuid_str() strips
the revision bits anyway.

Florian Fainelli (3):
  perf vendor events arm64: Remove [[:xdigit:]] wildcard
  perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
  perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events

 .../arm/cortex-a57-a72/core-imp-def.json      | 179 ++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   5 +-
 2 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json

-- 
2.17.1

