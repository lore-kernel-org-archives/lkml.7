Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3294BC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9621537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m63z72u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfGHOj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:39:58 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39695 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGHOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:39:58 -0400
Received: by mail-ot1-f53.google.com with SMTP id r21so980700otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SDiQ+8VF4G7lQEr1WiQ+q4pu7BnAiOb9j0rphzoCZ8A=;
        b=m63z72u3/ha3hSHjwxVl/t7mnA/CQ/8pSssVOwxczftYFTB03o+yCUGvSF2Q3rCtYV
         IwoxVzfjEhlfe/sILAO16+vFUKChhY0kP+jkPAzBqc5RSbPENcasiEtjIt/eMCSoeUkt
         UR+0JU3fuY7QwETYy9MRuvft5eXi3KV6ed6xcoKXbKrPc3BPOV07NI4/4Sx+kZkuYj+2
         30CVmbzaz0CjCwLJ19ZvacDws+ptnxdvzDLwKJF+wk1/8bLwyDYxs3u8QT3EVUZjyL5n
         FsLFqqTJ4tivZUDq+0AZT/PszsjReMqgLI2nd35L4X04RX/1Hy2vuQkHN2+ZtrvANsWI
         N1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SDiQ+8VF4G7lQEr1WiQ+q4pu7BnAiOb9j0rphzoCZ8A=;
        b=cTjh8m/6f+jhMPS/LXBum0bWmt3PUXNexqt/Xdz1C1CNssPEfwhhQEIqvBRFBhI4RW
         EO0s9MLgNrhWVCg2DB4FimZ/DkkpLjee4dfIEIJXmJimYV5Oaqsc2jAoL9JELmSYRUs9
         D3VLs9kdB7Td3+GHBcYsgtavdqn65rMbFvtEvuy1Epu/T5kifODM9VOiVDSCROVARzYz
         C11eCOZM13BiDhy5Y2/Jbu3RfeKLlWZRmDZ2CgYiXYHMW4s/ZQYJEIqJoDG6WE1yRSPP
         2xiIAnyLdWK9nLF6YNWoQ2hA7wZmzlvXcChHj4yf6jEUE+qYRxWaQQvouuNTYIjBhknr
         Tlbg==
X-Gm-Message-State: APjAAAVP60i8sOuhFyDJrFCSy7etImsz2KUexP/GlMGQbGgcdYWFBbmk
        Tdjme8TxJqj7Dbe5/VwG7zACMw==
X-Google-Smtp-Source: APXvYqw+YSilI0PUAlEf1gAqmMoAHe3DA/X4BARsrtzJe9i9zFf1au9YeKZ6j24wXDlX3HkapZYZfQ==
X-Received: by 2002:a9d:5f10:: with SMTP id f16mr15005073oti.320.1562596797636;
        Mon, 08 Jul 2019 07:39:57 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id x5sm6386021otb.6.2019.07.08.07.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:39:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf: Fix errors detected by Smatch
Date:   Mon,  8 Jul 2019 22:39:33 +0800
Message-Id: <20190708143937.7722-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Arnaldo has picked up several patches from patch set v1 and have
left four patches which are needed to be refined based on the feedback.
So this is patch set v2 which contains the rest four patches with
addressed the comments and suggestions.

Changes from v1:
* Added WARN_ON_ONCE(!hbt) in ui/browsers/hists.c (Jiri)
* Removed NULL test for 'session->itrace_synth_opts (Adrian)

Leo Yan (4):
  perf hists: Smatch: Fix potential NULL pointer dereference
  perf intel-bts: Smatch: Fix potential NULL pointer dereference
  perf intel-pt: Smatch: Fix potential NULL pointer dereference
  perf cs-etm: Smatch: Fix potential NULL pointer dereference

 tools/perf/ui/browsers/hists.c | 15 +++++++++++----
 tools/perf/util/cs-etm.c       |  2 +-
 tools/perf/util/intel-bts.c    |  5 ++---
 tools/perf/util/intel-pt.c     | 13 +++++--------
 4 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.17.1

